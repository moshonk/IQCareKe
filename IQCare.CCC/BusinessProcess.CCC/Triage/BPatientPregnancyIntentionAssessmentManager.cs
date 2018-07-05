using DataAccess.Base;
using DataAccess.CCC.Context;
using DataAccess.CCC.Repository;
using Entities.CCC.Triage;
using Interface.CCC.Triage;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BusinessProcess.CCC.Triage
{

    public class BPatientPregnancyIntentionAssessmentManager : ProcessBase, IPatientPregnancyIntentionAssessmentManager
    {
        // private readonly UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext());
        private int Result = 0;

        public int AddPregnancyIntentionAssessment(PatientPregnancyIntentionAssessment a)
        {
            using (UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                _unitOfWork.PatientPregnancyIntentionAssessmentRepository.Add(a);
                Result = _unitOfWork.Complete();
                _unitOfWork.Dispose();
                return a.Id;
            }
        }

        public int UpdatePregnancyIntentionAssessment(PatientPregnancyIntentionAssessment u)
        {
            using (UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var pia = _unitOfWork.PatientPregnancyIntentionAssessmentRepository.GetById(u.Id);

                if (pia != null)
                {
                    pia.VisitDate = u.VisitDate;
                    pia.PartnerHivStatus = u.PartnerHivStatus;
                    pia.ClientEligibleForFP = u.ClientEligibleForFP;
                    pia.ServiceForEligibleClient = u.ServiceForEligibleClient;
                    pia.ReasonForFpIneligibility = u.ReasonForFpIneligibility;
                    pia.PlanningToConceive3M = u.PlanningToConceive3M;
                    pia.RegularMenses = u.RegularMenses;
                    pia.InitiatedOnART = u.InitiatedOnART;

                }
                _unitOfWork.PatientPregnancyIntentionAssessmentRepository.Update(pia);
                Result = _unitOfWork.Complete();
                _unitOfWork.Dispose();
                return pia.Id;
            }
        }
        public int DeletePregnancyIntentionAssessment(int Id)
        {
            using (UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var pa = _unitOfWork.PatientPregnancyIntentionAssessmentRepository.GetById(Id);
                _unitOfWork.PatientPregnancyIntentionAssessmentRepository.Remove(pa);
                Result = _unitOfWork.Complete();
                _unitOfWork.Dispose();
                return Result;
            }
        }

        public int CheckPregnancyIntentionAssessmentExists(int patientId)
        {
            using (UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var pa = _unitOfWork.PatientPregnancyIntentionAssessmentRepository.FindBy(x => x.PatientId == patientId & !x.DeleteFlag)
                    .Select(x => x.Id)
                    .FirstOrDefault();
                _unitOfWork.Dispose();
                return Convert.ToInt32(pa);
            }
        }

        public List<PatientPregnancyIntentionAssessment> GetPregnancyIntentionAssessment(int patientId, DateTime visitDate)
        {
            using (UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var PregnancyIntentionAssessmentList = _unitOfWork.PatientPregnancyIntentionAssessmentRepository.FindBy(x => x.PatientId == patientId & x.VisitDate == visitDate & !x.DeleteFlag).OrderByDescending(x => x.CreateDate).ToList();
                _unitOfWork.Dispose();
                return PregnancyIntentionAssessmentList;
            }
        }

        public List<PatientPregnancyIntentionAssessment> GetPregnancyIntentionAssessment(int patientId)
        {
            using (UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var PregnancyIntentionAssessmentList = _unitOfWork.PatientPregnancyIntentionAssessmentRepository.FindBy(x => x.PatientId == patientId & !x.DeleteFlag).OrderByDescending(x => x.CreateDate).ToList();
                _unitOfWork.Dispose();
                return PregnancyIntentionAssessmentList;
            }
        }

        public int CheckPregnancyIntentionAssessmentExists(int patientId, DateTime visitDate)
        {
            using (UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var pa = _unitOfWork.PatientPregnancyIntentionAssessmentRepository.FindBy(x => x.PatientId == patientId & x.VisitDate == visitDate & !x.DeleteFlag)
                    .Select(x => x.Id)
                    .FirstOrDefault();
                _unitOfWork.Dispose();
                return Convert.ToInt32(pa);
            }
        }

    }
}
