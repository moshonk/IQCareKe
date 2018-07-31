<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucPatientDuplicateFinder.ascx.cs" Inherits="IQCare.Web.CCC.UC.ucPatientDuplicateFinder" %>


<div class="col-md-4">
    <div class="col-md-12">
        <input type="checkbox" name="chkFirstName" value="1" checked="checked" />
        <label>First Name</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkLastName" value="1" checked="checked"/>
        <label>Last Name</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkMiddleName" value="1" />
        <label>Middle Name</label>
    </div>
</div>
<div class="col-md-4">
    <div class="col-md-12">
        <input type="checkbox" name="chkSex" value="1" checked="checked" />
        <label>Sex</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkEnrollmentNo" value="1" checked="checked" />
        <label>Enrollment Number</label>
    </div>
    <div class="col-md-12">
        <input type="checkbox" name="chkDOB" value="1" checked="checked" />
        <label>Date of Birth</label>
    </div>
</div>
<div class="col-md-4">
    <div class="col-md-12">
        <input type="checkbox" name="chkEnrollmentDate" value="1" checked="checked" />
        <label>Enrollment Date</label>
    </div>
    <div class="col-md-12">
    </div>
</div>
<div class="col-md-12">
    <div class="col-md-3">
    </div>
    <div class="col-md-3">
    </div>
    <div class="col-md-3">
    </div>
    <div class="col-md-3">
        <button name="btnSearch" id="btnSearch" value=" Search" class="btn btn-info btn-lg  btn-block" ><i class="fa fa-search"> </i> Search</button>
    </div>
</div>

<script type="text/javascript">

    $().ready(function () {

        $('#btnSearch').click(function () {
            TODO TODO TODO
            $.ajax({
                type: "POST",
                url: "../WebService/PatientVitals.asmx/GetCurrentPatientVitalsByPatientId",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var vitalList = JSON.parse(response.d);



                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message);
                }
            });            

        });

    });

</script>
