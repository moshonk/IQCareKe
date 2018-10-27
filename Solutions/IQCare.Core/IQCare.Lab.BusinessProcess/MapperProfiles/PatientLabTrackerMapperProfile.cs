﻿using AutoMapper;
using IQCare.Lab.BusinessProcess.Queries;
using IQCare.Lab.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace IQCare.Lab.BusinessProcess.MapperProfiles
{
    public class PatientLabTrackerMapperProfile : Profile
    {
        public PatientLabTrackerMapperProfile()
        {
            CreateMap<PatientLabTracker, LabTestResultViewModel>()
                .ForMember(src => src.LabTestName, dest => dest.MapFrom(x => x.LabName))
                .ReverseMap();
        }
    }
}