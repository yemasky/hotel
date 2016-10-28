<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">
.quick-actions li a {
    padding: 10px 5px 5px;
}
.pagination-left { text-align:left }
</style>
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
                    <h5><%$arrayLaguage['manager_room_layout_price_system']['page_laguage_value']%></h5>
                    <div class="buttons" id="btn_room_layout">
                        <a class="btn btn-primary btn-mini" href="<%$back_lis_url%>" id="back"><i class="am-icon-plus-square"></i> 
                        &#12288;<%$arrayLaguage['back_list']['page_laguage_value']%></a>
                    </div>
                </div>
                <div class="widget-title">
                    <ul class="nav nav-tabs">
                        <li class="active" id="rooms_layout_setting"><a data-toggle="tab" href="#tab1"><%$arrayLaguage['set_prices_on_a_monthly']['page_laguage_value']%></a></li>
                        <li id="room_layout_attr"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['set_prices_on_a_week']['page_laguage_value']%></a></li>
                        <li id="room_layout_images"><a data-toggle="tab" href="#tab4"><%$arrayLaguage['upload_images']['page_laguage_value']%></a></li>
                    </ul>
                </div>
                <div class="widget-content tab-content">
                	<div id="tab1" class="tab-pane active">
                    	<form action="<%$add_room_layout_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_room_layout_form" id="add_room_layout_form" novalidate>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['orientations']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <select name="room_layout_orientations" id="room_layout_orientations" class="span1">
                                    <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                    <%section name=direction loop=$orientations%>
                                        <option value="<%$orientations[direction]%>"<%if $orientations[direction]==$arrayDataInfo['room_layout_orientations']%> selected<%/if%>><%$arrayLaguage[$orientations[direction]]['page_laguage_value']%></option>
                                    <%/section%>
                                </select>
                            </div>
                        </div>
                        <ul class="quick-actions pagination-left">
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 1</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 2</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 3</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 4</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 5</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 6</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 1</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 2</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 3</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 4</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 5</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 6</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 1</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 2</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 3</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 4</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 5</i> <input id="event-name" class="span6" type="text" /></a> </li>
                          <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 6</i> <input id="event-name" class="span6" type="text" /></a> </li>
                        </ul>
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
</body>
</html>