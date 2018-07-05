using System;
using System.Collections.Generic;
using Entities.CCC.Triage;
using Application.Presentation;
using Interface.CCC.Triage;

namespace IQCare.CCC.UILogic.Triage
{
    public class PatientPIAPregnancySymptomManager
    {
        private IPatientPIAPregnancySymptomManager _PatientPIAPregnancySymptom = (IPatientPIAPregnancySymptomManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.Triage.BPatientPIAPregnancySymptom, BusinessProcess.CCC");

        public int AddPIAPregnancySymptom(int patientId, int patientPIAId, int pregnancySymptomId, int userId)
        {
            try
            {
                var FPLoad = new PatientPIAPregnancySymptom()
                {
                    PatientId = patientId,
                    PatientPIAId = patientPIAId,
                    PregnancySymptomId = pregnancySymptomId,
                    CreatedBy = userId
                };

                return _PatientPIAPregnancySymptom.AddPregnancySymptom(FPLoad);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int UpdatePIAPregnancySymptom(int PregnancySymptomId, int id)
        {
            try
            {
                var FPLoad = new PatientPIAPregnancySymptom()
                {
                    Id = id,
                    PregnancySymptomId = PregnancySymptomId
                };

                return _PatientPIAPregnancySymptom.UpdatePregnancySymptom(FPLoad);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int DeletePIAPregnancySymptom(int id)
        {
            try
            {
                return _PatientPIAPregnancySymptom.DeletePregnancySymptom(id);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int DeletePregnancySymptoms(int patientPIAId)
        {
            try
            {
                return _PatientPIAPregnancySymptom.DeletePregnancySymptoms(patientPIAId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<PatientPIAPregnancySymptom> GetPatientPIAPregnancySymptoms(int patientPIAId)
        {
            try
            {
                return _PatientPIAPregnancySymptom.GetPatientPregnancySymptoms(patientPIAId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int CheckIfPatientHasPIAPregnancySymptom(int patientId)
        {
            try
            {
                return _PatientPIAPregnancySymptom.CheckIfPatientHasPregnancySymptom(patientId);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
