﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace IQCare.Lab.Core.Models
{
    public class PatientLabTracker
    {
        public PatientLabTracker()
        {

        }
            int facilityId, DateTime ? sampleDate, int createdBy)
        {
            PatientId = patientId;
            LabName = labName;
            PatientMasterVisitId = patientMasterVisitId;
            LabTestId = labTestId;
            LabOrderId = labOrderId;
            FacilityId = facilityId;
            CreatedBy = createdBy;
            CreateDate = DateTime.Now;
            Results = LabOrderStatus.Pending.ToString();
        }
        public DateTime? SampleDate { get; set; }
        public string Results { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreateDate { get; set; }

        public void UpdateResults(decimal resultValues, DateTime resultDate,string resultText,string resultUnit)
        {
            ResultValues = resultValues;
            ResultDate = resultDate;
            ResultTexts = resultText;
            ResultUnits = resultUnit;
            Results = LabOrderStatus.Complete.ToString();
        }

    }
}