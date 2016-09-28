<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<link rel="stylesheet" href="<%$__RESOURCE%>css/colorpicker.css" />
<link rel="stylesheet" href="<%$__RESOURCE%>css/datepicker.css" />
<link rel="stylesheet" href="<%$__RESOURCE%>css/uniform.css" />
<link rel="stylesheet" href="<%$__RESOURCE%>css/select2.css" />
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=bRZ3pR32yPAhiE0XiCO3qF8Uoh5U9yqA"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
<style type="text/css">
#allmap {height: 300px;width:60%;overflow: hidden;}
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
                        <i class="icon-align-justify"></i>									
                    </span>
                    <h5><%$arrayLaguage['company_information']['page_laguage_value']%></h5>
                    <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                    <div class="buttons">
						<a class="btn btn-primary btn-mini" href="#" id="edit_company"><i class="icon-pencil"></i><%$arrayLaguage['company_edit']['page_laguage_value']%></a>	
                        <a class="btn btn-primary btn-mini" href="#" id="cancel_edit_company"><i class="icon-pencil"></i><%$arrayLaguage['company_cancel_edit']['page_laguage_value']%></a>
					</div>
                    <%/if%>
                </div>
                <%include file="hotel/inc/company_edit.tpl"%>
            </div>						
        </div>
    </div>
    
    </div>
</div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/company_js.tpl"%>
<script language="javascript">
	$("form input,textarea,select").prop("readonly", true);
	$('#cancel_edit_company').hide();
	$('#save_company_info').hide();
	$('#edit_company').click(function(e) {
            $("form input,textarea,select").prop("readonly", false);
			$(this).hide();
			$('#cancel_edit_company').show();
			$('#save_company_info').show();
	});
	$('#cancel_edit_company').click(function(e) {
		$("form input,textarea,select").prop("readonly", true);
		$(this).hide();
		$('#edit_company').show();
		$('#save_company_info').hide();
	});
</script>
</body>
</html>