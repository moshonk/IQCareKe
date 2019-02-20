﻿using System.Collections.Generic;
using IQCare.Common.BusinessProcess.Commands.Setup;
using IQCare.Library;
using MediatR;

namespace IQCare.HTS.BusinessProcess.Commands
{
    public class AfyaMobileFamilyDemographicsCommand : IRequest<Result<string>>
    {
        public MESSAGE_HEADER MESSAGE_HEADER { get; set; }
        public List<NEWFAMILY> FAMILY { get; set; }
    }
}