using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.CCC
{
    [Serializable]
    [Table("jootrh_covid19_screening")]
    public class Covid19Screening
    {
        [Key]
        public int id { get; set; }
        [Column]
        public string document_id { get; set; }
        [Column]
        public String serial_number { get; set; }
        [Column]
        public DateTime? screening_date { get; set; }
        [Column]
        public string client_name { get; set; }
        [Column]
        public string county_of_residence { get; set; }
        [Column]
        public string telephone_number { get; set; }
        [Column]
        public string type_of_client { get; set; }
        [Column]
        public decimal age { get; set; }
        [Column]
        public decimal age_in_months { get; set; }
        [Column]
        public decimal age_in_days { get; set; }
        [Column]
        public string sex { get; set; }
        [Column]
        public decimal temperature { get; set; }
        [Column]
        public string travel_history { get; set; }
        [Column]
        public string nature_of_travel { get; set; }
        [Column]
        public string country_of_travel { get; set; }
        [Column]
        public string county_of_travel { get; set; }
        [Column]
        public string fever { get; set; }
        [Column]
        public string cough { get; set; }
        [Column]
        public string difficulty_in_breathing { get; set; }
        [Column]
        public string sore_throat { get; set; }
        [Column]
        public string body_ache { get; set; }
        [Column]
        public string chest_pain { get; set; }
        [Column]
        public string headache { get; set; }
        [Column]
        public string nausea { get; set; }
        [Column]
        public string vomiting { get; set; }
        [Column]
        public string runny_nose { get; set; }
        [Column]
        public string diarrhoea { get; set; }
        [Column]
        public string lack_of_smell { get; set; }
        [Column]
        public string lack_of_taste { get; set; }
        [Column]
        public string contact_with_probable_case { get; set; }
        [Column]
        public string living_with_confirmed_case { get; set; }
        [Column]
        public string hcw_screening { get; set; }
        [Column]
        public string hcw_not_caring_for_confirmed_case { get; set; }
        [Column]
        public string hcw_caring_for_confirmed_case { get; set; }
        [Column]
        public string any_comorbidity { get; set; }
        [Column]
        public string diabetes { get; set; }
        [Column]
        public string hypertension { get; set; }
        [Column]
        public string chronic_respiratory_condition { get; set; }
        [Column]
        public string chronic_heart_condition { get; set; }
        [Column]
        public string chronic_kidney_disease { get; set; }
        [Column]
        public string obesity { get; set; }
        [Column]
        public string smoker { get; set; }
        [Column]
        public string department { get; set; }
        [Column]
        public string screening_outcome { get; set; }
        [Column]
        public string pregnant { get; set; }
        [Column]
        public string weight_loss { get; set; }
        [Column]
        public string night_sweat { get; set; }
        [Column]
        public string contact_tb_case { get; set; }
        [Column]
        public string ever_tested { get; set; }
        [Column]
        public string created_by { get; set; }
        [Column]
        public DateTime? date_created { get; set; }
    }
}
