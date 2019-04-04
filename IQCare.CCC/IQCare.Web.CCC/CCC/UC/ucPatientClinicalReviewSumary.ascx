<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucPatientClinicalReviewSumary.ascx.cs" Inherits="IQCare.Web.CCC.UC.ucClinicalReviewSumary" %>
<link href="https://fonts.googleapis.com/css?family=EB+Garamond" rel="stylesheet" />
<style type="text/css">
    #clinical-summary {
        font-family: 'EB Garamond', serif !important;
    }
</style>
<div id="clinical-summary">
    <div class="row">
        <div class="col-md-12" style="text-align: center">
            <h2>Adolescent Clinical Review Checklist</h2>
        </div>
    </div>
    <div class="row">
        <label class="label-text" style="text-align: left;">Date of review:</label>
        <input type="date" name="reviewDate" id="review-date">
    </div>
    <div class="row">
        <div class="col-md-2">
            <label>Unique No (CCC No.): </label>
            <span id="ccc-number"></span>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label class="label-text">Name:</label>
            <span id="name"></span>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3">
            <label class="label-text">Sex:</label>
             <span id="sex"></span>
        </div>
        <div class="col-md-3">           
        </div>
        <div class="col-md-3">
            <label class="control-label label-text">Date of Birth:</label>
            <span id="dob"></span>
        </div>
        <div class="col-md-3">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h3>BMI</h3>
        </div>
        <div class="col-md-12">
            <table class="table" id="vitals">
                <thead>
                    <tr>
                        <th>Review Date:</th>
                        <th>Weight (kg):</th>
                        <th>Height (cm):</th>
                        <th>BMI</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h3>Regimen</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <label class="label-text">Current ART regimen</label>
            <span id="regimen"></span>
        </div>
        <div class="col-md-6">
            <label class="label-text">Start Date:</label>
            <span id="regimen-date"></span>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <strong>Previous ART regimen</strong>
        </div>
        <div class="col-md-12">
            <table class="table" id="prev-art">
                <thead>
                    <tr>
                        <th>Switch/Substitution Dates:</th>
                        <th>Regimen</th>
                        <th>Reasons for change</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h3>Baseline CD4 Test:</h3>
        </div>
        <div class="col-md-12">
            <table class="table" id="cd4">
                <thead>
                    <tr>
                        <th>Sample Date</th>
                        <th>Results</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h3>Drug Resistance Testing</h3>
        </div>
        <div class="col-md-12">
            <table class="table" id="drt">
                <thead>
                    <tr>
                        <th>Sample Date  </th>
                        <th>Results</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <input type="date" class="form-control" name="drt-date" id="drt-date"></td>
                        <td>
                            <label class="radio-inline">
                                <input type="radio" name="drt-result" value="1">Resistance Mutation detected</label>
                            <label class="radio-inline">
                                <input type="radio" name="drt-result" value="0">Resistance Mutation not detected</label>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h3>IPT</h3>
        </div>
        <table class="table" id="ipt">
            <thead>
                <tr>
                    <th>Start Date  </th>
                    <th>IPT Outcome</th>
                    <th>Date of Outcome</th>
                    <th>Reasons (<em>for discontinuation</em>)
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table">
                <tbody></tbody>
                <thead>
                    <tr>
                        <th width="171">Investigations
                        </th>
                        <th width="171">Done/Not Done:
                        </th>
                        <th width="149">Result:
                        </th>
                        <th width="161">Date of result:
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td width="171">
                            <p>Hb (last)</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="hb" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="hb" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <input type="text" class="form-control" id="hb-result">
                            G/dl
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="hb-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Creatinine (last)</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="creatinine" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="creatinine" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <input type="text" class="form-control" id="creatinine-result">umol/L
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="creatinine-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>ALT (last)</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="alt" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="alt" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <input type="text" class="form-control" id="alt-result">IU
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="alt-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>HBsAg</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="hbsag" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="hbsag" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <label class="radio-inline">
                                <input type="radio" name="hb-result" id="hb-result-p" value="1">Positive</label>
                            <label class="radio-inline">
                                <input type="radio" name="hb-result" id="hb-result-n" value="0">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="hbsag-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>VDRL</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="vdrl" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="vdrl" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <label class="radio-inline">
                                <input type="radio" name="vdrl-result" id="vdrl-result-p" value="1">Positive</label>
                            <label class="radio-inline">
                                <input type="radio" name="vdrl-result" id="vdrl-result-n" value="0">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="vdrl-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Cr Ag if CD4 &lt; 100</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="crag" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="crag" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <label class="radio-inline">
                                <input type="radio" name="crag-result" id="crag-result-p" value="1">Positive</label>
                            <label class="radio-inline">
                                <input type="radio" name="crag-result" id="crag-result-n" value="0">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="crcag-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>TB LAM if CD4 &lt; 200</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="tblam" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="tblam" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <p></p>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="tblam-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Deworming</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="deworming" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="deworming" value="0">Not done</label>
                        </td>
                        <td width="149"></td>
                        <td width="161">
                            <input type="date" class="form-control" id="deworming-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Depression screening</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="depression-screening" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="depression-screening" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <label class="radio-inline">
                                <input type="radio" name="depression-screening-result" id="depression-screening-result-p" value="1">Positive</label>
                            <label class="radio-inline">
                                <input type="radio" name="depression-screening-result" id="depresion-screening-result-n" value="0">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="depression-screening-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>CaCx screening</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="cacx-screening" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="cacx-screening" value="0">Not done</label>
                        </td>
                        <td width="149">
                            <label class="radio-inline">
                                <input type="radio" name="cacx-screening-result" id="cacx-sceening-result-p" value="1">Positive</label>
                            <label class="radio-inline">
                                <input type="radio" name="cacx-screening-result" id="cacx-screening-result-n" value="0">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="cacx-screening-date">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Dental review</p>
                        </td>
                        <td width="171">
                            <label class="radio-inline">
                                <input type="radio" name="dental-review" value="1">Done</label>
                            <label class="radio-inline">
                                <input type="radio" name="dental-review" value="0">Not done</label>
                        </td>
                        <td width="149"></td>
                        <td width="161">
                            <input type="date" class="form-control" id="dental-review-date">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h3>Recommendations</h3>
        </div>
        <div class="col-md-12">
            <textarea class="form-control" id="recommendation" rows="6"></textarea>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 pull-right">
            <input type="button" value="Save" class="btn btn-primary btn-lg">
        </div>
    </div>
