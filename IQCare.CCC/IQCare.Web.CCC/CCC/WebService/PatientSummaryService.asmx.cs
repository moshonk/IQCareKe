﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using IQCare.CCC.UILogic;
using Microsoft.JScript;
using Convert = System.Convert;

namespace IQCare.Web.CCC.WebService
{
    /// <summary>
    /// Summary description for PatientSummaryService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class PatientSummaryService : System.Web.Services.WebService
    {
        public string msg { get; set; }

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod(EnableSession = true)]
        public string UpdatePatientBio(int patientId, string bioFirstName, string bioMiddleName, string bioLastName, int userId, string bioPatientPopulation, int keyPop)
        {
            int personId = 0;
            int gender = 0;
            try
            {
                bioFirstName = GlobalObject.unescape(bioFirstName);
                bioMiddleName = GlobalObject.unescape(bioMiddleName);
                bioLastName = GlobalObject.unescape(bioLastName);

                var personManager = new PersonManager();
                var patientLogic = new PatientLookupManager();
                var patient = patientLogic.GetPatientDetailSummary(patientId);
                personId = patient[0].PersonId;
                gender = patient[0].Sex;

                personManager.UpdatePerson(bioFirstName, bioMiddleName, bioLastName, gender, userId, personId);
                msg = "<p>Patient Bio Updated Successfully</p>";

                var personPoulation = new PatientPopulationManager();
                var population = personPoulation.GetCurrentPatientPopulations(personId);
                if (population.Count > 0)
                {
                    population[0].PopulationCategory = keyPop;
                    population[0].PopulationType = bioPatientPopulation;

                    personPoulation.UpdatePatientPopulation(population[0]);

                    msg += "<p>Person Population Edited Successfully.</p>";

                }
                else
                {
                    int Result = personPoulation.AddPatientPopulation(personId, bioPatientPopulation, keyPop, userId);
                    if (Result > 0)
                    {
                        msg += "<p>Person Population Status Recorded Successfully!</p>";
                    }
                }

                return msg;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public string AddPatientTreatmentSupporter(int patientId, string firstName , string middleName , string lastName , int gender , string mobile, int userId )
        {
            var patientLogic = new PatientLookupManager();
            var patient = patientLogic.GetPatientDetailSummary(patientId);
            var personId = patient[0].PersonId;


            var personLogic = new PersonManager();

            var personTreatmentSupporterId = personLogic.AddPersonTreatmentSupporterUiLogic(firstName,
                    middleName,
                    lastName, gender, userId);
                Session["PersonTreatmentSupporterId"] = personTreatmentSupporterId;

            if (personTreatmentSupporterId > 0)
            {
                msg += "<p>New Treatment Supporter Person Added Successfully!</p>";

                var treatmentSupporter = new PatientTreatmentSupporterManager();
                var treatment = treatmentSupporter.GetPatientTreatmentSupporter(personId);

                if (treatment.Count > 0)
                {
                    treatment[0].DeleteFlag = true;
                    treatmentSupporter.UpdatePatientTreatmentSupporter(treatment[0]);
                }

                var result = treatmentSupporter.AddPatientTreatmentSupporter(personId, personTreatmentSupporterId,
                    mobile, userId);
                if (result > 0)
                {
                    msg += "<p>Person Treatement Supported Added Successfully!</p>";
                }
            }

            return msg;
        }
    }
}
