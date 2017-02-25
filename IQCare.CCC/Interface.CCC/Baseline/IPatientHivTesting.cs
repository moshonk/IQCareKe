﻿using System.Collections.Generic;
using Entities.CCC.Baseline;
using Entities.CCC.Encounter;

namespace Interface.CCC.Baseline
{
    public interface IPatientHivTesting
    {
        int AddPatientHivTesting(PatientHivTesting p);

        PatientHivTesting GetPatientHivTesting(int id);

        void DeletePatientHivTesting(int id);

        int UpdatePatientHivTesting(PatientHivTesting p);

    }
}