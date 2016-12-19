<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
<style type="text/css">
#room_status ul{text-align:left;}
#room_status .stat-boxes2{top:0px;}
.form-horizontal .div-control-label {padding-top: 10px; margin-left:20px;width: 248px;float: left;text-align: right;}
.form-horizontal .controls { margin-left: 268px; padding: 10px 0;}
.form-horizontal .right{min-width:70px; width:auto;}
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
                    <%if ($isArriveTime)%>
                    <div class="widget-content nopadding form-horizontal" id="room_status">
                        <div class="control-group">
                            <label class="control-label"> </label>
                            <div class="controls"></div>
                        </div>
                        <%foreach key=book_order_number item=arrayData from=$arrayDataInfo%>
                        <div class="control-group">
                            <div class="div-control-label">
                                <ul class="stat-boxes stat-boxes2">
                                    <li>
                                        <div class="left peity_line_neutral">
                                        <%$arrayLaguage['order_number']['page_laguage_value']%>
                                        </div>
                                        <div class="right"> <%$book_order_number%> </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="controls">
                                <%foreach key=i item=book from=$arrayData%>
                                <ul class="stat-boxes stat-boxes2">
                                    <li>
                                        <!--<div class="left peity_line_neutral">
                                        1<%$arrayLaguage['room_number']['page_laguage_value']%>
                                        </div>-->
                                        <div class="left peity_line_neutral">入住日期</div>
                                        <div class="right"> <%$book.book_check_in%> </div>
                                        <div class="left peity_line_neutral">&#12288;</div>
                                        <div class="left peity_line_neutral text-warning">退房日期</div>
                                        <div class="right"> <%$book.book_check_out%> </div>
                                        <div class="left peity_line_neutral">&#12288;</div>
                                        <div class="left peity_line_neutral">
                                        <%$arrayLaguage['room_number']['page_laguage_value']%>
                                        </div>
                                        <div class="right"> <%$arrayRoom[$book.room_id].room_name%>[<%$arrayRoom[$book.room_id].room_number%>] </div>
                                        <div class="left peity_line_neutral">&#12288;</div>
                                        <div class="left peity_line_neutral">联系人</div>
                                        <div class="right"> <%$book.book_contact_name%> </div>
                                        <div class="left peity_line_neutral">&#12288;</div>
                                        <div class="left peity_line_neutral">电话</div>
                                        <div class="right"> <%$book.book_contact_mobile%> </div>
                                    </li>
                                </ul>
                                <%/foreach%>
                            </div>
                        </div>
                        <%/foreach%>
                    </div>
                    <%else%>
                     <div class="control-group">
                        <label class="control-label"></label>
                        <div class="controls">还没到夜审时间！</div>
                    </div>
                    <%/if%>
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