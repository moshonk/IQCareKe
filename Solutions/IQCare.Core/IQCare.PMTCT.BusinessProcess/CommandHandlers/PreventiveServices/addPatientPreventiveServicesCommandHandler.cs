﻿using IQCare.Library;
using IQCare.PMTCT.BusinessProcess.Commands.PreventiveServices;
using IQCare.PMTCT.Core.Models;
using IQCare.PMTCT.Infrastructure;
using MediatR;
using Serilog;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace IQCare.PMTCT.BusinessProcess.CommandHandlers.PreventiveServices
{
    public class addPatientPreventiveServicesCommandHandler : IRequestHandler<PatientPreventiveServiceCommand, Result<AddPatientPreventiveServiceCommandResponse>>
    {
       private readonly ICommonUnitOfWork _pmtctUnitOfWork;

        public addPatientPreventiveServicesCommandHandler(ICommonUnitOfWork pmtctUnitOfWork)
        {
            _pmtctUnitOfWork = pmtctUnitOfWork;  
        }
        public async Task<Result<AddPatientPreventiveServiceCommandResponse>> Handle(PatientPreventiveServiceCommand request, CancellationToken cancellationToken)
        {
            using (_pmtctUnitOfWork)
            {
                try
                {
                    List<PreventiveService> preventiveServices = new List<PreventiveService>();

                    foreach (var item in request.preventiveService)
                    {
                        PreventiveService _preventiveServices = new PreventiveService()
                        {                          
                            Id=item.Id, 
                              PatientId =item.PatientId,
                             PatientMasterVisitId =item.PatientMasterVisitId,
                             PreventiveServiceId=item.PreventiveServiceId,
                             PreventiveServiceDate =item.PreventiveServiceDate,
                            Description=item.Description
                        };
                        preventiveServices.Add(_preventiveServices);
                    }
                    await _pmtctUnitOfWork.Repository<PreventiveService>().AddRangeAsync(preventiveServices);
                     await _pmtctUnitOfWork.SaveAsync();

                    _pmtctUnitOfWork.Dispose();

                    return Result<AddPatientPreventiveServiceCommandResponse>.Valid(new AddPatientPreventiveServiceCommandResponse()
                    {
                        PreventiveServiceId = 1

                    });
                }
                catch (Exception e)
                {

                    Log.Error(e.Message);
                    return Result<AddPatientPreventiveServiceCommandResponse>.Invalid(e.Message);
                }
            }
        }
    }
}
