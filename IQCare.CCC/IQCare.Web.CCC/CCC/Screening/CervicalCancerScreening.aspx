<%@ Page Title="" Language="C#" MasterPageFile="~/CCC/Greencard.Master" AutoEventWireup="true" CodeBehind="CervicalCancerScreening.aspx.cs" Inherits="IQCare.Web.CCC.Screening.CervicalCancerScreening" %>

<%@ Register TagPrefix="uc" TagName="tnCxCaScreening" Src="~/CCC/UC/Screening/ucCervicalCancerScreening.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <style>
        .control-label {
            text-align: left !important;
        }
    </style>
    <div class="col-md-12" style="padding-top: 20px">
        <div class="col-md-12">
            <div class="wizard" data-initialize="wizard" id="myWizard">
                <div class="steps-container">
                    <ul class="steps">
                        <li data-step="1" id="dsSectionOne" data-name="template" class="active complete">
                            <span class="badge">1</span>Cervical Cancer Screening
							<span class="chevron"></span>
                        </li>
                    </ul>
                </div>
                <div class="step-content">
                    <div class="step-pane active sample-pane" id="datastep1" data-parsley-validate="true" data-show-errors="true" data-step="1">
                        <div class="col-md-12 form-group">
                            <uc:tnCxCaScreening ID="CervicalCancerScreeningScreeningPanel" runat="server" />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
