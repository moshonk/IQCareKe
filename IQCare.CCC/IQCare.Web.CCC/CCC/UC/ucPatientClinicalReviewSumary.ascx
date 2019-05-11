<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucPatientClinicalReviewSumary.ascx.cs" Inherits="IQCare.Web.CCC.UC.ucClinicalReviewSumary" %>
<link href="https://fonts.googleapis.com/css?family=EB+Garamond" rel="stylesheet" />
<style type="text/css">
    #clinical-summary {
        font-family: 'EB Garamond', serif !important;
    }

        #clinical-summary h1, #clinical-summary h2, #clinical-summary h3, #clinical-summary h4, #clinical-summary label, #clinical-summary th, #clinical-summary td {
            font-family: 'EB Garamond', serif !important;
            color: #000000;
        }

        #clinical-summary h3 {
            background-color: #e4e4e4;
        }

        #clinical-summary label.inline-radio {
            font-weight: normal
        }

        #clinical-summary div[class^=col-] {
            text-align: left;
        }

        #clinical-summary .error {
            border: 1px solid #f2a696;
        }
</style>
<div class="row">
    <button class="btn btn-md btn-info pull-right" id="btn-history">Show/Hide review history</button>
</div>
<div id="clinical-summary" data-show-errors="true" class="col-md-9">
    <div class="row">
        <div class="col-md-12" style="text-align: center">
            <h2>Adolescent Clinical Review Checklist</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label class="label-text" style="text-align: left;">Date of review:</label>
            <input type="date" name="reviewDate" id="review-date" max="<%=Today%>">
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <label>Unique No (CCC No.): </label>
            <span id="ccc-number"></span>
        </div>
        <div class="col-md-6">
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
            <h4>Previous ART regimen</h4>
        </div>
        <div class="col-md-12">
            <table class="table" id="prev-art">
                <thead>
                    <tr>
                        <th>Regimen</th>
                        <th>Switch/Substitution Dates</th>
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
            <table class="table">
                <tbody>
                    <tr>
                        <td>
                            <input type="date" class="form-control" name="drt-date" id="drt-date" max="<%=Today%>"></td>
                        <td>
                            <label class="inline-radio">
                                <input type="radio" name="drt-result" value="1" class="result" id="drt-result-d" required="">Resistance Mutation detected</label>
                            <label class="inline-radio">
                                <input type="radio" name="drt-result" value="0" class="result" id="drt-result-nd">Resistance Mutation not detected</label>
                        </td>
                    </tr>
                </tbody>            
            </table>
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
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h3>IPT</h3>
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
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table" id="investigations">
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
                            <label class="inline-radio">
                                <input type="radio" name="hb" value="1" class="status" id="hb-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="hb" value="0" class="status" id="hb-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="hb" value="-1" class="status" id="hb-na">Not appllicable</label>
                        </td>
                        <td width="149">
                            <input type="number" class="form-control result" id="hb-result">
                            G/dl
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="hb-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Creatinine (last)</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="creatinine" value="1" class="status" id="creatinine-d">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="creatinine" value="0" class="status" id="creatinine-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="creatinine" value="-1" class="status" id="creatinine-na">Not applicable</label>
                        </td>
                        <td width="149">
                            <input type="number" class="form-control result" id="creatinine-result">umol/L
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="creatinine-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>ALT (last)</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="alt" value="1" class="status" id="alt-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="alt" value="0" class="status" id="alt-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="alt" value="-1" class="status" id="alt-na">Not applicable</label>
                        </td>
                        <td width="149">
                            <input type="number" class="form-control result" id="alt-result">IU
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="alt-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>HBsAg</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="hbsag" value="1" class="status" id="hbsag-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="hbsag" value="0" class="status" id="hbsag-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="hbsag" value="-1" class="status" id="hbsag-na">Not applicable</label>
                        </td>
                        <td width="149">
                            <label class="inline-radio">
                                <input type="radio" name="hbsag-result" class="result" id="hbsag-result-p" value="1">Positive</label>
                            <label class="inline-radio">
                                <input type="radio" name="hbsag-result" class="result" id="hbsag-result-n" value="0">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="hbsag-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>VDRL</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="vdrl" value="1" class="status" id="vdrl-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="vdrl" value="0" class="status" id="vdrl-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="vdrl" value="-1" class="status" id="vdrl-na">Not applicable</label>
                        </td>
                        <td width="149">
                            <label class="inline-radio">
                                <input type="radio" name="vdrl-result" id="vdrl-result-p" value="1" class="result">Positive</label>
                            <label class="inline-radio">
                                <input type="radio" name="vdrl-result" id="vdrl-result-n" value="0" class="result">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="vdrl-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Cr Ag if CD4 &lt; 100</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="crag" class="status" value="1" id="crag-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="crag" class="status" value="0" id="crag-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="crag" class="status" value="-1" id="crag-na">Not applicable</label>
                        </td>
                        <td width="149">
                            <label class="inline-radio">
                                <input type="radio" name="crag-result" id="crag-result-p" value="1" class="result">Positive</label>
                            <label class="inline-radio">
                                <input type="radio" name="crag-result" id="crag-result-n" value="0" class="result">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="crag-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>TB LAM if CD4 &lt; 200</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="tblam" value="1" class="status" id="tblam-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="tblam" value="0" class="status" id="tblam-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="tblam" value="-1" class="status" id="tblam-na">Not applicable</label>
                        </td>
                        <td width="149">
                            <p></p>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="tblam-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Deworming</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="deworming" value="1" class="status" id="deworming-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="deworming" value="0" class="status" id="deworming-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="deworming" value="-1" class="status" id="deworming-na">Not applicable</label>
                        </td>
                        <td width="149"></td>
                        <td width="161">
                            <input type="date" class="form-control" id="deworming-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Depression screening</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="depression-screening" class="status" value="1" id="depression-screening-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="depression-screening" class="status" value="0" id="depression-screening-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="depression-screening" class="status" value="-1" id="depression-screening-na">Not applicable</label>
                        </td>
                        <td width="149">
                            <label class="inline-radio">
                                <input type="radio" name="depression-screening-result" id="depression-screening-result-p" value="1" class="result">Positive</label>
                            <label class="inline-radio">
                                <input type="radio" name="depression-screening-result" id="depresion-screening-result-n" value="0" class="result">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="depression-screening-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>CaCx screening</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="cacx-screening" value="1" class="status" id="cacx-screening-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="cacx-screening" value="0" class="status" id="cacx-screening-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="cacx-screening" value="-1" class="status" id="cacx-screening-na">Not applicable</label>
                        </td>
                        <td width="149">
                            <label class="inline-radio">
                                <input type="radio" name="cacx-screening-result" id="cacx-sceening-result-p" value="1" class="result">Positive</label>
                            <label class="inline-radio">
                                <input type="radio" name="cacx-screening-result" id="cacx-screening-result-n" value="0" class="result">Negative</label>
                        </td>
                        <td width="161">
                            <input type="date" class="form-control" id="cacx-screening-date" max="<%=Today%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="171">
                            <p>Dental review</p>
                        </td>
                        <td width="171">
                            <label class="inline-radio">
                                <input type="radio" name="dental-review" value="1" class="status" id="dental-review-d" required="">Done</label>
                            <label class="inline-radio">
                                <input type="radio" name="dental-review" value="0" class="status" id="dental-review-nd">Not done</label>
                            <label class="inline-radio">
                                <input type="radio" name="dental-review" value="-1" class="status" id="dental-review-na">Not applicable</label>
                        </td>
                        <td width="149"></td>
                        <td width="161">
                            <input type="date" class="form-control" id="dental-review-date" max="<%=Today%>">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h4>Recommendations</h4>
        </div>
        <div class="col-md-12">
            <textarea class="form-control" id="recommendations" rows="6"></textarea>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 pull-left">
            <a href="#" class="btn btn-info fa fa-plus-circle btn-lg" id="btnSave">Save </a>
        </div>
        <div class="col-md-6 pull-right">
            <a href="#" class="btn btn-warning fa fa-plus-circle btn-lg" id="btnClose">Close</a>
        </div>
    </div>
