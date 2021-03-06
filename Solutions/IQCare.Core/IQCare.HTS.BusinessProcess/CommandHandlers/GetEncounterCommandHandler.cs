﻿using System;
using System.Threading;
using System.Threading.Tasks;
using IQCare.Common.Core.Models;
using IQCare.Common.Infrastructure;
using IQCare.HTS.BusinessProcess.Commands;
using IQCare.HTS.Core.Model;
using IQCare.HTS.Infrastructure;
using IQCare.Library;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace IQCare.HTS.BusinessProcess.CommandHandlers
{
    public class GetEncounterCommandHandler : IRequestHandler<GetEncounterCommand, Result<GetEncounterResponse>>
    {
        private readonly IHTSUnitOfWork _hTSUnitOfWork;
        private readonly ICommonUnitOfWork _unitOfWork;
        public GetEncounterCommandHandler(IHTSUnitOfWork hTSUnitOfWork, ICommonUnitOfWork commonUnitOfWork)
        {
            _hTSUnitOfWork = hTSUnitOfWork ?? throw new ArgumentNullException(nameof(hTSUnitOfWork));
            _unitOfWork = commonUnitOfWork ?? throw new ArgumentNullException(nameof(commonUnitOfWork));
        }

        public async Task<Result<GetEncounterResponse>> Handle(GetEncounterCommand request, CancellationToken cancellationToken)
        {
            using (_hTSUnitOfWork)
            {
                try
                {
                    // Get HTS Encounter
                    var result = await _hTSUnitOfWork.Repository<HtsEncounter>().Get(x => x.Id == request.EncounterId).ToListAsync();

                    // Get Hts Testing Results
                    var htsResults = await _hTSUnitOfWork.Repository<HtsEncounterResult>()
                        .Get(x => x.HtsEncounterId == request.EncounterId).ToListAsync();

                    // Get Patient Global Encounter
                    var patientEncounter = await _unitOfWork.Repository<PatientEncounter>()
                        .Get(x => x.Id == result[0].PatientEncounterID).ToListAsync();

                    // Get Client Disabilities
                    var disablity = await _hTSUnitOfWork.Repository<ClientDisability>()
                        .Get(x => x.PersonId == result[0].PersonId && x.DeleteFlag == false).ToListAsync();

                    // Get Consent For Testing
                    var consentType = await _unitOfWork.Repository<LookupItemView>().Get(x => x.MasterName == "ConsentType" && x.ItemName == "ConsentToBeTested").FirstOrDefaultAsync();
                    int consentTypeId = consentType != null ? consentType.ItemId : 0;
                    var consent = await _unitOfWork.Repository<PatientConsent>().Get(x =>
                        x.PatientId == patientEncounter[0].PatientId &&
                        x.PatientMasterVisitId == patientEncounter[0].PatientMasterVisitId && x.ServiceAreaId == 2 &&
                        x.ConsentType == consentTypeId).ToListAsync();

                    // Get Consent To List Partners
                    var consentToListPartnersType = await _unitOfWork.Repository<LookupItemView>().Get(x => x.MasterName == "ConsentType" && x.ItemName == "ConsentToListPartners").FirstOrDefaultAsync();
                    int consentTypeIdList = consentToListPartnersType != null ? consentToListPartnersType.ItemId : 0;
                    var consentToListPartners = await _unitOfWork.Repository<PatientConsent>().Get(x =>
                        x.PatientId == patientEncounter[0].PatientId &&
                        x.PatientMasterVisitId == patientEncounter[0].PatientMasterVisitId && x.ServiceAreaId == 2 &&
                        x.ConsentType == consentTypeIdList).ToListAsync();

                    //Get Client Screening for TB
                    var tbScreeningLookup = await _unitOfWork.Repository<LookupItemView>()
                        .Get(x => x.MasterName == "TbScreening").FirstOrDefaultAsync();
                    int tbScreeningId = tbScreeningLookup != null ? tbScreeningLookup.MasterId : 0;
                    var tbStatus = await _unitOfWork.Repository<PatientScreening>().Get(x =>
                        x.ScreeningTypeId == tbScreeningId && x.PatientId == patientEncounter[0].PatientId &&
                        x.PatientMasterVisitId == patientEncounter[0].PatientMasterVisitId).ToListAsync();


                    return Result<GetEncounterResponse>.Valid(new GetEncounterResponse()
                    {
                        encounter = result,
                        patientEncounter = patientEncounter,
                        disabilities = disablity,
                        consent = consent,
                        tbStatus = tbStatus,
                        htsResults = htsResults,
                        consentToListPartners = consentToListPartners
                    });
                }
                catch (Exception e)
                {
                    return Result<GetEncounterResponse>.Invalid(e.Message);
                }
            }
        }
    }
}