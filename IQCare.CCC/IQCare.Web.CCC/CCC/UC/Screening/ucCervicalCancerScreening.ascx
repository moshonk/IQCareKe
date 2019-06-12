<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCervicalCancerScreening.ascx.cs" Inherits="IQCare.Web.CCC.UC.Screening.ucCervicalCancerScreening" %>
<!-- 
TODO:   Load saved screening data.
        validate screening data before save. done
        Ensure that it updates and does not create new entries when editting encounter. done
        Load the date and person who did the assesssment. done
        -- On the patient dashboard, display whether a CxCa screening is pending or not . View or SProc AssessmentPatientMasterVisitId
        Ensure that Screening data is saved to PatientCervicalCancerScreening table. done
        When checking for last asesssment, filter by date, today's date. done 
-->

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
<div class="col-md-12 form-group" id="CxCaScreening">
    <div class="col-md-12" id="PatientVisitDate" data-parsley-validate="true" data-show-errors="true">
        <div class="panel panel-info">
            <div class="panel-body">
                <div class="col-md-6">
                    <div class="col-md-12">
                        <label class="required control-label pull-left">Visit Date</label>
                    </div>
                    <div class="col-md-12 form-group">
                        <div class='input-group date' id='VisitDatedatepicker'>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                            <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control input-sm" ID="PersonVisitDate" data-parsley-required="true" onblur="DateFormat(this,this.value,event,false,'3')" onkeyup="DateFormat(this,this.value,event,false,'3')"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="col-md-12">
                        <label class="required control-label">Last Cervical cancer screening Assessment</label>
                    </div>
                    <div class="col-md-12">
                        <div>
                            Done by:
                            <asp:Label ID="AssessmentBy" runat="server" Text="Label"></asp:Label>
                        </div>
                        <div>
                            Date Done:
                            <asp:Label ID="AssessmentDate" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-12">
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
                                <asp:TextBox ClientIDMode="Static" ID="referredTo" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder ID="phReferralReasons" runat="server"></asp:PlaceHolder>
                    <div class="row">
                        <div class="col-md-12 text-left">
                            <div class="row">
                                <label class="control-label pull-left"><span class="text-primary">Followup Date/Next Appointment</span></label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 form-group">
                                <div class="input-group date" id="AppointmentDatedatepicker">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                    <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control input-sm" ID="appointmentDate" data-parsley-required="true" onblur="DateFormat(this,this.value,event,false,'3')" onkeyup="DateFormat(this,this.value,event,false,'3')"></asp:TextBox>
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
<div class="col-md-12">
    <div class="col-md-12">
        <h2>Screening History</h2>
    </div>
    <div class="col-md-12">
        <table id="dtlScreeningHistory" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th><span class="text-primary">Screening Date</span></th>
                    <th><span class="text-primary">Next Appointment Date</span></th>
                    <th><span class="text-primary">Referral</span></th>
                    <th><span class="text-primary">id</span></th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>

    </div>
</div>

