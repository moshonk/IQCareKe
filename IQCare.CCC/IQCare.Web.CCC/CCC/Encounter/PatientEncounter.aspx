﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true" CodeBehind="PatientEncounter.aspx.cs" Inherits="IQCare.Web.CCC.Encounter.PatientEncounter" %>
<%@ Register TagPrefix="uc" TagName="PatientDetails" Src="~/CCC/UC/ucPatientDetails.ascx" %>
<%@ Register TagPrefix="uc" TagName="PatientTriage" Src="~/CCC/UC/ucPatientTriage.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
  
        <div class="container-fluid">
        
        <div class="row">
            <div class="col-md-12">
                <uc:PatientDetails ID="PatientSummary" runat="server" />
            </div>
            <div class="col-md-12 col-xs-12">

                 <ul class="nav nav-tabs" role="tablist">
                     <li role="presentation" class="active"><a href="#home"><i class="fa fa-home fa-lg" aria-hidden="true"></i> Home</a></li>
                     <li role="presentation"> <a href="#encounter"    aria-controls="encounter"   role="tab" data-toggle="tab"><i class="fa fa-exchange fa-lg" aria-hidden="true"></i> Clinical Encounter</a></li>
                     <li role="presentation"> <a href="#vlTracker"    aria-controls="vlTracker"   role="tab" data-toggle="tab"><i class="fa fa-line-chart fa-lg" aria-hidden="true"></i> Viraload Tracker</a></li>
                     <li role="presentation"> <a href="#Laboratory"   aria-controls="Laboratory"  role="tab" data-toggle="tab"><i class="fa fa-flask fa-lg" aria-hidden="true"></i> Laboratory</a></li>
                     <li role="presentation"> <a href="#Pharmacy"     aria-controls="Pharmacy"    role="tab" data-toggle="tab"><i class="fa fa-tint fa-lg" aria-hidden="true"></i> Pharmacy</a></li>
                     <li role="presentation"> <a href="#history"      aria-controls="history"     role="tab" data-toggle="tab"><i class="fa fa-history fa-lg" aria-hidden="true"></i> Encounter History</a></li>
                 </ul>
             </div><!-- .col-md-12 -->
            
            <div class="col-md-12 col-xs-12">

                 <div class="tab-content">
                           
                      <div  role="tabpanel"     class="tab-pane active"    id="home">
                          <p>am home</p>
                      </div><!-- .home-->

                    
                      <div  role="tabpanel" class="tab-pane fade" id="encounter">
                         
                             <div class="col-md-12"><h5 class="pull-left"><i class="fa fa-crosshairs fa-2x" aria-hidden="true"> Patient Encounter </i></h5></div>
                             <div class="col-md-12">
                                  <div class="wizard" data-initialize="wizard"  id="ptnEncounter">
                                       <div class="steps-container">
	                                    <ul class="steps">
		                                   
                                            <li data-step="1" data-name="campaign">
			                                    <span class="badge">1</span>Presenting Complaints
			                                    <span class="chevron"></span>
		                                    </li>
		                                    <li data-step="2">
			                                    <span class="badge">2</span>Patient Examination
			                                    <span class="chevron"></span>
		                                    </li>
		                                    <li data-step="3" data-name="template">
			                                    <span class="badge">3</span>Patient Management
			                                    <span class="chevron"></span>
		                                    </li>
	                                    </ul>
                                    </div>
                                       
                                       <div class="actions">
	                                    <button type="button" class="btn btn-default btn-prev">
		                                    <span class="glyphicon glyphicon-arrow-left"></span>Prev</button>
	                                    <button type="button" class="btn btn-primary btn-next" data-last="Complete">Next
		                                    <span class="glyphicon glyphicon-arrow-right"></span>
	                                    </button>
                                    </div>
                                    
                                      <div class="step-content">
	                                    

	                                       <div class="step-pane active sample-pane" data-step="1">
		                                    <div class="col-md-12"><small class="muted pull-left"><strong>Presenting Complaints </strong></small></div> <div class="col-md-12"><hr /> </div>  

                                            <div class="row">
                                                <div class="col-md-1">
                                                    <h4 class="pull-left text-danger"><i class="fa fa-user-md fa-5x" aria-hidden="true"></i></h4>
                                                </div>
                                                <div class="col-md-5">
                                                     <div class="col-md-12"><h1 class="text-primary pull-left"><small>Complaints & History of Complaints</small></h1></div>
                                                     <div class="col-md-12"><hr /></div>
                                                      <div class="row">
                                                        
                                                           <div class="col-md-12 form-group">

                                                                  <div class="col-md-12"><label class="control-label pull-left" for="complaints">Complaints Today</label></div>
                                                                  <div class="col-md-12">
                                                                      <textarea id="complaints" class="form-control input-sm" rows="4"></textarea>
                                                                  </div>
                                                           </div>
                                                    </div>
                                                    <div class="row">
                                                         
                                                             <div class="col-md-6  form-group">
                                                                 <div class="col-md-12"><label class="control-label pull-left input-sm" for="TBScreening">TB Screening</label></div>
                                                                 <div class="col-md-12">
                                                                     <select id="TBScreening" class="form-control"></select>
                                                                 </div>
                                                             </div>
                                                             <div class="col-md-6">
                                                                 <div class="col-md-12"><label class="control-label pull-left input-sm" for="NutritionStatus">Nutrition Status</label></div>
                                                                 <div class="col-md-12">
                                                                     <select id="NutritionStatus" class="form-control"></select>
                                                                 </div>
                                                             </div>
                         
                                                    </div>
                                                </div>
                                                a<div class="col-md-6">
                                                     <div class="col-md-12"><h1 class="text-primary pull-left">Adverse Event(s)</h1></div>
                                                     <div class="col-md-12"><hr /></div>
                                                     <div class="row">
                                                         <div class="col-md-3">
                                                              <div class="col-md-12"><label class="control-label pull-left" ><small>Adverse event(s)</small></label></div>
                                                             <div class="col-md-12">
                                                                 <input type="text" id="adverseEvent" class="form-control input-sm" runat="server" />
                                                             </div>
                                                         </div>
                                                         <div class="col-md-3">
                                                             <div class="col-md-12"><label class="control-label" >Medicine Causing a/e</label></div>
                                                             <div class="col-md-12">
                                                                 <input type="text" id="medicineCauseingae" class="form-control input-sm" runat="server" />
                                                             </div>
                                                         </div>
                                                         <div class="col-md-3">
                                                             <div class="col-md-12"><label class="control-label pull-left" >Severity</label></div>
                                                             <div class="col-md-12">
                                                                 <input type="text" id="severity" class="form-control input-sm" runat="server" />
                                                             </div>
                                                         </div>
                                                         <div class="col-md-3">
                                                             <div class="col-md-12"><label class="control-label pull-left" >Action</label></div>
                                                             <div class="col-md-12">
                                                                 <input type="text" id="adverseAction" class="form-control input-sm" runat="server" />
                                                             </div>
                                                         </div>
                                                     </div>
                                                     <div class="row" style="padding-top:3%">
                                                         <div class="col-md-3"></div>
                                                         <div class="col-md-3"></div>
                                                         <div class="col-md-3"></div>
                                                         <div class="col-md-3">
                                                             <div class="col-md-12">
                                                                 <asp:LinkButton runat="server" ID="btnAdverseEventsAdd" CssClass="btn btn-info btn-lg fa fa-plus-circle">Add Adverse Event</asp:LinkButton>
                                                             </div>
                                                         </div>
                                                     </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-11">
                                                    
                                                </div>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-11">
                                                   <div class="col-md-12">
                                                     <div class="panel panel-default">
                                                     <div class="panel-heading">Patient Diagnosis Today</div>
                                                     <div class="panel-body">
                                                         <div class="row">
                                                             <div class="col-md-4">
                                                                  <div class="col-md-12 form-group">
                                                                      <div class="col-md-5"><label class="control-label  pull-left">Female LMP</label></div>
                                                                      <div class="col-md-7">
                                                                          <div class="datepicker fuelux" id="FemaleLMP">
                                                                          <div class="input-group">
                                                                              <input class="form-control input-sm" id="lmp" type="text" />
                                                                              <div class="input-group-btn">
                                                                                 <button type="button" class="btn btn-default dropdown-toggle input-sm" data-toggle="dropdown">
                                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                                                <span class="sr-only">Toggle Calendar</span>
                                                                              </button>
                                                                              <div class="dropdown-menu dropdown-menu-right datepicker-calendar-wrapper" role="menu">
                                                                                <div class="datepicker-calendar">
                                                                                  <div class="datepicker-calendar-header">
                                                                                       <button type="button" class="prev"><span class="glyphicon glyphicon-chevron-left input-sm"></span><span class="sr-only">Previous Month</span></button>
                                                                                       <button type="button" class="next"><span class="glyphicon glyphicon-chevron-right input-sm"></span><span class="sr-only">Next Month</span></button>
                                                                                       <button type="button" class="title" data-month="11" data-year="2014">
                                                                                            <span class="month">
                                                                                              <span data-month="0">January</span>
                                                                                              <span data-month="1">February</span>
                                                                                              <span data-month="2">March</span>
                                                                                              <span data-month="3">April</span>
                                                                                              <span data-month="4">May</span>
                                                                                              <span data-month="5">June</span>
                                                                                              <span data-month="6">July</span>
                                                                                              <span data-month="7">August</span>
                                                                                              <span data-month="8">September</span>
                                                                                              <span data-month="9">October</span>
                                                                                              <span data-month="10">November</span>
                                                                                              <span data-month="11" class="current">December</span>
                                                                                            </span> <span class="year">2014</span>
                                                                                       </button>
                                                                                  </div>
                                                                                  <table class="datepicker-calendar-days">
                                                                                    <thead>
                                                                                    <tr>
                                                                                      <th>Su</th>
                                                                                      <th>Mo</th>
                                                                                      <th>Tu</th>
                                                                                      <th>We</th>
                                                                                      <th>Th</th>
                                                                                      <th>Fr</th>
                                                                                      <th>Sa</th>
                                                                                    </tr>
                                                                                    </thead>
                                                                                    <tbody></tbody>
                                                                                  </table>
                                                                                  <div class="datepicker-calendar-footer">
                                                                                    <button type="button" class="datepicker-today">Today</button>
                                                                                  </div>
                                                                                </div>
                                                                                <div class="datepicker-wheels" aria-hidden="true">
                                                                                  <div class="datepicker-wheels-month">
                                                                                    <h2 class="header">Month</h2>
                                                                                    <ul>
                                                                                      <li data-month="0"><button type="button">Jan</button></li>
                                                                                      <li data-month="1"><button type="button">Feb</button></li>
                                                                                      <li data-month="2"><button type="button">Mar</button></li>
                                                                                      <li data-month="3"><button type="button">Apr</button></li>
                                                                                      <li data-month="4"><button type="button">May</button></li>
                                                                                      <li data-month="5"><button type="button">Jun</button></li>
                                                                                      <li data-month="6"><button type="button">Jul</button></li>
                                                                                      <li data-month="7"><button type="button">Aug</button></li>
                                                                                      <li data-month="8"><button type="button">Sep</button></li>
                                                                                      <li data-month="9"><button type="button">Oct</button></li>
                                                                                      <li data-month="10"><button type="button">Nov</button></li>
                                                                                      <li data-month="11"><button type="button">Dec</button></li>
                                                                                    </ul>
                                                                                  </div>
                                                                                  <div class="datepicker-wheels-year">
                                                                                    <h2 class="header">Year</h2>
                                                                                    <ul></ul>
                                                                                  </div>
                                                                                  <div class="datepicker-wheels-footer clearfix">
                                                                                    <button type="button" class="btn datepicker-wheels-back"><span class="glyphicon glyphicon-arrow-left"></span><span class="sr-only">Return to Calendar</span></button>
                                                                                    <button type="button" class="btn datepicker-wheels-select">Select <span class="sr-only">Month and Year</span></button>
                                                                                  </div>
                                                                                </div>
                                                                              </div>
                                                                            </div>
                                                                          </div>
                                                                    </div>
                                                                      </div>
                                                                  </div>
                                                                 <div class="col-md-12 form-group">
                                                                      <div class="col-md-5"><label class="control-label  pull-left">Pregnancy Status</label></div>
                                                                     <div class="col-md-7">
                                                                         <select class="form-control input-sm" id="pregnancyStatus" runat="server" ></select>
                                                                     </div>
                                                                 </div>
                                                                 <div class="col-md-12 form-group">
                                                                     <div class="col-md-5"><label class="control-label  pull-left">EDCD</label></div>
                                                                     <div class="col-md-7">
                                                                         <div class="datepicker fuelux" id="EDCD">
                                                                          <div class="input-group">
                                                                              <input class="form-control input-sm" id="ExpectedDateOfChildBirth" type="text" />
                                                                              <div class="input-group-btn">
                                                                                 <button type="button" class="btn btn-default dropdown-toggle input-sm" data-toggle="dropdown">
                                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                                                <span class="sr-only">Toggle Calendar</span>
                                                                              </button>
                                                                              <div class="dropdown-menu dropdown-menu-right datepicker-calendar-wrapper" role="menu">
                                                                                <div class="datepicker-calendar">
                                                                                  <div class="datepicker-calendar-header">
                                                                                       <button type="button" class="prev"><span class="glyphicon glyphicon-chevron-left input-sm"></span><span class="sr-only">Previous Month</span></button>
                                                                                       <button type="button" class="next"><span class="glyphicon glyphicon-chevron-right input-sm"></span><span class="sr-only">Next Month</span></button>
                                                                                       <button type="button" class="title" data-month="11" data-year="2014">
                                                                                            <span class="month">
                                                                                              <span data-month="0">January</span>
                                                                                              <span data-month="1">February</span>
                                                                                              <span data-month="2">March</span>
                                                                                              <span data-month="3">April</span>
                                                                                              <span data-month="4">May</span>
                                                                                              <span data-month="5">June</span>
                                                                                              <span data-month="6">July</span>
                                                                                              <span data-month="7">August</span>
                                                                                              <span data-month="8">September</span>
                                                                                              <span data-month="9">October</span>
                                                                                              <span data-month="10">November</span>
                                                                                              <span data-month="11" class="current">December</span>
                                                                                            </span> <span class="year">2014</span>
                                                                                       </button>
                                                                                  </div>
                                                                                  <table class="datepicker-calendar-days">
                                                                                    <thead>
                                                                                    <tr>
                                                                                      <th>Su</th>
                                                                                      <th>Mo</th>
                                                                                      <th>Tu</th>
                                                                                      <th>We</th>
                                                                                      <th>Th</th>
                                                                                      <th>Fr</th>
                                                                                      <th>Sa</th>
                                                                                    </tr>
                                                                                    </thead>
                                                                                    <tbody></tbody>
                                                                                  </table>
                                                                                  <div class="datepicker-calendar-footer">
                                                                                    <button type="button" class="datepicker-today">Today</button>
                                                                                  </div>
                                                                                </div>
                                                                                <div class="datepicker-wheels" aria-hidden="true">
                                                                                  <div class="datepicker-wheels-month">
                                                                                    <h2 class="header">Month</h2>
                                                                                    <ul>
                                                                                      <li data-month="0"><button type="button">Jan</button></li>
                                                                                      <li data-month="1"><button type="button">Feb</button></li>
                                                                                      <li data-month="2"><button type="button">Mar</button></li>
                                                                                      <li data-month="3"><button type="button">Apr</button></li>
                                                                                      <li data-month="4"><button type="button">May</button></li>
                                                                                      <li data-month="5"><button type="button">Jun</button></li>
                                                                                      <li data-month="6"><button type="button">Jul</button></li>
                                                                                      <li data-month="7"><button type="button">Aug</button></li>
                                                                                      <li data-month="8"><button type="button">Sep</button></li>
                                                                                      <li data-month="9"><button type="button">Oct</button></li>
                                                                                      <li data-month="10"><button type="button">Nov</button></li>
                                                                                      <li data-month="11"><button type="button">Dec</button></li>
                                                                                    </ul>
                                                                                  </div>
                                                                                  <div class="datepicker-wheels-year">
                                                                                    <h2 class="header">Year</h2>
                                                                                    <ul></ul>
                                                                                  </div>
                                                                                  <div class="datepicker-wheels-footer clearfix">
                                                                                    <button type="button" class="btn datepicker-wheels-back"><span class="glyphicon glyphicon-arrow-left"></span><span class="sr-only">Return to Calendar</span></button>
                                                                                    <button type="button" class="btn datepicker-wheels-select">Select <span class="sr-only">Month and Year</span></button>
                                                                                  </div>
                                                                                </div>
                                                                              </div>
                                                                            </div>
                                                                          </div>
                                                                    </div>
                                                                     </div>
                                                                 </div>
                                                             </div>
                                                             <div class="col-md-4">
                                                                  <div class="col-md-12 form-group">
                                                                       <div class="col-md-5"><label class="control-label  pull-left">ANC/PNC Profile</label></div>
                                                                      <div class="col-md-7">
                                                                          <select id="ancpncProfile" class="form-control input-sm"></select>
                                                                      </div>
                                                                  </div>
                                                                 <div class="col-md-12 form-group">
                                                                      <div class="col-md-5"><label class="control-label  pull-left">On Family Planning</label></div>
                                                                      <div class="col-md-7">
                                                                          <select id="OnFamilyPlanning" class="form-control input-sm"></select>
                                                                      </div>
                                                                 </div>
                                                                 <div class="col-md-12 form-group">
                                                                     <div class="col-md-5"><label class="control-label  pull-left">FP Method</label></div>
                                                                      <div class="col-md-7">
                                                                          <select id="FPMethod" class="form-control input-sm"></select>
                                                                      </div>
                                                                 </div>
                                                                 
                                                             </div>
                                                             <div class="col-md-4">
                                                                 <div class="col-md-12 form-group">
                                                                      <div class="col-md-5"><label class="control-label  pull-left">CaCX Screeing</label></div>
                                                                      <div class="col-md-7">
                                                                          <select id="cacxscreen" class="form-control input-sm"></select>
                                                                      </div>
                                                                 </div>
                                                                 <div class="col-md-12 form-group">
                                                                      <div class="col-md-5"><label class="control-label  pull-left">STI Screeing</label></div>
                                                                      <div class="col-md-7">
                                                                          <select id="stiscreen" class="form-control input-sm"></select>
                                                                      </div>
                                                                 </div>
                                                                 <div class="col-md-12 form-group">
                                                                      <div class="col-md-5"><label class="control-label  pull-left">STI Partner Notification</label></div>
                                                                      <div class="col-md-7">
                                                                          <select id="STIPartnerNotification" class="form-control input-sm"></select>
                                                                      </div>
                                                                 </div>
                                                             </div>
                                                         </div>
                                                    </div><%-- .panel-body--%>
                                                </div>
                                                   </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-11">
                                                    <div class="col-md-12"><hr /></div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-4">
                                                    <div class="col-md-12">
                                                       <div class="col-md-12 form-group"><label class="control-label pull-left">Antigen Today</label></div> 
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                 <div class="form-group col-md-12">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblbcg">
                                                                         <input class="sr-only" type="checkbox" id="BCG" value="option1"> <span class="checkbox-label"><strong> BCG </strong></span>
                                                                     </label>
                                                                </div>
                                                        
                                                                 <div class="form-group col-md-6">
                                                                    <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblpv">
                                                                      <input class="sr-only" type="checkbox" id="PV" value="option1"> <span class="checkbox-label"><strong>Polio Vaccine </strong> </span>
                                                                    </label>
                                                                </div>

                                                                 <div class="form-group col-md-6">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblpenta">
                                                                          <input class="sr-only" type="checkbox" id="penta" value="option1"> <span class="checkbox-label"><strong> Pentavallent </strong></span>
                                                                    </label>     
                                                                </div>

                                                                 <div class="form-group col-md-6">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblpcv">
                                                                         <input class="sr-only" type="checkbox" id="pcv" value="option1"> <span class="checkbox-label"> <strong>Pneumococcal </strong></span>
                                                                    </label>
                                                                </div>
                                                        
                                                                 <div class="form-group col-md-6">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblmeasles">
                                                                         <input class="sr-only" type="checkbox" id="measles" value="option1"> <span class="checkbox-label"> Measles </span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                           
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-11">
                                                            <div class="col-md-12">
                                                             </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="col-md-7">
                                                     <div class="row">
                                                        <div class="form-group col-md-12">
                                                            <div class="panel panel-default">
                                                            <div class="panel-heading">Add any vaccination/antigen give to Child</div>
                                                            <div class="panel-body">
                                                               
                                                                 <div class="col-md-12">
                                                                      <div class="form-group col-md-3">
                                                                            <div class="col-md-12"><label class="control-label pull-left">Antigen</label></div>
                                                                            <div class="col-md-12">
                                                                                <select runat="server" id="AntigenToday" class="form-control input-sm"></select>
                                                                            </div>
                                                                        </div>
                                                                      <div class="col-md-3">
                                                                              <div class="col-md-12"><label class="control-label pull-left">Duration(wks)</label></div>
                                                                              <div class="col-md-12">
                                                                                    <select runat="server"  id="antigenDuration" class="form-control input-sm"></select>
                                                                              </div>
                                                                        </div>
                                                                      <div class="col-md-4">
                                                                            <div class="col-md-12"><label class="control-label pull-left">Date Given</label></div>
                                                                            <div class="col-md-12">
                                                                                <div class="datepicker fuelux" id="AntigenDate">
                                                                                      <div class="input-group">
                                                                                          <input class="form-control input-sm" id="DateGiven" type="text" />
                                                                                          <div class="input-group-btn">
                                                                                             <button type="button" class="btn btn-default dropdown-toggle input-sm" data-toggle="dropdown">
                                                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                                                            <span class="sr-only">Toggle Calendar</span>
                                                                                          </button>
                                                                                          <div class="dropdown-menu dropdown-menu-right datepicker-calendar-wrapper" role="menu">
                                                                                            <div class="datepicker-calendar">
                                                                                              <div class="datepicker-calendar-header">
                                                                                                   <button type="button" class="prev"><span class="glyphicon glyphicon-chevron-left input-sm"></span><span class="sr-only">Previous Month</span></button>
                                                                                                   <button type="button" class="next"><span class="glyphicon glyphicon-chevron-right input-sm"></span><span class="sr-only">Next Month</span></button>
                                                                                                   <button type="button" class="title" data-month="11" data-year="2014">
                                                                                                        <span class="month">
                                                                                                          <span data-month="0">January</span>
                                                                                                          <span data-month="1">February</span>
                                                                                                          <span data-month="2">March</span>
                                                                                                          <span data-month="3">April</span>
                                                                                                          <span data-month="4">May</span>
                                                                                                          <span data-month="5">June</span>
                                                                                                          <span data-month="6">July</span>
                                                                                                          <span data-month="7">August</span>
                                                                                                          <span data-month="8">September</span>
                                                                                                          <span data-month="9">October</span>
                                                                                                          <span data-month="10">November</span>
                                                                                                          <span data-month="11" class="current">December</span>
                                                                                                        </span> <span class="year">2014</span>
                                                                                                   </button>
                                                                                              </div>
                                                                                              <table class="datepicker-calendar-days">
                                                                                                <thead>
                                                                                                <tr>
                                                                                                  <th>Su</th>
                                                                                                  <th>Mo</th>
                                                                                                  <th>Tu</th>
                                                                                                  <th>We</th>
                                                                                                  <th>Th</th>
                                                                                                  <th>Fr</th>
                                                                                                  <th>Sa</th>
                                                                                                </tr>
                                                                                                </thead>
                                                                                                <tbody></tbody>
                                                                                              </table>
                                                                                              <div class="datepicker-calendar-footer">
                                                                                                <button type="button" class="datepicker-today">Today</button>
                                                                                              </div>
                                                                                            </div>
                                                                                            <div class="datepicker-wheels" aria-hidden="true">
                                                                                              <div class="datepicker-wheels-month">
                                                                                                <h2 class="header">Month</h2>
                                                                                                <ul>
                                                                                                  <li data-month="0"><button type="button">Jan</button></li>
                                                                                                  <li data-month="1"><button type="button">Feb</button></li>
                                                                                                  <li data-month="2"><button type="button">Mar</button></li>
                                                                                                  <li data-month="3"><button type="button">Apr</button></li>
                                                                                                  <li data-month="4"><button type="button">May</button></li>
                                                                                                  <li data-month="5"><button type="button">Jun</button></li>
                                                                                                  <li data-month="6"><button type="button">Jul</button></li>
                                                                                                  <li data-month="7"><button type="button">Aug</button></li>
                                                                                                  <li data-month="8"><button type="button">Sep</button></li>
                                                                                                  <li data-month="9"><button type="button">Oct</button></li>
                                                                                                  <li data-month="10"><button type="button">Nov</button></li>
                                                                                                  <li data-month="11"><button type="button">Dec</button></li>
                                                                                                </ul>
                                                                                              </div>
                                                                                              <div class="datepicker-wheels-year">
                                                                                                <h2 class="header">Year</h2>
                                                                                                <ul></ul>
                                                                                              </div>
                                                                                              <div class="datepicker-wheels-footer clearfix">
                                                                                                <button type="button" class="btn datepicker-wheels-back"><span class="glyphicon glyphicon-arrow-left"></span><span class="sr-only">Return to Calendar</span></button>
                                                                                                <button type="button" class="btn datepicker-wheels-select">Select <span class="sr-only">Month and Year</span></button>
                                                                                              </div>
                                                                                            </div>
                                                                                          </div>
                                                                                        </div>
                                                                                      </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                      <div class="col-md-2">
                                                                    <div class="col-md-12"><label class="control-label pull-right fa fa-cog">Action</label></div> 
                                                                    <div class="col-md-12">
                                                                          <asp:LinkButton runat="server" ID="btnAmtigenAdd" CssClass="btn btn-info btn-lg fa fa-plus-circle">Add Antigen</asp:LinkButton>
                                                                     </div>
                                                                </div>
                                                                 </div>
                                                                
                                                            </div>
                                                        </div>
                                                            
                                                           <%-- <div class="col-md-12 form-group"><label class="control-label pull-left"> Add any vaccination/antigen give to Child</label></div> --%>
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><%--.row--%>

                                            <div class="row">
                                                
                                                <div class="col-md-1"></div>
                                                 <div class="col-md-11">
                                                     <div class="col-md-12"><hr /></div> 
                                                     <div class="col-md-12 form-group"><label class="control-label pull-left">Chronic Illnesses & Comorbidities</label></div>
                                                     <div class="row">
                                                         <div class="col-md-12">
                                                              <div class="col-md-5 form-group">
                                                                   <div class="col-md-12"><label class="control-label pull-left">Illness</label></div>
                                                                  <div class="col-md-12">
                                                                      <select runat="server" id="ChronicIllness" class="form-control input-sm"></select>
                                                                  </div>
                                                              </div>

                                                              <div class="col-md-3 form-group">
                                                                   <div class="col-md-12"><label class="control-label pull-left">Current Treatment</label></div>
                                                                   <div class="col-md-12">
                                                                       <input runat="server" class="form-control input-sm" id="ChronicIllnessTreatment" />
                                                                   </div>
                                                              </div>

                                                             <div class="col-md-2 form-group">
                                                                 <div class="col-md-12"><label class="control-label pull-left"> Dose</label></div>
                                                                 <div class="col-md-12">
                                                                     <select runat="server" class="form-control input-sm" id="ChronicIllnessDose"></select>
                                                                 </div>
                                                             </div>
                                                             <div class="col-md-1 form-group">
                                                                  <div class="col-md-12"><label class="control-label pull-left"> Duration</label></div>
                                                                 <div class="col-md-12">
                                                                     <input type="text" min="0" max="180" class="form-control" runat="server" />
                                                                 </div>
                                                             </div>

                                                             <div class="col-md-1">
                                                                 <div class="col-md-12"><label class="control-label pull-left"><span class="fa fa-cog">Action</span></label></div>
                                                                 <div class="col-md-4">
                                                                     <asp:LinkButton runat="server" ID="LinkButton1" CssClass="btn btn-info btn-lg fa fa-plus-circle">Add</asp:LinkButton>
                                                                 </div>
                                                             </div>
                                                         </div>
                                                         
                                                     </div>
                                                 </div>
                                            </div>


	                                    </div>
	                                    
                                           <div class="step-pane sample-pane" data-step="2">
                                             <div class="col-md-12"><small class="muted pull-left"><strong>PATIENT Examination</strong></small></div> <div class="col-md-12"><hr /> </div>  
                                             <div class="row">
                                                 <div class="col-md-1">
                                                     <h4 class="pull-left text-warning"><i class="fa fa-search fa-5x" aria-hidden="true"></i></h4>
                                                 </div>
                                                 <div class="col-md-11">
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><h1 class="text-primary pull-left"><small>Physical Examination</small> </h1></div>
                                                         <div class="col-md-12"><hr /></div>

                                                         <div class="col-md-12 form-group">
                                                             <label class="control-label pull-left">Indicate Physical Examination Findings below </label>
                                                         </div>

                                                         <div class="form-group col-md-12">
                                                              <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblpallor">
                                                                    <input class="sr-only" type="checkbox" id="pallor" value="option1"> <span class="checkbox-label"><strong> Pallor </strong> </span>
                                                            </label>
                                                         </div>
                                                         <div class="form-group col-md-12">
                                                             <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblJaundice">
                                                                 <input class="sr-only" type="checkbox" id="Jaundice" value="option1"> <span class="checkbox-label"><strong> Jaundice </strong> </span>
                                                            </label>
                                                         </div>
                                                         <div class="form-group col-md-12">
                                                             <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblOedema">
                                                                 <input class="sr-only" type="checkbox" id="Oedema" value="option1"> <span class="checkbox-label"><strong> Oedema </strong> </span>
                                                            </label>
                                                         </div>
                                                         <div class="form-group col-md-12">
                                                             <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblOralThhrush">
                                                                 <input class="sr-only" type="checkbox" id="OralThrush" value="option1"> <span class="checkbox-label"><strong> Oral Thrush </strong> </span>
                                                            </label>
                                                         </div>
                                                     </div>
                                                     <div class="col-md-6">
                                                          <div class="col-md-12"><h1 class="text-primary pull-left"><small>Physical Examination Notes</small> </h1></div>
                                                         <div class="col-md-12"><hr /></div>
                                                         <div class="row">
                                                             <div class="col-md-12 form-group">
                                                                 <label class="control-label pull-left">Examination Notes on further findings</label>
                                                            </div>
                                                             <div class="col-md-12">
                                                                 <textarea runat="server" class="form-control input-sm" id="examinationNotes" rows="6"></textarea>
                                                             </div>
                                                         </div>
                                                     </div>
                                                 </div>
                                             </div>
                                             
	                                    </div>

                                           <div class="step-pane sample-pane" data-step="3">
                                             <div class="col-md-12"><small class="muted pull-left"><strong>PATIENT MANAGEMENT</strong></small></div> <div class="col-md-12"><hr /> </div>  
                                             <div class="row">
                                                  <div class="col-md-1">
                                                      <h4 class="pull-left text-danger"><i class="fa fa-bed fa-5x" aria-hidden="true"></i></h4>
                                                 </div>

                                                  <div class="col-md-11">
                                                  
                                                       <div class="col-md-4">
                                                           <h1 class="col-md-12"><small class="pull-left">Positive Health,Dignity & Prevention (PHDP)</small></h1>
                                                           <div class="col-md-12"><hr /></div>
                                                            
                                                                <div class="form-group col-md-12">
                                                                         <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblAdc">
                                                                             <input class="sr-only" type="checkbox" id="adc" value="option1"> <span class="checkbox-label"><strong> Adherance Counselling (Adc) </strong></span>
                                                                         </label>
                                                                </div>

                                                                <div class="form-group col-md-12">
                                                                         <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblcondom">
                                                                             <input class="sr-only" type="checkbox" id="CondonUse" value="option1"> <span class="checkbox-label"><strong> Condom Distribution (CD) </strong></span>
                                                                         </label>
                                                                </div>

                                                                <div class="form-group col-md-12">
                                                                         <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblsubstanceAbuse">
                                                                             <input class="sr-only" type="checkbox" id="SubstanceAbuse" value="option1"> <span class="checkbox-label"><strong> Substance Abuse (SA) </strong></span>
                                                                         </label>
                                                                </div>

                                                                <div class="form-group col-md-12">
                                                                         <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lbldsp">
                                                                             <input class="sr-only" type="checkbox" id="DisclosureToSexPartner" value="option1"> <span class="checkbox-label"><strong> Disclosure to Sex Partner (Disc) </strong></span>
                                                                         </label>
                                                                </div>

                                                                <div class="form-group col-md-12">
                                                                         <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblPartnerTesting">
                                                                             <input class="sr-only" type="checkbox" id="Partner Testing" value="option1"> <span class="checkbox-label"><strong> Partner Testing (PT) </strong></span>
                                                                         </label>
                                                                </div>

                                                                <div class="form-group col-md-12">
                                                                         <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblstiscreening">
                                                                             <input class="sr-only" type="checkbox" id="STIScreening" value="option1"> <span class="checkbox-label"><strong> STI Screening (STI)</strong></span>
                                                                         </label>
                                                                 </div>
                                                       </div>

                                                       <div class="col-md-8">
                                                            
                                                            <h1 class="col-md-12"><small class="pull-left"> Patient Diagnosis and Treatment</small></h1>
                                                            <div class="col-md-12"><hr /></div>
                                                            
                                                            <div class="col-md-12">
                                                                 <div class="col-md-7"><label class="control-label pull-left">Diagnosis (ICD 10 Codes)</label></div>
                                                                 <div class="col-md-3"><label class="control-label pull-left">Treatment</label></div>
                                                                 <div class="col-md-2"><label class="control-label pull-left">Action</label></div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                 <div class="col-md-7 form-group">
                                                                      <input type="text" id="Diagnosis" class ="form-control input-sm" placeholder="Type Diagnosis......" runat="server" />
                                                                 </div>
                                                                
                                                                 <div class="col-md-3 form-group">
                                                                     <input type="text" id="DiagnosisTreatment" class ="form-control input-sm" placeholder="treatment" runat="server" />
                                                                 </div>
                                                                 
                                                                <div class="col-md-2 form-group">
                                                                      <asp:LinkButton runat="server" ID="btnAddDiagnosis" CssClass="btn btn-info btn-lg fa fa-plus-circle"> Add</asp:LinkButton>
                                                                 </div>
                                                                
                                                            </div>

                                                            <div class="col-md-12">
                                                                 <div class="col-md-12">
                                                                      <div class="panel panel-default">
			                                                          <div class="panel-heading">Patient Diagnosis Today</div>
			                                                              <div class="panel-body">
		   
			                                                              </div>
                                                                      </div>
                                                                 </div> 
                                                            </div>
                                                       </div>
                                                   
                                                  </div><%-- .col-md-11--%>
                                                    
                                             </div>
                                             
                                             <div class="row">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-11">
                                                     <div class="col-md-4">
                                                          <div class="col-md-12"><hr /></div>
                                                          <div class="col-md-12">

                                                               <div class="col-md-8">
                                                                  <div class="col-md-12"><label class="control-label pull-left">ARV Adherence</label></div>
                                                              </div>

                                                               <div class="col-md-4">
                                                                  <div class="form-group col-md-12">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblGood">
                                                                         <input class="sr-only" type="checkbox" id="ARVGood" value="option1"> <span class="checkbox-label"><strong> Good </strong></span>
                                                                     </label>
                                                                  </div>

                                                                  <div class="form-group col-md-12">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblFair">
                                                                         <input class="sr-only" type="checkbox" id="ARVFair" value="option1"> <span class="checkbox-label"><strong> Fair </strong></span>
                                                                     </label>
                                                                  </div>

                                                                  <div class="form-group col-md-12">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblPoor">
                                                                         <input class="sr-only" type="checkbox" id="ARVPoor" value="option1"> <span class="checkbox-label"><strong> Poor </strong></span>
                                                                     </label>
                                                                  </div>
                                                              </div>
                                                          </div><%-- .col-md-12--%>
                                                          <div class="col-md-12">
                                                             <div class="col-md-8">
                                                                  <div class="col-md-12"><label class="control-label pull-left">CTX/Dapsone Adherence</label></div>
                                                              </div>
                                                             <div class="col-md-4">
                                                                  <div class="form-group col-md-12">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblCTXGood">
                                                                         <input class="sr-only" type="checkbox" id="CTXGood" value="option1"> <span class="checkbox-label"><strong> Good </strong></span>
                                                                     </label>
                                                                  </div>

                                                                  <div class="form-group col-md-12">
                                                                     <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblCTXFair">
                                                                         <input class="sr-only" type="checkbox" id="CTXFair" value="option1"> <span class="checkbox-label"><strong> Fair </strong></span>
                                                                     </label>
                                                                  </div>

                                                                  <div class="form-group col-md-12">
                                                                         <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblCTXPoor">
                                                                             <input class="sr-only" type="checkbox" id="CTXPoor" value="option1"> <span class="checkbox-label"><strong> Poor </strong></span>
                                                                         </label>
                                                                      </div>
                                                             </div>
                                                         </div>

                                                          <div class="col-md-12">
                                                              <div class="col-md-12"><hr /></div>
                                                              <div class="col-md-12">
                                                                   <div class="col-md-5"><label class="control-label pull-left">Next Appointment </label></div>
                                                                   <div class="col-md-7">
                                                                        <div class="datepicker fuelux form-group" id="NextAppDate">
                                                                          <div class="input-group">
                                                                              <input class="form-control input-sm" id="NextAppointmentDate" type="text" />
                                                                              <div class="input-group-btn">
                                                                                 <button type="button" class="btn btn-default dropdown-toggle input-sm" data-toggle="dropdown">
                                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                                                <span class="sr-only">Toggle Calendar</span>
                                                                              </button>
                                                                              <div class="dropdown-menu dropdown-menu-right datepicker-calendar-wrapper" role="menu">
                                                                                <div class="datepicker-calendar">
                                                                                  <div class="datepicker-calendar-header">
                                                                                       <button type="button" class="prev"><span class="glyphicon glyphicon-chevron-left input-sm"></span><span class="sr-only">Previous Month</span></button>
                                                                                       <button type="button" class="next"><span class="glyphicon glyphicon-chevron-right input-sm"></span><span class="sr-only">Next Month</span></button>
                                                                                       <button type="button" class="title" data-month="11" data-year="2014">
                                                                                            <span class="month">
                                                                                              <span data-month="0">January</span>
                                                                                              <span data-month="1">February</span>
                                                                                              <span data-month="2">March</span>
                                                                                              <span data-month="3">April</span>
                                                                                              <span data-month="4">May</span>
                                                                                              <span data-month="5">June</span>
                                                                                              <span data-month="6">July</span>
                                                                                              <span data-month="7">August</span>
                                                                                              <span data-month="8">September</span>
                                                                                              <span data-month="9">October</span>
                                                                                              <span data-month="10">November</span>
                                                                                              <span data-month="11" class="current">December</span>
                                                                                            </span> <span class="year">2014</span>
                                                                                       </button>
                                                                                  </div>
                                                                                  <table class="datepicker-calendar-days">
                                                                                    <thead>
                                                                                    <tr>
                                                                                      <th>Su</th>
                                                                                      <th>Mo</th>
                                                                                      <th>Tu</th>
                                                                                      <th>We</th>
                                                                                      <th>Th</th>
                                                                                      <th>Fr</th>
                                                                                      <th>Sa</th>
                                                                                    </tr>
                                                                                    </thead>
                                                                                    <tbody></tbody>
                                                                                  </table>
                                                                                  <div class="datepicker-calendar-footer">
                                                                                    <button type="button" class="datepicker-today">Today</button>
                                                                                  </div>
                                                                                </div>
                                                                                <div class="datepicker-wheels" aria-hidden="true">
                                                                                  <div class="datepicker-wheels-month">
                                                                                    <h2 class="header">Month</h2>
                                                                                    <ul>
                                                                                      <li data-month="0"><button type="button">Jan</button></li>
                                                                                      <li data-month="1"><button type="button">Feb</button></li>
                                                                                      <li data-month="2"><button type="button">Mar</button></li>
                                                                                      <li data-month="3"><button type="button">Apr</button></li>
                                                                                      <li data-month="4"><button type="button">May</button></li>
                                                                                      <li data-month="5"><button type="button">Jun</button></li>
                                                                                      <li data-month="6"><button type="button">Jul</button></li>
                                                                                      <li data-month="7"><button type="button">Aug</button></li>
                                                                                      <li data-month="8"><button type="button">Sep</button></li>
                                                                                      <li data-month="9"><button type="button">Oct</button></li>
                                                                                      <li data-month="10"><button type="button">Nov</button></li>
                                                                                      <li data-month="11"><button type="button">Dec</button></li>
                                                                                    </ul>
                                                                                  </div>
                                                                                  <div class="datepicker-wheels-year">
                                                                                    <h2 class="header">Year</h2>
                                                                                    <ul></ul>
                                                                                  </div>
                                                                                  <div class="datepicker-wheels-footer clearfix">
                                                                                    <button type="button" class="btn datepicker-wheels-back"><span class="glyphicon glyphicon-arrow-left"></span><span class="sr-only">Return to Calendar</span></button>
                                                                                    <button type="button" class="btn datepicker-wheels-select">Select <span class="sr-only">Month and Year</span></button>
                                                                                  </div>
                                                                                </div>
                                                                              </div>
                                                                            </div>
                                                                          </div>
                                                                    </div>
                                                                   </div>
                                                              </div>

                                                              <div class="col-md-12">
                                                                   <div class="col-md-5"><label class="control-label pull-left">Referred for </label></div>
                                                                   <div class="col-md-7 form-group">
                                                                       <input type="text" class="form-control input-sm" id="ReferredFor" placeholder="referred for" runat="server" />
                                                                   </div>
                                                              </div>
                                                              
                                                              <div class="col-md-12">
                                                                  <div class="col-md-5"><label class="control-label pull-left">Referred for </label></div>
                                                                  <div class="col-md-7 form-group">
                                                                      <select class="form-control input-sm" id="PrescribedBy" runat="server"></select>
                                                                  </div>
                                                              </div>
                                                          </div>
                                                     </div><%-- .col-md-4--%>
                                                     <div class="col-md-8">
                                                         <div class="col-md-12"><hr /></div>
                                                         <div class="col-md-12">
                                                              <div class="form-group col-md-4">
                                                                   <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblART">
                                                                          <input class="sr-only" type="checkbox" id="DrugsART" value="option1"> <span class="checkbox-label"><strong> ART </strong></span>
                                                                   </label>
                                                              </div>
                                                                   
                                                              <div class="form-group col-md-4">
                                                                   <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblNonART">
                                                                           <input class="sr-only" type="checkbox" id="DrugsARV" value="option1"> <span class="checkbox-label"><strong> Non-ART </strong></span>
                                                                   </label>
                                                              </div>

                                                               <div class="form-group col-md-4">
                                                                    <label class="checkbox-custom checkbox-inline pull-left" data-initialize="checkbox"  id="lblProphylaxis">
                                                                           <input class="sr-only" type="checkbox" id="Prophylaxis" value="option1"> <span class="checkbox-label"><strong> Prophylaxis </strong></span>
                                                                     </label>
                                                               </div>
                                                         </div> <%--.col-md-12--%>

                                                         <div class="col-md-12">
                                                             <hr />
                                                              <div class="col-md-4 form-group"><label class="control-label pull-left">Regimen Line </label></div>     
                                                              <div class="col-md-4 form-group">
                                                                   <select id="RegimenLine" runat="server" class="form-control input-sm" ></select>
                                                              </div>
                                                              <div class="col-md-4 form-group"></div>
                                                         </div>  
                                                         <div class="col-md-12">  
                                                              <div class="col-md-4 form-group"><label class="control-label pull-left">Subsitututions/Switches/Interuptions </label></div>
                                                              <div class="col-md-4 form-group">
                                                                   <select id="substitution" runat="server" class="form-control input-sm" ></select>
                                                              </div>
                                                              <div class="col-md-4"></div>

                                                         </div>
                                                             
                                                         <div class="col-md-12">
                                                              <div class="panel panel-default">
                                                          <div class="panel-heading">Drug Prescription </div>
                                                          <div class="panel-body">
                                                               <div class="row">
                                                                    <div class="col-md-12">
                                                                         <div class="col-md-10">
                                                                         <div class="col-md-12"><label class="control-label pull-left">Select Drug (s) </label></div>
                                                                         <div class="col-md-12">
                                                                              <input type="text" class="form-control input-sm" placeholder="type to search...." runat="server" />
                                                                         </div>
                                                                     </div>
                                                                                   
                                                                         <div class="col-md-2">
                                                                          <div class="col-md-12"><label class="control-lable pull-left">*</label></div>
                                                                          <div class="col-md-12">
                                                                               <asp:LinkButton runat="server" CssClass="btn btn-info btn-lg fa fa-plus-circle"> Add Drug</asp:LinkButton> 
                                                                          </div>
                                                                    </div>
                                                                    </div>
                                                                    <div class="col-md-12"><hr /></div>
                                                                    <div class="col-md-12">
                                                                         <div class="col-md-4 pull-left"><label class="control-label pull-left"> Drug</label></div>
                                                                         <div class="col-md-2 pull-left"><label class="control-label pull-left"> Dose</label></div>
                                                                        <div class="col-md-2 pull-left"><label class="control-label pull-left">  Frequency</label></div>
                                                                         <div class="col-md-2 pull-left"><label class="control-label pull-left"> Quantity</label></div>
                                                                         <div class="col-md-2 pull-left"><label class="control-label pull-left"> Duration</label></div>
                                                                    </div>  
                                                                    <div class="col-md-12">
                                                                       <div class="col-md-4"><label class="control-label pull-left text-primary">--Selected drug--</label></div>
                                                                        <div class="col-md-2"><input type="text" class="form-control input-sm" runat="server" id="Dose" /> </div>
                                                                        <div class="col-md-2"><select class="form-control input-sm" id="Frequency" runat="server"></select></div>
                                                                       <div class="col-md-2"><input type="text" class="form-control input-sm" runat="server" id="Quantity" /> </div>
                                                                       <div class="col-md-2"><input type="text" class="form-control input-sm" runat="server" id="Duration" /> </div>
                                                                    </div>
                                                                 </div>
                                                           </div>
                                                     </div>
                                                         </div>            
                                                     </div>
                                                 </div>
                                               
                                            </div> <%--.row--%>

 
                                        </div><%-- .data-step-3--%>
                                     
                                      </div><%-- .step-content--%>
                               </div> <%-- .wizard--%>
                             </div><%--.col-md-12--%>
                      
                      </div><!-- .encounter-->
                      <div  role="tabpanel"     class="tab-pane fade"      id="vlTracker">...</div><!-- .viraload tracker-->
                      <div  role="tabpanel"     class="tab-pane fade"      id="Laboratory">...</div><!-- .laboratory-->
                      <div  role="tabpanel"     class="tab-pane fade"      id="Pharmacy">...</div><!-- .pharmacy-->
                       <div  role="tabpanel"    class="tab-pane fade"      id="history">...</div><!-- .history-->
                 </div><!-- .tab-content-->
            </div><!-- .col-md-12 -->
        </div><!-- .row -->
    </div><!-- .container-fluid -->

    <script type="text/javascript">
        $(document).ready(function () {

            $('#OnsetDate').datepicker();
            $('#FemaleLMP').datepicker();
            $('#EDCD').datepicker();
            $('#AntigenDate').datepicker();
            $('#NextAppDate').datepicker();
            $('#ptnEncounter').wizard();
        });

    </script>
</asp:Content>
