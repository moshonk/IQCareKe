﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IQCare.CCC.UILogic;
using Entities.CCC.Lookup;
using IQCare.CCC.UILogic.Screening;
using Entities.CCC.Screening;
using Entities.CCC.Encounter;
using IQCare.CCC.UILogic.Encounter;
using IQCare.CCC.UILogic.Visit;
using Entities.CCC.Visit;

namespace IQCare.Web.CCC.UC.Depression
{
    public partial class ucDepressionScreening : System.Web.UI.UserControl
    {
        public int depressionId, PatientId, PatientMasterVisitId, userId, NotesId, screenTypeId,PmVisitId;
        public DateTime? VisitDate;
        public RadioButtonList rbList;
        public TextBox depressionTotalTb;
        public TextBox depressionSeverityTb;
        public TextBox depressionReccommendationTb;
        public int serviceAreaId;
        
        protected string DateOfEnrollment
        {
            get { return Session["DateOfEnrollment"].ToString(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
            PatientId = Convert.ToInt32(HttpContext.Current.Session["PatientPK"]);
            PatientMasterVisitId = Convert.ToInt32(Request.QueryString["visitId"] != null ? Request.QueryString["visitId"] : HttpContext.Current.Session["PatientMasterVisitId"]);

            PatientMasterVisitManager VisitManager = new PatientMasterVisitManager();
            List<PatientMasterVisit> visitPatientMasterVisit = new List<PatientMasterVisit>();
             visitPatientMasterVisit = VisitManager.GetVisitDateByMasterVisitId(PatientId, PatientMasterVisitId);
            VisitDate = visitPatientMasterVisit[0].VisitDate;
            PatientLookupManager patientLookupManager = new PatientLookupManager();
            var patientDetails = patientLookupManager.GetPatientDetailSummary(PatientId);
            Session["DateOfEnrollment"] = patientDetails.EnrollmentDate;
            serviceAreaId = Convert.ToInt32(LookupLogic.GetLookupItemId("MoH 257 GREENCARD"));
            PmVisitId = Convert.ToInt32(Session["ExistingRecordPatientMasterVisitID"].ToString() == "0" ? Session["PatientMasterVisitID"].ToString() : Session["ExistingRecordPatientMasterVisitID"].ToString());
            userId = Convert.ToInt32(Session["AppUserId"]);
            if (!IsPostBack)
            {
                displayQuestions();
                getDepressionScreeningData();
            }
        }
        public void displayQuestions()
        {
            LookupLogic lookUp = new LookupLogic();
            List<LookupItemView> lasttwoweeksqlist = lookUp.getQuestions("DepressionScreeningQuestions");
            foreach (var value in lasttwoweeksqlist)
            {
                screenTypeId = value.MasterId;
                depressionId = value.MasterId;
                PlaceHolder2.Controls.Add(new LiteralControl("<div class='col-md-6 text-left'>"));
                PlaceHolder2.Controls.Add(new LiteralControl("<div class='row'>"));
                PlaceHolder2.Controls.Add(new LiteralControl("<div class='col-md-8 text-left'>"));
                PlaceHolder2.Controls.Add(new LiteralControl("<label>" + value.ItemDisplayName + "" + "</label>"));
                PlaceHolder2.Controls.Add(new LiteralControl("</div>"));
                PlaceHolder2.Controls.Add(new LiteralControl("<div class='col-md-4 text-right'>"));
                rbList = new RadioButtonList();
                rbList.ID = "uds" + value.ItemId.ToString();
              //  rbList.ID = value.ItemId.ToString();
                rbList.RepeatColumns = 4;
                rbList.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                rbList.CssClass = "rbList";
                lookUp.populateRBL(rbList, "GeneralYesNo");
                PlaceHolder2.Controls.Add(rbList);
                PlaceHolder2.Controls.Add(new LiteralControl("</div>"));
                PlaceHolder2.Controls.Add(new LiteralControl("</div>"));
                PlaceHolder2.Controls.Add(new LiteralControl("</div>"));
            }
            List<LookupItemView> ph9qlist = lookUp.getQuestions("PHQ9Questions");
            foreach (var value in ph9qlist)
            {
                PlaceHolder1.Controls.Add(new LiteralControl("<div class='row'>"));
                PlaceHolder1.Controls.Add(new LiteralControl("<div class='col-md-5 text-left'>"));
                PlaceHolder1.Controls.Add(new LiteralControl("<label>" + value.ItemDisplayName + "" + "</label>"));
                PlaceHolder1.Controls.Add(new LiteralControl("</div>"));
                PlaceHolder1.Controls.Add(new LiteralControl("<div class='col-md-7 text-right'>"));
                rbList = new RadioButtonList();
                rbList.ID = "uds" + value.ItemId.ToString();
                rbList.RepeatColumns = 4;
                rbList.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                rbList.CssClass = "rbList";
                lookUp.populateRBL(rbList, "DepressionFrequency");
                PlaceHolder1.Controls.Add(rbList);
                PlaceHolder1.Controls.Add(new LiteralControl("</div>"));
                PlaceHolder1.Controls.Add(new LiteralControl("</div>"));
                PlaceHolder1.Controls.Add(new LiteralControl("<hr />"));
            }
            //Depression Total
            PHDepressionTotal.Controls.Add(new LiteralControl("<div class='input-group'>"));
            PHDepressionTotal.Controls.Add(new LiteralControl("<span class='input-group-addon'>Total</span>"));
            depressionTotalTb = new TextBox();
            depressionTotalTb.CssClass = "form-control input-sm";
            depressionTotalTb.ClientIDMode = System.Web.UI.ClientIDMode.Static;
            depressionTotalTb.ID = "uds" + LookupLogic.GetLookupItemId("DepressionTotal");

            //depressionTotalTb.ID = LookupLogic.GetLookupItemId("DepressionTotal");
            depressionTotalTb.Enabled = false;
            PHDepressionTotal.Controls.Add(depressionTotalTb);
            PHDepressionTotal.Controls.Add(new LiteralControl("<span class='input-group-addon'>/ 27</span>"));
            PHDepressionTotal.Controls.Add(new LiteralControl("</div>"));
            //Depression Severity
            PHDepressionSeverity.Controls.Add(new LiteralControl("<div class='input-group'>"));
            PHDepressionSeverity.Controls.Add(new LiteralControl("<span class='input-group-addon'>Depression Severity</span>"));
            depressionSeverityTb = new TextBox();
            depressionSeverityTb.CssClass = "form-control input-sm";
            depressionSeverityTb.ClientIDMode = System.Web.UI.ClientIDMode.Static;
            // depressionSeverityTb.ID = LookupLogic.GetLookupItemId("DepressionSeverity");
            depressionSeverityTb.ID = "uds" + LookupLogic.GetLookupItemId("DepressionSeverity");
            depressionSeverityTb.Enabled = false;
            PHDepressionSeverity.Controls.Add(depressionSeverityTb);
            PHDepressionSeverity.Controls.Add(new LiteralControl("</div>"));
            //Reccommended Management
            PHRecommendedManagement.Controls.Add(new LiteralControl("<div class='input-group'>"));
            PHRecommendedManagement.Controls.Add(new LiteralControl("<span class='input-group-addon'>Reccommended Management</span>"));
            depressionReccommendationTb = new TextBox();
            depressionReccommendationTb.CssClass = "form-control input-sm";
            depressionReccommendationTb.ClientIDMode = System.Web.UI.ClientIDMode.Static;
            depressionReccommendationTb.ID ="uds"+ LookupLogic.GetLookupItemId("ReccommendedManagement");
            depressionReccommendationTb.Enabled = false;
            PHRecommendedManagement.Controls.Add(depressionReccommendationTb);
            PHRecommendedManagement.Controls.Add(new LiteralControl("</div>"));
        }

        public void getDepressionScreeningData()
        {
            var PSM = new PatientScreeningManager();
            List<PatientScreening> screeningList = PSM.GetPatientScreeningByVisitId(PatientId, PatientMasterVisitId);
            if (screeningList != null)
            {
                foreach (var value in screeningList)
                {
                    depressionId = Convert.ToInt32(value.ScreeningTypeId);
                    RadioButtonList rblPC1Qs = (RadioButtonList)PlaceHolder1.FindControl("uds" + value.ScreeningCategoryId.ToString());
                    if (rblPC1Qs != null)
                    {
                        rblPC1Qs.SelectedValue = value.ScreeningValueId.ToString();
                    }
                    RadioButtonList rblPC2Qs = (RadioButtonList)PlaceHolder2.FindControl("uds" + value.ScreeningCategoryId.ToString());
                    if (rblPC2Qs != null)
                    {
                        rblPC2Qs.SelectedValue = value.ScreeningValueId.ToString();
                    }
                }
            }
            var PCN = new PatientClinicalNotesLogic();
            List<PatientClinicalNotes> notesList = PCN.getPatientClinicalNotesByVisitId(PatientId, PatientMasterVisitId);
                //getPatientClinicalNotes(PatientId);
            if (notesList.Any())
            {
                foreach (var value in notesList)
                {
                    TextBox ntb = (TextBox)PlaceHolder2.FindControl("uds" +value.NotesCategoryId.ToString());
                    if (ntb != null)
                    {
                        ntb.Text = value.ClinicalNotes;
                    }
                }
            }
        }
    }
}