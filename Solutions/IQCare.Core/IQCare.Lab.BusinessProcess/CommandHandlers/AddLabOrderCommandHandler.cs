﻿using AutoMapper;
using IQCare.Lab.BusinessProcess.Commands;
using IQCare.Lab.BusinessProcess.Services;
using IQCare.Lab.Core.Models;
using IQCare.Lab.Infrastructure.Interface;
using IQCare.Library;
using MediatR;
using Serilog;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace IQCare.Lab.BusinessProcess.CommandHandlers
{
    public class AddLabOrderCommandHandler : IRequestHandler<AddLabOrderCommand, Result<AddLabOrderResponse>>
    {
        ILabUnitOfWork _labUnitOfWork;
        IMapper _mapper;

        public AddLabOrderCommandHandler(ILabUnitOfWork labUnitOfWork, IMapper mapper)
        {
            _labUnitOfWork = labUnitOfWork;
            _mapper = mapper;
        }
        public async Task<Result<AddLabOrderResponse>> Handle(AddLabOrderCommand request, CancellationToken cancellationToken)
        {
            using (var transaction = _labUnitOfWork.BeginTransaction(IsolationLevel.ReadCommitted))
            {
                try
                {
                    var labOrder = _mapper.Map<LabOrder>(request);
                    await _labUnitOfWork.Repository<LabOrder>().AddAsync(labOrder);

                    var labOrderTests = request.LabTests.Select(x => new LabOrderTest(labOrder.Id, x.Id, x.Notes, request.UserId, false)).ToList();
                    await _labUnitOfWork.Repository<LabOrderTest>().AddRangeAsync(labOrderTests);

                    List<PatientLabTracker> patientLabTrackers = new List<PatientLabTracker>();

                    foreach (var labOrderTest in labOrderTests)
                    {
                        var labName = request.LabTests.FirstOrDefault(x => x.Id == labOrderTest.LabTestId)?.LabTestName;
                        var parameterCount = _labUnitOfWork.Repository<LabTest>().Get(x => x.Id == labOrderTest.LabTestId)
                            .SingleOrDefault()?.ParameterCount;
                        if(parameterCount == 1)  // PatientLabTracker is created only for LabTests with only one parameter count
                        {
                            var patientLabTacker = new PatientLabTracker(request.PatientId, labName, request.PatientMasterVisitId, labOrderTest.LabTestId, labOrder.Id, request.FacilityId, request.OrderDate, request.UserId);

                            patientLabTrackers.Add(patientLabTacker);
                        }                       
                    }

                    await _labUnitOfWork.Repository<PatientLabTracker>().AddRangeAsync(patientLabTrackers);
                    await _labUnitOfWork.SaveAsync();

                    transaction.Commit();

                    return Result<AddLabOrderResponse>.Valid(new AddLabOrderResponse
                    {
                        LabOrderId = labOrder.Id
                    });
                }
                catch (Exception ex)
                {
                    string message = $"An error occured while saving lab order request for patientId {request.PatientId}";
                    Log.Error(ex, message);
                    transaction.Rollback();

                    return Result<AddLabOrderResponse>.Invalid(message);
                }
            }
           
        }
    }
}