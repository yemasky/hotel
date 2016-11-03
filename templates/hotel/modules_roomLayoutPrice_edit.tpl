<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
<style type="text/css">
.quick-actions li a {
    padding: 10px 5px 5px;
}
.pagination-left { text-align:left }
.stat-boxes, .quick-actions, .quick-actions-horizontal, .stats-plain { margin:0px;}
.stat-boxes li, .quick-actions li, .quick-actions-horizontal li{margin:0px 5px 5px 0;}
.quick-actions li{max-width:210px; min-width:210px; width:210px;}
.custom-date-style{ cursor:pointer; color:#666666 !important;}
#hotel_service input{margin:0px 2px 0px 8px;}
.dropdown-menu li,.dropdown-menu li a{word-break:break-all;word-wrap:break-word;white-space:normal !important;}
</style>
<script src="<%$__RESOURCE%>js/select2.min.js"></script>
<link rel="stylesheet" href="<%$__RESOURCE%>css/select2.css" />
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
</head>
<body>
<%include file="hotel/inc/top_menu.tpl"%>
<div id="content">
<%include file="hotel/inc/navigation.tpl"%>
	<div class="container-fluid">
      <div class="row-fluid">
        <div class="span12">
            <div class="widget-box widget-calendar">
							
                <div class="widget-title">
                    <span class="icon"><i class="am-icon-cubes am-yellow-F58A17"></i></span>
                    <h5><%$arrayLaguage['manager_room_layout_price']['page_laguage_value']%></h5>
                    <div class="buttons" id="btn_room_layout">
                        <a class="btn btn-primary btn-mini" href="<%$back_lis_url%>" id="back"><i class="am-icon-plus-square"></i> 
                        &#12288;<%$arrayLaguage['back_list']['page_laguage_value']%></a>
                    </div>
                </div>
                <div class="widget-content nopadding">
                    <form action="" method="post" class="form-horizontal" enctype="multipart/form-data" name="" id="" novalidate>
                    <div class="control-group">
                        <label class="control-label"><%$arrayLaguage['sale_room']['page_laguage_value']%> :</label>
                        <div class="controls">
                            <select name="room_layout" id="room_layout" class="span2">
                            <%section name=layout loop=$arrayRoomLayout%>
                                <option value="<%$arrayRoomLayout[layout].room_layout_id%>"><%$arrayRoomLayout[layout].room_layout_name%></option>
                            <%/section%>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><%$arrayLaguage['room_layout_price_system']['page_laguage_value']%> :</label>
                        <div class="controls">
                            <%section name=system loop=$arrayRoomLayoutPriceSystem%>
                                <div class="btn-group">
                                    <a class="btn btn-primary system_prices" href="#system_prices" data-id="<%$arrayRoomLayoutPriceSystem[system].room_layout_price_system_id%>"><i class="am-icon-circle-o"></i> <%$arrayRoomLayoutPriceSystem[system].room_layout_price_system_name%></a>
                                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                    <ul class="dropdown-menu" data-id="<%$arrayRoomLayoutPriceSystem[system].room_layout_price_system_id%>" layout-id="<%$arrayRoomLayoutPriceSystem[system].room_layout_id%>" data-name="<%$arrayRoomLayoutPriceSystem[system].room_layout_price_system_name%>">
                                        <li><a href="#" class="system_prices_edit"><i class="am-icon-pencil am-yellow-FFAA3C"></i> Edit</a></li>
                                        <li><a href="#" class="system_prices_delete"><i class="am-icon-trash am-red-FB0000"></i> Delete</a></li>
                                        <li class="divider"></li>
                                        <li><a href="#"><i class="i"></i>
                                        <%section name=service loop=$arrayRoomLayoutPriceSystem[system].hotel_service_id%>
                                        <i class="am-icon-check-square-o" data-id="<%$arrayRoomLayoutPriceSystem[system].hotel_service_id[service]%>"></i><%$arrayRoomLayoutPriceSystem[system].hotel_service_name[service]%>
                                        <%/section%></a>
                                        </li>
                                    </ul>
                                </div>
                            <%/section%>
                            
                        </div>
                        <div class="controls">
                            <a id="add_edit_system" class="btn btn-primary btn-mini"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_room_layout_price_system']['page_laguage_value']%></a>
                        </div>
                    </div>
                    <input type="hidden" name="room_layout_price_system_id" value=""/>
                    <input type="hidden" name="room_layout_id" value=""/>
                    </form>
                </div>
                <div id="addSystemPrice" class="collapse widget-content nopadding">
                    <div class="control-group">
                        <div class="controls">
                            <form method="post" class="form-horizontal" enctype="multipart/form-data" name="room_layout_price_system" id="room_layout_price_system" novalidate>
                                <div class="modal-header">
                                    <button data-toggle="collapse" data-target="#addSystemPrice" class="close" type="button">×</button>
                                    <h3><%$arrayLaguage['add_room_layout_price_system']['page_laguage_value']%></h3>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%$arrayLaguage['sale_room']['page_laguage_value']%> :</label>
                                    <div class="controls">
                                        <select name="room_layout_id" id="room_layout_id" class="span2">
                                        <option value="0"><%$arrayLaguage['common_room_layout']['page_laguage_value']%></option>
                                        <%section name=layout loop=$arrayRoomLayout%>
                                            <option value="<%$arrayRoomLayout[layout].room_layout_id%>"><%$arrayRoomLayout[layout].room_layout_name%></option>
                                        <%/section%>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%$arrayLaguage['system_price_name']['page_laguage_value']%> :</label>
                                    <div class="controls">
                                        <input id="price_system_name" name="price_system_name" class="span2" placeholder="" value="" type="text">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%$arrayLaguage['select_additional_services']['page_laguage_value']%> :</label>
                                    <div class="controls" id="hotel_service">
                                        
                                    </div>
                                </div>

                              <div class="control-group"> 
                                <div class="controls"><button type="submit" id="save_info" class="btn btn-success pagination-centered">Save</button> <a data-toggle="collapse" data-target="#addSystemPrice" class="btn" href="#">Cancel</a> 
                                </div>  
                              </div>
                              <input type="hidden" name="update_system_id" id="update_system_id" value="" />
                            </form>
                        </div>
                    </div>
                </div>
                <div class="widget-title">
                    <ul class="nav nav-tabs">
                        <li class="active" id="prices_on_a_week"><a data-toggle="tab" href="#tab1"><%$arrayLaguage['set_prices_on_a_week']['page_laguage_value']%></a></li>
                        <li id="prices_on_a_monthly"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['set_prices_on_a_monthly']['page_laguage_value']%></a></li>
                        <li id="history_prices"><a data-toggle="tab" href="#tab3"><%$arrayLaguage['history_prices']['page_laguage_value']%></a></li>

                    </ul>
                </div>
                <div class="widget-content tab-content nopadding">
                    <div id="tab1" class="tab-pane active">
                    	<form action="<%$add_room_layout_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="" id="" novalidate>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <input type="text" id="time_begin" value="<%$thisDay%>" />
                                <input type="text" id="time_end" value="<%$toDay%>" />
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <ul class="quick-actions pagination-left" id="room_layout_price_week">
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周一</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周二</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周三</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周四</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周五</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周六</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周日</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                </ul>
                            </div>
                        </div>
                        </form>
                    </div>
                	<div id="tab2" class="tab-pane">
                    	<form action="<%$add_room_layout_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_room_layout_form" id="add_room_layout_form" novalidate>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <select name="room_layout_date_year" id="room_layout_date_year" class="span1">
                                    <option value="<%$thisYear%>" ><%$thisYear%></option>
                                    <option value="<%$thisYear + 1%>" ><%$thisYear + 1%></option>
                                </select>
                                
                                <select name="room_layout_date_month" id="room_layout_date_month" class="span1">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                        <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <ul class="quick-actions pagination-left" id="room_layout_price_kalendar"></ul>
                            </div>
                        </div>
                        </form>
                    </div>
                    <div id="tab3" class="tab-pane">
                    	<form action="" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_room_layout_form" id="add_room_layout_form" novalidate>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <input type="text" id="history_begin" value="<%$thisDay%>" />
                                <input type="text" id="history_end" value="<%$toDay%>" />
                            </div>
                        </div>
                        <div class="control-group">
                        <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <ul class="quick-actions pagination-left" id=""></ul>
                            </div>
                        </div>
                        </form>
                    </div>
                    
                </div>
                <div class="widget-content">
                    
                </div>
            </div>   
        </div>
					
	  </div>
    
    </div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<%include file="hotel/inc/roomLayoutPrice_edit_js.tpl"%>
</body>
</html>