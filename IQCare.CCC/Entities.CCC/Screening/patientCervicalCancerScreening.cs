using Entities.CCC.Visit;
using Entities.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

namespace Entities.CCC.Screening
{
    [Serializable]
    [Table("PatientCervicalCancerScreening")]
    public class PatientCervicalCancerScreening : BaseObject
    {
        [Column]

        public int PatientId { get; set; }
        public int PatientMasterVisitId { get; set; }
        [ForeignKey("PatientMasterVisitId")]
        public virtual PatientMasterVisit PatientMasterVisit { get; set; }
        public DateTime? VisitDate { get; set; }
        public DateTime? AppointmentDate { get; set; }
        public String ReferredTo { get; set; }
    }
}