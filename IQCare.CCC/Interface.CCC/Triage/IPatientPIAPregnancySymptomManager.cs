using Entities.CCC.Triage;
using System.Collections.Generic;

namespace Interface.CCC.Triage
{
    public interface IPatientPIAPregnancySymptomManager
    {
        int AddPregnancySymptom(PatientPIAPregnancySymptom a);
        int UpdatePregnancySymptom(PatientPIAPregnancySymptom u);
        int DeletePregnancySymptom(int id);
        int DeletePregnancySymptoms(int patientPIAId);
        List<PatientPIAPregnancySymptom> GetPatientPregnancySymptoms(int patientPIAId);
        int CheckIfPatientHasPregnancySymptom(int patientId);
    }
}
