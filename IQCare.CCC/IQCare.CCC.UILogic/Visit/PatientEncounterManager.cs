﻿using System;
using System.Collections.Generic;
using Application.Presentation;
using Entities.CCC.Visit;
using Interface.CCC.Visit;

namespace IQCare.CCC.UILogic.Visit
{
    public class PatientEncounterManager
    {
        private readonly IPatientEncounterManager _patientEncounterManager = (IPatientEncounterManager)ObjectFactory.CreateInstance("BusinessProcess.CCC.visit.BPatientEncounterManager, BusinessProcess.CCC");

        public int AddpatientEncounter(PatientEncounter patientEncounter)
        {
            try
            {
                PatientEncounter patientVisitEncounter = new PatientEncounter()
                {
                    PatientId = patientEncounter.PatientId,
                    EncounterTypeId = patientEncounter.EncounterTypeId,
                    PatientMasterVisitId = patientEncounter.PatientMasterVisitId

                };
                return _patientEncounterManager.AddpatientEncounter(patientVisitEncounter);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
           
        }

        public int UpdatePatientEncounter(PatientEncounter patientEncounter)
        {
            try
            {
               return _patientEncounterManager.UpdatePatientEncounter(patientEncounter);
            }
            catch (Exception e)
            {
                
                throw new Exception(e.Message) ;
            }
        }

        public int DeletePatientEncounter(int id)
        {
            try
            {
                return _patientEncounterManager.DeletePatientEncounter(id);
            }
            catch (Exception e)
            {
                
                throw new Exception(e.Message);
            } 
        }

        public  List<PatientEncounter> GetPatientCurrentEncounters(int patientId, DateTime visitDate)
        {
            try
            {
                return _patientEncounterManager.GetPatientCurrentEncounters(patientId, visitDate);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
            
        }

        public List<PatientEncounter> GetPatientEncounterAll(int patientId)
        {
            try
            {
                return _patientEncounterManager.GetPatientEncounterAll(patientId);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }

        }

        public List<PatientEncounter>  GetPatientEncounterByEncounterType(int patientId, string encounterName)
        {
            try
            {
                return _patientEncounterManager.GetPatientEncounterByEncounterType(patientId, encounterName);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw new Exception(e.Message);
            }
        }
    }
}