﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IQCare.Common.Core.Models
{
    public class PatientWHOStage
    {
        public int Id { get; set; }
        public int PatientId { get; set; }
        public int PatientMasterVisitId {get;set;}
        public int WHOStage { get; set; }
    }
}
