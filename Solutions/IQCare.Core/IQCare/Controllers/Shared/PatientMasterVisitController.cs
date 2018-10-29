﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IQCare.Common.BusinessProcess.Commands.Encounter;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace IQCare.Controllers.Shared
{
    [Produces("application/json")]
    [Route("api/PatientMasterVisit")]
    public class PatientMasterVisitController : Controller
    {
        private readonly IMediator _mediator;

        public PatientMasterVisitController(IMediator mediator)
        {
            _mediator = mediator ?? throw new ArgumentNullException(nameof(mediator));
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] AddEncounterVisitCommand addEncounterVisitCommand)
        {
            var encountervisit = await _mediator.Send(addEncounterVisitCommand, Request.HttpContext.RequestAborted);
            if (encountervisit.IsValid)
                return Ok(encountervisit.Value);
            return BadRequest(encountervisit);
        } 
    }
}