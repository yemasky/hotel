<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
<style type="text/css">
#room_status ul{text-align:left;}
#room_status .stat-boxes2{top:0px;}
.form-horizontal .div-control-label {padding-top: 10px; margin-left:20px;width: 180px;float: left;text-align: right;}
.form-horizontal .right{width:50px;}
.room_status_ul .left{height:100px;}
.room_status_ul .dropdown-menu li{ display:list-item;}
.room_status_ul .dropdown-menu li a{ padding: 3px 0;}
.room_status_ul .dropdown-menu li a:hover{ background:none;}
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
                        <i class="am-icon-clock-o am-yellow-E88A26"></i>
                    </span>
                    <h5></h5>
                </div>
                <div class="widget-content nopadding">
                    <form action="<%$search_url%>" method="get" class="form-horizontal ui-formwizard" enctype="multipart/form-data">
                        <input type="hidden" value="<%$module%>" name="module">
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <div class="input-prepend input-append">
                                    <span class="add-on am-icon-calendar"></span>
                                    <input class="input-small" type="text" id="time_begin" name="time_begin" value="<%$thisDay%>" />
                                    <button class="btn btn-primary"><i class="am-icon-search"></i> <%$arrayLaguage['search']['page_laguage_value']%></button >
                                </div>
                                <a id="begin_night_audit" class="btn btn-primary"><i class="am-icon-server am-yellow-EBC012"></i> <%$arrayLaguage['begin_night_audit']['page_laguage_value']%></a >
                            </div>
                        </div>
                    </form>
                </div>
                <div class="widget-title"><span class="icon"><i class="am-icon-server am-yellow-EBC012"></i></span><h5><%$selfNavigation['hotel_modules_name']%></h5></div>
                <%if $act == 'night_audit'%>
                <div class="widget-content nopadding form-horizontal" id="room_status">
                    <div class="control-group">
                        <label class="control-label">A</label>
                        <div class="controls"></div>
                    </div>
                </div>
                <%else%>
                <div class="widget-content nopadding form-horizontal" id="room_status">
                    <div class="control-group">
                        <label class="control-label">B </label>
                        <div class="controls"></div>
                    </div>
                    
                </div>
                <%/if%>
            </div>
        </div>
        
    </div>
    
    </div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<%include file="hotel/inc_js/nightAudit_js.tpl"%>
</body>
</html>