</div>
<div id="clinical-review-history" class="col-md-3">
    <div class="row">
        <div class="col-md-12">
            <h3>Clinical review history
            </h3>
        </div>
    </div>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Review Date</th>
                <th>Provider</th>
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
<script type="text/javascript">
    $().ready(function () {
        $("body").removeClass("fuelux");
        toggleShowHistory();

        var patientId = <%=PatientId%>;
        getClinicalReviewHistory(patientId);
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
                    var clinicalSummary = JSON.parse(response.d);

                    $("#sex").text(clinicalSummary.sex);
                    $("#ccc-number").text(clinicalSummary.cccNumber);
                    $("#name").text(clinicalSummary.patientName);
                    $("#dob").text(clinicalSummary.dob);

                    var currentRegimen = clinicalSummary.currRegimen;
                    $("#regimen").text(currentRegimen.regimen);
                    $("#regimen-date").text(currentRegimen.regimenDate);

                    var vitals = clinicalSummary.vitals;
                    fillTableWithArrayValues(vitals, $("table#vitals tbody"));

                    var prevArt = clinicalSummary.prevArt;
                    fillTableWithArrayValues(prevArt, $("table#prev-art tbody"));

                    var cd4 = clinicalSummary.cd4History;
                    fillTableWithArrayValues(cd4, $("table#cd4 tbody"));

                    var drt = clinicalSummary.drtHistory;
                    fillTableWithArrayValues(drt, $("table#drt tbody"));

                    var ipt = clinicalSummary.iptHistory;
                    fillTableWithArrayValues(ipt, $("table#ipt tbody"));

                    var vl = clinicalSummary.vlHistory;
                    fillTableWithArrayValues(vl, $("table#vl tbody"));

                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message);
                }
            });
        }

        function getClinicalReviewHistory(patientId) {
            $.ajax({
                type: "POST",
                url: "../WebService/PatientClinicalSummaryService.asmx/GetPatientClinicalReviewHistory",
                data: "{'patientId':'" + patientId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //toastr.success(response.d);
                    var clinicalReviewHistory = JSON.parse(response.d);

                    fillTableWithArrayValues(clinicalReviewHistory.crHistory, $("div#clinical-review-history table tbody"));

                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message);
                }
            });
        }

        function fillTableWithArrayValues(array, table) {
            table.children("tr").remove();
            $.each(array, function (i, o) {

                var tr = $("<tr/>");
                $.each(o, function (i, o) {
                    tr.append($("<td/>").html(o));
                });

                table.append(tr);

            });
        }

        function savePatientClinicalReviewSummary() {
            var patientId = "<%=PatientId%>";
            var patientMasterVisitId = "<%=PatientMasterVisitId%>";
            var reviewDate = $("#review-date").val();
            var drtDate = $("#drt-date").val();
            var drtResult = $("input[name=drt-result]:checked").val() == undefined ? '' : $("input[name=drt-result]:checked").val();
            var hbDate = $("#hb-date").val();
            var hb = $("input[name=hb]:checked").val();
            var hbResult = $("input#hb-result").val();
            var creatinineDate = $("#creatinine-date").val();
            var creatinine = $("input[name=creatinine]:checked").val();
            var creatinineResult = $("input#creatinine-result").val();
            var altDate = $("#alt-date").val();
            var alt = $("input[name=alt]:checked").val();
            var altResult = $("input#alt-result").val();
            var hbsagDate = $("#hbsag-date").val();
            var hbsag = $("input[name=hbsag]:checked").val();
            var hbsagResult = $("input[name=hbsag-result]:checked").val() == undefined ? '' : $("input[name=hbsag-result]:checked").val();
            var vdrlDate = $("#vdrl-date").val();
            var vdrl = $("input[name=vdrl]:checked").val();
            var vdrlResult = $("input[name=vdrl-result]:checked").val() == undefined ? '' : $("input[name=vdrl-result]:checked").val();
            var cragDate = $("#crag-date").val();
            var crag = $("input[name=crag]:checked").val();
            var cragResult = $("input[name=crag-result]:checked").val() == undefined ? '' : $("input[name=crag-result]:checked").val()
            var cacxScreeningDate = $("#cacx-screening-date").val();
            var cacxScreening = $("input[name=cacx-screening]:checked").val();
            var cacxScreeningResult = $("input[name=cacx-screening-result]:checked").val() == undefined ? '' : $("input[name=cacx-screening-result]:checked").val()
            var depressionScreeningDate = $("#depression-screening-date").val();
            var depressionScreening = $("input[name=depression-screening]:checked").val();
            var depressionScreeningResult = $("input[name=depression-screening-result]:checked").val() == undefined ? '' : $("input[name=depression-screening-result]:checked").val();
            var tbLamDate = $("#tblam-date").val();
            var tbLam = $("input[name=tblam]:checked").val();
            var dewormingDate = $("#deworming-date").val();
            var deworming = $("input[name=deworming]:checked").val();
            var dentalReviewDate = $("#dental-review-date").val();
            var dentalReview = $("input[name=dental-review]:checked").val();
            var recommendations = $("#recommendations").val();
            var createdBy = <%=UserId%>;
            //var createDate = $("input[name=creatinine-result]:checked").val();

            var paramValues = {
                PatientMasterVisitId: patientMasterVisitId,
                PatientId: patientId,
                ReviewDate: reviewDate,
                DrtDate: drtDate,
                DrtResult: drtResult,
                HBDone: hb,
                HBDate: hbDate,
                HBResult: hbResult,
                CreatinineDone: creatinine,
                CreatinineDate: creatinineDate,
                CreatinineResult: creatinineResult,
                AltDone: alt,
                AltDate: altDate,
                AltResult: altResult,
                HbsagDone: hbsag,
                HbsagDate: hbsagDate,
                HbsagResult: hbsagResult,
                VdrlDone: vdrl,
                VdrlDate: vdrlDate,
                VdrlResult: vdrlResult,
                CragDone: crag,
                CragDate: cragDate,
                CragResult: cragResult,
                CacxScreeningDone: cacxScreening,
                CacxScreeningDate: cacxScreeningDate,
                CacxScreeningResult: cacxScreeningResult,
                TbLamDone: tbLam,
                TbLamDate: tbLamDate,
                DewormingDone: deworming,
                DewormingDate: dewormingDate,
                DepressionScreeningDone: depressionScreening,
                DepressionScreeningDate: depressionScreeningDate,
                DepressionScreeningResult: depressionScreeningResult,
                DentalReviewDone: dentalReview,
                DentalReviewDate: dentalReviewDate,
                Recommendations: recommendations,
                CreatedBy: createdBy
            };

            let paramValuesStr = JSON.stringify(paramValues);

            $.ajax({
                type: "POST",
                url: "../WebService/PatientClinicalSummaryService.asmx/SavePatientClinicalSummary",
                data: "{'json':'" + paramValuesStr + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //toastr.success(response.d);
                    //console.log(response.d)
                    var ret = JSON.parse(response.d);
                    if (ret.id > 0) {
                        toastr.success(ret.msg, "Successfull");
                        getClinicalReviewHistory(patientId);
                    } else {
                        toastr.error(ret.msg, "Failed");
                    }

                },
                error: function (xhr, errorType, exception) {
                    var jsonError = jQuery.parseJSON(xhr.responseText);
                    toastr.error("" + xhr.status + "" + jsonError.Message);
                }
            });
        }

        function validateInvestigations() {
            let valid = true;

            //$("table#investigations div.error").children().unwrap();

            $("table#investigations").find("tbody tr").each(function () {

                let tr = $(this);

                if (tr.find("input.status:checked").length == 0) {
                    showError(tr.find("input.status").parent("label"));
                    valid = false;
                }

                let statusCtl = tr.find("input[type=radio].status:checked");
                let resultCtrl = tr.find("input.result");
                let dateCtrl = tr.find("input[type=date]");

                if (statusCtl.length > 0 && statusCtl.val() == "1") {
                    if (dateCtrl.val() == "") {
                        showError(dateCtrl);
                        valid = false;
                    }

                    if (resultCtrl.prop("type") == "number" && resultCtrl.val() == "") {
                        showError(resultCtrl);
                    } else if (resultCtrl.prop("type") == "radio" && resultCtrl.filter(function () { return $(this).is(":checked") }).length == 0) {
                        showError(resultCtrl.parent("label"));
                        valid = false;
                    }
                } else {
                    hideError(dateCtrl);
                    hideError(resultCtrl);
                }

            });

            return valid;
        }

        function validate() {
            hideError($("#review-date"));
            if ($("#review-date").val() == "") {
                showError($("#review-date"));
                return "Enter missing review date";
            }

            hideError($("#recommendations"));
            if ($("#recommendations").val() == "") {
                showError($("#recommendations"));
                return "Enter recommendations";
            }

            if (!validateInvestigations()) {
                return "Please fill all the highlighted fields";
            }

            return "";
        }

        $("#btnSave").click(function (e) {

            e.preventDefault();

            let msg = validate();

            if (msg.length > 0) {
                toastr.error(msg, "Error");
            } else {
                savePatientClinicalReviewSummary();
            }
        });

        $("#btnClose").click(function (e) {
            e.preventDefault();
            window.location
                .href = '<%=ResolveClientUrl( "~/CCC/Patient/PatientHome.aspx")%>';
        });

        $("table#investigations input[type=radio].status").change(function () {
            var resultCtrl = $(this).parents("tr").find("input.result");
            var dateCtrl = $(this).parents("tr").find("input[type=date]");
            if ($(this).is(":checked") && $(this).val() == "1") {
                if (resultCtrl.prop("type") == "number") {
                    resultCtrl.show();
                } else if (resultCtrl.prop("type") == "radio") {
                    resultCtrl.parent().show();
                }
                dateCtrl.show();
            } else {
                if (resultCtrl.prop("type") == "number") {
                    resultCtrl.val("").hide();
                } else if (resultCtrl.prop("type") == "radio") {
                    resultCtrl.attr("checked", false);
                    resultCtrl.parent().hide();
                }
                dateCtrl.val("").hide();
                hideError(resultCtrl);
                hideError(dateCtrl);
            }
        });

        $("table#investigations input").change(function () {
            if ($(this).prop("type") == "radio" && $(this).is("checked")) {
                hideError($(this).parent("label"));
            } else {
                hideError($(this));
            }
        });

        $("#btn-history").click(function (e) {
            e.preventDefault();
            toggleShowHistory();
        });

        function hideError($obj) {
            $obj.parents("p.error").children().unwrap();
        }

        function showError($obj) {
            if ($obj.parents("p.error").length == 0) {
                $obj.wrapAll($("<p/>").addClass("error"));
            }
        }

        function toggleShowHistory() {
            let summaryDiv = $("#clinical-summary");
            let historyDiv = $("#clinical-review-history");

            if (historyDiv.hasClass("col-md-3")) {
                historyDiv.removeClass("col-md-3").hide("slow");
            } else {
                historyDiv.addClass("col-md-3").show("slow");
            }

            if (summaryDiv.hasClass("col-md-9")) {
                summaryDiv.removeClass("col-md-9", 1000, "easeOutBack").addClass("col-md-12", 1000, "easeInBack");
            } else {
                summaryDiv.removeClass("col-md-12", 1000, "easeOutBack").addClass("col-md-9", 1000, "easeInBack");
            }
        }
    });
</script>
