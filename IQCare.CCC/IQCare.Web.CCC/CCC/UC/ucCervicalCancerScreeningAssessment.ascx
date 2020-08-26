<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCervicalCancerScreeningAssessment.ascx.cs" Inherits="IQCare.Web.CCC.UC.ucCervicalCancerScreeningAssessment" %>
<asp:PlaceHolder ID="phCxcaScreeningAssessment" runat="server">
    <div class="panel panel-info">
        <div class="panel-header">
            <div class="col-md-12 form-group">
                <label class="control-label pull-left">Cervical cancer screening assessment</label>
            </div>
        </div>
        <div class="panel-body">
            <div class="col-md-12 form-group" id="CxCaScreening">
                <asp:PlaceHolder ID="phScreenedInLastOneYear" runat="server"></asp:PlaceHolder>
                <asp:PlaceHolder ID="phReferForScreening" runat="server"></asp:PlaceHolder>
            </div>
        </div>
    </div>
</asp:PlaceHolder>

<script type="text/javascript">
    var contain = "";
    var visitDate = "<%=VisitDate%>";

    ('focus', function (ev) { ev.preventDefault(); });

    $(document).ready(function () {
        var patientMasterVisitId = <%=PatientMasterVisitId%>;
        var gender = "<%=Gender%>";

        $("#myWizard").on("actionclicked.fu.wizard", function (evt, data) {
            var currentStep = data.step;
            if (currentStep == 2) {
                if ($('#datastep2').parsley().validate() && gender == 'Female') {
                    var visitDate = "<%=VisitDate%>";
                    var screenedInLastOneYear = $("#ScreenedInLastOneYear").find("input[type=radio]:checked").siblings("label").text();
                    var referForScreening = $("#ReferForScreening").find("input[type=radio]:checked").siblings("label").text();

                    if (screenedInLastOneYear == "") {
                        toastr.error("Cervival cancer screening assessment is missing");
                        return false;
                    }

                    if (screenedInLastOneYear == "No" && referForScreening == "") {
                        toastr.error("Cervival cancer screening referral is missing");
                        return false;
                    }

                    addCxCaScreeningEncounter(visitDate);
                }
            }
        });

        function addCxCaScreeningEncounter(visitDate) {
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

            var error = 0;
            $("#CxCaScreening input[type=radio]:checked").each(function () {
                var screeningValue = $(this).val();
                var screeningType =  <%=ScreeningTypeId%>
                var patientId = <%=PatientId%>;
                var patientMasterVisitId = mastervisitid;
                var userId = <%=userId%>;
                var screeningCategory = $(this).attr('id').split('_')[0];
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
                toastr.success("Cervical Cancer Screening Asessment Saved");
            }
        }

        function showHideReferForScreening() {
            var screenedInThePastYearResponse = $("#ScreenedInLastOneYear").find("input[type=radio]:checked").siblings('label').text();

            if (screenedInThePastYearResponse == 'No') {
                $("#ReferForScreening").show();
                $("#ReferForScreening").find('input').attr('data-parsley-required', 'true');
            } else {
                $("#ReferForScreening").hide();
                $("#ReferForScreening").find('input').removeAttr('data-parsley-required');
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
                    $.each(itemList, function (index, patientScreening) {
                        $("#CxCaScreening input[type=radio][id*='" + patientScreening.ScreeningCategoryId + "'][value='" + patientScreening.ScreeningValueId + "']").prop('checked', true);
                    });

                    showHideReferForScreening();
                },
                error: function (response) {
                    toastr
                        .error("Error fetching Cervical Cancer Screening Assessment data <br/>" + response.d);
                }
            });

        }

        function init() {
            $("#ScreenedInLastOneYear").find('input').attr('data-parsley-required', 'true');

            // NOT VERY NECESARY FOR NOW
            if ($("#ScreenedInLastOneYear").find("input[type=radio]:checked").length == 0) {
                var screeningTypeId = "<%=CervicalCancerScreeningId%>";
                $.ajax({
                    type: "POST",
                    url: "../WebService/PatientScreeningService.asmx/GetScreeningByScreeningType",
                    data: "{'patientId':'" + patientId + "', 'screeningTypeId': '" + screeningTypeId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var itemList = JSON.parse(response.d);
                        if (itemList.length > 0) {
                            var screeningDate = itemList[0].ScreeningDate;
                            if (moment(screeningDate).isAfter(moment(new Date()).subtract(1, 'years'))) {
                                $("#ScreenedInLastOneYear").find("label").filter(function () {
                                    return $(this).text() == "Yes"
                                }).siblings("input").prop("checked", true);
                            } else {
                                $("#ScreenedInLastOneYear").find("label").filter(function () {
                                    return $(this).text() == "No"
                                }).siblings("input").prop("checked", true);
                            }
                        } else {
                            $("#ScreenedInLastOneYear").find("label").filter(function () {
                                return $(this).text() == "No"
                            }).siblings("input").prop("checked", true);
                        }

                        showHideReferForScreening();
                    },
                    error: function (response) {
                        toastr
                            .error("Error fetching Cervical Cancer Screening data <br/>" + response.d);
                    }

                });
            }
            // NOT VERY NECESSARY FOR NOW     
        }

        $("#ScreenedInLastOneYear").find("input[type=radio]").change(function () {

            showHideReferForScreening();

        });

        getPatientScreening(patientId, patientMasterVisitId);

        init();
    });

</script>
