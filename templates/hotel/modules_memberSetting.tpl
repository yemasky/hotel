<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style media="all" type="text/css">
.quick-actions li{max-width:175px;}
</style>
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
                    <h5><%$arrayLaguage['list_of_rooms']['page_laguage_value']%></h5>
                    <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                    <div class="buttons">
                        <a class="btn btn-primary btn-mini" href="<%$add_room_url%>" id="add_company"><i class="am-icon-plus-square"></i> 
                        &#12288;<%$arrayLaguage['add_hotel_rooms']['page_laguage_value']%></a>
                    </div>
                    <%/if%>
                </div>
            </div>
            <%foreach key=room_type item=arrayRoomType from=$arrayDataInfo%>
            <div class="widget-box">
              <div class="widget-title"> <span class="icon"> <i class="icon-hand-right"></i> </span>
                <h5><%$arrayLaguage[$room_type]['page_laguage_value']%></h5>
              </div>
              <div class="widget-content">
                <ul class="quick-actions">
                <%foreach key=key item=item from=$arrayRoomType%>
                <li> <a href="<%$item.url%>"> <i class="icon-home"></i> <%$item.room_name%> </a> </li>
                <%/foreach%>
                </ul>
               </div>
              </div>
            <%/foreach%>            
        </div>
					
	  </div>
    
    </div>
</div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
</body>
</html>