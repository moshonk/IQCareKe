﻿using System;
using Config.Core.Interfaces;
using PatientManagement.Core.Interfaces;


namespace Unitofwork.Core.Interface
{
    public interface IUnitOfWork : IDisposable
    {
        int Complete();
        
        IServiceAreaRepository ServiceAreaRepository { get; }

        //Patient Context Interfaces
        IPatientRepository PatientRepository { get; }
        IPatientContactRepository PatientContactRepository { get; }
        IPatientEnrollmentRepository PatientEnrollmentRepository { get; }
        IPatientLocationRepository PatientLocationRepository { get; }
        IPatientMaritalStatusRepository PatientMaritalStatusRepository { get; }
        IPatientOVCStatusRepository PatientOvcStatusRepository { get; }
        IPatientPopulationRepository PatientPopulationRepository { get; }
        IPatientTreatmentSupporterRepository PatientTreatmentSupporterRepository { get; }
    }
}
