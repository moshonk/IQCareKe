﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IQCare.Maternity.BusinessProcess.Commands.PNC;
using IQCare.Maternity.BusinessProcess.Queries.PNC;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace IQCare.Maternity.WebApi.Controllers
{
    [Produces("application/json")]
    [Route("api/FamilyPlanning")]
    public class FamilyPlanningController : Controller
    {
        IMediator _mediator;
        public FamilyPlanningController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost]
        public async Task<IActionResult> AddFamilyPlanning([FromBody] AddPatientFamilyPlanningCommand command)
        {
            if (!ModelState.IsValid)
                return BadRequest(command);

            var result = await _mediator.Send(command, HttpContext.RequestAborted);
            if (result.IsValid)
                return Ok(result.Value);

            return BadRequest(result);
        }

        [HttpPost("UpdateFamilyPlanning")]
        public async Task<IActionResult> UpdateFamilyPlanning([FromBody]UpdatePatientFamilyPlanningCommand updatePatientFamilyPlanningCommand)
        {
            if (!ModelState.IsValid)
                return BadRequest(updatePatientFamilyPlanningCommand);

            var response = await _mediator.Send(updatePatientFamilyPlanningCommand, Request.HttpContext.RequestAborted);
            if (response.IsValid)
                return Ok(response.Value);
            return BadRequest(response);
        }

        [HttpGet("{Id}")]
        public async Task<object> Get(int Id)
        {
            var getPatientFamilyPlanning = await _mediator.Send(new GetPatientFamilyPlanningQuery { PatientId = Id }, HttpContext.RequestAborted);
            if (getPatientFamilyPlanning.IsValid)
                return Ok(getPatientFamilyPlanning.Value);
            return BadRequest(getPatientFamilyPlanning);
        }
    }
}