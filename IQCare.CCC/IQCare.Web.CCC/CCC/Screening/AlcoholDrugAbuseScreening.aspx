﻿<%@ Page Title="" Language="C#" MasterPageFile="~/CCC/Greencard.Master" AutoEventWireup="true" CodeBehind="AlcoholDrugAbuseScreening.aspx.cs" Inherits="IQCare.Web.CCC.Screening.AlcoholDrugAbuseScreening" %>
<%@ Register TagPrefix="uc" TagName="tnCAGEAIDScreening" Src="~/CCC/UC/Depression/ucCAGEAID.ascx" %>
<%@ Register TagPrefix="uc" TagName="tnCRAFFTScreening" Src="~/CCC/UC/Depression/ucCRAFFT.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
      <style>
        .control-label{text-align: left !important;}
    </style>
     <div class="col-md-12" style="padding-top: 20px">
        <div class="col-md-12" id="Menu">
            <div class="wizard" data-initialize="wizard" id="myWizard" >
                <div class="steps-container">
                    <ul class="steps">
					    <li data-step="1" id="dsSectionOne" data-name="template" class="active complete">
						    <span class="badge">1</span>Alcohol and Drug Use Screening
							<span class="chevron"></span>
					    </li>
					   
					   
				    </ul>
                </div>
                <div class="step-content">
                    <div class="step-pane active sample-pane" id="datastep1" data-parsley-validate="true" data-show-errors="true" data-step="1">
                         <div class="col-md-12 form-group">
                            <asp:PlaceHolder ID="PHAlcoholSection" runat="server"></asp:PlaceHolder>
                        </div>
                    </div>
                    
                    
                   <%-- <div id="prevNextButton" class="actions">
					    <button type="button" class="btn btn-default btn-prev">
						    <span class="glyphicon glyphicon-arrow-left"></span>
                            Prev
					    </button>
					    <button type="button" class="btn btn-primary btn-next" data-last="Complete">
						    Next
						   <%-- <span class="glyphicon glyphicon-arrow-right"></span>
					    </button>
				    </div>--%>
                </div>
                
            </div>
        </div>
    </div>
    <script type="text/javascript">      
        $(document).ready(function () {
            var age = "<%=age%>";
            if (age < 9) {
                $('#Menu').hide();
            }
            else {
                $('#Menu').show();
            }
        });
    </script>
</asp:Content>