<script type="text/javascript">

    var contain = "";
    var Answers = new Array;
    var visitDate = "<%=VisitDate%>";
    var appointmentDate = '';
    var gender = "<%=Gender%>";

    ('focus', function (ev) { ev.preventDefault(); });

    $(document).ready(function () {
        var patientMasterVisitId = <%=PatientMasterVisitId%>;
        var patientId =  <%=patientId%>;

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

            var patientId ="<%=patientId%>";
            var screeningCategoryId = "<%=ScreeningTypeId%>";

            if (moment(vDate).isValid()) {

                var visitDate = moment(vDate).format('YYYY-MM-DD');
                var patientId = <%=patientId%>;
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
                        toastr.error("Unable to get visit information");
                    }
                });
            }
        });

        $('#AppointmentDatedatepicker').datetimepicker({
            format: 'DD-MMM-YYYY',
            date: appointmentDate,
            allowInputToggle: true,
        });

        $('#AppointmentDatedatepicker').on('dp.change', function (e) {
            var vDate = moment($("#PersonVisitDate").val(), 'DD-MMM-YYYYY').toDate();
            var aDate = moment($("#appointmentDate").val(), 'DD-MMM-YYYYY').toDate();
            var validAppointmentDate = moment(aDate).isBefore(enrollmentDate);
            var pastdate = moment(aDate).isBefore(vDate) || moment(aDate).isSame(vDate);

            if (pastdate) {
                $("#appointmentDate").val('');
                toastr.error("Past dates not allowed!");

                return false;
            }
            if (validAppointmentDate) {
                $("#appointmentDate").val('');
                toastr.error("Appointment date CANNOT be before ENROLLMENT date");
                return false;
            }

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
                    }
                }
            }
            else {
                return false;
            }
        });

        function Reset() {

            $('input:checked').removeAttr('checked');

        }

        function checkifFieldsHavevalue() {
            $("#CxCaScreening input[type=radio]:checked").each(function () {
                var screeningValue = $(this).val();
                var screeningType = <%=ScreeningTypeId%>;
                var patientId = <%=patientId%>;
                var patientMasterVisitId = <%=PatientMasterVisitId%>;
                var userId = <%=userId%>;
                var screeningCategory = $(this).attr('itemid');

                if (screeningValue > 0) {
                    Answers.push({ 'Id': screeningCategory, 'value': screeningValue });
                }
            });

        }

        function addCxCaScreeningEncounter(visitDate) {
            var patientId = <%=patientId%>;
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

                        addUpdateCxCaScreeningData(result);

                    }

                },
                error: function (response) {
                    error = 1;
                    toastr.error("Cervical Cancer Screening not Saved");
                    //window.location.href = '<%=ResolveClientUrl("~/CCC/patient/patientHome.aspx") %>';
                }
            });
        }

        function addUpdateCxCaScreeningData(mastervisitid) {
            var appointmentDate = moment($("#appointmentDate").val()).format('YYYY-MM-DD');
            var referredTo = $("#referredTo").val();
            var patientId = <%=patientId%>;
            var patientMasterVisitId = mastervisitid;
            var userId = <%=userId%>;

            $.ajax({
                type: "POST",
                url: "../WebService/PatientScreeningService.asmx/SaveUpdatePatientCervicalCancerScreening",
                data: "{'patientId': '" + patientId + "','patientMasterVisitId': '" + patientMasterVisitId + "','visitDate':'" + visitDate + "','appointmentDate':'" + appointmentDate + "','referredTo':'" + referredTo + "','userId':'" + userId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var screeningTypeId =  <%=ScreeningTypeId%>;
                    $.ajax({
                        type: "POST",
                        url: "../WebService/PatientScreeningService.asmx/DeleteScreeningData",
                        data: "{'patientId': '" + patientId + "','patientMasterVisitId': '" + patientMasterVisitId + "','screeningTypeId':'" + screeningTypeId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            $("#CxCaScreening input[type=radio]:checked").each(function () {
                                var screeningValue = $(this).val();
                                var screeningCategory = $(this).attr('itemid');
                                var rdIdValue = $(this).val();
                                var label = $(this).siblings('label').text();
                                $.ajax({
                                    type: "POST",
                                    url: "../WebService/PatientScreeningService.asmx/AddUpdateScreeningData",
                                    data: "{'patientId': '" + patientId + "','patientMasterVisitId': '" + patientMasterVisitId + "','screeningType':'" + screeningTypeId + "','screeningCategory':'" + screeningCategory + "','screeningValue':'" + screeningValue + "','userId':'" + userId + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        toastr.success(label + " Saved");
                                        //window.location.href = '<%=ResolveClientUrl("~/CCC/patient/patientHome.aspx") %>';
                                    },
                                    error: function (resp, status, errorMsg) {
                                        toastr.error("Not saved: " + errorMsg);
                                    }
                                });
                            });
                        },
                        error: function (resp, status, errorMsg) {
                            toastr.error("Not saved: " + errorMsg);
                        }
                    });

                },
                error: function (resp, status, errorMsg) {
                    toastr.error("Not saved: " + errorMsg);
                }
            });
        }

        function getPatientScreening(patientId, patientMasterVisitId) {
            $.ajax({
                type: "POST",
                url: "../WebService/PatientScreeningService.asmx/getCervicalCancerScreeningByVisitId",
                data: "{'PatientId':'" + patientId + "', 'PatientMasterVisitId': '" + patientMasterVisitId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var screening = JSON.parse(response.d);
                    console.log(screening);
                    if (screening != null) {
                        $("#referredTo").val(screening.ReferredTo);
                        $("#appointmentDate").val(moment(screening.AppointmentDate).format('DD-MMM-YYYY'));
                        //$("#PersonVisitDate").val(moment(screening.VisitDate).format('DD-MMM-YYYY'));
                    }

                    $.ajax({
                        type: "POST",
                        url: "../WebService/PatientScreeningService.asmx/getScreeningByIdandMasterVisit",
                        data: "{'PatientId':'" + patientId + "', 'PatientMasterVisitId': '" + patientMasterVisitId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var itemList = JSON.parse(response.d);
                            $.each(itemList, function (index, patientScreening) {
                                $("#CxCaScreening input[type=radio][itemid='" + patientScreening.ScreeningCategoryId + "'][value='" + patientScreening.ScreeningValueId + "']").prop('checked', true);
                            });

                            showHideReferralOut();

                            showHideChildControls();

                        },
                        error: function (response) {
                            toastr
                                .error("Error fetching Cervical Cancer Screening List " + response.d);
                        }
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

        function showHideReferralOut() {
            var referredOutResponse = $("#Referred").find("input[type=radio]:checked").siblings('label').text();

            if (referredOutResponse == 'Yes') {
                $("#ReferralOut, #CxCaReferralReasons").show();
                $("#ReferralOut, #CxCaReferralReasons").find('input').attr('data-parsley-required', 'true');
            } else {
                $("#ReferralOut, #CxCaReferralReasons").hide();
                $("#ReferralOut, #CxCaReferralReasons").find('input').removeAttr('data-parsley-required');
            }
        }

        function getScreeningHistory() {
            $.ajax({
                type: "POST",
                url: "../WebService/PatientScreeningService.asmx/GetPatientCervicalCancerScreeningHistory",
                data: "{patientId: '" + patientId + "'}",
                dataSrc: 'd',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).done(function (res) {
                $('#dtlScreeningHistory').DataTable({
                    data: res.d,
                    paging: false,
                    searching: false,
                    info: false,
                    ordering: false,
                    columnDefs: [
                        {
                            "targets": [0],
                            "visible": true,
                            "searchable": false
                        }
                    ]
                });

            });

        }

        $('#dtlScreeningHistory').on('click', 'tbody tr', function () {
            // window.location.href = $(this).attr('href');
            var patientId = <%=patientId%>;
            var patientMasterVisitId = $(this).find('td').eq(3).text();

            getPatientScreening(patientId, patientMasterVisitId);

        });

        function init() {
            if (gender != 'Female') {
                $("#CxCaScreening").html("This form can ONLY be filled for FEMALE clients");
            } else {
                $("#CxCaScreening .children").hide();
                $(".question").find('input[type=radio]').attr('data-parsley-required', 'true');
            }

            getScreeningHistory();

        }

        function showHideChildControls() {
            $("#CxCaScreeningVisitType, #CxCaScreeningMethod, #CxCaTreatment #CxCaReferralReasons #Referred #CxCaReferralReasons").find(".question input[type=radio]").each(function () {
                if ($(this).is(":checked")) {
                    $(this).parent().siblings().show();
                    $(this).parent().siblings().find('input[type=radio]').attr('data-parsley-required', 'true')
                } else {
                    $(this).parent().siblings().find('input[type=radio]').attr("checked", false);
                    $(this).parent().siblings().find('input[type=radio]').removeAttr('data-parsley-required')
                    $(this).parent().siblings().hide();
                }
            });
        }

        $("#CxCaScreeningVisitType, #CxCaScreeningMethod, #CxCaTreatment #CxCaReferralReasons #Referred #CxCaReferralReasons").find(".question input[type=radio]").change(function () {
            showHideChildControls();
        });

        $("#Referred").find("input[type=radio]").change(function () {
            showHideReferralOut();
        });

        init();

        getPatientScreening(patientId, patientMasterVisitId);

    });

</script>
