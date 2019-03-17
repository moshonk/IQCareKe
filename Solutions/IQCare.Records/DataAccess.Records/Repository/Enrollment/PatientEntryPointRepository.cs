﻿using DataAccess.Context;
using DataAccess.Records.Context;
using DataAccess.Records.Interface;
using Entities.Records.Enrollment;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Records.Repository
{
   
    public class PatientEntrypointRepository : BaseRepository<PatientEntryPoint>, IPatientEntryPointRepository
    {
        private readonly RecordContext _context;

        public PatientEntrypointRepository() : this(new RecordContext())
        {

        }

        public PatientEntrypointRepository(RecordContext context) : base(context)
        {
            _context = context;
        }
    }
}
