﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IQCare.Common.BusinessProcess.Commands.Encounter;
using IQCare.PMTCT.BusinessProcess.Commands;
using MediatR;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace IQCare.Controllers.PMTCT.ANC
{
    [Produces("application/json")]
    [Route("api/[controller]/[action]")]
    public class PatientScreeningController : Controller
    {
        private readonly IMediator _mediator;

        public PatientScreeningController(IMediator mediator)
        {
            _mediator = mediator;
        }
        // GET: api/<controller>
        [HttpGet("{patientId}")]
        public async Task<ActionResult> GetPatientScreeningByPatientId(int patientId)
        {
            var response = await
                _mediator.Send(
                    new GetPatientScreeningByPatientIdCommand
                        { PatientId = patientId },
                    HttpContext.RequestAborted);
            if (response.IsValid)
                return Ok(response.Value);
            return BadRequest(response.Value);
        }

        // GET api/<controller>/5
        [HttpGet("{patientId}/{patientMasterVisitId}")]
        public async Task<IActionResult> GetPatientScreening(int patientId, int patientMasterVisitId)
        {
            var response = await 
                _mediator.Send(
                    new GetPatientScreeningViewCommand
                        {PatientMasterVisitId = patientMasterVisitId, PatientId = patientId},
                    HttpContext.RequestAborted);
            if (response.IsValid)
                return Ok(response.Value);
            return BadRequest(response.Value);
        }



        // POST api/<controller>
        [HttpPost]
        public void Post([FromBody]string value)
        {
            
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
