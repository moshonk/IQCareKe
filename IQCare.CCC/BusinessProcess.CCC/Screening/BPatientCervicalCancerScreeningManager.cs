using DataAccess.Base;
using DataAccess.CCC.Context;
using DataAccess.CCC.Repository;
using Entities.CCC.Screening;
using Interface.CCC.Screening;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BusinessProcess.CCC.Screening
{
    public class BPatientCervicalCancerScreeningManager : ProcessBase, IPatientCervicalCancerScreeningManager
    {
        // private UnitOfWork _unitOfWork = new UnitOfWork(new GreencardContext());
        internal int Result = 0;

        public int AddPatientCervicalCancerScreening(PatientCervicalCancerScreening a)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                unitOfWork.PatientCervicalCancerScreeningRepository.Add(a);
                Result = unitOfWork.Complete();
                unitOfWork.Dispose();
                return Result;
            }
        }

        public int UpdatePatientCervicalCancerScreening(PatientCervicalCancerScreening p)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var ps = unitOfWork.PatientCervicalCancerScreeningRepository.FindBy(
                x => x.Id == p.Id)
                .FirstOrDefault();
                if (ps != null)
                {
                    ps.VisitDate = p.VisitDate;
                    ps.AppointmentDate = p.AppointmentDate;
                    ps.ReferredTo = p.ReferredTo;
                }
                unitOfWork.PatientCervicalCancerScreeningRepository.Update(ps);
                Result = unitOfWork.Complete();
                unitOfWork.Dispose();
                return Result;
            }
        }

        public int DeletePatientCervicalCancerScreening(int id)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var ps = unitOfWork.PatientCervicalCancerScreeningRepository.GetById(id);
                ps.DeleteFlag = true;
                unitOfWork.PatientCervicalCancerScreeningRepository.Update(ps);
                Result = unitOfWork.Complete();
                unitOfWork.Dispose();
                return Result;
            }
        }

        public List<PatientCervicalCancerScreening> GetPatientCervicalCancerScreening(int patientId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var screeningList = unitOfWork.PatientCervicalCancerScreeningRepository.FindBy(x => x.PatientId == patientId & !x.DeleteFlag).ToList();
                unitOfWork.Dispose();
                return screeningList;
            }
        }

        public List<PatientCervicalCancerScreening> GetPatientCervicalCancerScreening(int patientId, int patientMasterVisitId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var screeningList = unitOfWork.PatientCervicalCancerScreeningRepository.FindBy(x => x.PatientId == patientId & x.PatientMasterVisitId == patientMasterVisitId & !x.DeleteFlag).ToList();
                unitOfWork.Dispose();
                return screeningList;
            }
        }

        public int CheckIfPatientCervicalCancerScreeningExists(int patientId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var PS = unitOfWork.PatientCervicalCancerScreeningRepository.FindBy(x => x.PatientId == patientId & !x.DeleteFlag)
                      .Select(x => x.Id)
                      .FirstOrDefault();
                unitOfWork.Dispose();
                return Convert.ToInt32(PS);
            }
        }

        public int CheckIfPatientCervicalCancerScreeningExists(int patientId, int patientMasterVisitId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var ps = unitOfWork.PatientCervicalCancerScreeningRepository.FindBy(x => x.PatientId == patientId & x.PatientMasterVisitId == patientMasterVisitId & !x.DeleteFlag)
                      .Select(x => x.Id)
                      .FirstOrDefault();
                unitOfWork.Dispose();
                return Convert.ToInt32(ps);
            }
        }

        public PatientCervicalCancerScreening GetPatientCervicalCancerScreeningByVisitId(int patientId, int patientMasterVisitId)
        {
            using (UnitOfWork unitOfWork = new UnitOfWork(new GreencardContext()))
            {
                var screeningItem = unitOfWork.PatientCervicalCancerScreeningRepository.FindBy(x => x.PatientId == patientId & x.PatientMasterVisitId == patientMasterVisitId & !x.DeleteFlag).FirstOrDefault();

                unitOfWork.Dispose();
                return screeningItem;
            }
        }
    }
}