﻿using System;
using System.Threading;
using System.Threading.Tasks;
using IQCare.Common.BusinessProcess.Commands.Encounter;
using IQCare.Common.Core.Models;
using IQCare.Common.Infrastructure;
using IQCare.Library;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace IQCare.Common.BusinessProcess.CommandHandlers.Encounter
{
    public class AddEncounterVisitCommandHand : IRequestHandler<AddEncounterVisitCommand, Result<AddEncounterVisitResponse>>
    {
        private readonly ICommonUnitOfWork _unitOfWork;
        public AddEncounterVisitCommandHand(ICommonUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork ?? throw new ArgumentNullException(nameof(unitOfWork));
        }

        public async Task<Result<AddEncounterVisitResponse>> Handle(AddEncounterVisitCommand request, CancellationToken cancellationToken)
        {
            using (var trans = _unitOfWork.Context.Database.BeginTransaction())
            {
                try
                {
                    var masterVisits = await _unitOfWork.Repository<Core.Models.PatientMasterVisit>()
                        .Get(x => x.PatientId == request.PatientId && x.VisitDate == request.EncounterDate && x.ServiceId == request.ServiceAreaId)
                        .ToListAsync();

                    if (masterVisits.Count > 0)
                    {
                        var patientEncounters = await _unitOfWork.Repository<PatientEncounter>()
                            .Get(x => x.PatientMasterVisitId == masterVisits[0].Id).ToListAsync();

                        return Result<AddEncounterVisitResponse>.Valid(new AddEncounterVisitResponse
                        {
                            PatientMasterVisitId = masterVisits[0].Id,
                            PatientEncounterId = patientEncounters[0].Id
                        });
                    }

                    Core.Models.PatientMasterVisit patientMasterVisit = new Core.Models.PatientMasterVisit()
                    {
                        PatientId = request.PatientId,
                        ServiceId = request.ServiceAreaId,
                        Start = request.EncounterDate,
                        Active = true,
                        CreateDate = DateTime.Now,
                        DeleteFlag = false,
                        VisitDate = request.EncounterDate,
                        CreatedBy = request.UserId,
                        VisitType = 0
                    };

                    await _unitOfWork.Repository<Core.Models.PatientMasterVisit>().AddAsync(patientMasterVisit);
                    await _unitOfWork.SaveAsync();

                    PatientEncounter patientEncounter = new PatientEncounter()
                    {
                        PatientId = request.PatientId,
                        EncounterTypeId = request.EncounterType,
                        Status = 0,
                        PatientMasterVisitId = patientMasterVisit.Id,
                        EncounterStartTime = request.EncounterDate,
                        EncounterEndTime = request.EncounterDate,
                        ServiceAreaId = request.ServiceAreaId,
                        CreatedBy = request.UserId,
                        CreateDate = DateTime.Now
                    };

                    await _unitOfWork.Repository<PatientEncounter>().AddAsync(patientEncounter);
                    await _unitOfWork.SaveAsync();

                    trans.Commit();

                    //_unitOfWork.Dispose();

                    return Result<AddEncounterVisitResponse>.Valid(new AddEncounterVisitResponse
                    {
                        PatientMasterVisitId = patientMasterVisit.Id,
                        PatientEncounterId = patientEncounter.Id
                    });
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    return Result<AddEncounterVisitResponse>.Invalid(ex.Message);
                }
            }
                
        }
    }
}