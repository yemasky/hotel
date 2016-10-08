<div class="widget-content nopadding">
    <form action="<%$hotel_update_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="hotel_form" id="hotel_form" novalidate> 
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_name']['page_laguage_value']%> :</label>
            <div class="controls"><input type="text" class="span3" placeholder="<%$arrayLaguage['hotel_name']['page_laguage_value']%>" name="hotel_name" id="hotel_name" value="<%$arrayDataInfo['hotel_name']%>" /> </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_mobile']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" class="span3" placeholder="<%$arrayLaguage['hotel_mobile']['page_laguage_value']%>" name="hotel_mobile" id="hotel_mobile" value="<%$arrayDataInfo['hotel_mobile']%>" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_phone']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" class="span3" placeholder="<%$arrayLaguage['hotel_phone']['page_laguage_value']%>" name="hotel_phone" value="<%$arrayDataInfo['hotel_phone']%>" /> 
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_fax']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" class="span3" placeholder="<%$arrayLaguage['hotel_fax']['page_laguage_value']%>" name="hotel_fax" value="<%$arrayDataInfo['hotel_fax']%>" /> 
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_email']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" class="span3" placeholder="<%$arrayLaguage['hotel_email']['page_laguage_value']%>" name="hotel_email" value="<%$arrayDataInfo['hotel_email']%>" /> 
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_location']['page_laguage_value']%> :</label>
            <div class="controls ">
                <select id="location_province" name="hotel_province" style="width:120px;">
                    <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                </select>
                <select id="location_city" name="hotel_city" style="width:120px;">
                    <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                </select>
                <select id="location_town" name="hotel_town" style="width:120px;">
                    <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_address']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" id="address" name="hotel_address" class="span6" placeholder="<%if $arrayDataInfo['hotel_address']==''%><%$arrayLaguage['hotel_address']['page_laguage_value']%><%else%><%$arrayDataInfo['hotel_address']%><%/if%>" value="<%$arrayDataInfo['hotel_address']%>"  /> 
                <!--<button class="btn btn-primary" type="button" onclick="theLocation()"><%$arrayLaguage['search_map']['page_laguage_value']%></button>-->
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_map']['page_laguage_value']%> :</label>
            <div class="controls">
                <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
                <div id="allmap" class="span6"></div>
                </div>
                <input type="hidden" name="hotel_longitude" id="hotel_longitude" value="<%$arrayDataInfo['hotel_longitude']%>" />
                <input type="hidden" name="hotel_latitude" id="hotel_latitude" value="<%$arrayDataInfo['hotel_latitude']%>" />
        </div>
        
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_type']['page_laguage_value']%> :</label>
            <div class="controls">
                <select id="hotel_type" name="hotel_type" style="width:120px;">
                    <option value="hotel"><%$arrayLaguage['hotel']['page_laguage_value']%></option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_star']['page_laguage_value']%> :</label>
            <div class="controls">
                <select id="hotel_star" name="hotel_star" style="width:120px;">
                	<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                    <option value="1"<%if $arrayDataInfo['hotel_star'] == 1%> selected="selected"<%/if%>>★</option>
                    <option value="2"<%if $arrayDataInfo['hotel_star'] == 2%> selected="selected"<%/if%>>★★</option>
                    <option value="3"<%if $arrayDataInfo['hotel_star'] == 3%> selected="selected"<%/if%>>★★★</option>
                    <option value="4"<%if $arrayDataInfo['hotel_star'] == 4%> selected="selected"<%/if%>>★★★★</option>
                    <option value="5"<%if $arrayDataInfo['hotel_star'] == 5%> selected="selected"<%/if%>>★★★★★</option>
                    <option value="6"<%if $arrayDataInfo['hotel_star'] == 6%> selected="selected"<%/if%>>★★★★★★</option>
                    <option value="7"<%if $arrayDataInfo['hotel_star'] == 7%> selected="selected"<%/if%>>★★★★★★★</option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_wifi']['page_laguage_value']%> :</label>
            <div class="controls">
                <select id="hotel_wifi" name="hotel_wifi" style="width:120px;">
                	<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                    <option value="1"<%if $arrayDataInfo['hotel_wifi'] == 1%> selected="selected"<%/if%>><%$arrayLaguage['have']['page_laguage_value']%></option>
                    <option value="0"<%if $arrayDataInfo['hotel_wifi'] == 0%> selected="selected"<%/if%>><%$arrayLaguage['not_have']['page_laguage_value']%></option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['brand']['page_laguage_value']%> :</label>
            <div class="controls">
                <input type="text" id="hotel_brand" name="hotel_brand" class="span3" placeholder="<%if $arrayDataInfo['hotel_brand']==''%><%$arrayLaguage['brand']['page_laguage_value']%><%else%><%$arrayDataInfo['hotel_brand']%><%/if%>" value="<%$arrayDataInfo['hotel_brand']%>"  /> 
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><%$arrayLaguage['hotel_introduce']['page_laguage_value']%></label>
            <div class="controls">
                <textarea class="span6" style="height:300px;"  placeholder="<%$arrayLaguage['hotel_introduce']['page_laguage_value']%>" name="hotel_introduce" value="<%$arrayDataInfo['hotel_introduce']%>" ><%$arrayDataInfo['hotel_introduce']%></textarea>
            </div>
        </div>
       

        
        <div class="form-actions pagination-centered">
            <button type="submit" id="save_company_info" class="btn btn-success pagination-centered">Save</button>
        </div>
    </form>
</div>