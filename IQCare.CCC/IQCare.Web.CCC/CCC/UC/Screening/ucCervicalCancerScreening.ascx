<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCervicalCancerScreening.ascx.cs" Inherits="IQCare.Web.CCC.UC.Screening.ucCervicalCancerScreening" %>
<style>
    /*.rbList{float: right;}
    .rbList input{margin-left: 5px;}*/
    .cageaidrbList td {
        text-align: left;
    }

    .depression-results {
        padding-top: 10px;
        padding-bottom: 10px;
    }

    .CaCxList label {
        color: #8a6d3b;
    }
</style>
<div class="col-md-12 form-group">
    <div class="col-md-12" id="PatientVisitDate" data-parsley-validate="true" data-show-errors="true">
        <div class="panel panel-info">
            <div class="panel-body">
                <div class="col-md-12">
                    <label class="required control-label pull-left">Visit Date</label>
                </div>

                <div class="col-md-4 form-group">
                    <div class='input-group date' id='VisitDatedatepicker'>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                        <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control input-sm" ID="PersonVisitDate" data-parsley-required="true" onblur="DateFormat(this,this.value,event,false,'3')" onkeyup="DateFormat(this,this.value,event,false,'3')"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-12" id="CxCaScreening">
        <div class="panel panel-info">
            <div class="panel-body">
                <div class="col-md-12 form-group" id="caCxScreeningQuestionsContainer">
                    <asp:PlaceHolder ID="phScreenedInLastOneYear" runat="server"></asp:PlaceHolder>
                    <asp:PlaceHolder ID="phVisitType" runat="server"></asp:PlaceHolder>
                    <asp:PlaceHolder ID="phScreeningMethod" runat="server"></asp:PlaceHolder>
                    <asp:PlaceHolder ID="phTreatment" runat="server"></asp:PlaceHolder>
                    <asp:PlaceHolder ID="phReferral" runat="server">
                        <asp:PlaceHolder ID="phReferred" runat="server" />
                        <div id="ReferralOut">
                            <div class="row">
                                <label class="control-label pull-left"><span class="text-primary">Referral Out</span></label>
                            </div>
                            <div class='col-md-4 text-left'>
                                <label>Referred to: </label>
                                <asp:TextBox ID="phReferredTo" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder ID="phReferralReasons" runat="server"></asp:PlaceHolder>
                    <div class="row" id="followupDate">
                        <div class="col-md-12 text-left">
                            <div class="row">
                                <label class="control-label pull-left"><span class="text-primary">Followup Date/Next Appointment</span></label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 form-group">
                                <div class="input-group date" id="followupDatedatepicker">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                    <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control input-sm" ID="followpDate" data-parsley-required="true" onblur="DateFormat(this,this.value,event,false,'3')" onkeyup="DateFormat(this,this.value,event,false,'3')"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <button type="button" id="submitData" class="btn btn-primary btn-next" data-last="Complete" onclientclick="return false;" />
