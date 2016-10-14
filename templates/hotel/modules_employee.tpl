<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<%include file="hotel/inc/editor_upload_images.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
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
             <span class="icon"><i class="icon-th"></i></span> 
            <h5><%$arrayLaguage['hotel_department_manage']['page_laguage_value']%></h5>
          </div>
          <div class="widget-title">
            <ul class="nav nav-tabs">
                <li class="active" id="rooms_layout_setting"><a data-toggle="tab" href="#tab1"><%$arrayLaguage['hotel_department_manage']['page_laguage_value']%></a></li>
                <li id="room_layout_attr"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['department_role_setting']['page_laguage_value']%></a></li>
            </ul>
        </div>
          <div class="widget-content tab-content nopadding">
           <div id="tab1" class="tab-pane active">
            <form action="" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_room_layout_form" id="add_room_layout_form" novalidate> 
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['room_layout_name']['page_laguage_value']%> :</label>
                    <div class="controls"><input type="text" class="span3" placeholder="<%$arrayLaguage['room_layout_name']['page_laguage_value']%>" name="room_layout_name" id="room_layout_name" value="<%$arrayDataInfo['room_layout_name']%>" /> </div>
                </div>
                
            </form>
           </div>
    	   <div id="tab2" class="tab-pane">
              <form action="<%$add_room_layout_attr_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_room_layout_attr_form" id="add_room_layout_attr_form" novalidate> 
           		
                <div class="control-group">
                    <label class="control-label"></label>
                    <div class="controls">
                        <label class="control-label"><span><a href="<%$room_attribute_url%>" target="_blank" class="btn btn-primary btn-mini"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_customize_attr']['page_laguage_value']%></a></span></label>
                        
                    </div>
                </div>
                <div class="form-actions pagination-centered btn-icon-pg">
                    <button type="submit" class="btn btn-primary pagination-centered save_info"><%$arrayLaguage['save_next']['page_laguage_value']%></button>
                </div>
              </form>
           </div>
           
           </div>
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