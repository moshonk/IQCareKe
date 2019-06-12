using Entities.CCC.Screening;
using System;
using System.Collections.Generic;

namespace Interface.CCC.Screening
{
    public interface IPatientCervicalCancerScreeningManager
    {
        int AddPatientCervicalCancerScreening(PatientCervicalCancerScreening a);
        int UpdatePatientCervicalCancerScreening(PatientCervicalCancerScreening p);
        int DeletePatientCervicalCancerScreening(int Id);
        List<PatientCervicalCancerScreening> GetPatientCervicalCancerScreening(int patientId);
        List<PatientCervicalCancerScreening> GetPatientCervicalCancerScreening(int patientId, int patientMasterVisitId);
        int CheckIfPatientCervicalCancerScreeningExists(int patientId);
        int CheckIfPatientCervicalCancerScreeningExists(int patientId, int patientMasterVisitId);
        PatientCervicalCancerScreening GetPatientCervicalCancerScreeningByVisitId(int patientId, int patientMasterVisitId);
    }
}
