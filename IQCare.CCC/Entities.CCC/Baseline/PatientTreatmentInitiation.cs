﻿using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Entities.CCC.Enrollment;
using Entities.CCC.Visit;
using Entities.Common;

namespace Entities.CCC.Baseline
{
    [Serializable]
    [Table("PatientTreatmentInitiation")]
   public class PatientTreatmentInitiation:BaseEntity
    {
        [Key]
        public int Id { get; set; }
      
        public int PatientId { get; set; }
        [ForeignKey("PatientId")]
        public virtual PatientEntity PatientEntity { get; set; }
        public int PatientMasterVisitId { get; set; }
        public DateTime DateStartedOnFirstline { get; set; }
        public string Cohort { get; set; }
        public int Regimen { get; set; }
        public decimal BaselineViralload { get; set; }
        public DateTime BaselineViralloadDate { get; set; }
        [ForeignKey("PatientId")]
        public virtual PatientEntity Patient { get; set; }
        [ForeignKey("PatientMasterVisitId")]
        public virtual PatientMasterVisit PatientMasterVisit { get; set; }

    }
}
