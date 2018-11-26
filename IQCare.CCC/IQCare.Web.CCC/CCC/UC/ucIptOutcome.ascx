<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucIptOutcome.ascx.cs" Inherits="IQCare.Web.CCC.UC.ucIptOutcome" %>

<div class="col-md-12 form-group">
    <div class="col-md-12 form-group">
        <div class="col-md-12">
            <div class="col-md-12">
                <label class="control-label pull-left">Event</label>
            </div>
            <div class="col-md-12">
                <asp:DropDownList runat="server" AutoPostBack="False" CssClass="form-control input-sm" ID="iptEvent" ClientIDMode="Static" onclick="IptOutcomeEvent();" />
            </div>
        </div>
        <div class="col-md-12">
            <div class="col-md-12">
                <label class="control-label pull-left">Reason For Discontinuation</label>
            </div>
            <div class="col-md-12">
                  <asp:DropDownList runat="server" AutoPostBack="False" CssClass="form-control input-sm" ID="iptDiscontinuationReason" ClientIDMode="Static" onclick="IptDiscontinuationReasonEvent();" />
            </div>
            <div class="col-md-12">
                <label class="control-label pull-left">Specify, if other </label>
                <asp:TextBox runat="server" AutoPostBack="False" CssClass="form-control input-sm" ID="discontinuation" ClientIDMode="Static" />
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        getIptOutcome();

        if ($("#<%=discontinuation.ClientID%>").val() === '') {
            $("#<%=discontinuation.ClientID%>").prop('disabled', true);
        }

        if ($("#<%=iptDiscontinuationReason.ClientID%>").val() === '') {
            $("#<%=iptDiscontinuationReason.ClientID%>").prop('disabled', true);
        }
        
    });

    function IptOutcomeEvent() {
        if ($("#iptEvent :selected").text() === "Discontinued") {
            $("#<%=iptDiscontinuationReason.ClientID%>").prop('disabled', false);
        } else {
            $("#<%=discontinuation.ClientID%>").prop('disabled', true);
            $("#<%=iptDiscontinuationReason.ClientID%>").prop('disabled', true);
        }
    }

    function IptDiscontinuationReasonEvent() {
        if ($("#<%=iptDiscontinuationReason.ClientID%> :selected").text() === "Other") {
            $("#<%=discontinuation.ClientID%>").prop('disabled', false);
        } else {
            $("#<%=discontinuation.ClientID%>").prop('disabled', true);
            $("#<%=discontinuation.ClientID%>").val('');
        }
    }

    function getIptOutcome() {
        
        var iptEvent = $("#iptEvent").val();
        var reasonForDiscontinuation = $("#discontinuation").val();
        var patientId = <%=PatientId%>;
        var patientMasterVisitId = <%=PatientMasterVisitId%>;
        $.ajax({
            type: "POST",
            url: "../WebService/PatientTbService.asmx/GetPatientIptOutcome",
            data: "{'patientId': '" + patientId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d !== null) {
                    var ipt = JSON.parse(response.d);
                    $('#iptEvent').val(ipt.IptEvent);
                    $("#<%=discontinuation.ClientID%>").val(ipt.ReasonForDiscontinuation)
                    $("#<%=iptDiscontinuationReason.ClientID%>").val(ipt.IptDiscontinuationReason)
                }
            },
            error: function (response) {
                toastr.error(response.d, "Unable to fetch IPT Outcome");
            }
        });

    }

</script>
