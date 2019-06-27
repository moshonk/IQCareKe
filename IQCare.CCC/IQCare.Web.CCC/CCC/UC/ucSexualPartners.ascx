<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSexualPartners.ascx.cs" Inherits="IQCare.Web.CCC.UC.ucSexualPartners" %>
<div class="row">
    <div class="col-md-12">
        <div class="col-md-12">
            <h2 class="text-muted text-Warning pull-left">Marital  Status and Sexual Partners | </h2>
            <h6>
                <label class="control-label text-primary pull-left text-muted">Marital Status and Sexual partner Listing</label>
            </h6>
        </div>
        <div class="col-md-12">
            <hr />
        </div>
        <div class="col-md-12 col-xs-12 col-sm-12 form-group" id="maritalStatus" data-parsley-validate="true" data-show-errors="true">
            <div class="col-md-6">
                <div class="input-group">
                    <span class="input-group-addon"><small class="text-danger">*</small> Marital Status</span>
                    <select id="cboMaritalstatus">
                        <option value="0">Select</option>
                    </select>
                </div>
                <div class="input-group">
                    <span class="input-group-addon"><small class="text-danger">*</small> Marital Status</span>
                    <input type="radio" name="rdSexuallyActive" value="" />
                </div>
            </div>
        </div>
    </div>
</div>
