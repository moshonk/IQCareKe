﻿using System;
using System.Threading;
using System.Threading.Tasks;
using IQCare.Common.BusinessProcess.Services;
using IQCare.Common.Core.Models;
using IQCare.Common.Infrastructure;
using IQCare.HTS.BusinessProcess.Commands;
using IQCare.HTS.BusinessProcess.Services;
using IQCare.HTS.Infrastructure;
using IQCare.Library;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Serilog;

namespace IQCare.HTS.BusinessProcess.CommandHandlers
{
    public class AfyaMobileSynchronizeTracingCommandHandler : IRequestHandler<AfyaMobileSynchronizeTracingCommand, Result<string>>
    {
        private readonly ICommonUnitOfWork _unitOfWork;
        private readonly IHTSUnitOfWork _htsUnitOfWork;

        public AfyaMobileSynchronizeTracingCommandHandler(IHTSUnitOfWork htsUnitOfWork, ICommonUnitOfWork unitOfWork)
        {
            _htsUnitOfWork = htsUnitOfWork ?? throw new ArgumentNullException(nameof(htsUnitOfWork));
            _unitOfWork = unitOfWork ?? throw new ArgumentNullException(nameof(unitOfWork));
        }

        public async Task<Result<string>> Handle(AfyaMobileSynchronizeTracingCommand request, CancellationToken cancellationToken)
        {
            string afyaMobileId = String.Empty;
            string enrollmentNo = string.Empty;

            using (var trans = _htsUnitOfWork.Context.Database.BeginTransaction())
            {
                RegisterPersonService registerPersonService = new RegisterPersonService(_unitOfWork);
                EncounterTestingService encounterTestingService = new EncounterTestingService(_unitOfWork, _htsUnitOfWork);

                try
                {
                    var facilityId = request.MESSAGE_HEADER.SENDING_FACILITY;
                    //Person Identifier
                    for (int j = 0; j < request.INTERNAL_PATIENT_ID.Count; j++)
                    {
                        if (request.INTERNAL_PATIENT_ID[j].ASSIGNING_AUTHORITY ==
                            "HTS" && request.INTERNAL_PATIENT_ID[j]
                                .IDENTIFIER_TYPE == "HTS_SERIAL")
                        {
                            enrollmentNo = request.INTERNAL_PATIENT_ID[j].ID;
                        }

                        if (request.INTERNAL_PATIENT_ID[j].IDENTIFIER_TYPE ==
                            "AFYA_MOBILE_ID" &&
                            request.INTERNAL_PATIENT_ID[j].ASSIGNING_AUTHORITY ==
                            "AFYAMOBILE")
                        {
                            afyaMobileId = request.INTERNAL_PATIENT_ID[j].ID;
                        }
                    }

                    //Tracing
                    var enrollmentTracing = await _unitOfWork.Repository<LookupItemView>()
                        .Get(x => x.MasterName == "TracingType" && x.ItemName == "Enrolment").FirstOrDefaultAsync();
                    int tracingType = enrollmentTracing.ItemId;
                    int providerId = request.PLACER_DETAIL.PROVIDER_ID;
                    string tracingRemarks = String.Empty;

                    //check if person already exists
                    var identifiers = await registerPersonService.getPersonIdentifiers(afyaMobileId, 10);
                    if (identifiers.Count > 0)
                    {
                        var person = await registerPersonService.GetPerson(identifiers[0].PersonId);
                        var patient = await registerPersonService.GetPatientByPersonId(identifiers[0].PersonId);

                        //check for client tracing
                        for (int j = 0; (request.TRACING != null && j < request.TRACING.Count); j++)
                        {
                            DateTime tracingDate =
                                DateTime.ParseExact(request.TRACING[j].TRACING_DATE, "yyyyMMdd", null);
                            int mode = request.TRACING[j].TRACING_MODE;
                            int outcome = request.TRACING[j].TRACING_OUTCOME;

                            //add Client Tracing
                            var clientTracing = await encounterTestingService.addTracing(person.Id, tracingType,
                                tracingDate, mode, outcome,
                                providerId, tracingRemarks, null, null, null);
                        }
                    }
                    else
                    {
                        return Result<string>.Invalid($"Person with afyaMobileId: {afyaMobileId} could not be found");
                    }

                    trans.Commit();
                    return Result<string>.Valid("Successfully synchronized HTS Tracing");
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    Log.Error(ex.Message);
                    return Result<string>.Invalid($"Failed to synchronize Hts Referral for clientid: {afyaMobileId} " + ex.Message + " " + ex.InnerException);
                }
            }
        }
    }
}