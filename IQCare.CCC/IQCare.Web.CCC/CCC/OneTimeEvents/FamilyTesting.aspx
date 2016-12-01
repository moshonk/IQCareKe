﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/IQCare.master" AutoEventWireup="true" CodeBehind="FamilyTesting.aspx.cs" Inherits="IQCare.Web.CCC.OneTimeEvents.FamilyTesting" %>
<%@ Register TagPrefix="uc" TagName="PatientDetails" Src="~/CCC/UC/ucTriage.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row">
                <div class="col-md-12">
                    <uc:PatientDetails ID="PatientSummary" runat="server" />
                </div>
        </div>

        <div class="row">
            <div class="col-md-12"><h5 class="pull-left"><i class="fa fa-users fa-2x" aria-hidden="true"> Family Member(s) Information</i> </h5></div> 
            
                 <div class="col-md-12">
                     <div class="panel panel-default">
                            <div class="panel-body">
                               
                                 <div class="col-md-12">

                                     <div class="col-md-6">
                                         <div class="col-md-12"><small class="pull-left">Enter Family Testing information</small><hr /></div>
                                         <div class="col-md-12 form-group">
                                              <div class="col-md-3"><label class="control-label pull-left">Name(s)</label></div>
                                             <div class="col-md-9"><input class="form-control input-sm" type="text" runat="server" placeholder="Family Names" /></div>
                                         </div>

                                         <div class="col-md-12 form-group">
                                              <div class="col-md-3"><label class="control-label pull-left">Relationship</label></div>
                                              <div class="col-md-4">
                                                    <select runat="server" id="relationship" class="form-control input-sm"></select>
                                              </div>
                                         </div>

                                         <div class="col-md-12 form-group">
                                              <div class="col-md-3"><label class="control-label pull-left">Baseline HIV Status</label></div>
                                             <div class="col-md-4">
                                                 <select runat="server" id="BaselineHIVStatus" class="form-control input-sm"></select>
                                             </div>
                                             <div class="col-md-1"><label class="control-label pull-left">Date</label></div>
                                             <div class="col-md-4">
                                                  <div class="datepicker fuelux form-group" id="BaselineHIVStatusD">
                                           <div class="input-group">
                                                                              <input class="form-control input-sm" id="BaselineHIVStatusDate" type="text" />
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
                                              <div class="col-md-3"><label class="control-label pull-left"> HIV Testing Date</label></div>
                                             <div class="col-md-4">
                                                  <div class="datepicker fuelux form-group" id="TestingDate">
                                           <div class="input-group">
                                                                              <input class="form-control input-sm" id="HIVTestingDate" type="text" />
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
                                             <div class="col-md-1"><label class="control-label pull-left">Results</label></div>
                                             <div class="col-md-4">
                                                 <select runat="server" id="HIVTestingResults" class="form-control input-sm"></select>
                                             </div>
                                             
                                         </div>

                                         <div class="col-md-12">
                                             <div class="col-md-12"><hr /></div>
                                             <div class="col-md-9"></div>
                                              <div class="col-md-1">
                                                 <asp:LinkButton runat="server" ID="btnAddFamilyTesting" CssClass=" btn btn-info btn-lg fa fa-plus-circle" >Add Family Member</asp:LinkButton>
                                              </div>
                                             <div class="col-md-1"></div>
                                         </div>
                                     </div>
                                     <div class="col-md-6">
                                         <div class="col-md-12"><small class="pull-left">Enter Family Testing Grid</small><hr /></div>
                                         
                                     </div>
                                 </div>

                                 <div class="col-md-12">
                                     <hr />
                                     <div class="col-md-8"></div>
                                     
                                     <div class="col-md-4 pull-right">
                                          <asp:LinkButton runat="server" ID="btnOneTimeEventsTracker" CssClass=" btn btn-primary btn-lg fa fa-arrow-circle-o-right" > Save Family Testing</asp:LinkButton>
                                          <asp:LinkButton runat="server" ID="btnReloadHistory" CssClass=" btn btn-warning fa fa-refresh btn-lg" > Reload Members</asp:LinkButton>
                                          <asp:LinkButton runat="server" ID="btnClose" CssClass=" btn btn-danger fa fa-times btn-lg" > Close Family Testing</asp:LinkButton>
          
                                                                                                                          
                                     </div>
                                 </div>

                            </div> <%--.panel-body--%>
                        </div>
                    </div><%-- .col-md-12--%>

                 
            
        </div>
    </div> <%--.container-fluid--%>

   <script type="text/javascript">
        
    $(document).ready(function () {
            $('#BaselineHIVStatusD').datepicker();
            $('#TestingDate').datepicker();
    

        });

    </script>

</asp:Content>
