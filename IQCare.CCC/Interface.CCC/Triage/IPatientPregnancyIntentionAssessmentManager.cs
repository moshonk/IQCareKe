using Entities.CCC.Triage;
using System;
using System.Collections.Generic;

namespace Interface.CCC.Triage
{
    public interface IPatientPregnancyIntentionAssessmentManager
    {
        int AddPregnancyIntentionAssessment(PatientPregnancyIntentionAssessment a);
        int UpdatePregnancyIntentionAssessment(PatientPregnancyIntentionAssessment u);
        int DeletePregnancyIntentionAssessment(int id);
        List<PatientPregnancyIntentionAssessment> GetPregnancyIntentionAssessment(int patientId);
        List<PatientPregnancyIntentionAssessment> GetPregnancyIntentionAssessment(int patientId, DateTime visitDate);
        int CheckPregnancyIntentionAssessmentExists(int patientId);
        int CheckPregnancyIntentionAssessmentExists(int patientId, DateTime visitDate);
    }
}
