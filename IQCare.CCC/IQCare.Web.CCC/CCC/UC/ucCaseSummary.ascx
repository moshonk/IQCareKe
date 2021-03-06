﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCaseSummary.ascx.cs" Inherits="IQCare.Web.CCC.UC.ucCaseSummary" %>
<%@ Register TagPrefix="uc" TagName="PatientTriageSummary" Src="~/CCC/UC/ucPatientTriageSummary.ascx" %>
<%@ Register TagPrefix="uc" TagName="PatientTriage" Src="~/CCC/UC/ucPatientTriage.ascx" %>
<div class="box box-default box-solid" id="divCaseSummary">
    <div class="col-md-12 form-group">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-body">
                    <div class="col-md-12 form-group">
                        <label class="control-label pull-left"><span class="text-primary">Case Summary</span></label>
                    </div>


                    
                    <div class="col-md-12 form-group" id="casesummary">
                        <asp:PlaceHolder ID="QuestionsPlaceholder" runat="server"></asp:PlaceHolder>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-body">
                    <%--Lab Results--%>
                    <div>
                        <div class="col-md-12 form-group" style="margin-top: 30px;">
                            <div class="col-md-12 col-xs-12 col-sm-12">
                                <div id="LabResults" class="panel panel-primary">
                                    <div class="panel-heading">Lab Results</div>
                                    <div style="min-height: 10px; max-height: 550px; overflow-y: auto; overflow-x: auto;">
                                        <table id="dtlLabResults" class="table table-bordered table-striped" style="width: 100%">
                                            <thead>
                                                <tr>

                                                    <%-- <th><span class="text-primary">VisitID</span></th>--%>
                                                    <th><span class="text-primary">Date</span></th>
                                                    <th><span class="text-primary">Investigation(s)</span></th>
                                                    <th><span class="text-primary">Results</span></th>
                                                    <%-- <th><span class="text-primary">viral Load</span></th>--%>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Regimen Changes--%>
                    <div>
                        <div class="col-md-12 form-group" style="margin-top: 30px;">
                            <div class="col-md-12 col-xs-12 col-sm-12">
                                <div id="RegimenChanges" class="panel panel-primary">
                                    <div class="panel-heading">Current Regimen</div>
                                    <div style="min-height: 10px; max-height: 550px; overflow-y: auto; overflow-x: auto;">
                                        <table id="dtlRegimenChanges" class="table table-bordered table-striped" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th><span class="text-primary">Date</span></th>
                                                    <th><span class="text-primary">Regimen</span></th>
                                                    <th><span class="text-primary">TreatmentStatus</span></th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--OIS--%>
                    <div>
                        <div class="col-md-6 form-group" style="margin-top: 30px;">
                            <div class="col-md-12 col-xs-12 col-sm-12">
                                <div id="OIS" class="panel panel-primary">
                                    <div class="panel-heading">OIS</div>
                                    <div style="min-height: 10px; max-height: 550px; overflow-y: auto; overflow-x: auto;">
                                        <table id="dtlOIS" class="table table-bordered table-striped" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th><span class="text-primary">Date</span></th>
                                                    <th><span class="text-primary">OIS</span></th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Condition--%>
                    <div>
                        <div class="col-md-6 form-group" style="margin-top: 30px;">
                            <div class="col-md-12 col-xs-12 col-sm-12">
                                <div id="Condition" class="panel panel-primary">
                                    <div class="panel-heading">Condition</div>
                                    <div style="min-height: 10px; max-height: 550px; overflow-y: auto; overflow-x: auto;">
                                        <table id="dtlCondition" class="table table-bordered table-striped" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th><span class="text-primary">Date</span></th>
                                                    <th><span class="text-primary">Condition</span></th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--Anthropoemetric Measurements--%>
                    <div>
                        <div class="col-md-12 form-group" style="margin-top: 30px;">
                            <div class="col-md-12">
                                <div id="presentingComplaintsTable" class="panel panel-primary">
                                    <div class="panel-heading">Anthropoemetric Measurements</div>
                                    <div style="min-height: 10px; max-height: 550px; overflow-y: auto; overflow-x: auto;">
                                        <table id="dtlPreviousTriage" class="table table-bordered table-striped" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th>VisitDate</th>
                                                    <th>Height</></th>
                                                    <th>Weight</th>
                                                    <th>MUAC</th>
                                                    <th>BSystolic Bp</th>
                                                    <th>Diastolic Bp</th>
                                                    <th>Temp</th>
                                                    <th>Pulse Rate</th>
                                                    <th>Respiration Rate</th>
                                                    <th>SPOC (%)</th>
                                                    
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var OIList = [];
    var WHOList = [];
    var arrCurrentReg = [];


    
       function AddUpdateCaseSummary(mastervisitid){
         var error = 0;
        var ScreeningData = new Array;
        var ClinicalNotesData = new Array;
           $("#casesummary textarea").each(function () {
                var categoryId = $(this).attr('id');
               // alert(categoryId);
                var patientId = <%=PatientId%>;
                var patientMasterVisitId = <%=PatientMasterVisitId%>;
                var clinicalNotes = $(this).val();
                var serviceAreaId = 203;
                var userId = <%=userId%>;
           ClinicalNotesData.push({'notesCategoryId': categoryId, 'clinicalNotes': clinicalNotes, 'serviceAreaId': serviceAreaId, 'userId': userId  });
                });


            if (ClinicalNotesData.length > 0) {
            var patientId = <%=PatientId%>;
            var patientMasterVisitId = mastervisitid;

            $.ajax({
                type: "POST",
                url: "../WebService/PatientClinicalNotesService.asmx/AddPatientClinicalNotesRecord",
                data: "{'patientId': '" + patientId + "','patientMasterVisitId': '" + patientMasterVisitId + "','clinicaldata':'" + JSON.stringify(ClinicalNotesData) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    
                    error = 0;
                },
                error: function (response) {
                    error = 1;
                }
            });
           }
           if (error == 0) {
            toastr.success("Case  Summary Form is  Saved");
             
           }

         }

              
    function CheckifCaseSummaryHasValues() {
        Answers.length = 0;
               $("#casesummary textarea").each(function () {
                var categoryId = $(this).attr('id');
               // alert(categoryId);
                var patientId = <%=PatientId%>;
                var patientMasterVisitId = <%=PatientMasterVisitId%>;
                var clinicalNotes = $(this).val();
                var serviceAreaId = 203;
                var userId = <%=userId%>;
           Answers.push({ 'Id': categoryId, 'value': clinicalNotes});
                     });

                }
    function DrawDataTable(ctrlName, arrUI) {

    if (arrUI.length > 0) {
        var table = $("#" + ctrlName ).DataTable();
        table.rows.add(arrUI).draw();
        table.searching = false;
        tale.paging = false;
        table.searching = false;
        table.info = false;
        table.ordering = false;
        
    }
      }

    function LoadOIList() {
        $.ajax({
            type: "POST",
            url: "../WebService/PatientEncounterService.asmx/LoadPatientOIList",
           contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                OIList = response.d;
                if (OIList != null) {
                    if (OIList.length > 0) {
                        DrawDataTable("dtlOIS", OIList);;
                    }
                }
            }
       
        });
    }

    function LoadCurrentRegimen() {
        $.ajax({
            type: "POST",
            url: "../WebService/PatientEncounterService.asmx/LoadCurrentRegimen",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                arrCurrentReg = response.d;
                if (arrCurrentReg != null) {
                    if (arrCurrentReg.length > 0) {
                        DrawDataTable("dtlRegimenChanges", arrCurrentReg);
                    }
                }
            }
        });
    }

    function LoadWHOList() {
             $.ajax({
            type: "POST",
            url: "../WebService/PatientEncounterService.asmx/LoadPatientWHOStageList",
           contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                WHOList = response.d;
                if (WHOList != null) {
                    if (WHOList.length > 0) {
                        DrawDataTable("dtlCondition", WHOList);
                    }
                }
            }
       
        });
    }

    jQuery(function ($) {
        var caseSummaryId = <%=caseSummaryId%>;
        if (caseSummaryId > 0) {
            $('#myWizard').wizard();
            $('#myWizard').find('#dsSectionTwo').toggleClass('complete', true);
            $('#myWizard').on('changed.fu.wizard', function (evt, data) {
            $('#myWizard').find('#dsSectionTwo').toggleClass('complete', true);
            });
        }
    });

  

    $(document).ready(function () {

        $('.DataTable').DataTable({iDisplayLength: 50, responsive: true});

        // alert("Page iko ready sasa");
       // $.hivce.loader('show');
        //GetClinicalSummaryData();
        LoadOIList();
        LoadWHOList();
        LoadCurrentRegimen();
        var previousTriage = $('#dtlPreviousTriage').DataTable({
        ajax: {
            type: "POST",
            url: "../WebService/PatientEncounterService.asmx/LoadVitalSigns",
            dataSrc: 'd',
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        },
        paging: false,
        searching: false,
        info: false,
        ordering: false,
        columnDefs: [
            {
                "targets": [0],
                "searchable": false
            }
        ]
        });

  
       


        // Load Lab Results
         var previousTriage = $('#dtlLabResults').DataTable({
        ajax: {
            type: "POST",
            url: "../WebService/PatientEncounterService.asmx/GetPatientAllLabs",
            dataSrc: 'd',
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        },
        paging: false,
        searching: false,
        info: false,
        ordering: false,
        columnDefs: [
            {
                "targets": [0],
                
                "searchable": false
            }
        ]
        });


    });
   
  
</script>
