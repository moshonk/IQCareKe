﻿using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using IQCare.Library;
using IQCare.PMTCT.BusinessProcess.Commands.VisitDetails;
using IQCare.PMTCT.Core.Models;
using IQCare.PMTCT.Infrastructure;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Serilog;

namespace IQCare.PMTCT.BusinessProcess.CommandHandlers.VisitDetails
{
    public class GetVisitDetailsByServiceAreaIdCommandHandler: IRequestHandler<GetVisitDetailsByServiceAreaIdCommand, Result<List<Core.Models.VisitDetails>>>
    {
        private readonly IPmtctUnitOfWork _unitOfWork;

        public GetVisitDetailsByServiceAreaIdCommandHandler(IPmtctUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork ?? throw new ArgumentException(nameof(unitOfWork));
        }

        public async Task<Result<List<Core.Models.VisitDetails>>> Handle(GetVisitDetailsByServiceAreaIdCommand request, CancellationToken cancellationToken)
        {
            using (_unitOfWork)
            {
                try
                {
                    List<Core.Models.VisitDetails> visitDetails = await _unitOfWork.Repository<Core.Models.VisitDetails>()
                        .Get(x => x.PatientId == request.PatientId && x.ServiceAreaId == request.ServiceAreaId)
                        .ToListAsync();
                    return Result<List<Core.Models.VisitDetails>>.Valid(visitDetails);
                }
                catch (Exception e)
                {
                    Log.Error(e.Message);
                    return Result<List<Core.Models.VisitDetails>>.Invalid(e.Message);
                }
            }
        }
    }
}