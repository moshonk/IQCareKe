﻿using Application.Presentation;
using Interface.CCC;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;
using static Entities.CCC.Encounter.PatientEncounter;

namespace IQCare.CCC.UILogic
{
    public class PatientEncounterLogic
    {
        public int savePatientEncounterPresentingComplaints(string patientMasterVisitID, string patientID, string serviceID, string VisitDate, string VisitScheduled, string VisitBy, string Complaints, int TBScreening, int NutritionalStatus, string lmp, string PregStatus, string edd, string ANC, int OnFP, int fpMethod, string CaCx, string STIScreening, string STIPartnerNotification, string adverseEvent)
        {
            IPatientEncounter patientEncounter = (IPatientEncounter)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPatientEncounter, BusinessProcess.CCC");
            JavaScriptSerializer parser = new JavaScriptSerializer();
            var advEvent = parser.Deserialize<List<AdverseEvents>>(adverseEvent);
            int val = patientEncounter.savePresentingComplaints(patientMasterVisitID, patientID, serviceID,VisitDate,VisitScheduled,VisitBy, Complaints, TBScreening, NutritionalStatus, lmp,PregStatus,edd,ANC, OnFP, fpMethod, CaCx,STIScreening,STIPartnerNotification, advEvent);
            return val;
        }

        public void savePatientEncounterChronicIllness(string masterVisitID, string patientID, string chronicIllness, string Vaccines)
        {
            IPatientEncounter patientEncounter = (IPatientEncounter)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPatientEncounter, BusinessProcess.CCC");
            JavaScriptSerializer parser = new JavaScriptSerializer();
            var chrIllness = parser.Deserialize<List<ChronicIlness>>(chronicIllness);
            var vacc = parser.Deserialize<List<Vaccines>>(Vaccines);
            int val = patientEncounter.saveChronicIllness(masterVisitID, patientID, chrIllness, vacc);
        }

        public void savePatientEncounterPhysicalExam(string masterVisitID, string patientID, string physicalExam)
        {
            IPatientEncounter patientEncounter = (IPatientEncounter)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPatientEncounter, BusinessProcess.CCC");
            JavaScriptSerializer parser = new JavaScriptSerializer();
            var phyExam = parser.Deserialize<List<PhysicalExamination>>(physicalExam);
            int val = patientEncounter.savePhysicalEaxminations(masterVisitID, patientID, phyExam);
        }

        public void savePatientManagement(string PatientMasterVisitID, string PatientID, string ARVAdherence, string CTXAdherence, string nextAppointment, string appointmentType, string phdp, string diagnosis)
        {
            IPatientEncounter patientEncounter = (IPatientEncounter)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPatientEncounter, BusinessProcess.CCC");
            JavaScriptSerializer parser = new JavaScriptSerializer();
            var diag = parser.Deserialize<List<Diagnosis>>(diagnosis);
            List<string> PHDPList = phdp.Split(',').ToList();
            int val = patientEncounter.savePatientManagement(PatientMasterVisitID,PatientID,ARVAdherence,CTXAdherence,nextAppointment,appointmentType, PHDPList, diag);
        }

        public DataSet loadPatientEncounter(int PatientMasterVisitID, string PatientID)
        {
            IPatientEncounter patientEncounter = (IPatientEncounter)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPatientEncounter, BusinessProcess.CCC");
            return patientEncounter.getPatientEncounter(PatientMasterVisitID.ToString(), PatientID);
        }

