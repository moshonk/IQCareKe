﻿using System;
using System.Collections.Generic;
using System.Text;
using MediatR;
using IQCare.Library;
using IQCare.Queue.Core.Models;

namespace IQCare.Queue.BusinessProcess.Command
{
   public  class GetServiceAreasCommand : IRequest<Result<GetServiceAreasResponse>>
    {

    }

    public class GetServiceAreasResponse
    {
        public List<ServiceArea> serviceAreas { get; set; }
    }
}