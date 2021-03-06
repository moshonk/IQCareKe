﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IQCare.Common.Core.Models;
using IQCare.PMTCT.BusinessProcess.CommandHandlers;
using IQCare.PMTCT.BusinessProcess.Commands.PreventiveServices;
using IQCare.PMTCT.Services;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.Semantics;
using Serilog;
using PatientPreventiveServiceCommand = IQCare.PMTCT.BusinessProcess.Commands.PatientPreventiveServiceCommand;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace IQCare.Controllers.PMTCT.ANC
{
    [Produces("application/json")]
    [Route("api/[controller]/[action]")]
    public class PatientServiceController : Controller
    {
        private readonly IMediator _mediator;

        public PatientServiceController(IMediator mediator)
        {
            _mediator = mediator;
        }
        // GET: api/<controller>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        [HttpGet("{patientId}")]
        public async Task<IActionResult> GetByPatientId(int patientId)
        {
            if (patientId < 1)
                return BadRequest("invalid patientId");
            var response = await _mediator.Send(new GetPreventiveServiceViewCommand {PatientId = patientId},
                HttpContext.RequestAborted);
            if (response.IsValid)
                return Ok(response.Value);
            return BadRequest(response.Value);
        }

        // POST api/<controller>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] PatientPreventiveServiceCommand patientPreventive)
        {
            var response = await _mediator.Send(new PatientPreventiveServiceCommand
            {
                InsecticideGivenDate = patientPreventive.InsecticideGivenDate,
                InsecticideTreatedNet = patientPreventive.InsecticideTreatedNet,
                AntenatalExercise = patientPreventive.AntenatalExercise,
                PartnerTestingVisit = patientPreventive.PartnerTestingVisit,
                FinalHIVResult = patientPreventive.FinalHIVResult,
                PreventiveService = patientPreventive.PreventiveService,
            }, Request.HttpContext.RequestAborted);

            if (response.IsValid)
            {
                return Ok(response.Value);
            }
            return BadRequest(response);
        }


        // PUT api/<controller>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
