using Application.Presentation;
using BusinessProcess.CCC;
using Entities.CCC;
using Interface.CCC;
using IQCare.CCC.UILogic.Screening;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;

namespace IQCare.Web.CCC.WebService
{
    /// <summary>
    /// Summary description for Covid19UpdateService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Covid19UpdateService : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public Covid19Screening UpdateDatabase(
            int id,
            string document_Id,
            string serial_number,
            DateTime screening_date,
            string client_name,
            string county_of_residence,
            decimal age,
            decimal age_in_months,
            decimal age_in_days,
            string sex,
            string telephone_number,
            string type_of_client,
            decimal temperature,
            string travel_history,
            string nature_of_travel,
            string country_of_travel,
            string county_of_travel,
            string fever,
            string cough,
            string difficulty_in_breathing,
            string sore_throat,
            string body_ache,
            string chest_pain,
            string headache,
            string nausea,
            string vomiting,
            string runny_nose,
            string diarrhoea,
            string lack_of_smell,
            string lack_of_taste,
            string contact_with_probable_case,
            string living_with_confirmed_case,
            string hcw_caring_for_confirmed_case,
            string hcw_not_caring_for_confirmed_case,
            string hcw_screening,
            string any_comorbidity,
            string diabetes,
            string hypertension,
            string chronic_respiratory_condition,
            string chronic_heart_condition,
            string chronic_kidney_disease,
            string obesity,
            string smoker,
            string department,
            string screening_outcome,
            string pregnant,
            string weight_loss,
            string night_sweat,
            string contact_tb_case,
            string ever_tested,
            string created_by,
            DateTime date_created
            )
        {
            Covid19Screening covid19screening = new Covid19Screening()
            {
                document_id = document_Id,
                serial_number = serial_number,
                screening_date = screening_date,
                client_name = client_name,
                county_of_residence = county_of_residence,
                age = age,
                age_in_months = age_in_months,
                age_in_days = age_in_days,
                sex = sex,
                telephone_number = telephone_number,
                type_of_client = type_of_client,
                temperature = temperature,
                travel_history = travel_history,
                nature_of_travel = nature_of_travel,
                country_of_travel = country_of_travel,
                county_of_travel = county_of_travel,
                fever = fever,
                cough = cough,
                difficulty_in_breathing = difficulty_in_breathing,
                sore_throat = sore_throat,
                body_ache = body_ache,
                chest_pain = chest_pain,
                headache = headache,
                nausea = nausea,
                vomiting = vomiting,
                runny_nose = runny_nose,
                diarrhoea = diarrhoea,
                lack_of_smell = lack_of_smell,
                lack_of_taste = lack_of_taste,
                contact_with_probable_case = contact_with_probable_case,
                living_with_confirmed_case = living_with_confirmed_case,
                hcw_caring_for_confirmed_case = hcw_caring_for_confirmed_case,
                hcw_not_caring_for_confirmed_case = hcw_not_caring_for_confirmed_case,
                any_comorbidity = any_comorbidity,
                diabetes = diabetes,
                hypertension = hypertension,
                chronic_respiratory_condition = chronic_respiratory_condition,
                chronic_heart_condition = chronic_heart_condition,
                chronic_kidney_disease = chronic_kidney_disease,
                obesity = obesity,
                smoker = smoker,
                department = department,
                screening_outcome = screening_outcome,
                pregnant = pregnant,
                weight_loss = weight_loss,
                night_sweat = night_sweat,
                contact_tb_case = contact_tb_case,
                ever_tested = ever_tested,
                date_created = date_created,
                created_by = created_by
            };

            Covid19Screening screeningRecord = new Covid19ScreeningManager().AddUpdateCovid19Screening(covid19screening);

            return screeningRecord;
        }

    }

}
