using Application.Presentation;
using Interface.CCC.ClinicalSummary;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IQCare.CCC.UILogic.ClinicalSummary
{
    public class ClinicalSummaryManager
    {
        IClinicalSummaryForm cs = (IClinicalSummaryForm)ObjectFactory.CreateInstance("BusinessProcess.CCC.ClinicalSummary.BClinicalSummary, BusinessProcess.CCC");

        public Object GetClinicalSummary(string patientId)
        {
            DataSet ds = cs.GetPatientClinicalSummary(patientId);

            DataTable dtPatient = ds.Tables[0];
            var patient = new
            {
                cccNumber = dtPatient.Rows[0]["CCCNumber"].ToString(),
                patientName = dtPatient.Rows[0]["PatientName"].ToString(),
                sex = dtPatient.Rows[0]["Sex"].ToString(),
                dob = dtPatient.Rows[0]["DOB"].ToString()
            };

            //Vitals
            DataTable dtVitals = ds.Tables[1];
            Object[] vitals = new Object[dtVitals.Rows.Count];
            for (int i = 0; i < dtVitals.Rows.Count; i++)
            {
                vitals[i] = new
                {
                    visitDate = dtVitals.Rows[i]["VisitDate"].ToString(),
                    weight = dtVitals.Rows[i]["Weight"].ToString(),
                    height = dtVitals.Rows[i]["Height"].ToString(),
                    bmi = dtVitals.Rows[i]["BMI"].ToString()
                };
            }

            //Current ART
            DataTable dtRegimen = ds.Tables[2];
            var currRegimen = new
            {
                regimen = dtRegimen.Rows[0]["Regimen"].ToString(),
                regimenDate = dtRegimen.Rows[0]["RegimenDate"].ToString()
            };

            //Previous ART
            DataTable dtPrevArt = ds.Tables[3];
            Object[] prevArt = new Object[dtPrevArt.Rows.Count];
            for (int i = 0; i < dtPrevArt.Rows.Count; i++)
            {
                prevArt[i] = new
                {
                    regimen = dtPrevArt.Rows[i]["regimenType"].ToString(),
                    regimenDate = dtPrevArt.Rows[i]["DispensedByDate"].ToString()
                };
            }

            //CD4 History
            DataTable dtCd4 = ds.Tables[4];
            Object[] cd4History = new Object[dtCd4.Rows.Count];
            for (int i = 0; i < dtCd4.Rows.Count; i++)
            {
                cd4History[i] = new
                {
                    cd4Date = dtCd4.Rows[i]["CD4Date"].ToString(),
                    cd4Result = dtCd4.Rows[i]["CD4Results"].ToString()
                };
            }

            //VL HIstory
            DataTable dtVl = ds.Tables[5];
            Object[] vlHistory = new object[dtVl.Rows.Count];
            for (int i = 0; i < dtVl.Rows.Count; i++)
            {
                vlHistory[i] = new
                {
                    vlDate = dtVl.Rows[i]["VLDate"].ToString(),
                    vlResult = dtVl.Rows[i]["VLResults"].ToString()
                };
            }

            //DRT History
            DataTable dtDrt = ds.Tables[6];
            Object[] drtHistory = new Object[dtDrt.Rows.Count];
            for (int i = 0; i < dtDrt.Rows.Count; i++)
            {
                drtHistory[i] = new
                {
                    drtDate = dtDrt.Rows[i]["DrtDate"].ToString(),
                    drtResult = dtDrt.Rows[i]["DrtResult"].ToString()
                };
            }

            //IPT History
            DataTable dtIpt = ds.Tables[7];
            Object[] iptHistory = new object[dtIpt.Rows.Count];
            for (int i = 0; i < dtIpt.Rows.Count; i++)
            {
                iptHistory[i] = new
                {
                    iptStartDate = dtIpt.Rows[i]["IptStartDate"].ToString(),
                    iptOutcomeDate = dtIpt.Rows[i]["IptOutcomeDate"].ToString(),
                    iptOutcome = dtIpt.Rows[i]["IptOutcome"].ToString(),
                    IptDiscontinuationReason = dtIpt.Rows[i]["IptDiscontinuationReason"].ToString()
                };
            }

            return new
            {
                patient.cccNumber,
                patient.patientName,
                patient.sex,
                patient.dob,
                vitals,
                currRegimen,
                prevArt,
                cd4History,
                vlHistory,
                drtHistory,
                iptHistory
            };

        }

        public object GetClinicalReviewHistory(string patientId)
        {
            DataSet ds = cs.GetPatientClinicalReviewHistory(patientId);
            
            //Clinical review history
            DataTable dtCRHistory = ds.Tables[0];
            Object[] crHistory = new Object[dtCRHistory.Rows.Count];
            for (int i = 0; i < dtCRHistory.Rows.Count; i++)
            {
                crHistory[i] = new
                {
                    reviewDate = dtCRHistory.Rows[i]["ReviewDate"].ToString(),
                    provider = dtCRHistory.Rows[i]["ProviderName"].ToString(),
                };
            }

            return new { crHistory };
        }

        public Dictionary<string, string> SavePatientClinicalSummary(Dictionary<string, string> paramValues)
        {
            IClinicalSummaryForm cs = (IClinicalSummaryForm)ObjectFactory.CreateInstance("BusinessProcess.CCC.ClinicalSummary.BClinicalSummary, BusinessProcess.CCC");

            return cs.SavePatientClinicalSummary(paramValues);

        }

    }
}