</div>
<script type="text/javascript">
    $().ready(function () {
        var patientId = <%=PatientId%>;
        getClinicalSummary(patientId);

        function getClinicalSummary(patientId) {
            $.ajax({
                type: "POST",
                url: "../WebService/PatientClinicalSummaryService.asmx/GetPatientClinicalSummary",
                data: "{'patientId':'" + patientId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //toastr.success(response.d);
                    //console.log(response.d)
                    var clinicalSummary = response.d;

                    $("sex").text(clinicalSummary.sex);
                    $("ccc-number").text(clinicalSummary.cccNumber);
                    $("name").text(clinicalSummary.patientName);
                    $("dob").text(clinicalSummary.dob);

                    var currentRegimen = clinicalSummary.currRegimen;
                    $("#regimen") = currentRegimen.regimen;
                    $("#regimen-date") = currentRegimen.regimenDate;

                    var vitals = clinicalSummary.vitals;
                    fillTableWithArrayValues(vitals, $("table#vitals tbody"));

                    var prevArt = clinicalSummary.prevArt;
                    fillTableWithArrayValues(prevArt, $("table#prev-art tbody"));

                    var cd4 = clinicalSummary.cd4;
                    fillTableWithArrayValues(cd4, $("table#cd4 tbody"));

                    var drt = clinicalSummary.drt;
                    fillTableWithArrayValues(drt, $("table#drt tbody"));

                    var ipt = clinicalSummary.ipt;
                    fillTableWithArrayValues(ipt, $("table#ipt tbody"));

                    var vl = clinicalSummary.vl;
                    fillTableWithArrayValues(vl, $("table#vl tbody"));

                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message);
                }
            });

            function fillTableWithArrayValues(array, table) {
                $.each(vitals, function (i, o) {

                    var tr = $("<tr/>");
                    $.each(o, function (i, o) {
                        tr.append($("<td/>").html(o));
                    });

                    table.append(tr);

                });
            }

            function savePatientClinicalReviewSummary() {
                var patientId = "";
                var patientMastervisitId = "";
                var reviewDate = $("#review-date").val();
                var drtDate = $("#drt-date").val();
                var drtResult = $("input[name=drt-result]:checked").val();
                var hbDate = $("#hb-date").val();
                var hb = $("input[name=hb]:checked").val();
                var hbResult = $("input[name=hb-result]:checked").val();
                var creatinineDate = $("#creatinine-date").val();
                var creatinine = $("input[name=creatinine]:checked").val();
                var creatinineResult = $("input[name=creatinine-result]:checked").val();
                var altDate = $("#alt-date").val();
                var alt = $("input[name=alt]:checked").val();
                var altResult = $("input[name=alt-result]:checked").val();
                var hbsagDate = $("#hbsag-date").val();
                var hbsag = $("input[name=hbsag]:checked").val();
                var hbsagResult = $("input[name=hbsag-result]:checked").val();
                var vdrlDate = $("#vdrl-date").val();
                var vdrl = $("input[name=vdrl]:checked").val();
                var vdrlResult = $("input[name=vdrl-result]:checked").val();
                var cragDate = $("#crag-date").val();
                var crag = $("input[name=crag]:checked").val();
                var cragResult = $("input[name=crag-result]:checked").val();
                var cacxScreeningDate = $("#cacx-screening-date").val();
                var cacxScreening = $("input[name=cacx-screening]:checked").val();
                var cacxScreeningResult = $("input[name=cacx-screening-result]:checked").val();
                var depressionScreeningDate = $("#depression-screening-date").val();
                var depressionScreening = $("input[name=depression-screening]:checked").val();
                var depressionScreeningResult = $("input[name=depression-screening-result]:checked").val();
                var tbLamDate = $("#tblam-date").val();
                var tbLam = $("input[name=tblam]:checked").val();
                var dewormingDate = $("#deworming-date").val();
                var deworming = $("input[name=deworming]:checked").val();
                var dentalReviewDate = $("#dental-review-date").val();
                var dentalReview = $("input[name=dental-review]:checked").val();
                var recommendations = $("#recommendations").val();
                //var createdBy = $("input[name=creatinine]:checked").val();
                //var createDate = $("input[name=creatinine-result]:checked").val();


                var paramValues = [];
                paramValues.push({PatientMasterVisitId: patientMasterVisitId});
                paramValues.push({ PatientId: patientId });
                paramValues.push({ ReviewDate: reviewDate });
                paramValues.push({ DrtDate: drtDate });
                paramValues.push({ DrtResult: drtResult });
                paramValues.push({ HBDone: hb });
                paramValues.push({ HBDate: hbDate });
                paramValues.push({ HBResult: hbResult });
                paramValues.push({ CreatinineDone: creatinine });
                paramValues.push({ CreatinineDate: creatinineDate });
                paramValues.push({ CreatinineResult: creatinineResult });

                paramValues.push({ HBDone: hb });

            }

        }
    });
</script>
