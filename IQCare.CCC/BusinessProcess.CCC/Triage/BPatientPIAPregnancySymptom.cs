using Interface.CCC.Triage;
using System;
using System.Collections.Generic;
using System.Linq;
using Entities.CCC.Triage;
using DataAccess.CCC.Repository;
using DataAccess.CCC.Context;
using DataAccess.Base;

namespace BusinessProcess.CCC.Triage
{
    public class BPatientPIAPregnancySymptom : ProcessBase, IPatientPIAPregnancySymptomManager
    {
        // private readonly UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext());
        private int _result = 0;

        public int AddPregnancySymptom(PatientPIAPregnancySymptom a)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                unitOfWork.PatientPIAPregnancySymptomRepository.Add(a);
                _result = unitOfWork.Complete();
                unitOfWork.Dispose();
                return _result;
            }
        }

        public int UpdatePregnancySymptom(PatientPIAPregnancySymptom u)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var ps =
                  unitOfWork.PatientPIAPregnancySymptomRepository.FindBy(
                          x => x.PatientId == u.PatientId & !x.DeleteFlag)
                      .FirstOrDefault();
                if (ps != null)
                {
                    ps.PatientPIAId = u.PatientPIAId;
                    ps.PregnancySymptomId = u.PregnancySymptomId;
                }
                unitOfWork.PatientPIAPregnancySymptomRepository.Update(ps);
                _result = unitOfWork.Complete();
                unitOfWork.Dispose();
                return _result;
            }
        }

        public int DeletePregnancySymptom(int id)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var FP = unitOfWork.PatientPIAPregnancySymptomRepository.GetById(id);
                unitOfWork.PatientPIAPregnancySymptomRepository.Remove(FP);
                _result = unitOfWork.Complete();
                unitOfWork.Dispose();
                return _result;
            }
        }

        public List<PatientPIAPregnancySymptom> GetPatientPregnancySymptoms(int patientPIAId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var fpMethodList = unitOfWork.PatientPIAPregnancySymptomRepository.FindBy(x => x.PatientPIAId == patientPIAId & !x.DeleteFlag).ToList();
                unitOfWork.Dispose();
                return fpMethodList;
            }
        }

        public int CheckIfPatientHasPregnancySymptom(int patientId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var FP = unitOfWork.PatientPIAPregnancySymptomRepository.FindBy(x => x.PatientId == patientId & !x.DeleteFlag)
                          .Select(x => x.Id)
                          .FirstOrDefault();
                unitOfWork.Dispose();
                return Convert.ToInt32(FP);
            }
        }

        public int DeletePregnancySymptoms(int patientPIAId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var psList = unitOfWork.PatientPIAPregnancySymptomRepository.FindBy(x => x.PatientPIAId == patientPIAId);
                foreach (var ps in psList)
                {
                    var pia = unitOfWork.PatientPIAPregnancySymptomRepository.GetById(ps.Id);
                    unitOfWork.PatientPIAPregnancySymptomRepository.Remove(pia);
                }
                _result = unitOfWork.Complete();
                unitOfWork.Dispose();
                return _result;
            }
        }
    }
}
