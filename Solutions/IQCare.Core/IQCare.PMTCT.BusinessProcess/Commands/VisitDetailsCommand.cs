﻿using System;
using IQCare.Library;
using MediatR;

namespace IQCare.PMTCT.BusinessProcess.Commands
{
    public class VisitDetailsCommand : IRequest<Result<VisitDetailsCommandResult>>
    {
        public int PatientId { get; set; }
        public int PatientMasterVisitId { get; set; }
        public int ServiceAreaId { get; set; }
        public DateTime VisitDate { get; set; }
        public int VisitNumber { get; set; }
        public int VisitType { get; set; }
        public DateTime Lmp { get; set; }
        public DateTime Edd { get; set; }
        public Decimal Gestation { get; set; }
        public Decimal ? AgeAtMenarche { get; set; }
        public int ParityOne { get; set; }
        public int ParityTwo { get; set; }
        public int Gravidae { get; set; }
        public int UserId { get; set; }
      //  public string EncounterType { get; set; }
        public int ? DaysPostPartum { get; set; }
    }

    public class VisitDetailsCommandResult
    {
        public int PregancyId { get; set; }
        public int ProfileId { get; set; }
    }
}