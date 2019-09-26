﻿using System;
using System.Collections.Generic;
using System.Text;
using IQCare.Prep.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace IQCare.Prep.Infrastructure.Mapping
{
    public class AdherenceOutcomeMapping : IEntityTypeConfiguration<AdherenceOutcome>
    {
        public void Configure(EntityTypeBuilder<AdherenceOutcome> builder)
        {
            builder.ToTable("AdherenceOutcome")
                .HasKey(c => c.Id);
        }
    }
}