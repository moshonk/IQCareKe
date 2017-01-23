﻿using Entities.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

namespace Entities.PatientCore
{
    [Serializable]
    public class PatientOVCStatus : BaseEntity
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey("PersonId")]
        public virtual int PersonId { get; set; }
        public virtual Person person { get; set; }      
        public bool Orphan { get; set; }
        public bool InSchool { get; set; }
        public bool Active { get; set; }
    }
}
