﻿using IQCare.Library;
using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace IQCare.Maternity.BusinessProcess.Commands.Maternity
{
    public class AddMaternalPatientDeliveryInfoCommand : IRequest<Result<AddPatientDeliveryInfoResponse>>
    {
        public int PatientMasterVisitId { get;  set; }
        public int ? PregnancyId { get;  set; }
        public string DurationOfLabour { get;  set; }
        public DateTime DateOfDelivery { get;  set; }
        public DateTime TimeOfDelivery { get;  set; }
        public int? ModeOfDelivery { get;  set; }
        public int? PlacentaComplete { get;  set; }
        public int? BloodLossCapacity { get;  set; } 
        public int ? BloodLossClassification { get;  set; }
        public int? MotherCondition { get;  set; }
        public int ? MaternalDeathAudited { get;  set; }
        public DateTime? MaternalDeathAuditDate { get;  set; }
        public int ? DeliveryComplicationsExperienced { get;  set; }
        public string DeliveryComplicationNotes { get;  set; }
        public string DeliveryConductedBy { get;  set; }
        public int CreatedBy { get;  set; }
    }

    public class AddPatientDeliveryInfoResponse
    {
        public int PatientDeliveryId { get; set; }
        public int PatientMasterVisitId { get; set; }
        public int ? PregnancyId { get; set; }       
    }

    public class UpdateMaternalPatientDeliveryInfoCommand : IRequest<Result<UpdatePatientDeliveryInfoResponse>>
    {
        public int PatientDeliveryInfoId { get; set; }
        public AddMaternalPatientDeliveryInfoCommand MaternalPatientDeliveryInfoCommand { get; set; }

    }

    public class UpdatePatientDeliveryInfoResponse
    {
        public int PatientDeliveryId { get; set; }
        public int PatientMasterVisitId { get; set; }
        public string Message { get; set; }

    }
}
