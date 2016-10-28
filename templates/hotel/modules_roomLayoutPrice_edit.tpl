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
                        <li class="active" id="rooms_layout_setting"><a data-toggle="tab" href="#tab1">1</a></li>
                        <li id="room_layout_attr"><a data-toggle="tab" href="#tab2">2</a></li>
                        <li id="set_room"><a data-toggle="tab" href="#tab3">3</a></li>
                        <li id="room_layout_images"><a data-toggle="tab" href="#tab4"><%$arrayLaguage['upload_images']['page_laguage_value']%></a></li>
                        <!--<li id="room_layout_price_setting"><a href="#tab3"><%$arrayLaguage['room_layout_price_setting']['page_laguage_value']%></a></li>-->
                    </ul>
                </div>
                <div class="widget-title">
                    <div class="buttons">
                        <a id="add-event" data-toggle="modal" href="#modal-add-event" class="btn btn-inverse btn-mini">
                        	<i class="icon-plus icon-white"></i> Add new event
                        </a>
                        <div class="modal hide" id="modal-add-event">
                             <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">×</button>
                                <h3>Add a new event</h3>
                            </div>
                            <div class="modal-body">
                                <p>Enter event name:</p>
                                <p><input id="event-name" type="text" /></p>
                            </div>
                            <div class="modal-footer">
                                <a href="#" class="btn" data-dismiss="modal">Cancel</a>
                                <a href="#" id="add-event-submit" class="btn btn-primary">Add event</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="widget-content">
                    <ul class="quick-actions">
                      <li> <a href="#"> <i class="icon-book"></i> 1 <input id="event-name" class="span6" type="text" /></a> </li>
                      <li> <a href="#"> <i class="icon-cabinet"></i> icon-cabinet</a> </li>
                      <li> <a href="#"> <i class="icon-calendar"></i> icon-calendar </a> </li>
                      <li> <a href="#"> <i class="icon-client"></i> icon-client</a> </li>
                      <li> <a href="#"> <i class="icon-database"></i> icon-database </a> </li>
                      <li> <a href="#"> <i class="icon-download"></i> icon-download </a> </li>
                      
                      <li> <a href="#"> <i class="icon-graph"></i> icon-graph </a> </li>
                      <li> <a href="#"> <i class="icon-home"></i>icon-home </a> </li>
                      <li> <a href="#"> <i class="icon-lock"></i> icon-lock </a> </li>
                      <li> <a href="#"> <i class="icon-mail"></i>icon-mail </a> </li>
                      <li> <a href="#"> <i class="icon-pdf"></i> icon-pdf </a> </li>
                      <li> <a href="#"> <i class="icon-people"></i> icon-people </a> </li>
                      <li> <a href="#"> <i class="icon-piechart"></i> icon-piechart </a> </li>
                      <li> <a href="#"> <i class="icon-search"></i> icon-search </a> </li>
                      <li> <a href="#"> <i class="icon-survey"></i> icon-survey </a> </li>
                      <li> <a href="#"> <i class="icon-tag"></i> icon-tag </a> </li>
                      <li> <a href="#"> <i class="icon-user"></i> icon-user</a> </li>
                      <li> <a href="#"> <i class="icon-wallet"></i> icon-wallet </a> </li>
                      <li> <a href="#"> <i class="icon-web"></i>icon-web </a> </li>
                      <li> <a href="#"> <i class="icon-dashboard"></i> icon-dashboard </a> </li>
                    </ul>
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