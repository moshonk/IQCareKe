using Entities.CCC.Enrollment;
using Entities.Common;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Entities.CCC.Triage
{
    [Serializable]
    [System.ComponentModel.DataAnnotations.Schema.Table("PatientPIAPregnancySymptom")]

    public class PatientPIAPregnancySymptom : BaseEntity
    {
        [System.ComponentModel.DataAnnotations.Schema.Column]
        [Key]

        public int Id { get; set; }

        [Required]
        public int PatientId { get; set; }
        [ForeignKey("PatientId")]
        public virtual PatientEntity Patient { get; set; }

        [Required]
        public int PatientPIAId { get; set; }

        [Required]
        public int PregnancySymptomId { get; set; }

    }
}
