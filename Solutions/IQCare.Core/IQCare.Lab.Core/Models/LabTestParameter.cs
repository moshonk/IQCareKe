﻿using System;

namespace IQCare.Lab.Core.Models
{
    public class LabTestParameter
    {
        public int Id { get; set; }

        public string ReferenceId { get; set; }

        public string ParameterName { get; set; }

        public int LabTestId { get; set; }

        public string DataType { get; set; }

        public int OrdRank { get; set; }

        public string LoincCode { get; set; }

        public int? UserId { get; set; }

        public DateTime CreateDate { get; set; }

        public DateTime? UpdateDate { get; set; }

        public bool DeleteFlag { get; set; }

        public virtual LabTest LabTest { get; set; }
    }
}