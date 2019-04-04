<%@ Page Title="" Language="C#" MasterPageFile="~/CCC/Greencard.Master" AutoEventWireup="true" CodeBehind="PatientClinicalReviewSummary.aspx.cs" Inherits="IQCare.Web.CCC.CaseSummary.PatientClinicalSummary" %>

<%@ Register Src="~/CCC/UC/ucPatientClinicalReviewSumary.ascx" TagPrefix="IQ" TagName="ucClinicalReviewSumary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="IQCareContentPlaceHolder" runat="server">
    <IQ:ucClinicalReviewSumary runat="server" id="ucClinicalReviewSumary" />
</asp:Content>
