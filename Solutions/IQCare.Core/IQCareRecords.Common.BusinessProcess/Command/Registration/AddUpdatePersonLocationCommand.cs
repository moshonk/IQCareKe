﻿using System;
using System.Collections.Generic;
using System.Text;
using IQCare.Common.Core.Models;
using MediatR;
namespace IQCareRecords.Common.BusinessProcess.Command
{
    public class AddUpdatePersonLocationCommand:IRequest<Result<AddUpdatePersonLocationResponse>>
    {
        public int PersonId { get; set; }
        public int CountyId { get; set; }

        public int SubCountyId { get; set; }

        public int WardId { get; set; }

        public string NearestHealthCentre { get; set; }

        public string LandMark { get; set; }

        public int UserId { get; set; }
    }
    public class AddUpdatePersonLocationResponse
    {
        public string Message { get; set; }
    }
}
