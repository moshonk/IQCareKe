using System.Collections.Generic;
using System.Data;

namespace Interface.CCC.ClinicalSummary
{
    public interface IClinicalSummaryForm
    {
        IClinicalSummaryForm GetClinicalSummaryData(int ptn_pk, int Visit_Id, int LocationID);
        int SaveUpdateClinicalSummaryData(IClinicalSummaryForm obj, int userID);
        int SavePatientClinicalSummary(Dictionary<string, string> paramValues);
        DataSet GetPatientClinicalSummary(string patientId);
    }
}
