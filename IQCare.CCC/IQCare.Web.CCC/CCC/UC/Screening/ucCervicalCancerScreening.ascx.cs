using Application.Presentation;
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

namespace IQCare.Web.CCC.UC.Screening
{
    public partial class ucCervicalCancerScreening : System.Web.UI.UserControl
    {
        public int PatientId, PatientMasterVisitId, userId, SocialHistoryId;
        public DateTime? VisitDate;
        public int screenTypeId = 0, recordId = 0;
        public RadioButtonList rbList;
        public int NotesId;
        public int PmVisitId;
        protected int screeningTypeId;
        public int serviceAreaId;
        protected ILookupManager lookupManager = (ILookupManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.BLookupManager, BusinessProcess.CCC");


        protected string DateOfEnrollment
        {
            get { return Session["DateOfEnrollment"].ToString(); }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            PatientId = Convert.ToInt32(HttpContext.Current.Session["PatientPK"]);
            PatientMasterVisitId = Convert.ToInt32(Request.QueryString["visitId"] != null ? Request.QueryString["visitId"] : HttpContext.Current.Session["PatientMasterVisitId"]);
            userId = Convert.ToInt32(Session["AppUserId"]);
            PmVisitId = Convert.ToInt32(Session["ExistingRecordPatientMasterVisitID"].ToString() == "0" ? Session["PatientMasterVisitID"].ToString() : Session["ExistingRecordPatientMasterVisitID"].ToString());
            screeningTypeId = lookupManager.GetLookUpMasterId("CervicalCancerScreening");

            PatientMasterVisitManager VisitManager = new PatientMasterVisitManager();
            List<PatientMasterVisit> visitPatientMasterVisit = new List<PatientMasterVisit>();
            visitPatientMasterVisit = VisitManager.GetVisitDateByMasterVisitId(PatientId, PatientMasterVisitId);
            VisitDate = visitPatientMasterVisit[0].VisitDate;
            PatientLookupManager patientLookupManager = new PatientLookupManager();
            var patientDetails = patientLookupManager.GetPatientDetailSummary(PatientId);
            Session["DateOfEnrollment"] = patientDetails.EnrollmentDate;
            serviceAreaId = Convert.ToInt32(LookupLogic.GetLookupItemId("MoH 257 GREENCARD"));
            if (!IsPostBack)
            {
                GetCervicalCancerScreeningCTRLs("Ever been screened in the past 1 year", "ScreenedInLastOneYear", phScreenedInLastOneYear);
                GetCervicalCancerScreeningCTRLs("Visit Type", "CxCaScreeningVisitType", phVisitType);
                GetCervicalCancerScreeningCTRLs("Screening method and result", "CxCaScreeningMethod", phScreeningMethod);
                GetCervicalCancerScreeningCTRLs("Treatment", "CxCaTreatment", phTreatment);
                GetCervicalCancerScreeningCTRLs("ReferralReasons", "CxCaReferralReasons", phReferralReasons);
                GetCervicalCancerScreeningCTRLs("Referred Out?", "Referred", phReferred);
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
            placeholder.Controls.Add(new LiteralControl("<div class='row'><label class='control-label pull-left'><span class='text-primary'>" + title + "</span></label></div>"));

            foreach (var question in questions)
            {
                string controlName = title.Replace(" ", "");
                List<LookupItemView> childControls = lookUp.getQuestions(question.ItemName);

                placeholder.Controls.Add(new LiteralControl("<div class='row'>"));
                if (childControls.Count > 0)
                {
                    placeholder.Controls.Add(new LiteralControl("<div class='col-md-4 text-left question'>"));
                }
                else
                {
                    placeholder.Controls.Add(new LiteralControl("<div class='col-md-8 text-left question'>"));
                }

                HtmlInputRadioButton radioButton = new HtmlInputRadioButton
                {
                    ID = string.Format("{0}_{1}", screeningCategoryId.ToString(), question.ItemId.ToString()),
                    Name = controlName,
                    Value = question.ItemId.ToString(),
                    ClientIDMode = System.Web.UI.ClientIDMode.Static,
                };
                radioButton.Attributes.Add("itemId", screeningCategoryId.ToString());

                placeholder.Controls.Add(radioButton);
                HtmlGenericControl label = new HtmlGenericControl("label")
                {
                    InnerHtml = string.Format("{0}", question.ItemDisplayName)
                };
                label.Attributes.Add("for", radioButton.ClientID);

                placeholder.Controls.Add(label);

                placeholder.Controls.Add(new LiteralControl("</div>"));
                placeholder.Controls.Add(new LiteralControl("<div class='col-md-8 text-left children'>"));

                GetChildCtrls(question.ItemName, placeholder);

                placeholder.Controls.Add(new LiteralControl("</div>"));
                placeholder.Controls.Add(new LiteralControl("</div>"));
            }
            placeholder.Controls.Add(new LiteralControl("</div>"));
            placeholder.Controls.Add(new LiteralControl("</div>"));
        }

        public void GetChildCtrls(string groupName, Control placeholder)
        {

            List<LookupItemView> listItems = lookupManager.GetLookItemByGroup(groupName);
            foreach (var item in listItems)
            {
                HtmlInputRadioButton radioButton = new HtmlInputRadioButton
                {
                    ID = string.Format("{0}_{1}", groupName, item.ItemId.ToString()),
                    Name = groupName,
                    Value = item.ItemId.ToString(),
                    ClientIDMode = System.Web.UI.ClientIDMode.Static,
                };
                radioButton.Attributes.Add("itemid", item.MasterId.ToString());
                placeholder.Controls.Add(radioButton);

                HtmlGenericControl label = new HtmlGenericControl("label")
                {
                    InnerText = string.Format(" {0}", item.ItemDisplayName)
                };
                label.Attributes.Add("for", radioButton.ClientID);

                placeholder.Controls.Add(label);

            }
        }

        public void GetCervicalCancerScreeningData(int PatientId)
        {
            var PSM = new PatientScreeningManager();
            List<PatientScreening> screeningList = PSM.GetPatientScreeningByVisitId(PatientId, PatientMasterVisitId);
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