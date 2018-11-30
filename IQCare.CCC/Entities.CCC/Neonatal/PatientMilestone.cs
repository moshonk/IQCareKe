﻿using System;
using Entities.CCC.Enrollment;
using Entities.CCC.Visit;
using Entities.Common;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Entities.CCC.Neonatal
{
    [Serializable]
    [Table("PatientMilestone")]
    public class PatientMilestone:BaseEntity
    {
        [Key]
        public int Id { get; set; }
        public int PatientId { get; set; }
        [ForeignKey("PatientId")]
        public virtual PatientEntity Patient { get; set; }
        public int PatientMasterVisitId { get; set; }
        [ForeignKey("PatientMasterVisitId")]
        public virtual PatientMasterVisit PatientMasterVisit { get; set; }
        public int TypeAssessedId { get; set; }
        public DateTime? DateAssessed { get; set; }
        public int AchievedId { get; set; }
        public int  StatusId { get; set; }
        public string Comment { get; set; }
    }
}

