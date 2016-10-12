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
            <h5><%$arrayLaguage['add_rooms_layout']['page_laguage_value']%></h5>
            <div class="buttons" id="btn_room_layout">
                <a class="btn btn-primary btn-mini" href="<%$back_lis_url%>" id="add_room_layout"><i class="am-icon-arrow-circle-left"></i> 
                &#12288;<%$arrayLaguage['back_list']['page_laguage_value']%></a>
            </div>
          </div>
          <div class="widget-title">
            <ul class="nav nav-tabs">
                <li class="active" id="rooms_layout_setting"><a data-toggle="tab" href="#tab1"><%$arrayLaguage['rooms_layout_setting']['page_laguage_value']%></a></li>
                <li id="room_layout_attr"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['room_layout_attr']['page_laguage_value']%></a></li>
                <li id="room_layout_images"><a data-toggle="tab" href="#tab3"><%$arrayLaguage['upload_images']['page_laguage_value']%></a></li>
                <!--<li id="room_layout_price_setting"><a href="#tab3"><%$arrayLaguage['room_layout_price_setting']['page_laguage_value']%></a></li>-->
            </ul>
        </div>
          <div class="widget-content tab-content nopadding">
           <div id="tab1" class="tab-pane active">
            <form action="<%$add_room_layout_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_room_layout_form" id="add_room_layout_form" novalidate> 
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['room_layout_name']['page_laguage_value']%> :</label>
                    <div class="controls"><input type="text" class="span3" placeholder="<%$arrayLaguage['room_layout_name']['page_laguage_value']%>" name="room_layout_name" id="room_layout_name" value="<%$arrayDataInfo['room_layout_name']%>" /> </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['room_layout_valid']['page_laguage_value']%> :</label>
                    <div class="controls">
                    <label>
                    	<div class="radio" id="room_layout_valid-1"><span><input value="1" name="room_layout_valid" type="radio"<%if $arrayDataInfo['room_layout_valid']=='1'%> checked<%/if%>></span><%$arrayLaguage['valid']['page_laguage_value']%></div> 
                    
                    	<div class="radio" id="room_layout_valid-0"><span><input value="0" name="room_layout_valid" type="radio"<%if $arrayDataInfo['room_layout_valid']=='0'%> checked<%/if%>></span><%$arrayLaguage['no_avail']['page_laguage_value']%></div> 
                    </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['area']['page_laguage_value']%> :</label>
                    <div class="controls"><input type="text" class="span1" placeholder="<%$arrayLaguage['area']['page_laguage_value']%>" name="room_layout_area" id="room_layout_area" value="<%$arrayDataInfo['room_layout_area']%>" /> </div>
                </div>
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
                <div class="form-actions pagination-centered btn-icon-pg">
            	<!--<ul><li class="btn btn-primary" id="hotel_attribute_setting_btn">  </li></ul>-->
                    <button type="submit" id="save_info" class="btn btn-primary pagination-centered save_info"><%$arrayLaguage['save_next']['page_laguage_value']%></button>
                </div>
            </form>
           </div>
    	   <div id="tab2" class="tab-pane">
              <form action="<%$add_room_layout_attr_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_room_layout_attr_form" id="add_room_layout_attr_form" novalidate> 
           		<%section name=attr loop=$arrayAttribute%>
                    <div class="control-group">
                        <label class="control-label"><%$arrayAttribute[attr].room_layout_attribute_name%> :</label>
                        <div class="controls">
                        	<%section name=attr_childen loop=$arrayAttribute[attr].childen%>
                        	 <label class="control-label"><%$arrayAttribute[attr].childen[attr_childen].room_layout_attribute_name%> :</label>
                             <div class="controls">
                             	<input type="text" name="<%$arrayAttribute[attr].childen[attr_childen].room_layout_attribute_id%>[]" class="span2" value="">
                             	<a href="#add" class="btn btn-primary btn-mini"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_attribute_value']['page_laguage_value']%></a>
                             </div>
                        	<%/section%>
                        	<label class="control-label"><span><a href="#add" class="btn btn-primary btn-mini"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_customize_attr']['page_laguage_value']%></a></span></label>
                            
                        </div>
                    </div>
                <%/section%>
                <div class="form-actions pagination-centered btn-icon-pg">
                    <button type="submit" class="btn btn-primary pagination-centered save_info"><%$arrayLaguage['save_next']['page_laguage_value']%></button>
                </div>
              </form>
           </div>
           <div id="tab3" class="tab-pane">
               <div class="widget-content">
                <ul class="thumbnails">
                	<%section name=images loop=$arrayDataImages%>
                    <li class="span2">
                        <a class="thumbnail lightbox_trigger" href="<%$__IMGWEB%><%$arrayDataImages[images].room_layout_images_path%>">
                            <img id="room_layout_<%$arrayDataImages[images].room_layout_images_id%>" src="<%$__IMGWEB%><%$arrayDataImages[images].room_layout_images_path%>" alt="" >
                        </a>
                        <div class="actions">
                            <a title="" href="#"><i class="icon-pencil icon-white"></i></a>
                            <a title="" href="#"><i class="icon-remove icon-white"></i></a>
                        </div>
                    </li>
                    <%/section%>
                 </ul>
                </div>
           		<form method="post" class="form-horizontal" enctype="multipart/form-data" novalidate> 
                <div class="control-group">
                	<label class="control-label"><%$arrayLaguage['upload_room_layout_images']['page_laguage_value']%> :</label>
                    <div class="controls">
           			<p><input type="text" id="upload_images_url" value="" /> <input type="button" id="upload_images" value="选择图片" /></p>
                    </div>
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
<script language="javascript">
var room_layout_id = '<%$room_layout_id%>';
var url = '<%$add_room_layout_url%>';
$(document).ready(function(){
	// Form Validation
    var v = $("#add_room_layout_form").validate({
		rules:{
			room_layout_name: {
				required:true,
				minlength:2,
				maxlength:50
			},
			room_layout_valid:{
				required:true
			},
			room_layout_area:{
				required:true,
				digits:true
			},
			room_layout_orientations:{
				required:true
			}
		},
		messages: {
			room_layout_name:"请输入房型名称，2~50个字符",
			room_layout_area:"必须是整数",
			room_layout_orientations:"请选择朝向"
		},
		errorClass: "help-inline",
		errorElement: "span",
		highlight:function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('success');
			$(element).parents('.control-group').addClass('error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('error');
			$(element).parents('.control-group').addClass('success');
		},
		submitHandler: function() {
			var param = $("#add_room_layout_form").serialize();
			$.ajax({
			   url : url,
			   type : "post",
			   dataType : "json",
			   data: param,
			   success : function(data) {
			       if(data.success == 1) {
					   $('#modal_fail').modal('hide');
					   $('#modal_success').modal('show');
					   $('#modal_success_message').html(data.message);
					   room_layout_id = data.itemDate.room_layout_id;
					   url = data.redirect;
					   $('#modal_success').on('hidden.bs.modal', function () {
							$('#room_layout_attr a').tab('show');
					   })
			       } else {
					   $('#modal_success').modal('hide');
					   $('#modal_fail').modal('show');
					   $('#modal_fail_message').html(data.message);
			       }
			   }
			 });
		}
	});
	$('#room_layout_attr').click(function() {
		if (v.form()) {
			if(room_layout_id == '') return false;
		} else {
			return false;
		}
	});
	$('#room_layout_images').click(function() {
		if (v.form()) {
			if(room_layout_id == '') return false;
		} else {
			return false;
		}
	});
	$('#room_layout_price_setting').click(function() {
		if (v.form()) {
			if(room_layout_id == '') return false;
		} else {
			return false;
		}
	});
	var v_server = $('#add_room_layout_attr_form').validate({
		submitHandler: function() {
			var param = $("#add_room_layout_attr_form").serialize();
			$.ajax({
			   url : '<%$add_room_layout_attr_url%>&room_layout_id=' + room_layout_id,
			   type : "post",
			   dataType : "json",
			   data: param,
			   success : function(data) {
			       if(data.success == 1) {
					   $('#modal_fail').modal('hide');
					   $('#modal_success').modal('show');
					   $('#modal_success_message').html(data.message)
					   $('#modal_success').on('hidden.bs.modal', function () {
							$('#room_layout_images a').tab('show');
					   })
			       } else {
					   $('#modal_success').modal('hide');
					   $('#modal_fail').modal('show');
					   $('#modal_fail_message').html(data.message);
			       }
			   }
			 });
		}
	});
});
</script>
<%if $view=='1'%>
<script language="javascript">
$("form input,textarea,select").prop("readonly", true);
$('.save_info').hide();
$('#upload_images').hide();
</script>
<%/if%>
<script language="javascript">
function uploadSuccess(url, id) {
	if(id == '') {
		url = url.replace('/data/images/', '');//<%$upload_images_url%>
		
	}
	var html = '<li class="span2"><a class="thumbnail lightbox_trigger" href="'+url+'"><img id="room_layout_'+id+'" src="<%$__IMGWEB%>'+url+'" alt="" ></a>'
              +'<div class="actions">'
              +'<a title="" href="#"><i class="icon-pencil icon-white"></i></a>'
              +'<a title="" href="#"><i class="icon-remove icon-white"></i></a>'
              +'</div></li>';
	$('.thumbnails').append(html);
}
</script>
</body>
</html>