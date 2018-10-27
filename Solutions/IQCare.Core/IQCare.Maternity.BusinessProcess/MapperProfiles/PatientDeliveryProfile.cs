﻿using AutoMapper;
using IQCare.Maternity.BusinessProcess.Commands.Maternity;
using IQCare.Maternity.Core.Domain.Maternity;
using System;
using System.Collections.Generic;
using System.Text;

namespace IQCare.Maternity.BusinessProcess.MapperProfiles
{
    public class PatientDeliveryProfile : Profile
    {
        public PatientDeliveryProfile()
        {
            CreateMap<AddMaternalPatientDeliveryInfoCommand, PatientDeliveryInformation>()
                .ForMember(dest => dest.CreateDate, src => src.MapFrom(x => DateTime.Now))
                .ReverseMap();
        }
    }
}