        public void EncounterHistory(TreeView TreeViewEncounterHistory)
        {
            IPatientEncounter patientEncounter = (IPatientEncounter)ObjectFactory.CreateInstance("BusinessProcess.CCC.BPatientEncounter, BusinessProcess.CCC");
            DataTable theDT = patientEncounter.getPatientEncounterHistory("1");

            int tmpYear = 0;
            int tmpMonth = 0;
            TreeNode root = new TreeNode();
            TreeNode theMRoot = new TreeNode();
            bool flagyear = true;

            foreach (DataRow theDR in theDT.Rows)
            {

                if (theDR["visitDate"] != DBNull.Value && theDR["visitDate"].ToString().Trim() != "" && ((DateTime)theDR["visitDate"]).Year != 1900)
                {
                    if (tmpYear != ((DateTime)theDR["visitDate"]).Year)
                    {
                        root = new TreeNode();
                        root.Text = ((DateTime)theDR["visitDate"]).Year.ToString();
                        root.Value = "";
                        if (flagyear)
                        {
                            root.Expand();
                            flagyear = false;
                        }
                        else
                        {
                            root.Collapse();
                        }
                        TreeViewEncounterHistory.Nodes.Add(root);
                        tmpYear = ((DateTime)theDR["visitDate"]).Year;
                        tmpMonth = 0;
                    }

                    if (tmpYear == ((DateTime)theDR["visitDate"]).Year && tmpMonth != ((DateTime)theDR["visitDate"]).Month)
                    {
                        theMRoot = new TreeNode();
                        theMRoot.Text = ((DateTime)theDR["visitDate"]).ToString("MMMM");
                        theMRoot.Value = "";
                        root.ChildNodes.Add(theMRoot);
                        tmpMonth = ((DateTime)theDR["visitDate"]).Month;
                    }

                    if (tmpYear == ((DateTime)theDR["visitDate"]).Year && tmpMonth == ((DateTime)theDR["visitDate"]).Month)
                    {
                        TreeNode theFrmRoot = new TreeNode();
                        theFrmRoot.Text = theDR["VisitName"].ToString() + " ( " + ((DateTime)theDR["visitDate"]).ToString(HttpContext.Current.Session["AppDateFormat"].ToString()) + " ) - " + theDR["UserName"].ToString();
                        string _VisitName = theDR["VisitName"].ToString();
                        theFrmRoot.ImageUrl = "~/images/15px-Yes_check.svg.png";
                        //if (Convert.ToString(Session["TechnicalAreaId"]) == Convert.ToString(theDR["Module"]) || theDR["VisitName"].ToString() == "Patient Registration")
                        //{
                        //    if (DQ != "")
                        //    {
                        //        theFrmRoot.ImageUrl = "~/images/15px-Yes_check.svg.png";
                        //    }
                        //    else if (theDR["CAUTION"].ToString() == "1")
                        //    {
                        //        theFrmRoot.ImageUrl = "~/images/caution.png";
                        //    }
                        //    else
                        //    {
                        //        theFrmRoot.ImageUrl = "~/Images/No_16x.ico";
                        //    }
                        //}
                        //else
                        //{
                        //    if ((_VisitName == "Pharmacy") || (_VisitName == "Laboratory") || (_VisitName == "Paediatric Pharmacy") || _VisitName.Contains("Service Request"))
                        //    {
                        //        if (Session["Paperless"].ToString() == "1")
                        //        {

                        //            if ((_VisitName == "Pharmacy") || (_VisitName == "Laboratory") || (_VisitName == "Paediatric Pharmacy") || _VisitName.Contains("Service Request"))
                        //            {
                        //                if (theDR["CAUTION"].ToString() == "1")
                        //                {
                        //                    theFrmRoot.ImageUrl = "~/images/caution.png";
                        //                }
                        //                else
                        //                    theFrmRoot.ImageUrl = "~/images/15px-Yes_check.svg.png";
                        //            }

                        //        }
                        //        else
                        //        {
                        //            if (DQ != "")
                        //            {
                        //                theFrmRoot.ImageUrl = "~/images/15px-Yes_check.svg.png";
                        //            }
                        //            else
                        //            {
                        //                theFrmRoot.ImageUrl = "~/Images/No_16x.ico";
                        //            }
                        //        }
                        //    }
                        //    else
                        //    {
                        //        //find if form is linked to this module

                        //        if (linkedForms != null && linkedForms.Select("VisitName = '" + _VisitName + "'").Length > 0)
                        //        {
                        //            if (DQ != "")
                        //            {
                        //                theFrmRoot.ImageUrl = "~/images/15px-Yes_check.svg.png";
                        //            }
                        //            else
                        //            {
                        //                theFrmRoot.ImageUrl = "~/Images/No_16x.ico";
                        //            }
                        //        }
                        //        else
                        //        {
                        //            theFrmRoot.ImageUrl = "~/Images/lock.jpg";
                        //            theFrmRoot.ImageToolTip = "You are Not Authorized to Access this Functionality";
                        //            theFrmRoot.SelectAction = TreeNodeSelectAction.None;
                        //        }
                        //    }
                        //}
                        //else
                        //{
                        //    if (Convert.ToInt32(theDR["Module"]) > 2)
                        //    {
                        //        theFrmRoot.ImageUrl = "~/Images/lock.jpg";
                        //        theFrmRoot.ImageToolTip = "You are Not Authorized to Access this Functionality";
                        //        theFrmRoot.SelectAction = TreeNodeSelectAction.None;
                        //    }

                        //    else if (Convert.ToString(Session["TechnicalAreaId"]) == Convert.ToString(theDR["Module"]) || (_VisitName == "Pharmacy") || 
                        //        (_VisitName == "Laboratory") || (_VisitName == "Paediatric Pharmacy") ||_VisitName.Contains("Service Request") )
                        //    {

                        //    }
                        //    else
                        //    {
                        //        theFrmRoot.ImageUrl = "~/Images/lock.jpg";
                        //        theFrmRoot.ImageToolTip = "You are Not Authorized to Access this Functionality";
                        //        theFrmRoot.SelectAction = TreeNodeSelectAction.None;
                        //    }
                        //}
                        theFrmRoot.NavigateUrl = "PatientEncounter.aspx?visitId=" + theDR["visitID"].ToString();
                        theFrmRoot.Value = "";// Convert.ToInt32(PId) + "%" + theDR["OrderNo"].ToString() + "%" + theDR["LocationID"].ToString() + "%" + PtnARTStatus + "%" + theDR["Module"].ToString() + "%" + theDR["VisitName"].ToString();
                        theMRoot.ChildNodes.Add(theFrmRoot);
                    }
                }

            }

        }

    }
}