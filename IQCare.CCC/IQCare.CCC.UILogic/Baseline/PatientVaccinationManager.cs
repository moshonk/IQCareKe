﻿using Application.Presentation;
using Entities.CCC.Encounter;
using Interface.CCC.Baseline;

namespace IQCare.CCC.UILogic.Baseline
{
    public class PatientVaccinationManager
    {
        private IPatientVaccinationManager _mgr = (IPatientVaccinationManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.Baseline.BPatientVaccination, BusinessProcess.CCC");
        private int _retval;

        public int addPatientVaccination(PatientVaccination patientVaccination)
        {
            return _retval = _mgr.addPatientVaccination(patientVaccination);
        }

        public int UpdatePatientVaccination(PatientVaccination patientVaccination)
        {
            return _retval = _mgr.updatePatientVaccination(patientVaccination);
        }
    }
}