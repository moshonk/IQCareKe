using DataAccess.Base;
using DataAccess.Common;
using DataAccess.Entity;
using Interface.CCC.ClinicalSummary;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessProcess.CCC.ClinicalSummary
{
    public class BClinicalSummary : ProcessBase, IClinicalSummaryForm
    {
        public IClinicalSummaryForm GetClinicalSummaryData(int ptn_pk, int Visit_Id, int LocationID)
        {
            throw new NotImplementedException();
        }

        public int SaveUpdateClinicalSummaryData(IClinicalSummaryForm obj, int userID)
        {
            throw new NotImplementedException();
        }

        public DataSet GetPatientClinicalSummary(string PatientID)
        {
            lock (this)
            {
                ClsObject PatientEncounter = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@PatientID", SqlDbType.Int, PatientID);

                return (DataSet)PatientEncounter.ReturnObject(ClsUtility.theParams, "sp_getPatientClinicalSummary", ClsUtility.ObjectEnum.DataSet);
            }
        }

        public Dictionary<String, String> SavePatientClinicalSummary(Dictionary<string, string> paramValues)
        {

            try
            {
                lock (this)
                {
                    ClsObject PatientEncounter = new ClsObject();
                    ClsUtility.Init_Hashtable();

                    ClsUtility.AddParameters("@PatientMasterVisitID", SqlDbType.Int, paramValues["PatientMasterVisitId"]);
                    ClsUtility.AddParameters("@PatientID", SqlDbType.Int, paramValues["PatientId"]);
                    ClsUtility.AddParameters("@ReviewDate", SqlDbType.Date, paramValues["ReviewDate"]);
                    ClsUtility.AddParameters("@DrtDate", SqlDbType.Date, paramValues["DrtDate"]);
                    ClsUtility.AddParameters("@DrtResult", SqlDbType.Int, paramValues["DrtResult"]);
                    ClsUtility.AddParameters("@HBDone", SqlDbType.Int, paramValues["HBDone"]);
                    ClsUtility.AddParameters("@HBDate", SqlDbType.Date, paramValues["HBDate"]);
                    ClsUtility.AddParameters("@HBResult", SqlDbType.Int, paramValues["HBResult"]);
                    ClsUtility.AddParameters("@CreatinineDone", SqlDbType.Int, paramValues["CreatinineDone"]);
                    ClsUtility.AddParameters("@CreatinineDate", SqlDbType.Date, paramValues["CreatinineDate"]);
                    ClsUtility.AddParameters("@CreatinineResult", SqlDbType.Int, paramValues["CreatinineResult"]);
                    ClsUtility.AddParameters("@AltDone", SqlDbType.Int, paramValues["AltDone"]);
                    ClsUtility.AddParameters("@AltDate", SqlDbType.Date, paramValues["AltDate"]);
                    ClsUtility.AddParameters("@AltResult", SqlDbType.Int, paramValues["AltResult"]);
                    ClsUtility.AddParameters("@HbsagDone", SqlDbType.Int, paramValues["HbsagDone"]);
                    ClsUtility.AddParameters("@HbsagDate", SqlDbType.Date, paramValues["HbsagDate"]);
                    ClsUtility.AddParameters("@HbsagResult", SqlDbType.Int, paramValues["HbsagResult"]);
                    ClsUtility.AddParameters("@VdrlDone", SqlDbType.Int, paramValues["VdrlDone"]);
                    ClsUtility.AddParameters("@VdrlDate", SqlDbType.Date, paramValues["VdrlDate"]);
                    ClsUtility.AddParameters("@VdrlResult", SqlDbType.Int, paramValues["VdrlResult"]);
                    ClsUtility.AddParameters("@CragDone", SqlDbType.Int, paramValues["CragDone"]);
                    ClsUtility.AddParameters("@CragDate", SqlDbType.Date, paramValues["CragDate"]);
                    ClsUtility.AddParameters("@CragResult", SqlDbType.Int, paramValues["CragResult"]);
                    ClsUtility.AddParameters("@TbLamDone", SqlDbType.Int, paramValues["TbLamDone"]);
                    ClsUtility.AddParameters("@TbLamdate", SqlDbType.Date, paramValues["TbLamDate"]);
                    ClsUtility.AddParameters("@DewormingDone", SqlDbType.Int, paramValues["DewormingDone"]);
                    ClsUtility.AddParameters("@DewormingDate", SqlDbType.Date, paramValues["DewormingDate"]);
                    ClsUtility.AddParameters("@DentalReviewDone", SqlDbType.Int, paramValues["DentalReviewDone"]);
                    ClsUtility.AddParameters("@DentalReviewDate", SqlDbType.Date, paramValues["DentalReviewDate"]);
                    ClsUtility.AddParameters("@DepressionScreening", SqlDbType.Int, paramValues["DepressionScreeningDone"]);
                    ClsUtility.AddParameters("@DepressionScreeningDate", SqlDbType.Date, paramValues["DepressionScreeningDate"]);
                    ClsUtility.AddParameters("@DepressionScreeningResult", SqlDbType.Int, paramValues["DepressionScreeningResult"]);
                    ClsUtility.AddParameters("@CacxScreeningDone", SqlDbType.Int, paramValues["CacxScreeningDone"]);
                    ClsUtility.AddParameters("@CacxScreeningDate", SqlDbType.Date, paramValues["CacxScreeningDate"]);
                    ClsUtility.AddParameters("@CacxScreeningResult", SqlDbType.Int, paramValues["CacxScreeningResult"]);
                    ClsUtility.AddParameters("@Recommendations", SqlDbType.NVarChar, paramValues["Recommendations"]);
                    ClsUtility.AddParameters("@CreateDate", SqlDbType.Date, paramValues["CreateDate"]);
                    ClsUtility.AddParameters("@CreatedBy", SqlDbType.Int, paramValues["CreatedBy"]);

                    DataRow dr = (DataRow)PatientEncounter.ReturnObject(ClsUtility.theParams, "sp_saveClincalReview", ClsUtility.ObjectEnum.DataRow);
                    string id = dr[0].ToString();

                    return new Dictionary<string, string>
                    {
                        { "id", id },
                        { "mdg", "Patient clinical summary added/Updated succesfully" }
                    };
                }
            }
            catch (Exception ex)
            {
                return new Dictionary<string, string>
                {
                    { "id", "0" },
                    {"msg", ex.Message }
                };
            }

        }

        public DataSet GetPatientClinicalReviewHistory(string patientId)
        {
            lock (this)
            {
                ClsObject PatientEncounter = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@PatientID", SqlDbType.Int, patientId);

                return (DataSet)PatientEncounter.ReturnObject(ClsUtility.theParams, "sp_getPatientClinicalReviewHistory", ClsUtility.ObjectEnum.DataSet);
            }
        }
    }
}
