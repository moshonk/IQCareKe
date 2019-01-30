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
    var Answers = new Array;
    var visitDate = "<%=VisitDate%>";

    ('focus', function (ev) { ev.preventDefault(); });

    $(document).ready(function () {
        $("#myWizard").on("actionclicked.fu.wizard", function (evt, data) {
            var currentStep = data.step;
            if (currentStep == 2) {
                var visitDate = "<%=VisitDate%>";

                checkifFieldsHavevalue();
                var values = Answers.filter((x) => { return x.value.length > 0 })
                if (values != null) {
                    if (values.length > 0) {
                        addCxCaScreeningEncounter(visitDate);
                    }
                    else {
                        toastr.error("Cervival cancer screening assessment is missing");
                        return false;
                    }
                }
            }
        });

        function checkifFieldsHavevalue() {
            $("#CxCaScreening input[type=radio]:checked").each(function () {
                var screeningValue = $(this).val();
                var screeningCategory = $(this).attr('itemid');

                if (screeningValue > 0) {
                    Answers.push({ 'Id': screeningCategory, 'value': screeningValue });
                }
            });
        }

        function addCxCaScreeningEncounter(visitDate) {
            var patientId = <%=PatientId%>;
            var ServiceAreaId = 203;
            var EncounterType = "CxCaScreening";
            var userId = <%=userId%>;
            var patientMasterVisitId = <%=PatientMasterVisitId%>;
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
                toastr.success("Cervical Cancer Screening Asessment Saved");
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
                        .error("Error fetching Cervical Cancer Screening Assessment data <br/>" + response.d);
                }
            });

        }

        $("#ScreenedInLastOneYear").find("input[type=radio]").change(function () {
            console.log($(this).val() + $(this).siblings('label').text());
            if ($(this).is(':checked') && $(this).siblings('label').text() == 'Yes') {
                $("#ReferForScreening").hide();
            } else {
                $("#ReferForScreening").show();
            }
        });

        $("#ReferForScreening").hide();

    });

</script>
