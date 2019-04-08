using Interface.CCC.ClinicalSummary;
using IQCare.CCC.UILogic.ClinicalSummary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace IQCare.Web.CCC.WebService
{
    /// <summary>
    /// Summary description for PatientClinicalSummaryService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class PatientClinicalSummaryService : System.Web.Services.WebService
    {
        private string msg;

        private object msgObject;

        [WebMethod(EnableSession = true)]
        public String GetPatientClinicalSummary(String patientId)
        {
            ClinicalSummaryManager csm = new ClinicalSummaryManager();
            var clinicalSummary = csm.GetClinicalSummary(patientId);

            return new JavaScriptSerializer().Serialize(clinicalSummary);
        }

        [WebMethod(EnableSession = true)]
        public string GetPatientClinicalReviewHistory(String patientId) {
            ClinicalSummaryManager csm = new ClinicalSummaryManager();
            var clinicalReviewHistory = csm.GetClinicalReviewHistory(patientId);

            return new JavaScriptSerializer().Serialize(clinicalReviewHistory);

        }

        [WebMethod(EnableSession = true)]
        public String SavePatientClinicalSummary(String json)
        {
            ClinicalSummaryManager csm = new ClinicalSummaryManager();

            try
            {
                JavaScriptSerializer ser = new JavaScriptSerializer();
                var paramValuesArray = ser.Deserialize<Dictionary<string, string>>(json);

                paramValuesArray.Add("CreateDate", DateTime.Now.ToString("yyyy-MM-dd"));

                var retMsg = csm.SavePatientClinicalSummary(paramValuesArray);

                msgObject = new { id = retMsg["id"], msg = retMsg["msg"] };
                msg = new JavaScriptSerializer().Serialize(msgObject);

            }
            catch (Exception e)
            {
                msgObject = new { id = 0, msg = e.Message };
                msg = new JavaScriptSerializer().Serialize(msgObject);
            }
            return msg;
        }

    }
}
