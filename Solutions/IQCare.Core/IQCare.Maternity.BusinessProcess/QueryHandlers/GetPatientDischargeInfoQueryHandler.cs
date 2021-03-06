﻿using AutoMapper;
using IQCare.Library;
using IQCare.Maternity.BusinessProcess.Queries.Maternity;
using IQCare.Maternity.Core.Domain.Maternity;
using IQCare.Maternity.Infrastructure.UnitOfWork;
using MediatR;
using Serilog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace IQCare.Maternity.BusinessProcess.QueryHandlers
{
    public class GetPatientDischargeInfoQueryHandler : IRequestHandler<GetPatientDischargeInfoQuery, Result<PatientDischargeInfoViewModel>>
    {
        IMapper _mapper;
        IMaternityUnitOfWork _maternityUnitOfWork;
        ILogger logger = Log.ForContext<GetPatientDischargeInfoQueryHandler>();

        public GetPatientDischargeInfoQueryHandler(IMaternityUnitOfWork maternityUnitOfWork, IMapper mapper)
        {
            _mapper = mapper;
            _maternityUnitOfWork = maternityUnitOfWork;
        }
        public Task<Result<PatientDischargeInfoViewModel>> Handle(GetPatientDischargeInfoQuery request,
            CancellationToken cancellationToken)
        {
            try
            {
                var patientDischargeInfo = _maternityUnitOfWork.Repository<PatientDischargeInformationView>()
                    .Get(x => x.PatientMasterVisitId == request.PatientMasterVisitId)
                    .OrderByDescending(x => x.DateDischarged).FirstOrDefault();

                var dischargeInfoViewModel = _mapper.Map<PatientDischargeInfoViewModel>(patientDischargeInfo);

                return Task.FromResult(Result<PatientDischargeInfoViewModel>.Valid(dischargeInfoViewModel));
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"An error occured while getting patient discharge info for master visit Id {request.PatientMasterVisitId}");
                return Task.FromResult(Result<PatientDischargeInfoViewModel>.Invalid(ex.Message));
            }
        }
    }
}
