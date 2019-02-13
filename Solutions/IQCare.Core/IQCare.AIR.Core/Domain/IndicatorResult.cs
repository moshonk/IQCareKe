﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IQCare.AIR.Core.Domain
{
    public class IndicatorResult
    {
        public IndicatorResult()
        {
            
        }

        public int Id { get; private set; }
        public int ReportingPeriodId { get; private set; }
        public int IndicatorId { get; private set; }
        public string ResultText { get; private set; }
        public decimal ResultNumeric { get; private set; }
        public DateTime DateCreated { get; private set; }
        public int CreatedBy { get; private set; }
        public DateTime? DateUpdated { get; private set; }
        public bool Active { get; private set; }
        public virtual  ReportingPeriod ReportingPeriod { get; set; }
        public virtual Indicator Indicator { get; set; }

    }
}
