﻿using System;
using System.Collections.Generic;
using System.Text;
using IQCare.Common.Core.Models;
using IQCare.Library;
using MediatR;
namespace IQCareRecords.Common.BusinessProcess.Command
{
    public class PersonRegistrationCommand:IRequest<Result<PersonRegistrationResponse>>
    {
        public Client Person;
    }

    public class Client
    {
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }

        public string NickName { get; set; }
        public DateTime DateOfBirth { get; set; }
        public int Sex { get; set; }
        public int CreatedBy { get; set; }
        public bool DobPrecision { get; set; }
        public DateTime RegistrationDate { get; set; }
        public int? Id { get; set; }
        public int PosId { get; set; }
    }

    public class PersonRegistrationResponse
    {
        public int PersonId { get; set; }
        public string Message { get; set; }
    }
}
