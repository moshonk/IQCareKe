﻿using IQCare.Common.Core.Models;
using MediatR;
using System;
using System.Collections.Generic;
using System.Text;
using IQCare.Library;

namespace IQCare.PMTCT.BusinessProcess.Commands
{
    public class AddPNCVisitCommand : IRequest<Result<AddPNCVisitResponse>>
    {
        public int PatientId { get; set; }
        public int ServiceAreaId { get; set; }
        public DateTime VisitDate { get; set; }
        public int VisitNumber { get; set; }
        public int VisitType { get; set; }
        public int UserId { get; set; }
        public int? DaysPostPartum { get; set; }
        public int PatientMasterVisitId { get; set; }
        public decimal? AgeMenarche { get; set; }
    }

    public class AddPNCVisitResponse
    {
        public int ProfileId { get; set; }

    }
}
