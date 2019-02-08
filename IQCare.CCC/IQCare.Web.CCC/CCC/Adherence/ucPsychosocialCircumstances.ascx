﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucPsychosocialCircumstances.ascx.cs" Inherits="IQCare.Web.CCC.UC.Adherence.ucPsychosocialCircumstances" %>

<style>
    .notessection{display: none;}
</style>
<div class="col-md-12 form-group">
	<div class="col-md-12">
		<div class="panel panel-info">
			<div class="panel-body">
				<div class="col-md-12 form-group">
					<label class="control-label pull-left"><span class="text-primary">Psychosocial Circumstances</span></label>
				</div>

				<div class="col-md-12 form-group" id="psychosocialcircumstancessection">
					<asp:PlaceHolder ID="QuestionsPlaceholder" runat="server"></asp:PlaceHolder>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    var currentStep;
    var PCScreeningDataArray = new Array;
    //$("#abmyWizard").on("actionclicked.fu.wizard", function (evt, data) {
    //    currentStep = data.step;
    //    if (currentStep == 3) {

    //                 checkifUpdatePCScreeningDateHasValues();
    //                var values = Answers.filter((x) => {return x.value.length > 0})
    //                  if (values != null) {
    //                      if (values.length > 0) {
    //                          addUpdatePCScreeningData(mastervisitid);
    //                      }
    //                      else {
    //                          toastr.info("No data Saved since Fields are empty");
                               
    //                      }


    //       // addUpdatePCScreeningData();
    //    }
    //});

    function checkifUpdatePCScreeningDateHasValues() {

        $("#psychosocialcircumstancessection input[type=radio]:checked").each(function () {
            var screeningValue = $(this).val();
            var screeningCategory = $(this).closest("table").attr('id');
            var screeningType = <%=screenTypeId%>;
            var patientId = <%=PatientId%>;
            var patientMasterVisitId = <%=PatientMasterVisitId%>;
            var userId = <%=userId%>;

            if (screeningValue > 0) {
                    PCScreeningDataArray.push({ 'Id': screeningCategory, 'value': screeningValue });
            }
        });

        $("#psychosocialcircumstancessection textarea").each(function () {
            var categoryId = ($(this).attr('id')).replace('notes', '');
            var patientId = <%=PatientId%>;
            var patientMasterVisitId = mastervisitid;
            var clinicalNotes = $(this).val();
            var serviceAreaId = 203;
            var userId = <%=userId%>;
            PCScreeningDataArray.push({ 'Id': categoryId, 'value': clinicalNotes });

        });
    }

    function addUpdatePCScreeningData(mastervisitid)
    {
        var error = 0;
        $("#psychosocialcircumstancessection input[type=radio]:checked").each(function () {
            var screeningValue = $(this).val();
            var screeningCategory = $(this).closest("table").attr('id');
            var screeningType = <%=screenTypeId%>;
            var patientId = <%=PatientId%>;
            var patientMasterVisitId = mastervisitid;
            var userId = <%=userId%>;
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
        $("#psychosocialcircumstancessection textarea").each(function () {
            var categoryId = ($(this).attr('id')).replace('notes','');
            var patientId = <%=PatientId%>;
            var patientMasterVisitId = mastervisitid;
            var clinicalNotes = $(this).val();
            var serviceAreaId = 203;
            var userId = <%=userId%>;
            $.ajax({
                type: "POST",
                url: "../WebService/PatientClinicalNotesService.asmx/addPatientClinicalNotes",
                data: "{'patientId': '" + patientId + "','patientMasterVisitId': '" + patientMasterVisitId + "','serviceAreaId':'" + serviceAreaId + "','notesCategoryId':'" + categoryId + "','clinicalNotes':'" + clinicalNotes + "','userId':'" + userId + "'}",
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
            toastr.success("Psychosocial Circumstances Saved");
        }
    }


    $("#psychosocialcircumstancessection input:radio").change(function (evt,data) {
        var radioButtons = $("input[type='radio']");
        var selectedValue = $(this).val();
        var selectedIndex = radioButtons.index(radioButtons.filter(':checked'));
        var parentPanel = $(this).parent().closest('.row').attr('id').split(' ');
        var rbName = $(this).attr('name');
        showhidenotes(parentPanel, selectedValue, rbName);
    });

    function showhidenotes(parentPanel, selectedValue, rbName)
    {
        var radioButtons = $("#psychosocialcircumstancessection input[name='" + rbName + "']");
        var selectedIndex = radioButtons.index(radioButtons.filter(':checked'));
        if (selectedIndex == 0)
        {
            $("#" + parentPanel + " > .notessection").show();
        }
        else {
            $("#" + parentPanel + " > .notessection").hide();
        }
        
    }

    function GetPyschosocialPatientNotesandScreening() {

      var patientId = <%=PatientId%>;
       $.ajax({
            type: "POST",
            url: "../WebService/PatientClinicalNotesService.asmx/getPatientNotes",
            data: "{'PatientId': '" + patientId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            cache: false,
            success: function (response) {
                //alert(JSON.stringify(response));
                 var res = JSON.parse(response.d);
                if (res != null) {
                    $.each(JSON.parse(response.d), function (index, value) {
                        inputnotes = this.ClinicalNotes;
                        if ($("#notes" + this.NotesCategoryId).length > 0) {
                            $("#notes" + this.NotesCategoryId).val(inputnotes);
                        }
                    });
                }
            },
            error: function (response) {
                toastr.error("Notes could not be loaded");
            }
        });
        $.ajax({
            type: "POST",
            url: "../WebService/PatientScreeningService.asmx/getPatientScreening",
            data: "{'PatientId': '" + patientId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            cache: false,
            success: function (response) {
                var res = JSON.parse(response.d);
                if (res != null) {
                    $.each(JSON.parse(response.d), function (index, value) {
                        if ($("#" + this.ScreeningCategoryId).length > 0) {
                            var radioBtns = "#" + this.ScreeningCategoryId;
                            $(radioBtns + " input:radio[value='" + this.ScreeningValueId + "']").attr("checked", true);
                        }
                    });
                }
                checkPCButtonsOnCtrls();
            },
            error: function (response) {
                toastr.error("Screening could  not be loaded");
            }
        }); 

    }
    $(document).ready(function () {
       //  $('.awarenessloading').show();
        GetPyschosocialPatientNotesandScreening();
        
        
    });
    function checkPCButtonsOnCtrls() {
        $("#abdatastep3 input[type=radio]:checked").each(function () {
            var selectedValue = $(this).val();
            var rbName = $(this).attr('name');
            var parentPanel = $(this).parent().closest('.row').attr('id');
            showhidenotes(parentPanel, selectedValue, rbName);
        });
    }
    jQuery(function ($) {
        var PCId = <%=PCId%>;
            $('#abmyWizard').wizard();
            $('#abmyWizard').find('#dsSectionThree').toggleClass('complete', true);
            $('#abmyWizard').on('changed.fu.wizard', function (evt, data) {
                $('#abmyWizard').find('#dsSectionThree').toggleClass('complete', true);
            });
        }
    });
</script>