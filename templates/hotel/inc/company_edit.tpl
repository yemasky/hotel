<div class="widget-content nopadding">
<%if $update_success==1%>
<div class="alert alert-success alert-block">  
  <h4 class="alert-heading"><%$arrayLaguage['excute_update_success']['page_laguage_value']%></h4>
</div>
<%/if%>
    <form action="<%$company_update_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="company_form" id="company_form" novalidate> 
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['company_name']['page_laguage_value']%> :</label>
            <div class="controls"><input type="text" class="span3" placeholder="<%$arrayLaguage['company_name']['page_laguage_value']%>" name="company_name" id="company_name" value="<%$arrayCompany['company_name']%>" /> </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['contact_information']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_mobile']['page_laguage_value']%>" name="company_mobile" id="company_mobile" value="<%$arrayCompany['company_mobile']%>" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['company_phone']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_phone']['page_laguage_value']%>" name="company_phone" value="<%$arrayCompany['company_phone']%>" /> 
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['company_fax']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_fax']['page_laguage_value']%>" name="company_fax" value="<%$arrayCompany['company_fax']%>" /> 
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['company_email']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_email']['page_laguage_value']%>" name="company_email" value="<%$arrayCompany['company_email']%>" /> 
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['company_location']['page_laguage_value']%> :</label>
            <div class="controls ">
                <select id="location_province" name="company_province" style="width:120px;">
                    <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                </select>
                <select id="location_city" name="company_city" style="width:120px;">
                    <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                </select>
                <select id="location_town" name="company_town" style="width:120px;">
                    <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['company_address']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" id="company_address" name="company_address" class="span6" placeholder="<%if $arrayCompany['company_address']==''%><%$arrayLaguage['company_address']['page_laguage_value']%><%else%><%$arrayCompany['company_address']%><%/if%>" value="<%$arrayCompany['company_address']%>"  /> 
                <!--<button class="btn btn-primary" type="button" onclick="theLocation()"><%$arrayLaguage['search_map']['page_laguage_value']%></button>-->
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['company_map']['page_laguage_value']%> :</label>
            <div class="controls">
                <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
                <div id="allmap" class="span6"></div>
                </div>
                <input type="hidden" name="company_longitude" id="company_longitude" value="<%$arrayCompany['company_longitude']%>" />
                <input type="hidden" name="company_latitude" id="company_latitude" value="<%$arrayCompany['company_latitude']%>" />
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['company_introduction']['page_laguage_value']%></label>
            <div class="controls">
                <textarea class="span6" style="height:300px;"  placeholder="<%$arrayLaguage['company_introduction']['page_laguage_value']%>" name="company_introduction" value="<%$arrayCompany['company_introduction']%>" ><%$arrayCompany['company_introduction']%></textarea>
            </div>
        </div>
       

        
        <div class="form-actions pagination-centered">
            <button type="submit" id="save_company_info" class="btn btn-success pagination-centered">Save</button>
        </div>
    </form>
</div>