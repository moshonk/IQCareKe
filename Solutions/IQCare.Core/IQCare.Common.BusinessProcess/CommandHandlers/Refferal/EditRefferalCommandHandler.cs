﻿using IQCare.Common.BusinessProcess.Commands.Refferal;
using IQCare.Common.Core.Models;
using IQCare.Common.Infrastructure;
using MediatR;
using Serilog;
using System;
using System.Threading;
using System.Threading.Tasks;
using IQCare.Library;

namespace IQCare.Common.BusinessProcess.CommandHandlers.Refferal
{
    public class EditRefferalCommandHandler : IRequestHandler<EditRefferalCommand, Result<EditRefferalCommandResponse>>
    {
        private readonly ICommonUnitOfWork _unitOfWork;

        public EditRefferalCommandHandler(ICommonUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<Result<EditRefferalCommandResponse>> Handle(EditRefferalCommand request, CancellationToken cancellationToken)
        {
            using (_unitOfWork)
            {
                try
                {
                   
                    var patientRefferal = await _unitOfWork.Repository<PatientRefferal>().FindByIdAsync(request.Id);
                    if (patientRefferal != null)
                    {
                        var patientReferralEditInfo = request;

                        patientRefferal.UpdateReferralInfo(patientReferralEditInfo.ReferralDate,
                            patientReferralEditInfo.ReferralReason, patientReferralEditInfo.ReferredBy,
                            patientReferralEditInfo.ReferredFrom, patientReferralEditInfo.ReferredTo);

                        _unitOfWork.Repository<PatientRefferal>().Update(patientRefferal);
                        var result = await _unitOfWork.SaveChangesAsync();

                        return Result<EditRefferalCommandResponse>.Valid(new EditRefferalCommandResponse()
                        {
                            Id = result
                        });
                    }
                    else
                    {
                        return Result<EditRefferalCommandResponse>.Invalid("Error updating referral with referralId: " + request.Id);
                    }
                }
                catch (Exception e)
                {
                    Log.Error(e.Message);
                    return Result<EditRefferalCommandResponse>.Invalid(e.Message);
                }
            }
                
        }
    }
}
