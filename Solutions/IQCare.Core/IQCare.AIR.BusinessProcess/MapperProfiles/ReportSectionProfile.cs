﻿using System;
using System.Collections.Generic;
using System.Text;
using AutoMapper;
using IQCare.AIR.BusinessProcess.Queries;
using IQCare.AIR.Core.Domain;

namespace IQCare.AIR.BusinessProcess.MapperProfiles
{
    public class ReportSectionProfile : Profile
    {
        public ReportSectionProfile()
        {
            CreateMap<ReportSection, ReportSectionViewModel>().ReverseMap();
        }
    }
}
