using System;
using System.Collections.Generic;
using Entities.CCC.Triage;
using Application.Presentation;
using Interface.CCC.Triage;

namespace IQCare.CCC.UILogic.Triage
{
    public class PatientPregnancyIntentionAssessmentManager
    {
        private IPatientPregnancyIntentionAssessmentManager _PatientPregnancyIntentionAssessment = (IPatientPregnancyIntentionAssessmentManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.Triage.BPatientPregnancyIntentionAssessment, BusinessProcess.CCC");

        public int AddPregnancyIntentionAssessment(int patientId,
            int PatientMasterVisitId,
            DateTime VisitDate,
            int PartnerHivStatus,
            string ClientEligibleForFP,
            int ServiceForEligibleClient,
            int ReasonForFpIneligibility,
            string PlanningToConceive3M,
            string RegularMenses,
            string InitiatedOnART,
            int userId)
        {
            try
            {
                var pia = new PatientPregnancyIntentionAssessment()
                {
                    PatientId = patientId,
                    PatientMasterVisitId = PatientMasterVisitId,
                    VisitDate = VisitDate,
                    PartnerHivStatus = PartnerHivStatus,
                    ClientEligibleForFP = ClientEligibleForFP == "undefined" ? null : ClientEligibleForFP,
                    ServiceForEligibleClient = ServiceForEligibleClient,
                    ReasonForFpIneligibility = ReasonForFpIneligibility,
                    PlanningToConceive3M = PlanningToConceive3M == "undefined" ? null : PlanningToConceive3M,
                    RegularMenses = RegularMenses == "undefined" ? null : RegularMenses,
                    InitiatedOnART = InitiatedOnART == "undefined" ? null : InitiatedOnART,
                    CreatedBy = userId
                };

                return _PatientPregnancyIntentionAssessment.AddPregnancyIntentionAssessment(pia);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int UpdatePregnancyIntentionAssessment(
            int id,
            DateTime VisitDate,
            int PartnerHivStatus,
            string ClientEligibleForFP,
            int ServiceForEligibleClient,
            int ReasonForFpIneligibility,
            string PlanningToConceive3M,
            string RegularMenses,
            string InitiatedOnART,
            int userId)
        {
            try
            {
                var pia = new PatientPregnancyIntentionAssessment()
                {
                    Id = id,
                    VisitDate = VisitDate,
                    PartnerHivStatus = PartnerHivStatus,
                    ClientEligibleForFP = ClientEligibleForFP == "undefined" ? null : ClientEligibleForFP,
                    ServiceForEligibleClient = ServiceForEligibleClient,
                    ReasonForFpIneligibility = ReasonForFpIneligibility,
                    PlanningToConceive3M = PlanningToConceive3M == "undefined" ? null : PlanningToConceive3M,
                    RegularMenses = RegularMenses == "undefined" ? null : RegularMenses,
                    InitiatedOnART = InitiatedOnART == "undefined" ? null : InitiatedOnART,
                    CreatedBy = userId
                };


                return _PatientPregnancyIntentionAssessment.UpdatePregnancyIntentionAssessment(pia);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int DeletePregnancyIntentionAssessment(int id)
        {
            try
            {
                return _PatientPregnancyIntentionAssessment.DeletePregnancyIntentionAssessment(id);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<PatientPregnancyIntentionAssessment> GetPatientPregnancyIntentionAssessment(int patientId, DateTime visitDate)
        {
            try
            {
                return _PatientPregnancyIntentionAssessment.GetPregnancyIntentionAssessment(patientId, visitDate);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<PatientPregnancyIntentionAssessment> GetPatientPregnancyIntentionAssessment(int patientId)
        {
            try
            {
                return _PatientPregnancyIntentionAssessment.GetPregnancyIntentionAssessment(patientId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int CheckIfPatientHasPregnancyIntentionAssessment(int patientId)
        {
            try
            {
                return _PatientPregnancyIntentionAssessment.CheckPregnancyIntentionAssessmentExists(patientId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int CheckIfPatientHasPregnancyIntentionAssessment(int patientId, DateTime visitDate)
        {
            try
            {
                return _PatientPregnancyIntentionAssessment.CheckPregnancyIntentionAssessmentExists(patientId, visitDate);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
