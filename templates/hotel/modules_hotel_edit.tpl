<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=bRZ3pR32yPAhiE0XiCO3qF8Uoh5U9yqA"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
<style type="text/css">
#allmap {height: 300px;min-width:48.5%;overflow: hidden; margin-left:0px;}
</style>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
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
                        <i class="icon-align-justify"></i>									
                    </span>
                    <h5><%$arrayLaguage['hotel_information']['page_laguage_value']%></h5>                   
                </div>
                <%include file="hotel/inc/hotel_edit.tpl"%>
            </div>						
        </div>
    </div>
    
    </div>
</div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/hotel_js.tpl"%>
<script language="javascript">
	<%if $view==1%>
	$("form input,textarea,select").prop("readonly", true);
	$('#save_hotel_info').hide();
	<%/if%>
</script>
<%include file="hotel/inc/modal_box.tpl"%>
</body>
</html>