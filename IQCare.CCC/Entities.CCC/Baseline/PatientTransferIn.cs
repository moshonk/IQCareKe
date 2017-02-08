﻿using Entities.CCC.Enrollment;
using Entities.Common;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Entities.CCC.Visit;

namespace Entities.CCC.Baseline
{
    [Serializable]
    [Table("PatientTransferIn")]

    public class PatientTransferIn:BaseEntity
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey("Patient")]
        public int PatientId { get; set; }
        public int ServiceAreaId { get; set; }
        [ForeignKey("PatientMasterVisit")]
        public int PatientMasterVisitId { get; set; }
        public DateTime TransferInDate { get; set; }
        public DateTime TreatmentStartDate { get; set; }
        public string CurrentTreatment { get; set; }
        public string FacilityFrom { get; set; }
        public int MflCode { get; set; }
        public string CountyFrom { get; set; }
        public string TransferInNotes { get; set; }

        public virtual PatientEntity Patient { get; set; }
        public virtual PatientMasterVisit PatientMasterVisit { get; set; }


    }
}
