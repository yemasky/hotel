<div class="widget-title">
    <ul class="nav nav-tabs">
        <li class="active" id="hotel_setting"><a data-toggle="tab" href="#tab1"><%$arrayLaguage['hotel_setting']['page_laguage_value']%></a></li>
        <li id="hotel_attribute_setting"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['hotel_attribute_setting']['page_laguage_value']%></a></li>
        <li id="hotel_images_upload"><a data-toggle="tab" href="#tab3"><%$arrayLaguage['upload_images']['page_laguage_value']%></a></li>
    </ul>
</div>
<div class="widget-content tab-content nopadding">
<%if $update_success==1%>
<%include file="hotel/inc/success_alert.tpl"%>
<%/if%>
    <div id="tab1" class="tab-pane active">
        <form action="<%$hotel_update_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="hotel_form" id="hotel_form" novalidate> 
            <div class="control-group">
                <label class="control-label"><%$arrayLaguage['belong_to_company']['page_laguage_value']%> :</label>
                <div class="controls">
                    <select id="company_id" name="company_id" class="span3">
                    	<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                        <%section name=company loop=$arrayEmployeeCompany%>
                        <option value="<%$arrayEmployeeCompany[company].company_id%>"<%if $arrayEmployeeCompany[company].company_id==$arrayDataInfo['company_id']%> selected="selected"<%/if%>><%$arrayEmployeeCompany[company].company_name%></option>
                        <%/section%>
                    </select>
                </div>
            </div>
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
                    <select id="location_province" name="hotel_province" class="span2">
                        <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                    </select>
                    <select id="location_city" name="hotel_city" class="span2">
                        <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                    </select>
                    <select id="location_town" name="hotel_town" class="span2">
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
                    <div id="searchResultPanel" class="span6" style="border:1px solid #C0C0C0;height:auto; display:none;"></div>
                    <div id="allmap" class="span6"></div>
                    </div>
                    <input type="hidden" name="hotel_longitude" id="hotel_longitude" value="<%$arrayDataInfo['hotel_longitude']%>" />
                    <input type="hidden" name="hotel_latitude" id="hotel_latitude" value="<%$arrayDataInfo['hotel_latitude']%>" />
            </div>
            
            <div class="control-group">
                <label class="control-label"><%$arrayLaguage['hotel_type']['page_laguage_value']%> :</label>
                <div class="controls">
                    <select id="hotel_type" name="hotel_type" class="span3">
                        <option value="hotel"<%if $arrayDataInfo['hotel_type']=='hotel'%> selected="selected"<%/if%>><%$arrayLaguage['hotel']['page_laguage_value']%></option>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><%$arrayLaguage['hotel_star']['page_laguage_value']%> :</label>
                <div class="controls">
                    <select id="hotel_star" name="hotel_star" class="span2">
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
                    <select id="hotel_wifi" name="hotel_wifi" class="span3">
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
                <label class="control-label"><%$arrayLaguage['hotel_checkin']['page_laguage_value']%> :</label>
                <div class="controls">
                    <input type="text" id="hotel_checkin" name="hotel_checkin" class="span1" placeholder="<%if $arrayDataInfo['hotel_checkin']==''%><%$arrayLaguage['hotel_checkin']['page_laguage_value']%><%else%><%$arrayDataInfo['hotel_checkin']%><%/if%>" value="<%$arrayDataInfo['hotel_checkin']%>"  /> 
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><%$arrayLaguage['hotel_checkout']['page_laguage_value']%> :</label>
                <div class="controls">
                    <input type="text" id="hotel_checkout" name="hotel_checkout" class="span1" placeholder="<%if $arrayDataInfo['hotel_checkout']==''%><%$arrayLaguage['hotel_checkout']['page_laguage_value']%><%else%><%$arrayDataInfo['hotel_checkout']%><%/if%>" value="<%$arrayDataInfo['hotel_checkout']%>"  /> 
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><%$arrayLaguage['hotel_booking_notes']['page_laguage_value']%> :</label>
                <div class="controls">
                    <textarea class="span6" style="height:300px;" id="hotel_booking_notes" name="hotel_booking_notes" placeholder="<%if $arrayDataInfo['hotel_booking_notes']==''%><%$arrayLaguage['hotel_booking_notes']['page_laguage_value']%><%else%><%$arrayDataInfo['hotel_booking_notes']%><%/if%>" value="<%$arrayDataInfo['hotel_booking_notes']%>"  ><%$arrayDataInfo['hotel_booking_notes']%></textarea> 
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><%$arrayLaguage['hotel_introduce']['page_laguage_value']%></label>
                <div class="controls">
                    <textarea class="span6" style="height:300px;"  placeholder="<%$arrayLaguage['hotel_introduce']['page_laguage_value']%>" name="hotel_introduce" value="<%$arrayDataInfo['hotel_introduce']%>" ><%$arrayDataInfo['hotel_introduce']%></textarea>
                </div>
            </div>
           
            
            <div class="form-actions pagination-centered btn-icon-pg">
            	<!--<ul><li class="btn btn-primary" id="hotel_attribute_setting_btn">  </li></ul>-->
                <button type="submit" id="save_hotel_info" class="btn btn-primary pagination-centered"><%$arrayLaguage['hotel_attribute_setting_next']['page_laguage_value']%></button>
            </div>
         </form>
    </div>
    <div id="tab2" class="tab-pane">
       	  <form action="" method="post" class="form-horizontal" enctype="multipart/form-data" name="hotel_attr_form" id="hotel_attr_form" novalidate> 
       		<%section name=attr loop=$arrayAttribute%>
                <div class="control-group">
                    <label class="control-label"><%$arrayAttribute[attr].hotel_attribute_name%> :</label>
                    <div class="controls">
                    <%section name=attr_childen loop=$arrayAttribute[attr].childen%>
                    <label class="control-label"><%$arrayAttribute[attr].childen[attr_childen].hotel_attribute_name%> :</label>
                    <div class="controls">
                        <input type="text" class="span2" value=""  />
                        <a href="#add" class="btn btn-primary btn-mini addAttr"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_attribute_value']['page_laguage_value']%></a>
                    </div>
                    <%/section%>
                    </div>
                </div>
            <%/section%>
            <div class="form-actions pagination-centered btn-icon-pg">
                <button type="submit" id="save_hotel_attr_val_info" class="btn btn-primary pagination-centered"><%$arrayLaguage['save_next']['page_laguage_value']%></button>
            </div>
           </form>
    </div>
    <div id="tab3" class="tab-pane">
        <div class="widget-content">
            <ul class="thumbnails">
                <%section name=images loop=$arrayDataImages%>
                <li class="span2">
                    <a class="thumbnail lightbox_trigger" href="<%$__IMGWEB%><%$arrayDataImages[images].room_layout_images_path%>">
                        <img id="room_layout_<%$arrayDataImages[images].hotel_images_id%>" src="<%$__IMGWEB%><%$arrayDataImages[images].hotel_images_path%>" alt="" >
                    </a>
                    <div class="actions">
                        <a title="" href="#"><i class="icon-pencil icon-white"></i></a>
                        <a title="" href="#"><i class="icon-remove icon-white"></i></a>
                    </div>
                </li>
                <%/section%>
            </ul>
        </div>
        <form method="post" class="form-horizontal" enctype="multipart/form-data" novalidate>
            <div class="control-group">
                <label class="control-label"><%$arrayLaguage['upload_holte_images']['page_laguage_value']%> :</label>
                <div class="controls">
                    <p><input type="text" id="upload_images_url" value="" /> <input type="button" id="upload_images" value="选择图片" /></p>
                </div>
            </div>
        </form>
    </div>
</div>
