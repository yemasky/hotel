<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<link rel="stylesheet" href="<%$__RESOURCE%>css/select2.css" />	
<script src="<%$__RESOURCE%>js/select2.min.js"></script>
<script language="javascript">
$(document).ready(function(){	
	$('select').select2();
});
</script>
</head>
<body>
<%include file="hotel/inc/top_menu.tpl"%>
<div id="content">
<%include file="hotel/inc/navigation.tpl"%>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div class="widget-box">
                <div class="widget-title">
                    <span class="icon">
                        <i class="icon-th-list"></i>
                    </span>
                    <h5><%$arrayLaguage['attribute_setting']['page_laguage_value']%></h5>
                    <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                    <div class="buttons">
                        <a class="btn btn-primary btn-mini" href="#add" url="<%$add_room_attribute_url%>" id="add_attribute"><i class="am-icon-plus-square"></i>
                        &#12288;<%$arrayLaguage['add_attribute_setting']['page_laguage_value']%></a>
                    </div>
                    <%/if%>
                </div>
                <div class="widget-content tab-content nopadding">
                <form action="<%$add_room_attribute_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="hotel_service_form" id="hotel_service_form" novalidate>
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['room_setting_type']['page_laguage_value']%> :</label>
                    <div class="controls ">
                        <select id="room_type" name="room_type" class="span1" disabled>
                            <%foreach key=type_key item=item from=$arayRoomType%>
                            <%if $item==1%>
                            <option value="<%$type_key%>"<%if $type_key==$room_type%> selected<%/if%>><%$arrayLaguage[$type_key]['page_laguage_value']%></option>
                            <%/if%>
                            <%/foreach%>
                        </select>
                    </div>
                </div>
                <%section name=attr loop=$arrayAttribute%>
                    <div class="control-group">
                        <label class="control-label"><%$arrayAttribute[attr].room_layout_attribute_name%> :</label>
                        <div class="controls">
                        <%section name=attr_childen loop=$arrayAttribute[attr].childen%>
                            <input type="text" id="hotel_booking_notes" name="hotel_booking_notes" class="span1" placeholder="" value="<%$arrayAttribute[attr].childen[attr_childen].room_layout_attribute_name%>"<%if $arrayAttribute[attr].childen[attr_childen].hotel_id==0%> readonly<%/if%> />
                        <%/section%>
                        </div>
                        <div class="controls"><input type="text" class="span1" value=""></div>
                        <div class="controls">
                        <a href="#add" class="btn btn-primary btn-mini"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_customize_attr']['page_laguage_value']%></a>
                        </div>
                    </div>
                <%/section%>
                <div class="form-actions pagination-centered btn-icon-pg">
                </div>
               </form>
           	   </div>
            </div>   
        </div>
					
	  </div>
    
    </div>
</div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<script language="JavaScript">
    

</script>
</body>
</html>