using IQCare.CCC.UILogic;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Application.Presentation;
using Entities.CCC.Lookup;
using Interface.CCC.Lookup;
using IQCare.Web.Laboratory;
using System.Web.Services;
using System.Web.UI;


namespace IQCare.Web.CCC.Encounter
{
    public partial class PatientEncounter : System.Web.UI.Page
    {
        public int PatientId;       
        public int PatientMasterVisitId;
        public int UserId;     
        public int patientId;              
        public string Msg { get; set; }
        public int Result { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {

            PatientId = Convert.ToInt32(HttpContext.Current.Session["PatientPK"]);
            PatientMasterVisitId = Convert.ToInt32(HttpContext.Current.Session["PatientMasterVisitId"]);
            UserId = Convert.ToInt32(HttpContext.Current.Session["AppUserId"]);

            CheckPatientBaselineData();

        }

        private void CheckPatientBaselineData()
        {
            //Redirect to baseline update page if baseline information is missing
            PatientBaselineLookupManager baselineManager = new PatientBaselineLookupManager();
            var baselines = baselineManager.GetPatientBaseline(PatientId);
            var missingBaseline = false;
            if (baselines.Count > 0)
            {
                if (null == baselines[0].EnrollmentWHOStage)
                {
                    missingBaseline = true;
                }
            }
            else
            {
                missingBaseline = true;
            }

            if (missingBaseline == true)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", " alert('This patient is missing important baseline info. You will be redirected to update this info before you can proceed'); window.location.href = '" + ResolveClientUrl("~/CCC/OneTimeEvents/Baseline.aspx") + "';", true);              
            }
        }
    }

}