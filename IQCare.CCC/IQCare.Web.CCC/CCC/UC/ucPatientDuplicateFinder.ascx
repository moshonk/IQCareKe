<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucPatientDuplicateFinder.ascx.cs" Inherits="IQCare.Web.CCC.UC.ucPatientDuplicateFinder" %>


<div class="col-md-4">
    <div class="col-md-12">
        <input type="checkbox" name="chkFirstName" id="chkFirstName" value="1" checked="checked" />
        <label>First Name</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkLastName" id="chkLastName" value="1" checked="checked" />
        <label>Last Name</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkMiddleName" id="chkMiddleName" value="1" />
        <label>Middle Name</label>
    </div>
</div>
<div class="col-md-4">
    <div class="col-md-12">
        <input type="checkbox" name="chkSex" id="chkSex" value="1" checked="checked" />
        <label>Sex</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkEnrollmentNo" id="chkEnrollmentNo" value="1" checked="checked" />
        <label>Enrollment Number</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkDOB" id="chkDob" value="1" checked="checked" />
        <label>Date of Birth</label>
    </div>
</div>
<div class="col-md-4">
    <div class="col-md-12">
        <input type="checkbox" name="chkEnrollmentDate" id="chkEnrollementDate" value="1" checked="checked" />
        <label>Enrollment Date</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkARTStartdate"  id="chkARTStartDate"value="1" checked="checked" />
        <label>ART Start Date</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkHIVDiagnosisDate"  id="chkHIVDiagnosisDate"value="1" checked="checked" />
        <label>HIV Diagnosis Date</label>
    </div>
</div>
<div class="col-md-12">
    <div class="col-md-3 col-xs-4 col-sm-3">
        <div class="col-md-12 pull-left" id="divAction">
            <i class="fa fa-spinner fa-pulse fa-3x fa-fw pull-left text-info"></i>
            <span class="sr-only"></span><strong class="pull-left" id="divActionString">Fetching Patient data</strong>
        </div>
    </div>
    <div class="col-md-3 col-xs-4 col-sm-3">
    </div>
    <div class="col-md-3 col-xs-4 col-sm-3">
    </div>
    <div class="col-md-3 col-xs-4 col-sm-3">
        <button name="btnSearch" id="btnSearch" value=" Search" class="btn btn-info btn-lg  btn-block" onclick="return false"><i class="fa fa-search"></i>Search</button>
    </div>
</div>

<div class="col-md-12 col-xs-12 col-sm-12 bs-callout bs-callout-info" id="infoGrid">
    <div class="col-md-6">
        <label class="control-label pull-left text-warning fa fa-search-plus">Patient Search Results </label>
    </div>
    <div class="col-md-6 pull-right">
        <button id="btnRemoveGrid" class="btn btn-warning btn-lg btn-sm pull-right fa fa-arrow-circle-o-left" onclick="return false">Back to Search</button>
    </div>
</div>

<div class="col-md-12 col-xs-12 col-sm-12" style="padding: 5px; text-align: left;" id="infoGridMessage">

</div>

<div class="col-md-12" id="duplicateFinder">
    <table id="tblFindDuplicates" class="table display" style="cursor: pointer">
        <thead>
            <tr>
                <th>First Name</th>
                <th>Middle Name</th>
                <th>Last Name</th>
                <th>Date Of Birth</th>
                <th>CCC Number</th>
                <th>Sex</th>
                <th>Enrollment Date</th>
                <th>Cell</th>
                <th style="width: 10px;">Patient Id</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script type="text/javascript">

    $().ready(function () {

        $("#PatientSearch").hide();
        $("#infoGrid").hide();
        $("#infoGridMessage").hide();
        $("#divAction").hide("fast");

        var table = null;
        $("#btnSearch").click(function (e) {

            $("#divAction").show("fast");
            $("#divActionString").text("Consolidating table and data features..");

            table = $("#tblFindDuplicates").dataTable({
                "oLanguage": {
                    "sZeroRecords": "No records to display",
                    "sSearch": "Search from all Records"
                },
                "bProcessing": true,
                "bServerSide": true,
                "ordering": true,
                "searching": true,
                "info": true,
                "bDestroy": true,
                "sAjaxSource": "../WebService/PatientService.asmx/GetDuplicatePatientRecords",
                "sPaginationType": "full_numbers",
                "bDeferRender": true,
                "responsive": true,
                "sPaginate": true,
                "lengthMenu": [[10, 20, 50], [10, 20, 50]],
                "aoColumns":
                    [
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null
                    ],
                "fnServerData": function (sSource, aoData, fnCallback) {

                    var dataPayLoad = {
                        matchFirstName: $("#chkFirstName").is(":checked"),
                        matchLastName: $("#chkLastName").is(":checked"),
                        matchMiddleName: $("#chkMiddleName").is(":checked"),
                        matchSex: $("#chkSex").is(":checked"),
                        matchEnrolmentNumber: $("#chkEnrollmentNo").is(":checked"),
                        matchDob: $("#chkDOB").is(":checked"),
                        matchEnrolmentDate: $("#chkEnrollmentDate").is(":checked"),
                        matchARTStartDate: $("#chkARTStartdate").is(":checked"),
                        matchHIVDiagnosisDate: $("#chkHIVDiagnosisDate").is(":checked")
                    };

                    $("#divActionString").text("Data features and table preparation complete");
                    var arrayReturn = [];

                    $.ajax({
                        "dataType": 'json',
                        "contentType": "application/json; charset=utf-8",
                        "type": "POST",
                        "url": sSource,
                        "data": JSON.stringify(dataPayLoad),
                        "success": function (msg) {
                            $("#divActionString").text("Rendering patients data...");
                            var json = jQuery.parseJSON(msg.d);
                            if (json === null) {
                                var data = [];
                                arrayReturn["data"] = data;
                                arrayReturn["draw"] = 1;
                                arrayReturn["recordsTotal"] = 0;
                                arrayReturn["recordsFiltered"] = 0;

                                fnCallback(arrayReturn);
                                $("#duplicateFinder").slideDown("fast", function () { $("#divAction").hide("fast"); $("#infoGrid").slideDown("fast", function () { $("#searchGrid").slideUp("fast") }); $("#infoGridMessage").slideDown("fast"); });
                            } else {
                                fnCallback(json);
                                $("#duplicateFinder").slideDown("fast", function () { $("#divAction").hide("fast"); $("#infoGrid").slideDown("fast", function () { $("#searchGrid").slideUp("fast") }); $("#infoGridMessage").slideDown("fast"); });
                            }
                        },
                        "error": function (xhr, errorType, exception) {
                            $("#divAction").show("fast");

                            var jsonError = jQuery.parseJSON(xhr.responseText);
                            $("#divAction").text(jsonError.Message);
                            toastr.error("" + xhr.status + "" + jsonError.Message + " ");
                            return false;
                        }
                    });
                }
            });

        });

    });

</script>
