<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
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
                        　<%$arrayLaguage['add_attribute_setting']['page_laguage_value']%></a>
                    </div>
                    <%/if%>
                </div>
                <div class="widget-content tab-content nopadding">
                <form action="<%$add_room_attribute_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="hotel_service_form" id="hotel_service_form" novalidate>
                <%section name=attr loop=$arrayAttribute%>
                    <div class="control-group">
                        <label class="control-label"><%$arrayAttribute[attr].room_layout_attribute_name%> :</label>
                        <div class="controls">
                        <%section name=attr_childen loop=$arrayAttribute[attr].childen%>
                            <input type="text" id="hotel_booking_notes" name="hotel_booking_notes" class="span1" placeholder="" value="<%$arrayAttribute[attr].childen[attr_childen].room_layout_attribute_name%>"  />
                        <%/section%>
                        </div>
                        <div class="controls">
                        <a href="#add" class="btn btn-primary btn-mini"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_attribute_value']['page_laguage_value']%></a>
                        </div>
                    </div>
                <%/section%>
                <div class="form-actions pagination-centered btn-icon-pg">
                    <button type="submit" id="save_info" class="btn btn-success pagination-centered">Save</button>
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
    $()

</script>
</body>
</html>