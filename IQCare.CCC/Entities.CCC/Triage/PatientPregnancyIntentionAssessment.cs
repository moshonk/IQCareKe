using Entities.CCC.Enrollment;
using Entities.CCC.Visit;
using Entities.Common;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Entities.CCC.Triage
{
    [Serializable]
    [Table("PatientPregnancyIntentionAssessment")]
    public class PatientPregnancyIntentionAssessment : BaseEntity
    {
        [Column]
        [Key]
        public int Id { get; set; }

        [Required]
        public int PatientId { get; set; }
        [ForeignKey("PatientId")]
        public virtual PatientEntity Patient { get; set; }

        [Required]
        public int PatientMasterVisitId { get; set; }
        public virtual PatientMasterVisit PatientMasterVisit { get; set; }

        [Required]
        public DateTime? VisitDate { get; set; }

        public int PartnerHivStatus { get; set; }
        public String ClientEligibleForFP { get; set; }
        public int ServiceForEligibleClient { get; set; }
        public int ReasonForFpIneligibility { get; set; }
        public String PlanningToConceive3M { get; set; }
        public String RegularMenses { get; set; }
        public String InitiatedOnART { get; set; }
    }
}
