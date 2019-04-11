﻿using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Application.Presentation;
using Entities.CCC.Lookup;
using Interface.CCC.Lookup;
using IQCare.CCC.UILogic.Triage;

namespace IQCare.Web.CCC.UC
{
    public partial class ucFemaleVitals : System.Web.UI.UserControl
    {
        protected int PatientId
        {
            get { return Convert.ToInt32(Session["PatientPK"]); }
        }

        protected int PatientMasterVisitId
        {
            get { return Convert.ToInt32(Session["patientMasterVisitId"]); }
        }

        protected string PatientGender
        {
            get { return Convert.ToString( Session["Gender"]); }
        }

        protected int PatientAge
        {
            get { return Convert.ToInt32(Session["Age"]); }
        }

        public int CaCxScreeningId { get; set; }
        public int STIScreeningId { get; set; }
        public int STIPartnerNotificationId { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ILookupManager lookupManager = (ILookupManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.BLookupManager, BusinessProcess.CCC");

            //load dropdown values
            List<LookupItemView> lookupItem = lookupManager.GetLookItemByGroup("PregnancyStatus");
            if (lookupItem != null && lookupItem.Count > 0)
            {
                examinationPregnancyStatus.Items.Add(new ListItem("select", "0"));
                foreach (var k in lookupItem)
                {
                    examinationPregnancyStatus.Items.Add(new ListItem(k.ItemDisplayName + "(" + k.ItemName + ")", k.ItemId.ToString()));
                }
            }

            /* cacx screening */
            List<LookupItemView> cacxList = lookupManager.GetLookItemByGroup("CaCxScreening");
            if (cacxList != null && cacxList.Count > 0)
            {
                CaCxScreeningId = cacxList[0].MasterId;
                cacxscreening.Items.Add(new ListItem("select", "0"));
                foreach (var k in cacxList)
                {
                    cacxscreening.Items.Add(new ListItem(k.ItemName, k.ItemId.ToString()));
                }
            }


            List<LookupItemView> stiScreeList = lookupManager.GetLookItemByGroup("STIScreening");
            if (stiScreeList != null && stiScreeList.Count > 0)
            {
                STIScreeningId = stiScreeList[0].MasterId;
                stiScreening.Items.Add(new ListItem("select", "0"));
                foreach (var k in stiScreeList)
                {
                    stiScreening.Items.Add(new ListItem(k.ItemName, k.ItemId.ToString()));
                }
            }

            List<LookupItemView> stiPartnerList = lookupManager.GetLookItemByGroup("STIPartnerNotification");
            if (stiPartnerList != null && stiPartnerList.Count > 0)
            {
                STIPartnerNotificationId = stiPartnerList[0].MasterId;
                stiPartnerNotification.Items.Add(new ListItem("select", "0"));
                foreach (var k in stiPartnerList)
                {
                    stiPartnerNotification.Items.Add(new ListItem(k.ItemName, k.ItemId.ToString()));
                }
            }


            List<LookupItemView> fpStatusList = lookupManager.GetLookItemByGroup("FPStatus");
            if (fpStatusList != null && fpStatusList.Count > 0)
            {
                onFP.Items.Add(new ListItem("select", "0"));
                foreach (var k in fpStatusList)
                {
                    onFP.Items.Add(new ListItem(k.ItemDisplayName + "(" + k.ItemName + ")", k.ItemId.ToString()));
                }
            }

            List<LookupItemView> fpMethodList = lookupManager.GetLookItemByGroup("FPMethod");
            if (fpMethodList != null && fpMethodList.Count > 0)
            {
                //fpMethod.Items.Add(new ListItem("select", "0"));
                foreach (var k in fpMethodList)
                {
                    fpMethod.Items.Add(new ListItem(k.ItemDisplayName+"("+ k.ItemName+")", k.ItemId.ToString()));
                }
            }

            List<LookupItemView> NoFPLookup = lookupManager.GetLookItemByGroup("NoFamilyPlanning");
            if (NoFPLookup != null && NoFPLookup.Count > 0)
            {
                ddlNoFP.Items.Add(new ListItem("select", "0"));
                foreach (var k in NoFPLookup)
                {
                    ddlNoFP.Items.Add(new ListItem(k.ItemDisplayName + "(" + k.ItemName + ")", k.ItemId.ToString()));
                }
            }

            List<LookupItemView> pregnancyOutCome = lookupManager.GetLookItemByGroup("PregnancyOutcome");
            if (pregnancyOutCome != null && pregnancyOutCome.Count > 0)
            {
                PregnancyOutCome.Items.Add(new ListItem("select", "0"));
                foreach (var item in pregnancyOutCome)
                {
                    PregnancyOutCome.Items.Add(new ListItem(item.ItemDisplayName + "(" + item.ItemName + ")", item.ItemId.ToString()));
                }
            }

            List<LookupItemView> fpIneligibilityReason = lookupManager.GetLookItemByGroup("FpIneligibilityReason");
            if (fpIneligibilityReason != null && fpIneligibilityReason.Count > 0)
            {
                FpIneligibilityReason.Items.Add(new ListItem("select", "0"));
                foreach (var item in fpIneligibilityReason)
                {
                    FpIneligibilityReason.Items.Add(new ListItem(item.ItemDisplayName, item.ItemId.ToString()));
                }
            }

            List<LookupItemView> fpServiceOffered = lookupManager.GetLookItemByGroup("FpServiceOffered");
            if (fpServiceOffered != null && fpServiceOffered.Count > 0)
            {
                FpServiceOffered.Items.Add(new ListItem("select", "0"));
                foreach (var item in fpServiceOffered)
                {
                    FpServiceOffered.Items.Add(new ListItem(item.ItemDisplayName, item.ItemId.ToString()));
                }
            }

            List<LookupItemView> partnerHivStatus = lookupManager.GetLookItemByGroup("PartnerHivStatus");
            if (partnerHivStatus != null && partnerHivStatus.Count > 0)
            {
                PartnerHivStatus.Items.Add(new ListItem("select", "0"));
                foreach (var item in partnerHivStatus)
                {
                    PartnerHivStatus.Items.Add(new ListItem(item.ItemDisplayName, item.ItemId.ToString()));
                }
            }

            CheckBoxList cblPregnancySymptoms = new CheckBoxList();
            ListItem li;
            List<LookupItemView> pregnancySymptomsLookup = lookupManager.GetLookItemByGroup("pregnancySymptoms");
            foreach (var item in pregnancySymptomsLookup)
            {
                li = new ListItem(item.ItemDisplayName, item.ItemId.ToString());
                li.Attributes.Add("data-value", item.ItemId.ToString());
                li.Attributes.Add("class", "pull-left");
                cblPregnancySymptoms.Items.Add(li);
            }
            pregnancySymptoms.Controls.Add(cblPregnancySymptoms);

            string gender = Session["Gender"].ToString();

            if (gender == "Female")
            {
                var pregnancyStatus = new PatientPregnancyManager();
                int pgStatus = pregnancyStatus.CheckIfPatientPregnancyExisists(PatientId);
                var pregnancyList = pregnancyStatus.GetPatientPregnancy(PatientId);
                if (pgStatus > 0)
                {
                    lblPregnancyStatus.Text = "<span class='label label-info'> Pregnant </span> ";
                    if (pregnancyList != null)
                    {
                        foreach (var item in pregnancyList)
                        {
                            lblLMP.Text = "<span class='label label-info'>LMP : " + item.LMP.ToString("dd-MMM-yyyy") +
                                          "</span>";

                            lblEDD.Text = "<span class='label label-info'>EDD : " +
                                          Convert.ToDateTime(item.EDD).ToString("dd-MMM-yyyy") + "</span>";

                        }
                    }
                }
            }


        }
    }
}