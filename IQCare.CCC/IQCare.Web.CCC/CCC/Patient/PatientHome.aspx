﻿<%@ Page Title="" Language="C#" MasterPageFile="~/CCC/Greencard.Master" AutoEventWireup="true" CodeBehind="PatientHome.aspx.cs" Inherits="IQCare.Web.CCC.Patient.PatientHome" %>

<%--<%@ Register Src="~/CCC/UC/ucPatientDetails.ascx" TagPrefix="IQ" TagName="ucPatientDetails" %>--%>

<%--<%@ Register Src="~/CCC/UC/ucPatientDetails.ascx" TagPrefix="IQ" TagName="ucPatientDetails" %>--%>
<%@ Register Src="~/CCC/UC/ucPatientBrief.ascx" TagPrefix="IQ" TagName="ucPatientDetails" %>
<%@ Register Src="~/CCC/UC/ucExtruder.ascx" TagPrefix="IQ" TagName="ucExtruder" %>


<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
      <%--  <div class="col-md-12 col-xs-12 col-sm-12" style="margin-top: 0%;padding-top: 0%">--%>
            <IQ:ucPatientDetails runat="server" ID="ucPatientDetails" />
        <%--</div>--%>

<%--    <div class="col-md-12 col-xs-12 col-sm-12 form-group">
        <div class="col-md-6 col-xs-12 col-sm-6">
            
              <div id="vl_container" style="min-width: 300px; height: 350px; margin: 0 auto"></div> 
            <!-- .bs-component-->
        </div>
        <!-- .col-lg-3 -->
        <div class="col-md-6 col-xs-12 col-sm-6">
             <div id="vitals_container" style="min-width: 300px; height: 350px; margin: 0 auto"></div> 
            <!-- .bs-component-->
        </div>
    </div>--%>
    <div class="col-md-12 col-xs-12 col-sm-12">
         <div class="panel panel-default">
              <div class="panel-body">
                  <div class="col-md-12">
                      
                      <div class="col-md-11">
                           <div class="col-md-3 col-xs-12 col-sm-12">
                                 <div class="col-md-12 col-xs-12 col-sm-12"><h5 class="pull-left"><asp:Label runat="server"> Last ViralLoad :</asp:Label></h5></div>
                                 <div class="col-md-12 col-md-12 col-xs-12 col-sm-12">
                                    <h6> <asp:Label runat="server" ClientIDMode="Static" ID="lblVL" CssClass="text-info pull-left"> </asp:Label></h6>
                                </div>
                           </div>
                          <div class="col-md-3 col-xs-12 col-sm-12">
                               <div class="col-md-12"><h5 class="pull-left"><asp:Label runat="server"> VL Due Date :</asp:Label></h5></div>
                               <div class="col-md-12">
                                    <h6> <asp:Label runat="server" ClientIDMode="Static" ID="lblvlDueDate" CssClass="text-info pull-left"> </asp:Label></h6>
                                </div>

                          </div>
                          <div class="col-md-3 col-xs-12 col-sm-12">
                                <div class="col-md-12"><h5 class="pull-left"><asp:Label runat="server"> Current Regimen :</asp:Label></h5></div>
                                <div class="col-md-12 col-md-12 col-xs-12 col-sm-12">
                                    <h6> <asp:Label runat="server" ClientIDMode="Static" ID="lblCurrentRegimen" CssClass="text-info pull-left"> </asp:Label></h6>
                                </div>
                          </div>
                          <div class="col-md-3 col-xs-12 col-sm-12">
                                <div class="col-md-12"><h5 class="pull-left"><asp:Label runat="server"> Adherance Status :</asp:Label></h5></div>
                               <div class="col-md-12 col-md-12 col-xs-12 col-sm-12">
                                    <h6> <asp:Label runat="server" ClientIDMode="Static" ID="lblAdheranceStatus" CssClass="text-info pull-left"> </asp:Label></h6>
                                </div>
                          </div>
                      </div>
                  </div><!-- .col-md-12 -->
                 
              </div><!-- .panel- body-->
         </div><!-- .panel-->
    </div>
    
    <div class="col-md-12 col-xs-12 col-sm-12">
      
        <ul class="nav nav-tabs">
             <li  class="active"><a data-toggle="tab" href="#Trending">Viral Load & BMI Trending </a></li>  
            <li><a data-toggle="tab" href="#Registration">Registration Summary </a></li>
            <li><a data-toggle="tab" href="#EntryPoint"><strong>Entry Point & Transfer Status</strong></a> </li>
            <li><a data-toggle="tab" href="#Baseline">Baseline Assessment & Treament Initiation </a></li>
                   

        </ul>
    
        <div class="col-md-12 col-xs-12 col-xs-12 form-group">
            <div class="col-md-12 form-group"></div> 
            <div class="tab-content">
                 <div id="Registration" class="tab-pane">
                     <div class="col-md-12 col-xs-12">
                         
                         <div class="col-md-4 col-xs-4 col-sm-4">
                             
                             
                             <div class="col-md-12 label label-info"><label class="control-label"><strong class="text-primary"></strong><h6>Patient Treatment Supporter</h6></label></div>
                             <div class="col-md-12"><hr style="margin-top:1%"/></div>
                             
                             <div class="col-md-12 form-group">
                                 <div class="col-md-6"><label class="control-label pull-left">Names:</label></div>
                                 <div class="col-md-6">
                                     <asp:Label ID="txtSupporterNames" runat="server" ClientIDMode="Static" CssClass="pull-left text-primary"></asp:Label>
                                 </div>
                             </div>
                             
                             <div class="col-md-12 form-group">
                                 <div class="col-md-6"><label class="control-label pull-left">Mobile:</label></div>
                                 <div class="col-md-6">
                                     <asp:Label ID="txtSupporterMobile" runat="server" ClientIDMode="Static" CssClass="pull-left text-primary"></asp:Label>
                                 </div>
                             </div>

                             <!-- Modal -->
                             <div id="patientBioModal" class="modal fade" role="dialog" data-parsley-validate="true" data-show-errors="true">
                                 <div class="modal-dialog">
                                     <!-- Modal content-->
                                     <div class="modal-content">
                                         <div class="modal-header bg-info">
                                             <!--<button type="button" class="close" data-dismiss="modal">&times;</button>-->
                                             <h4 class="modal-title">Change Bio</h4>

                                         </div>
                                         <div class="modal-body">
                                             <div class="row">
                                                 
                                                 <div class="col-md-12 form-group">
                                                     <div class="col-md-3"><label class="control-label pull-left">First Name:</label></div>
                                                     <div class="col-md-6">                     
                                                         <asp:TextBox ID="bioFirstName" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" placeholder="first name" data-parsley-required="true" type="text" data-parsley-length="[2,25]"></asp:TextBox>
                                                     </div>
                                                 </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     <div class="col-md-3"><label class="control-label pull-left">Middle Name:</label></div>
                                                     <div class="col-md-6">                     
                                                         <asp:TextBox ID="bioMiddleName" runat="server" CssClass="pull-left form-control" ClientIDMode="Static"></asp:TextBox>
                                                     </div>
                                                 </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     <div class="col-md-3"><label class="control-label pull-left">Last Name:</label></div>
                                                     <div class="col-md-6">                     
                                                         <asp:TextBox ID="bioLastName" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" placeholder="last name" data-parsley-required="true" type="text" data-parsley-length="[2,25]"></asp:TextBox>
                                                     </div>
                                                 </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     <div class="col-md-3"><label class="control-label pull-left">Patient Population:</label></div>
                                                     <div class="col-md-6">
                                                         <asp:DropDownList ID="bioPatientPopulation" runat="server" ClientIDMode="Static" CssClass="pull-left form-control" required="true" data-parsley-min="1"></asp:DropDownList>
                                                     </div>
                                                 </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     <div class="col-md-3"><label class="control-label pull-left">Select if Key.Pop:</label></div>
                                                     <div class="col-md-6">
                                                         <asp:DropDownList ID="bioPatientKeyPopulation" runat="server" ClientIDMode="Static" CssClass="pull-left form-control"></asp:DropDownList>
                                                     </div>
                                                 </div>

                                             </div>                                        
                                         </div>
                                         <div class="modal-footer">
                                             <div class="col-md-12 form-group">
                                                 
                                                <div class="col-md-6">
                                                    <button type="button" id="btnSaveBio" class="btn btn-default" OnClientClick="return false;">Save</button>
                                                </div>

                                                <div class="col-md-6">
                                                    <button type="button" id="btnCancelBio" class="btn btn-default" data-dismiss="modal">Close</button>
                                                </div>

                                            </div>

                                             

                                         </div>

                                     </div>

                                 </div>

                             </div>
                             
                             
                             

                             <!-- Modal -->
                             <div id="treatmentSupporterModal" class="modal fade" role="dialog" data-parsley-validate="true" data-show-errors="true">
                                 <div class="modal-dialog">
                                     <!-- Modal content-->
                                     <div class="modal-content">
                                         <div class="modal-header">
                                             <!--<button type="button" class="close" data-dismiss="modal">&times;</button>-->
                                             <h4 class="modal-title">Change Supporter</h4>

                                         </div>
                                         <div class="modal-body">
                                             <div class="row">
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                    <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">First Name:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="trtFirstName" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" placeholder="first name" data-parsley-required="true" type="text" data-parsley-length="[2,25]"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Gender:</label></div>
                                                         <div class="col-md-12">                                                           
                                                             <asp:DropDownList ID="trtGender" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" required="true" data-parsley-min="1"></asp:DropDownList>
                                                         </div>
                                                     </div>
                                                </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                    <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Middle Name:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="trtMiddleName" runat="server" CssClass="pull-left form-control" ClientIDMode="Static"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Mobile:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="trtMobile" runat="server" CssClass="pull-left form-control" placeholder="Mobile No..." ClientIDMode="Static" data-parsley-trigger="keyup" data-parsley-pattern-message="Please enter a valid Kenyan mobile phone number. Format ((+2547XXXXXXXX) or (07XXXXXXXX))" data-parsley-pattern="/(\+?254|0){1}[7]{1}([0-9]{1}[0-9]{1}|[9]{1}[0-2]{1})[0-9]{6}$/"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                    <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Last Name:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="trtLastName" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" placeholder="last name" data-parsley-required="true" type="text" data-parsley-length="[2,25]"></asp:TextBox>
                                                             <asp:DropDownList ID="Gender" runat="server" ClientIDMode="Static"></asp:DropDownList>
                                                         </div>
                                                     </div>
                                                     
                                                     
                                                </div>

                                             </div>
                                             
                                         </div>
                                         <div class="modal-footer">
                                             <button id="btnAddPatientTreatmentSupporter" type="button" class="btn btn-default" OnClientClick="return false;">Change Supporter</button>
                                             <button id="btnAddPatientTreatmentSupporterCancel" type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                                         </div>

                                     </div>

                                 </div>

                             </div>

                             <div class="col-md-6 form-group">
                                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#patientBioModal">Change Bio</button>
                             </div>

                             <div class="col-md-6 form-group">
                                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#treatmentSupporterModal">Change Supporter</button>
                             </div>

                         </div>
                         <div class="col-md-4 col-xs-4 col-sm-4">
                             <div class="col-md-12 label label-info"><label class="control-label"><strong class="text-primary"></strong><h6>Patient Location</h6></label></div>
                             <div class="col-md-12"><hr style="margin-top:1%"/></div>
                             
                             <div class="col-md-12 form-group">
                                 <div class="col-md-6"><label class="control-label pull-left">County:</label></div>
                                 <div class="col-md-6">
                                     <asp:Label ID="txtCounty" runat="server" ClientIDMode="Static" CssClass="pull-left text-primary"></asp:Label>
                                 </div>
                             </div>
                             
                             <!--<div class="col-md-12 form-group">
                                 <div class="col-md-2" style="padding: 0;"><label class="control-label pull-left">Ward:</label></div>
                                 <div class="col-md-10" style="padding: 0;">
                                     <asp:Label ID="txtWard" runat="server" ClientIDMode="Static" CssClass="pull-left text-primary"></asp:Label>
                                 </div>
                             </div>
                                       
                             <div class="col-md-12 form-group">
                                 <div class="col-md-3" style="padding: 0;"><label class="control-label pull-left">Village:</label></div>
                                 <div class="col-md-9" style="padding: 0;">
                                     <asp:Label ID="txtVillage" runat="server" ClientIDMode="Static" CssClass="pull-left text-primary"></asp:Label>
                                 </div>
                             <!--</div>-->

                             <div class="col-md-12 form-group">
                                 <div class="col-md-6"><label class="control-label pull-left">Nearest H/C:</label></div>
                                 <div class="col-md-6">
                                     <asp:Label ID="txtNearestHealthCentre" runat="server" ClientIDMode="Static" CssClass="pull-left text-primary"></asp:Label>
                                 </div>
                             </div>
                             
                             <!-- Modal -->
                             <div id="patientLocationModal" class="modal fade" role="dialog" data-parsley-validate="true" data-show-errors="true">
                                 <div class="modal-dialog">
                                     <!-- Modal content-->
                                     <div class="modal-content">
                                         <div class="modal-header">
                                             <!--<button type="button" class="close" data-dismiss="modal">&times;</button>-->
                                             <h4 class="modal-title">Change Location</h4>

                                         </div>
                                         <div class="modal-body">
                                             <div class="row">
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">County:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:DropDownList ID="smrCounty" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" required="true" data-parsley-min="1"></asp:DropDownList>

                                                         </div>
                                                     </div>
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Sub-Location:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="smrSubLocation" runat="server" CssClass="pull-left form-control" ClientIDMode="Static"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                    
                                                </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                    <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Sub-County:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:DropDownList ID="smrSubCounty" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" required="true" data-parsley-min="1"></asp:DropDownList>

                                                         </div>
                                                     </div>
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Village:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="smrVillage" runat="server" CssClass="pull-left form-control" ClientIDMode="Static"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                    <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Ward:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:DropDownList ID="smrWard" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" required="true" data-parsley-min="1"></asp:DropDownList>

                                                         </div>
                                                     </div>
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Landmark:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="smrLandmark" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" placeholder="landmark" data-parsley-required="true" type="text"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                    <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Location:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="smrLocation" runat="server" CssClass="pull-left form-control" ClientIDMode="Static"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Nearest Health Center:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="smrNearestHealthCenter" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" placeholder="nearest health center" data-parsley-required="true" type="text"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                </div>

                                             </div>
                                             
                                         </div>
                                         <div class="modal-footer">
                                             <button id="btnAddLocation" type="button" class="btn btn-default" OnClientClick="return false;">Change Location</button>
                                             <button id="btnAddLocationCancel" type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                                         </div>

                                     </div>

                                 </div>

                             </div>
                             
                             <div class="col-md-12 form-group">
                                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#patientLocationModal">Change Location</button>
                             </div>

                         </div>
                         <div class="col-md-4 col-xs-4 col-sm-4">
                             <div class="col-md-12 label label-info"><label class="control-label"><strong class="text-primary"></strong><h6>Patient Contact</h6></label></div>
                             <div class="col-md-12"><hr style="margin-top:1%"/></div>
                             
                             <div class="col-md-12 form-group">
                                 <div class="col-md-6"><label class="control-label pull-left">Postal Adress:</label></div>
                                 <div class="col-md-6">
                                     <asp:Label ID="txtPostalAddress" runat="server" ClientIDMode="Static" CssClass="pull-left text-primary"></asp:Label>
                                 </div>
                             </div>
                             
                             
                             <div class="col-md-12 form-group">
                                 <div class="col-md-6"><label class="control-label pull-left">Mobile:</label></div>
                                 <div class="col-md-6">
                                     <asp:Label ID="txtMobile" runat="server" ClientIDMode="Static" CssClass="pull-left text-primary"></asp:Label>
                                 </div>
                             </div>
                             
                            <!-- Modal -->
                             <div id="patientContactModal" class="modal fade" role="dialog" data-parsley-validate="true" data-show-errors="true">
                                 <div class="modal-dialog">
                                     <!-- Modal content-->
                                     <div class="modal-content">
                                         <div class="modal-header">
                                             <!--<button type="button" class="close" data-dismiss="modal">&times;</button>-->
                                             <h4 class="modal-title">Change Contacts</h4>

                                         </div>
                                         <div class="modal-body">
                                             <div class="row">
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                    <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Postal Address:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="patPostalAddress" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" placeholder="postal address" data-parsley-length="[8,100]"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Mobile:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="patMobile" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" placeholder="Mobile No..." data-parsley-trigger="keyup" data-parsley-pattern-message="Please enter a valid Kenyan mobile phone number. Format ((+2547XXXXXXXX) or (07XXXXXXXX))" data-parsley-pattern="/(\+?254|0){1}[7]{1}([0-9]{1}[0-9]{1}|[9]{1}[0-2]{1})[0-9]{6}$/" data-parsley-notequalto="#patAlternativeMobile"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                </div>
                                                 
                                                 <div class="col-md-12 form-group">
                                                     
                                                    <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Email Address:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="patEmailAddress" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" data-parsley-type="email"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                     
                                                     <div class="col-md-6">
                                                         <div class="col-md-12"><label class="control-label pull-left">Alternative Mobile:</label></div>
                                                         <div class="col-md-12">
                                                             <asp:TextBox ID="patAlternativeMobile" runat="server" CssClass="pull-left form-control" ClientIDMode="Static" data-parsley-trigger="keyup" placeholder="alternative mobile no..." data-parsley-pattern-message="Please enter a valid Kenyan mobile phone number. Format ((+2547XXXXXXXX) or (07XXXXXXXX))" data-parsley-pattern="/(\+?254|0){1}[7]{1}([0-9]{1}[0-9]{1}|[9]{1}[0-2]{1})[0-9]{6}$/" data-parsley-notequalto="#patMobile"></asp:TextBox>

                                                         </div>
                                                     </div>
                                                </div>

                                             </div>
                                             
                                         </div>
                                         <div class="modal-footer">
                                             <button id="btnEditPatientContacts" type="button" class="btn btn-default" OnClientClick="return false;">Change Contacts</button>
                                             <button id="btnEditPatientContactsCancel" type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                                         </div>

                                     </div>

                                 </div>

                             </div>
                             
                             <div class="col-md-12 form-group">
                                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#patientContactModal">Change Contacts</button>
                             </div>
                         </div>
                         

                     </div>
                     <div class="col-md-12 col-xs-12">
                         <div class="col-md-4 col-xs-4 col-sm-4">                       
                             <div class="col-md-6 form-group">
                                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#patientSummaryModal">Patient Summary</button>
                             </div>
                         </div>
                         
                         <!-- Modal -->
                        <div id="patientSummaryModal" class="modal fade" role="dialog" data-parsley-validate="true" data-show-errors="true">
                            <div class="modal-dialog" style="width: 90%">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header bg-info">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Patient Summary</h4>

                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <h2 class="text-muted text-Warning pull-left"> Bio </h2>
                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <label class="control-label text-primary pull-left text-muted">Profile</label>
                                                </div>
                                                
                                            </div>
                                            
                                            <div class="col-md-12">
                                                
                                                <div class="col-md-2">
                                                    CCC No
                                                </div>

                                                

                                                <div class="col-md-2">
                                                    FirstName
                                                </div>

                                                

                                                <div class="col-md-2">
                                                    Middle Name 
                                                </div>

                                                
                                                
                                                <div class="col-md-2">
                                                    Last Name 
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    Sex
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    Date Of Birth
                                                </div>

                                                

                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblCCC" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblFirstNameP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblMiddleNameP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblLastNameP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblSexP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblDobP" runat="server"></asp:Label>
                                                </div>

                                            </div>
                                            
                                            
                                            
                                            <div class="col-md-12" id="isChild">
                                                
                                                <div class="col-md-2">
                                                    Parent/Guardian
                                                </div>

                                                <div class="col-md-2">
                                                    Orphan?
                                                </div>

                                                <div class="col-md-2">
                                                    In school?
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-12" id="isChildP">
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblParent_GuardianP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblOrphanP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblInSchoolP" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            
                                            <div>
                                                &nbsp;
                                            </div>
                                            
                                            <div class="col-md-12" id="isAdult">
                                                
                                                <div class="col-md-2">
                                                    ID Number
                                                </div>

                                                <div class="col-md-2">
                                                    Marital Status
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    Pop. Type
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    Key Pop. Type
                                                </div>

                                            </div>
                                            
                                            <div class="col-md-12" id="isAdultP">
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblIdNumber" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblMaritalStatus" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblPopulationTypeA" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblKeyPopType" runat="server"></asp:Label>
                                                </div>

                                            </div>
                                            
                                            <div>
                                                &nbsp;
                                            </div>

                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <label class="control-label text-primary pull-left text-muted">Entry Point & Transfer Status</label>
                                                </div>
                                                
                                            </div>
                                            
                                            <div class="col-md-12">
                                                
                                                <div class="col-md-2">
                                                    Entry Point
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblEntryPointP" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            
                                            <div>
                                                &nbsp;
                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <label class="control-label text-primary pull-left text-muted">Diagnosis & ARV history</label>
                                                </div>
                                                
                                            </div>
                                            
                                            <div class="col-md-12">
                                                
                                                <div class="col-md-2">
                                                    Date of HIV diagnosis
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    Date of enrollment
                                                </div>
                                                

                                                <div class="col-md-2">
                                                    WHO stage at enrollment
                                                </div>

                                                <div class="col-md-2">
                                                    Date of ART initiation
                                                </div>
                                                
                                                
                                                <div class="col-md-2">
                                                    History of ART use
                                                </div>


                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblDateOfHivDiagnosisA" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblEnrollmentDateP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblWHOStageAtEnrollment"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblDateOfARTInitiation"></asp:Label>
                                                </div>
                                            </div>
                                            
                                            <div>
                                                &nbsp;
                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <label class="control-label text-primary pull-left text-muted">Baseline assessment & Treatment Initiation</label>
                                                </div>
                                                
                                            </div>
                                            
                                            <div class="col-md-12">
                                                
                                                <div class="col-md-2">
                                                    HBV infected
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    TB Infected
                                                </div>
                                                

                                                <div class="col-md-2">
                                                    WHO stage
                                                </div>

                                                <div class="col-md-2">
                                                    Pregnant?
                                                </div>
                                                
                                                
                                                <div class="col-md-2">
                                                    Breastfeeding?
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    CD4 Count
                                                </div>


                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblHIVInfected" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label ID="lblTBInfected" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblWHOStageNow"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblPregnant"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblBreastFeeding"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" ID="lblCD4Count"></asp:Label>
                                                </div>

                                            </div>

                                            <div class="col-md-12">
                                                <h2 class="text-muted text-Warning pull-left"> Triage </h2>
                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <label class="control-label text-primary pull-left text-muted">Anthropometric Measurement</label>
                                                </div>
                                                
                                            </div>
                                            
                                            <div class="col-md-12">
                                                
                                                <div class="col-md-1">
                                                    Weight
                                                </div>

                                                

                                                <div class="col-md-1">
                                                    Height
                                                </div>
                                                

                                                <div class="col-md-1">
                                                    MUAC
                                                </div>

                                                <div class="col-md-1">
                                                    Head Circumference
                                                </div>
                                                
                                                <div class="col-md-1">
                                                    Temperature (°C)
                                                </div>

                                            </div>
                                                
                                            <div class="col-md-12">
                                                
                                                <div class="col-md-1">
                                                    <asp:Label ID="lblWeightP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-1">
                                                    <asp:Label ID="lblHeightP" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-1">
                                                    <asp:Label ID="Label3" runat="server"></asp:Label>
                                                </div>

                                                

                                                <div class="col-md-1">
                                                    <asp:Label ID="lblHeadCircumference" runat="server"></asp:Label>
                                                </div>

                                                
                                                <div class="col-md-1">
                                                    <asp:Label ID="lblTemperature" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            
                                            <div>
                                                &nbsp;
                                            </div>
 
                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <label class="control-label text-primary pull-left text-muted">Blood Pressure</label>
                                                </div>
                                                
                                            </div>
                                            
                                            <div class="col-md-12">
                                                
                                                <div class="col-md-1">
                                                    Systolic
                                                </div>

                                                

                                                <div class="col-md-1">
                                                    Diastolic
                                                </div>

                                                

                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-1">
                                                    <asp:Label ID="lblSystolic" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-1">
                                                    <asp:Label ID="lblDiastolic" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-12">
                                                &nbsp;
                                            </div>
 
                                            <div class="col-md-12">
                                                <div class="col-md-12">
                                                    <label class="control-label text-primary pull-left text-muted">Pulse Rate/Respiratory/Oxygen Saturation</label>
                                                </div>
                                                
                                            </div>
                                            
                                            <div class="col-md-12">
                                                
                                                <div class="col-md-1">
                                                    Pulse Rate
                                                </div>

                                                

                                                <div class="col-md-1">
                                                    Respiration
                                                </div>

                                               
                                                
                                                <div class="col-md-3">
                                                    Blood Oxygen Saturation
                                                </div>

                                                

                                            </div>
                                            
                                            <div class="col-md-12">
                                                <div class="col-md-1">
                                                    <asp:Label ID="lblPulseRate" runat="server"></asp:Label>
                                                </div>
                                                
                                                 <div class="col-md-1">
                                                    <asp:Label ID="lblRespiration" runat="server"></asp:Label>
                                                </div>
                                                
                                                <div class="col-md-3">
                                                    <asp:Label ID="lblOxygenSat" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            
                                        </div>                                        
                                    </div>

                                </div>

                            </div>

                        </div>
                     </div>
                 </div> 
                 <div id="EntryPoint" class="tab-pane fade">
                     <div class="col-md-12 col-xs-12">
                         
                          <div class="col-md-4 col-xs-4 col-sm-4">
                               <div class="col-md-12 label label-info"><label class="control-label"><h6>TransferIn Status</h6></label></div>
                              <div class="col-md-12"><hr style="margin-top:1%"/></div>
                             
                              <div class="col-md-12 form-group">
                                   <div class="col-md-6"><label class="control-lable pull-left">Entry Point :</label></div>
                                  <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblEntryPoint" ClientIDMode="Static"></asp:Label></div>
                              </div>
                                 
                               <div class="col-md-12">
                                   <div class="col-md-6"><label class="control-lable pull-left">TransferIn Date :</label></div>
                                  <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblTransferinDate" ClientIDMode="Static"></asp:Label></div>
                              </div>
                              
                             <div class="col-md-12">
                                   <div class="col-md-6"><label class="control-lable pull-left">Treatment Start:</label></div>
                                  <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary" ID="lblTreatmentStartDate" ClientIDMode="Static"></asp:Label></div>
                              </div>
                              
                              <div class="col-md-12">
                                   <div class="col-md-4"><label class="control-lable pull-left">Regimen : </label></div>
                                  <div class="col-md-8"><asp:Label runat="server" CssClass=" pull-right text-primary"  ID="lblTIRegimen" ClientIDMode="Static"></asp:Label></div>
                              </div>
                            
                              <div class="col-md-12">
                                   <div class="col-md-5"><label class="control-lable pull-left">Facility From :</label></div>
                                  <div class="col-md-7"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblFacilityFrom" ClientIDMode="Static"></asp:Label></div>
                              </div>

                              

                          </div><!-- .col-md-4 -->

                          <div class="col-md-4 col-xs-12 col-sm-12">
                              <div class="col-md-12 label label-info"><label class="control-label"> <h6>Patient Diagnosis Status</h6></label></div>
                               <div class="col-md-12"><hr style="margin-top:1%"/></div>
                              
                               <div class="col-md-12 form-group">
                                    <div class="col-md-6"><label class="control-label pull-left">HIV Diagnosis Date :</label></div>
                                    <div class="col-md-6"><asp:Label runat="server" ID="lblDateOfHivDiagnosis" CssClass="text-info pull-right" ClientIDMode="Static"></asp:Label></div>
                               </div>
                              
                              <div class="col-md-12 form-group">
                                    <div class="col-md-6"><label class="control-label pull-left">Date of Enrollmet  :</label></div>
                                    <div class="col-md-6"><asp:Label runat="server" ID="lblDateOfEnrollment" CssClass="text-info pull-right" ClientIDMode="Static"></asp:Label></div>
                               </div>
                              
                               <div class="col-md-12 form-group">
                                    <div class="col-md-6"><label class="control-label pull-left">WHO at Enrollmet  :</label></div>
                                    <div class="col-md-6"><asp:Label runat="server" ID="lblWhoStage" CssClass="text-info pull-right" ClientIDMode="Static"></asp:Label></div>
                               </div>
                              
                              
                              <div class="col-md-12 form-group">
                                    <div class="col-md-6"><label class="control-label pull-left">ART Initiation Date :</label></div>
                                    <div class="col-md-6"><asp:Label runat="server" ID="lblARTInitiationDate" CssClass="text-info pull-right" ClientIDMode="Static"></asp:Label></div>
                               </div>


                          </div><!-- .col-md-4 -->

                          <div class="col-md-4 col-xs-4 col-sm-4">
                              <div class="col-md-12 label label-info"><label class="control-label"> <h6>ARV History Status</h6> </label></div>
                              <div class="col-md-12"><hr style="margin-top:1%" class="bg-info"/></div>
                              <div class="col-md-12">
                                  <table class="table table-condensed" width="100%">
                                      <tr>
                                          <th align="left">Purpose</th>
                                          <th align="left">Regimen</th>
                                           <th right="left">Date Last Used</th>
                                      </tr>
                                      <tbody id="tbdArvHistory" clientidmode="Static"></tbody>
                                      <tfoot class="bg-info">
                                          <tr>
                                               <th align="left">Purpose</th>
                                          <th align="left">Regimen</th>
                                           <th right="left">Date Last Used</th>
                                          </tr>
                                      </tfoot>
                                  </table>
                              </div>
                          </div><!-- .col-md-4 -->

                     </div>
                 </div>
                 <div id="Baseline" class="tab-pane fade">
                     <div class="col-md-4 col-xs-4 col-sm-4">
                         <div class="col-md-12 label label-info"><label class="control-label"><strong class="text-primary"></strong> <h6>Baseline Assessment Summary</h6></label></div>
                              <div class="col-md-12"><hr style="margin-top:1%"/></div>
                             
                              <div class="col-md-12 form-group">
                                   
                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">HBV Infected</label></div>
                                       <div class="col-md-3">
                                            <label class="checkbox-custom checkbox-inline" data-initialize="checkbox"  id="lblHbvInfectedYes">
                                                  <input class="sr-only" type="checkbox" value="option1"> <span class="checkbox-label pull-left"> Yes </span>
                                            </label>
                                       </div>
                                      <div class="col-md-3">
                                           <label class="checkbox-custom checkbox-inline" data-initialize="checkbox"  id="lblHbvInfectedNo">
                                                  <input class="sr-only" type="checkbox" value="option1"> <span class="checkbox-label pull-left"> NO </span>
                                            </label>
                                      </div>
                                  </div>
                                                               
                                  <div class="col-md-12 form-group">
                                      <div class="col-md-6"><label class="control-lable pull-left">Pregnant </label></div>
                                       <div class="col-md-3">
                                            <label class="checkbox-custom checkbox-inline" data-initialize="checkbox"  id="lblPregnantYes">
                                                  <input class="sr-only" type="checkbox" value="option1"> <span class="checkbox-label pull-left"> Yes </span>
                                            </label>
                                       </div>
                                      <div class="col-md-3">
                                           <label class="checkbox-custom checkbox-inline" data-initialize="checkbox"  id="lblPregnantNo">
                                                  <input class="sr-only" type="checkbox" value="option1"> <span class="checkbox-label pull-left"> NO </span>
                                            </label>
                                      </div>
                                  </div>
                                  
                                  <div class="col-md-12 form-group">
                                      <div class="col-md-6"><label class="control-lable pull-left">TB Infected</label></div> 
                                      <div class="col-md-3">
                                            <label class="checkbox-custom checkbox-inline" data-initialize="checkbox"  id="lblTBInfectedYes">
                                                  <input class="sr-only" type="checkbox" value="option1"> <span class="checkbox-label pull-left"> Yes </span>
                                            </label>
                                       </div>
                                      <div class="col-md-3">
                                           <label class="checkbox-custom checkbox-inline" data-initialize="checkbox"  id="lblTBInfectedNo">
                                                  <input class="sr-only" type="checkbox" value="option1"> <span class="checkbox-label pull-left"> NO </span>
                                            </label>
                                      </div>
                                  </div>
                                  
                                  <div class="col-md-12 form-group">
                                      <div class="col-md-6"><label class="control-lable pull-left">BreastFeeding</label></div> 
                                      <div class="col-md-3">
                                            <label class="checkbox-custom checkbox-inline" data-initialize="checkbox"  id="lblBreastfeedingYes">
                                                  <input class="sr-only" type="checkbox" value="option1"> <span class="checkbox-label pull-left"> Yes </span>
                                            </label>
                                       </div>
                                      <div class="col-md-3">
                                           <label class="checkbox-custom checkbox-inline" data-initialize="checkbox"  id="lblBreastfeedingNo">
                                                  <input class="sr-only" type="checkbox" value="option1"> <span class="checkbox-label pull-left"> NO </span>
                                            </label>
                                      </div>
                                  </div>

                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">Who Stage</label></div>
                                     <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblwhostage2" ClientIDMode="Static"></asp:Label></div>
                                  </div>
                              
                                  <div class="col-md-12 form-group">
                                   <div class="col-md-6"><label class="control-lable pull-left">CD4 Count</label></div>
                                  <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary" ID="lblcd4" ClientIDMode="Static"></asp:Label></div>
                              </div>
                              

                            </div>                      

                          </div>
                    
                     <div class="col-md-4 col-xs-4 col-sm-4">
                              <div class="col-md-12 label label-info"><label class="control-label"> <h6><strong>Patient Baseline Vitals</strong></h6> </label></div>
                              <div class="col-md-12"><hr style="margin-top:1%" class="bg-info"/></div>
                              <div class="col-md-12">
                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">MUAC</label></div>
                                     <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblmuac" ClientIDMode="Static"></asp:Label></div>
                                  </div>

                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">Weight</label></div>
                                     <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblweight" ClientIDMode="Static"></asp:Label></div>
                                  </div>
                                  
                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">Height</label></div>
                                     <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblheight" ClientIDMode="Static"></asp:Label></div>
                                  </div>
                                  
                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">BMI</label></div>
                                     <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblbmi" ClientIDMode="Static"></asp:Label></div>
                                  </div>

                              </div>
                          </div>

                      <div class="col-md-4 col-xs-4 col-sm-4">
                              <div class="col-md-12 label label-info"><label class="control-label"> <h6><strong>Treatment Initiation </strong></h6> </label></div>
                              <div class="col-md-12"><hr style="margin-top:1%" class="bg-info"/></div>
                              <div class="col-md-12">
                                  <div class="col-md-12 form-group">
                                       <div class="col-md-7"><label class="control-lable pull-left">Date Started Firstline:</label></div>
                                     <div class="col-md-5"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblFirstline" ClientIDMode="Static"></asp:Label></div>
                                  </div>

                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">ART Cohort: </label></div>
                                     <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblcohort" ClientIDMode="Static"></asp:Label></div>
                                  </div>
                                  
                                    <div class="col-md-12 form-group">
                                       <div class="col-md-5"><label class="control-lable pull-left">Regimen: </label></div>
                                     <div class="col-md-7"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblRegimenName" ClientIDMode="Static"></asp:Label></div>
                                  </div>
                                  
                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">Baseline ViralLoad :</label></div>
                                     <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblbaselineVL" ClientIDMode="Static"></asp:Label></div>
                                  </div>
                                  
                                  <div class="col-md-12 form-group">
                                       <div class="col-md-6"><label class="control-lable pull-left">ViralLoad Date :</label></div>
                                     <div class="col-md-6"><asp:Label runat="server" CssClass="pull-right text-primary"  ID="lblBlDate" ClientIDMode="Static"></asp:Label></div>
                                  </div>

                              </div>
                          </div>
                 </div> <!-- diagnosis -->  
                 <div id="Trending" class="tab-pane  fade in active">
                    
                      <div class="col-md-6 col-xs-12 col-sm-12">
                          <div id="vl_container" style="min-width: 450px; height: 300px; margin: 0"></div> 
                           <%-- <div id="container" style="min-width: 450px; height: 300px; margin: 0 auto"></div>  --%>
                     </div>  <!-- .bs-component-->
                     
                     <div class="col-md-6 col-xs-12 col-sm-12">
                          <div id="vitals_container" margin: 0 auto"></div>     
                     </div><!-- .bs-component-->
                        
                </div><!-- .trending-->
   
             </div><!-- .tab-content -->
        </div> <!-- col-md-12 -->

    </div> <!-- .col-md-12 col-xs-12 col-sm-12 -->

    <IQ:ucExtruder runat="server" ID="ucExtruder" />
     <!-- ajax begin -->
    <script type="text/javascript">

        $(document).ready(function() {

            var patientId = "<%=PatientId%>";
            $("#<%=Gender.ClientID%>").hide();
            
            /* populate patient baseline information */
            $.ajax({
                type: "POST",
                url: "../WebService/PatientBaselineService.asmx/GetPatientBaselineInfo",
                data: "{'patientId':'" + patientId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var itemList = JSON.parse(response.d);
                    $.each(itemList,
                        function(index, itemList) {
                            if (itemList.patientId > 0) {
                                
                                console.log(itemList);
                                /* transferin status */
                                $("#<%=lblTransferinDate.ClientID%>").text(moment(itemList.TransferInDate).format("DD-MMM-YYYY"));
                                $("#<%= lblTreatmentStartDate.ClientID%>").text(moment(itemList.TreatmentStartDate).format("DD-MMM-YYYY"));
                                $("#<%=lblTIRegimen.ClientID%>").text(itemList.CurrentTreatmentName);
                                $("#<%=lblFacilityFrom.ClientID%>").text(itemList.FacilityFrom);

                                /*patient Diagnosis */
                                $("#<%=lblDateOfHivDiagnosis.ClientID%>").text(moment(itemList.HivDiagnosisDate).format("DD-MMM-YYYY"));
                                $("#<%=lblDateOfHivDiagnosisA.ClientID%>").text(moment(itemList.HivDiagnosisDate).format("DD-MMM-YYYY"));
                                $("#<%=lblDateOfEnrollment.ClientID%>").text(moment(itemList.EnrollmentDate).format("DD-MMM-YYYY"));
                                $("#<%=lblWhoStage.ClientID%>").text(itemList.EnrollmentWHOStageName);
                                $("#<%=lblWHOStageAtEnrollment.ClientID%>").text(itemList.EnrollmentWHOStageName);
                                $("#<%=lblARTInitiationDate.ClientID%>").text(moment(itemList.ARTInitiationDate).format("DD-MMM-YYYY"));
                                $("#<%=lblDateOfARTInitiation.ClientID%>").text(moment(itemList.ARTInitiationDate).format("DD-MMM-YYYY"));
                                $("#<%=lblwhostage2.ClientID%>").text(itemList.WHOStageName);
                                $("#<%=lblcd4.ClientID%>").text(itemList.CD4Count);
                                $("#<%=lblmuac.ClientID%>").text(itemList.MUAC);
                                $("#<%=lblweight.ClientID%>").text(itemList.Weight);
                                $("#<%=lblheight.ClientID%>").text(itemList.Height);
                                $("#<%=lblHIVInfected.ClientID%>").text(itemList.HBVInfected);
                                $("#<%=lblTBInfected.ClientID%>").text(itemList.TBinfected);
                                $("#<%=lblWHOStageNow.ClientID%>").text(itemList.WhoStageName);
                                $("#<%=lblPregnant.ClientID%>").text(itemList.Pregnant);
                                $("#<%=lblBreastFeeding.ClientID%>").text(itemList.BreastFeeding);
                                $("#<%=lblCD4Count.ClientID%>").text(itemList.CD4Count);

                                $("#<%=lblbmi.ClientID%>").text(itemList.BMI.toFixed(2));

                                $("#<%=lblFirstline.ClientID%>").text(moment(itemList.DateStartedOnFirstline).format("DD-MMM-YYYY"));
                                $("#<%=lblcohort.ClientID%>").text(itemList.Cohort);
                                $("#<%=lblRegimenName.ClientID%>").text(itemList.RegimenName);
                                $("#<%=lblbaselineVL.ClientID%>").text(itemList.BaselineViralLoad + ' copies/ml');
                                $("#<%=lblBlDate.ClientID%>").text(moment(itemList.BaselineViralLoadDate).format("DD-MMM-YYYY"));
                                
                                /* patient baseline */
                                if (!itemList.HBVInfected) {
                                    $("#lblHbvInfectedNo").checkbox('check');
                                    $("#lblHbvInfectedYes").checkbox('uncheck');
                                } else {
                                    $("#lblHbvInfectedNo").checkbox('uncheck');
                                    $("#lblHbvInfectedYes").checkbox('check');
                                }

                                if (!itemList.Pregnant) {
                                    $("#lblPregnantNo").checkbox('check');
                                    $("#lblPregnantYes").checkbox('uncheck');
                                } else {
                                    $("#lblPregnantNo").checkbox('uncheck');
                                    $("#lblPregnantYes").checkbox('check');
                                }

                                if (!itemList.TBinfected) {
                                    $("#lblTBInfectedNo").checkbox('check');
                                    $("#lblTBInfectedYes").checkbox('uncheck');
                                } else {
                                    $("#lblTBInfectedNo").checkbox('uncheck');
                                    $("#lblTBInfectedYes").checkbox('check');
                                }

                                if (!itemList.BreastFeeding) {
                                    $("#lblBreastfeedingNo").checkbox('check');
                                    $("#lblBreastfeedingYes").checkbox('uncheck');
                                } else {
                                    $("#lblBreastfeedingNo").checkbox('uncheck');
                                    $("#lblBreastfeedingYes").checkbox('check');
                                }




                            }
                        });
                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message);
                }
            });

            $.ajax({
                type: "POST",
                url: "../WebService/PatientBaselineService.asmx/GetPatientPriorArvHistory",
                data: "{'patientId':'" + patientId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#tbdArvHistory").append(response.d);
                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message);
                }
            });


            var jan_height = "";
            var march_height = "";
            var jan_weight = "";
            var march_weight = "";
            var jan_BMI = "";
            var march_BMI = "";
            var jan_vl = "";
            var march_vl = "";

            window.onload = function() {

              $.when(getVitals()).then(function() {
                    setTimeout(function() {
                            vitals();
                        },
                        2000);
                });
              $.when(getViralLoad()).then(function () {
                    setTimeout(function () {
                        viralLoadGraph();
                    },
                        2000);
              });
            };

          function getViralLoad() {
                    console.log("get viral load  called");
                    $.ajax({
                        url: '../WebService/LabService.asmx/GetViralLoad',
                        type: 'POST',
                        dataType: 'json',
                        contentType: "application/json; charset=utf-8",
                        cache: false,
                        success: function (response) {
                            console.log(response.d);
                            var items = response.d;
                            items.forEach(function (item, i) {

                                if (item.Month == 1) {

                                    jan_vl = item.ResultValue;
                                   
                                } else if (item.Month == 3) {

                                    march_vl = item.ResultValue;                                   
                                   
                                }

                            });

                        }

                    });
                }
          function viralLoadGraph() {
            // $(function() {
                    $('#vl_container').highcharts({
                        title: {
                            text: 'Viral Load Trend',
                            x: -20 //center
                        },
                        subtitle: {
                            text: 'VL cp/ml',
                            x: -20
                        },
                        xAxis: {
                            categories: ['Jan', 'Mar', 'May', 'Jul', 'Sep', 'Nov', 'Dec']
                        },
                        yAxis: {
                            title: {
                                text: 'Viral Load cp/ml'
                            },
                            plotLines: [
                                {
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }
                            ]
                        },
                        tooltip: {
                            valueSuffix: 'cp/ml'
                        },
                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            borderWidth: 0
                        },
                        series: [
                            {
                                name: 'VL',
                                data: [jan_vl, march_vl, "", "", "", "", ""]
                            }, {
                                name: 'Threshold',
                                data: [1000, 1000, 1000, 1000, 1000, 1000, 1000]
                            }
                        ]
                    });
                };

            function getVitals() {
                console.log("get vitals called");
                $.ajax({
                    url: '../WebService/PatientVitals.asmx/GetVitals',
                    type: 'POST',
                    dataType: 'json',
                    contentType: "application/json; charset=utf-8",
                    cache: false,
                    success: function(response) {
                        console.log(response.d);
                        var items = response.d;
                        items.forEach(function(item, i) {

                            if (item.Month == 1) {

                                jan_height = item.Height;
                                jan_weight = item.Weight;
                                jan_BMI = item.BMI;                               

                            } else if (item.Month == 3) {

                                march_height = item.Height;
                                march_weight = item.Weight;
                                march_BMI = item.BMI;
                              
                            }

                        });

                    }

                });
            }

            function vitals() {
                //var jan_height = $(".march_height").val();
                //var march_height = $(".march_height").val();
                console.log("vitals graph function called");

                $('#vitals_container').highcharts({
                    title: {
                        text: 'Vitals',
                        x: -20 //center
                    },
                    subtitle: {
                        text: '',
                        x: -20
                    },
                    xAxis: {
                        categories: ['Jan', 'Mar', 'May', 'Jul', 'Sep', 'Nov', 'Dec']
                    },
                    yAxis: {
                        title: {
                            text: ''
                        },
                        plotLines: [
                            {
                                value: 0,
                                width: 1,
                                color: '#808080'
                            }
                        ]
                    },
                    tooltip: {
                        valueSuffix: ''
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle',
                        borderWidth: 0
                    },
                    series: [
                        {
                            name: 'Height',
                            data: [jan_height, march_height, "", "", "", "", ""]
                        },
                        {
                            name: 'Weight',
                            data: [jan_weight, march_weight, "", "", "", "", ""]
                        },
                        {
                            name: 'BMI',
                            data: [jan_BMI, march_BMI, "", "", "", "", "", ""]
                        }
                    ]
                });
            }

            if (patientId > 0) {
                $.ajax({
                    type: "POST",
                    url: "../WebService/PersonService.asmx/GetPersonDetails",
                    data: "{'PatientId':'" + patientId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var patientDetails = JSON.parse(response.d);
                        console.log(patientDetails);

                        
                        $("#<%=bioFirstName.ClientID%>").val(patientDetails.FirstName);
                        $("#<%=lblFirstNameP.ClientID%>").text(patientDetails.FirstName);
                        
                        $("#<%=bioMiddleName.ClientID%>").val(patientDetails.MiddleName);
                        $("#<%=lblMiddleNameP.ClientID%>").text(patientDetails.MiddleName);

                        $("#<%=bioLastName.ClientID%>").val(patientDetails.LastName);
                        $("#<%=lblLastNameP.ClientID%>").text(patientDetails.LastName);

                        $("#<%=lblCCC.ClientID%>").text(patientDetails.EnrollmentNumber);
                        
                        var populationType = 0;
                        if (patientDetails.population == "General Population") {
                            populationType = 74;
                        }
                        else if (patientDetails.population == "Key Population") {
                            populationType = 75;
                        }
                        console.log(populationType);
                        $("#<%=bioPatientPopulation.ClientID%>").val(populationType);

                        var names = null;
                        names = patientDetails.tsFname +
                            " " +
                            patientDetails.tsMiddleName +
                            " " +
                            patientDetails.tsLastName;

                        var ISContacts = "";
                        if (patientDetails.ISContacts != null && patientDetails.ISContacts != "") {
                            ISContacts = patientDetails.ISContacts;
                        }

                        $("#<%=txtSupporterNames.ClientID%>").text(names);
                        $("#<%=txtSupporterMobile.ClientID%>").text(ISContacts);

                        var village = "";
                        var nearestHealthCentre = "";

                        if(patientDetails.CountyId > 0)
                            $.when(GetLookupNameById(patientDetails.CountyId)).then();
                        if(patientDetails.Ward>0)
                            $.when(GetWardNameByWardId(patientDetails.Ward)).then();


                        if (patientDetails.Village != "" && patientDetails.Village != null) {
                            village = patientDetails.Village;
                        }

                        $("#<%=txtVillage.ClientID%>").text(village);

                        if (patientDetails.NearestHealthCentre != "" && patientDetails.NearestHealthCentre != null) {
                            nearestHealthCentre = patientDetails.NearestHealthCentre;
                        }
                        $("#<%=txtNearestHealthCentre.ClientID%>").text(nearestHealthCentre);

                        var PatientPostalAddress = "";
                        if (patientDetails.PatientPostalAddress != "" &&
                            patientDetails.PatientPostalAddress != null) {
                            PatientPostalAddress = patientDetails.PatientPostalAddress;
                        }
                        $("#<%=txtPostalAddress.ClientID%>").text(PatientPostalAddress);
                        var MobileNumber = "";
                        if (patientDetails.MobileNumber != "" && patientDetails.MobileNumber != null) {
                            MobileNumber = patientDetails.MobileNumber;
                        }
                        $("#<%=txtMobile.ClientID%>").text(MobileNumber);

                        $("#<%=patPostalAddress.ClientID%>").val(PatientPostalAddress);
                        $("#<%=patMobile.ClientID%>").val(MobileNumber);
                        $("#<%=patEmailAddress.ClientID%>").val(patientDetails.EmailAddress);
                        $("#<%=patAlternativeMobile.ClientID%>").val(patientDetails.AlternativeNumber);
                        $("#<%=bioPatientKeyPopulation.ClientID%>").val(patientDetails.PopulationCategoryId);
                        $("#<%=Gender.ClientID%>").val(patientDetails.Gender);
                        $("#<%=lblSexP.ClientID%>").text(patientDetails.GenderString);
                        $("#<%=lblDobP.ClientID%>").text(patientDetails.PersonDoB);


                        $("#<%=lblParent_GuardianP.ClientID%>").text(patientDetails.GurdianFNames + " " + patientDetails.GurdianMName + " " + patientDetails.GurdianLName);
                        $("#<%=lblInSchoolP.ClientID%>").text(patientDetails.InschoolString);
                        $("#<%=lblOrphanP.ClientID%>").text(patientDetails.ChildOrphanString);

                        $("#<%=lblIdNumber.ClientID%>").text(patientDetails.NationalId);

                        $("#<%=lblMaritalStatus.ClientID%>").text(patientDetails.MaritalStatusString);
                        $("#<%=lblPopulationTypeA.ClientID%>").text(patientDetails.population);
                        $("#<%=lblKeyPopType.ClientID%>").text(patientDetails.PopulationCategoryString);
                        

                        $("#<%=lblEntryPointP.ClientID%>").text(patientDetails.EntryPoint);

                        $("#<%=lblEnrollmentDateP.ClientID%>").text(patientDetails.EnrollmentDate);



                        $("#isChild").hide();
                        $("#isChildP").hide();
                        $("#isAdultP").hide();
                        $("#isAdult").hide();


                        if (patientDetails.Age <= 18) {
                            $("#isChild").show();
                            $("#isChildP").show();
                        } else {
                            $("#isAdultP").show();
                            $("#isAdult").show()
                        }

                        if (patientDetails.PatientTypeString == "New") {
                            
                        }else if(patientDetails.PatientTypeString == "New") {
                            
                        }else if (patientDetails.PatientTypeString == "New") {
                            
                        }
                    },
                    error: function (response) {
                        toastr.error(response.d, "Error Getting Person Details");
                    }
                });
            }

            $("#btnSaveBio").click(function() {
                if (!$('#patientBioModal').parsley().validate()) {
                    //console.log("here");
                    return false;
                }

                var sex = $("#<%=Gender.ClientID%>").find('option:selected').text();
                var optionType = $("#<%=bioPatientKeyPopulation.ClientID%>").find('option:selected').text();
                console.log(sex);
                console.log(optionType);

                if (sex == "Male" && optionType=="Female Sex Worker") {
                    toastr.error("Cannot select 'Female Sex Worker (FSW)' for a male person", "Person Population Error");
                    return false;
                }
                else if (sex == "Female" && optionType == "Men having Sex with Men") {
                    toastr.error("Cannot select 'Men having Sex with Men (MSM)' for a female person",
                        "Person Population Error");
                    return false;
                }

                var bioFirstName = escape($("#<%=bioFirstName.ClientID%>").val().trim());
                var bioMiddleName = escape($("#<%=bioMiddleName.ClientID%>").val().trim());
                var bioLastName = escape($("#<%=bioLastName.ClientID%>").val().trim());
                var bioPatientPopulation = $("#<%=bioPatientPopulation.ClientID%>").find('option:selected').text();
                var keyPop = $("#<%=bioPatientKeyPopulation.ClientID%>").val();
                var userId = <%=UserId%>;

                console.log(bioFirstName);
                console.log(bioMiddleName);
                console.log(bioLastName);
                console.log(bioPatientPopulation);

                if (patientId > 0) {
                    updatePatientBio(patientId, bioFirstName, bioMiddleName, bioLastName, userId, bioPatientPopulation, keyPop);
                }            
            });

            $('#<%=smrCounty.ClientID%>').on("change", function() {
                getSubcountyList(); /*call AJAX function */
            });

            $("#<%=smrSubCounty.ClientID%>").on("change", function() {
                getWardList();
            });

            $("#btnAddLocation").click(function() {
                if (!$('#patientLocationModal').parsley().validate()) {
                    return false;
                }
                var personId = 0;
                var county = $("#<%=smrCounty.ClientID%>").val();
                var subcounty = $("#<%=smrSubCounty.ClientID%>").val();
                var ward = $("#<%=smrWard.ClientID%>").val();
                var village = $("#<%=smrVillage.ClientID%>").val();
                var location = $("#<%=smrLocation.ClientID%>").val();
                var subLocation = $("#<%=smrLocation.ClientID%>").val();
                var landmark = $("#<%=smrLandmark.ClientID%>").val();
                var nearestHc = $("#<%=smrNearestHealthCenter.ClientID%>").val();
                var userId = <%=UserId%>;


                if (patientId > 0) {

                    addNewLocation(personId, county, subcounty, ward, village, location, subLocation, landmark, nearestHc, userId);
                }
                
            });

            $("#btnEditPatientContacts").click(function() {
                if (!$('#patientContactModal').parsley().validate()) {
                    return false;
                }
                
                var personId = 0;
                var physicalAddress = $("#<%=patPostalAddress.ClientID%>").val();
                var mobileNumber = $("#<%=patMobile.ClientID%>").val();
                var alternativeNumber = $("#<%=patAlternativeMobile.ClientID%>").val();
                var emailAddress = $("#<%=patEmailAddress.ClientID%>").val();
                var userId = <%=UserId%>;

                if (patientId > 0) {
                    editPatientContacts(personId, physicalAddress, mobileNumber, alternativeNumber, emailAddress, userId, patientId);
                }             
            });

            $("#btnAddPatientTreatmentSupporter").click(function() {             
                if (!$('#treatmentSupporterModal').parsley().validate()) {
                    return false;
                }
                var FirstName = $("#<%=trtFirstName.ClientID%>").val();
                var MiddleName = $("#<%=trtMiddleName.ClientID%>").val();
                var LastName = $("#<%=trtLastName.ClientID%>").val();
                var Gender = $("#<%=trtGender.ClientID%>").val();
                var Mobile = $("#<%=trtMobile.ClientID%>").val();
                var userId = <%=UserId%>;

                if (patientId > 0) {
                    addPatientTreatmentSupporter(patientId, FirstName, MiddleName, LastName, Gender, Mobile, userId);
                }
            });
            $("#<%=bioPatientKeyPopulation.ClientID%>").prop('disabled', true);
            $("#<%=bioPatientPopulation.ClientID%>").on("change",function() {

                console.log($("#<%=bioPatientPopulation.ClientID%>").find('option:selected').text());
                var dob  = "<%=Session["DateOfBirth"]%>";
                var today = new Date();
                var birthDate = new Date(dob);
                var age = today.getFullYear() - birthDate.getFullYear();

                if (age <= 18 && $("#<%=bioPatientPopulation.ClientID%>").find('option:selected').text() == "Key Population") {
                    $("#<%=bioPatientPopulation.ClientID%>").val(74);
                    toastr.error("Under 18 should not be a key population", "Population Type");
                    return false;
                }
                if ($("#<%=bioPatientPopulation.ClientID%>").find('option:selected').text() == "Key Population") {
                    $("#<%=bioPatientKeyPopulation.ClientID%>").prop('disabled', false);
                } else {
                    $("#<%=bioPatientKeyPopulation.ClientID%>").val("");
                    $("#<%=bioPatientKeyPopulation.ClientID%>").prop('disabled', true);
                }
            });

            getPatientVitals();
            //getPatientBaselinePreloadValues(patientId);
        });

        function addPatientTreatmentSupporter(patientId, firstName, middleName, lastName, gender, mobile, userId) {
            $.ajax({
                type: "POST",
                url: "../WebService/PatientSummaryService.asmx/AddPatientTreatmentSupporter",
                data: "{'patientId':'"+ patientId + "','firstName':'" + firstName + "', 'middleName':'" + middleName + "', 'lastName':'" + lastName + "', 'gender': '" + gender + "','mobile': '" + mobile + "','userId':'" + userId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response.d);
                    toastr.success(response.d, "Changing Treatment Supporter");
                },
                error: function (response) {
                    toastr.error(response.d, "Error Changing Treatment Supporter");
                }
            });
        }

        function editPatientContacts(personId, physicalAddress, mobileNumber, alternativeNumber, emailAddress, userId, patientid) {
            $.ajax({
                type: "POST",
                url: "../WebService/PersonService.asmx/AddPersonContact",
                data: "{'personId':'" + personId + "','physicalAddress':'" + physicalAddress + "','mobileNumber':'" + mobileNumber + "','alternativeNumber':'" + alternativeNumber + "','emailAddress':'" + emailAddress + "','userId':'" + userId + "','patientid':'" + patientid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response.d);
                    toastr.success(response.d, "Change Contacts");
                },
                error: function (response) {
                    toastr.error(response.d, "Error Changing Contacts");
                }
            });
        }

        function addNewLocation(personId, county, subcounty, ward, village, location, subLocation, landmark, nearestHc, userId) {
            $.ajax({
                type: "POST",
                url: "../WebService/PersonService.asmx/AddPersonLocation",
                data: "{'personId':'" + personId + "','county':'" + county + "','subcounty':'" + subcounty + "','ward':'" + ward + "','village':'" + village + "','location':'" + location + "','sublocation':'" + subLocation + "','landmark':'" + landmark + "','nearesthealthcentre':'" + nearestHc + "','userId':'" + userId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response.d);
                    toastr.success(response.d, "Change Location");
                },
                error: function (response) {
                    toastr.error(response.d, "Error Changing Location");
                }
            });
        }

        function updatePatientBio(patientId, bioFirstName, bioMiddleName, bioLastName, userId, bioPatientPopulation, keyPop) {
            $.ajax({
                type: "POST",
                url: "../WebService/PatientSummaryService.asmx/UpdatePatientBio",
                data: "{'patientId':'" + patientId + "', 'bioFirstName':'" + bioFirstName + "', 'bioMiddleName':'" + bioMiddleName + "', 'bioLastName': '" + bioLastName + "','userId': '" + userId + "','bioPatientPopulation':'" + bioPatientPopulation + "','keyPop':'" + keyPop + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response.d);
                    toastr.success(response.d, "Change Bio");
                },
                error: function (response) {
                    toastr.error(response.d, "Error Changing Bio");
                }
            });
        }

        function GetLookupNameById(Id) {
            $.ajax({
                type: "POST",
                url: "../WebService/LookupService.asmx/GetCountyByCountyId",
                data: "{'Id':'" + Id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#<%=txtCounty.ClientID%>").text(response.d);
                },
                error: function (response) {
                    toastr.error(response.d, "Error Getting County");
                }
            });
        }

        function GetWardNameByWardId(Id) {
            $.ajax({
                type: "POST",
                url: "../WebService/LookupService.asmx/GetWardNameByWardId",
                data: "{'wardId':'" + Id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#<%=txtWard.ClientID%>").text(response.d);
                },
                error: function (response) {
                    toastr.error(response.d, "Error Getting Ward Name");
                }
            });
        }

        function getSubcountyList()
        {
            var countyId = $("#<%=smrCounty.ClientID%>").find(":selected").text();
            //alert(countyId);
            $.ajax({
                type: "POST",
                url: "../WebService/LookupService.asmx/GetLookupSubcountyList",
                data: "{'county':'" + countyId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var itemList = JSON.parse(response.d);
                    $("#<%=smrSubCounty.ClientID%>").find('option').remove().end();
                    $("#<%=smrSubCounty.ClientID%>").append('<option value="0">Select</option>');
                    $.each(itemList, function (index, itemList) {

                        $("#<%=smrSubCounty.ClientID%>").append('<option value="' + itemList.SubcountyId + '">' + itemList.SubcountyName + '</option>');
                    }); 
                },
                error: function (response) {
                    toastr.error("Error in selecting the SubcountyList to Load "+ response.d, "Fetching subcounty List");
                }
            });
        }

        function getWardList()
        {
            var subcountyName = $("#<%=smrSubCounty.ClientID%>").find(":selected").text();
            //alert(subcountyName);
            $.ajax({
                type: "POST",
                url: "../WebService/LookupService.asmx/GetLookupWardList",
                data: "{'subcounty':'" + subcountyName + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var itemList = JSON.parse(response.d);
                    $("#<%=smrWard.ClientID%>").find('option').remove().end();
                    $("#<%=smrWard.ClientID%>").append('<option value="0">Select</option>');
                    $.each(itemList, function (index, itemList) {
                        $("#<%=smrWard.ClientID%>").append('<option value="' + itemList.WardId + '">' + itemList.WardName + '</option>');
                    }); 
                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message + " " + jsonError.StackTrace + " " + jsonError.ExceptionType);
                    return false;
                }
            });     
        }

        function getPatientVitals() {
            console.log();
            $.ajax({
                type: "POST",
                url: "../WebService/PatientVitals.asmx/GetByPatientId",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response.d);
                    var patientVitals = response.d;
                    //console.log("vitals");
                    $("#<%=lblWeightP.ClientID%>").text(patientVitals.Weight);
                    $("#<%=lblHeightP.ClientID%>").text(patientVitals.Height);
                    $("#<%=lblmuac.ClientID%>").text(patientVitals.Muac);
                    $("#<%=lblHeadCircumference.ClientID%>").text(patientVitals.HeadCircumference);
                    $("#<%=lblTemperature.ClientID%>").text(patientVitals.Temperature);
                    $("#<%=lblSystolic.ClientID%>").text(patientVitals.BpSystolic);
                    $("#<%=lblDiastolic.ClientID%>").text(patientVitals.Bpdiastolic);
                    $("#<%=lblPulseRate.ClientID%>").text(patientVitals.HeartRate);
                    $("#<%=lblRespiration.ClientID%>").text(patientVitals.RespiratoryRate);
                    $("#<%=lblOxygenSat.ClientID%>").text(patientVitals.SpO2);

                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message + " " + jsonError.StackTrace + " " + jsonError.ExceptionType);
                    return false;
                }
            });
        }

    </script>
</asp:Content>