</div>
<script type="text/javascript">
    //var currentStep;
    //$("#scmyWizard").on("actionclicked.fu.wizard", function (evt, data) {
    //    currentStep = data.step;
    //    if (currentStep == 3) {
    //        addUpdateFBVScreeningData();
    //    }
    //});

    var contain = "";
    var Answers = new Array;
    var visitDate = "<%=VisitDate%>";
    var followupDate = '2019-01-01';

    ('focus', function (ev) { ev.preventDefault(); });

    $(document).ready(function () {

        $('#VisitDatedatepicker').datetimepicker({
            format: 'DD-MMM-YYYY',
            date: visitDate,
            allowInputToggle: true,
        });

        $('#VisitDatedatepicker').on('dp.change', function (e) {

            if (!e.oldDate || !e.date.isSame(e.oldDate, 'day')) {
                Reset();
                $(this).data('DateTimePicker').hide();
            }

            var vDate = moment($("#PersonVisitDate").val(), 'DD-MMM-YYYYY').toDate();
            var validDateOfVisit = moment(vDate).isBefore(enrollmentDate);
            var futuredate = moment(vDate).isAfter(new Date());

            if (futuredate) {
                $("#<%=PersonVisitDate.ClientID%>").val('');
                toastr.error("Future dates not allowed!");

                return false;
            }
            if (validDateOfVisit) {
                toastr.error("VISIT date CANNOT be before ENROLLMENT date");
                $("#<%=PersonVisitDate.ClientID%>").val('');
                return false;
            }

            var patientId ="<%=PatientId%>";
            var screeningCategoryId = "<%=screeningTypeId%>";

            if (moment(vDate).isValid()) {

                var visitDate = moment(vDate).format('YYYY-MM-DD');
                var patientId = <%=PatientId%>;
                var ServiceAreaId = 203;
                var EncounterType = "CxCaScreening";
                var userId = <%=userId%>;
                $.ajax({

                    type: "POST",
                    url: "../WebService/PatientScreeningService.asmx/GetPatientMasterVisitId",
                    data: "{'PatientId': '" + patientId + "','ServiceAreaId':'" + ServiceAreaId + "','UserId':'" + userId + "','EncounterType':'" + EncounterType + "','visitDate': '" + visitDate + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        var res = JSON.parse(response.d);
                        if (res.Result > 0) {

                            var result = res.Result;

                            getPatientScreening(patientId, result);

                        }
                    },
                    error: function (response) {
                        error = 1;
                        toastr.error("Unable to get visit iinformation");
                    }
                });
            }
        });

        $('#followupDatedatepicker').datetimepicker({
            format: 'DD-MMM-YYYY',
            date: followupDate,
            allowInputToggle: true,
        });

        var enrollmentDate = "<%=DateOfEnrollment%>";
        $("#submitData").click(function () {

            if ($('#datastep1').parsley().validate()) {
                var visitDate = $("#<%=PersonVisitDate.ClientID%>").val();
                if (moment('' + visitDate + '').isAfter()) {
                    toastr.error("Visit date cannot be a future date.");
                    return false;
                }
                if (visitDate === "" || visitDate === null) {
                    toastr.error("VisitDate is a required field");
                    return false;
                }

                $('#VisitDatedatepicker').data('DateTimePicker').hide();

                checkifFieldsHavevalue();
                var values = Answers.filter((x) => { return x.value.length > 0 })
                if (values != null) {
                    if (values.length > 0) {
                        addCxCaScreeningEncounter(visitDate);
                    }
                    else {
                        toastr.info("No data Saved since Fields are empty");
                        //window.location.href = '<%=ResolveClientUrl("~/CCC/patient/patientHome.aspx") %>';
                    }
                }
            }
            else {
                return false;
            }
        });


    });
    function Reset() {

        $('input:checked').removeAttr('checked');

    }
    function checkifFieldsHavevalue() {
        $("#CxCaScreening input[type=radio]:checked").each(function () {
            var screeningValue = $(this).val();
            var screeningType = <%=screeningTypeId%>;
            var patientId = <%=PatientId%>;
            var patientMasterVisitId = <%=PatientMasterVisitId%>;
            var userId = <%=userId%>;
            var screeningCategory = $(this).attr('itemid');

            if (screeningValue > 0) {
                Answers.push({ 'Id': screeningCategory, 'value': screeningValue });
            }
        });

    }
    function addCxCaScreeningEncounter(visitDate) {
        var patientId = <%=PatientId%>;
        var dateOfVisit = $("#PersonVisitDate").val();
        var ServiceAreaId = 203;
        var EncounterType = "CxCaScreening";
        var userId = <%=userId%>;
        var patientMasterVisitId = <%=PatientMasterVisitId%>;
        $.ajax({

            type: "POST",
            url: "../WebService/PatientScreeningService.asmx/GetPatientMasterVisitId",
            data: "{'PatientId': '" + patientId + "','ServiceAreaId':'" + ServiceAreaId + "','UserId':'" + userId + "','EncounterType':'" + EncounterType + "','visitDate': '" + dateOfVisit + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                var res = JSON.parse(response.d);
                if (res.Result > 0) {

                    var result = res.Result;

                    toastr.success(res.Msg);

                    addUpdateCxCaScreeningData(result);

                }

            },
            error: function (response) {
                error = 1;
                toastr.error("Cervical Cancer Screening not Saved");
                window.location.href = '<%=ResolveClientUrl("~/CCC/patient/patientHome.aspx") %>';


            }
        });
    }

    function addUpdateCxCaScreeningData(mastervisitid) {
        var tcaDate = moment($("#followupDate").val(), 'DD-MMM-YYYYY').toDate();
        var referredTo = $("referredTo").val();

        var error = 0;
        $("#CxCaScreening input[type=radio]:checked").each(function () {
            var screeningValue = $(this).val();
            var screeningType =  <%=screeningTypeId%>
            var patientId = <%=PatientId%>;
            var patientMasterVisitId = mastervisitid;
            var userId = <%=userId%>;
            var screeningCategory = $(this).attr('itemid');
            var rdIdValue = $(this).val();
            $.ajax({
                type: "POST",
                url: "../WebService/PatientScreeningService.asmx/AddUpdateScreeningData",
                data: "{'patientId': '" + patientId + "','patientMasterVisitId': '" + patientMasterVisitId + "','screeningType':'" + screeningType + "','screeningCategory':'" + screeningCategory + "','screeningValue':'" + screeningValue + "','userId':'" + userId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    error = 0;
                },
                error: function (response) {
                    error = 1;
                }
            });
        });
        if (error == 0) {
            toastr.success("Cervical Cancer Screening Saved");
            //window.location.href = '<%=ResolveClientUrl("~/CCC/patient/patientHome.aspx") %>';
        }
    }

    function getPatientScreening(patientId, patientMasterVisitId) {
        $.ajax({
            type: "POST",
            url: "../WebService/PatientScreeningService.asmx/getScreeningByIdandMasterVisit",
            data: "{'PatientId':'" + patientId + "', 'PatientMasterVisitId': '" + patientMasterVisitId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var itemList = JSON.parse(response.d);
                console.log(itemList);
                $.each(itemList, function (index, patientScreening) {
                    $("#CxCaScreening input[type=radio][itemid='" + patientScreening.ScreeningCategoryId + "'][value='" + patientScreening.ScreeningValueId + "']").prop('checked', true);
                });

            },
            error: function (response) {
                toastr
                    .error("Error fetching Cervical Cancer Screening List " + response.d);
            }
        });
    }

    $('#VisitDatedatepicker').on('change blur keyup keypress', function () {
        var visitDate = moment(dateOfVisit.val());

    });

</script>
