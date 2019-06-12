using Application.Presentation;
using Entities.CCC.Enrollment;
using Entities.CCC.Lookup;
using Entities.CCC.Screening;
using Entities.CCC.Visit;
using Interface.CCC.Lookup;
using IQCare.CCC.UILogic;
using IQCare.CCC.UILogic.Screening;
using IQCare.CCC.UILogic.Visit;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace IQCare.Web.CCC.UC
{
    public partial class ucCervicalCancerScreeningAssessment : System.Web.UI.UserControl
    {
        public int PatientId, userId, SocialHistoryId;
        public DateTime? VisitDate;
        public int screenTypeId = 0, recordId = 0;
        public RadioButtonList rbList;
        public int NotesId;
        public int PmVisitId;
        public int serviceAreaId;
        protected ILookupManager lookupManager = (ILookupManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.BLookupManager, BusinessProcess.CCC");
        protected int ScreeningTypeId
        {
            get
            {
                var cxcaAssessmentId = Convert.ToInt32(lookupManager.GetLookUpMasterId("CervicalCancerScreeningAssessment"));
                return cxcaAssessmentId;
            }
        }
        protected int CervicalCancerScreeningId
        {
            get
            {
                var cxcaScreeningId = Convert.ToInt32(lookupManager.GetLookUpMasterId("CervicalCancerScreening"));
                return cxcaScreeningId;
            }
        }

        protected int PatientMasterVisitId
        {
            get
            {
                var vistId = Convert.ToInt32(Request.QueryString["visitId"] != null ? Request.QueryString["visitId"] : HttpContext.Current.Session["PatientMasterVisitId"]);
                return vistId;
            }
        }

        protected string Gender
        {
            get { return Convert.ToString(HttpContext.Current.Session["Gender"]); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            PatientId = Convert.ToInt32(HttpContext.Current.Session["PatientPK"]);
            userId = Convert.ToInt32(Session["AppUserId"]);

            List<PatientMasterVisit> visitPatientMasterVisit = new List<PatientMasterVisit>();
            PatientMasterVisitManager VisitManager = new PatientMasterVisitManager();
            visitPatientMasterVisit = VisitManager.GetVisitDateByMasterVisitId(PatientId, PatientMasterVisitId);
            VisitDate = visitPatientMasterVisit[0].VisitDate;
            PatientLookupManager pm = new PatientLookupManager();
            PatientLookup pe = pm.GetPatientDetailSummary(PatientId);            
            if (LookupLogic.GetLookupNameById(pe.Sex).Equals("Female"))
            {
                phCxcaScreeningAssessment.Visible = true;
            }
            else
            {
                phCxcaScreeningAssessment.Visible = false;
            }


            if (!IsPostBack)
            {
                GetCervicalCancerScreeningCTRLs("Has patient ever been screened for cervical cancer in the past 1 year? ", "ScreenedInLastOneYear", phScreenedInLastOneYear);
                GetCervicalCancerScreeningCTRLs("Do you want to refer this patient for cervical cancer screening today? ", "ReferForScreening", phReferForScreening);
            }
        }
        public void GetCervicalCancerScreeningCTRLs(string title, string lookupName, Control placeholder)
        {
            LookupLogic lookUp = new LookupLogic();
            List<LookupItemView> questions = lookUp.getQuestions(lookupName);
            int screeningCategoryId = lookupManager.GetLookUpMasterId(lookupName);

            placeholder.ClientIDMode = System.Web.UI.ClientIDMode.Static;
            placeholder.Controls.Add(new LiteralControl("<div class='row parent' id='" + lookupName + "'>"));
            placeholder.Controls.Add(new LiteralControl("<div class='col-md-12 text-left'>"));
            placeholder.Controls.Add(new LiteralControl("<label class='control-label pull-left'><span class='text-primary'>" + title + "</span></label> "));

            rbList = new RadioButtonList
            {
                ID = screeningCategoryId.ToString(),
                RepeatColumns = 2,
                ClientIDMode = System.Web.UI.ClientIDMode.Static,
                CssClass = "cxcarbList"
            };
            lookUp.populateRBL(rbList, lookupName);
            placeholder.Controls.Add(rbList);
            placeholder.Controls.Add(new LiteralControl("</div>"));
            placeholder.Controls.Add(new LiteralControl("</div>"));
        }

        public void GetCervicalCancerScreeningData(int PatientId)
        {
            var psm = new PatientScreeningManager();
            List<PatientScreening> screeningList = psm.GetPatientScreeningByVisitId(PatientId, PatientMasterVisitId);
            if (screeningList != null)
            {
                foreach (var value in screeningList)
                {
                    screenTypeId = Convert.ToInt32(value.ScreeningTypeId);
                }
            }
        }

    }
}