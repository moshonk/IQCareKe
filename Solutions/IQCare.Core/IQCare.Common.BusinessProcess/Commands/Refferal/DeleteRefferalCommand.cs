﻿using IQCare.Common.Core.Models;
using IQCare.Library;
using MediatR;

namespace IQCare.Common.BusinessProcess.Commands.Refferal
{
    public  class DeleteRefferalCommand :IRequest<Result<DeleteRefferalCommandResponse>>
    {
        public int Id;
    }

    public class DeleteRefferalCommandResponse
    {
        public int Id;
    }
}
