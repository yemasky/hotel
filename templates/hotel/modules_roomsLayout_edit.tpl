<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<%include file="hotel/inc_js/editor_upload_images.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
<style type="text/css">
.quick-actions li {margin: 0 2px 2px !important;}
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
                <li id="set_room"><a data-toggle="tab" href="#tab3"><%$arrayLaguage['set_room']['page_laguage_value']%></a></li>
                <li id="room_layout_images"><a data-toggle="tab" href="#tab4"><%$arrayLaguage['upload_images']['page_laguage_value']%></a></li>
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
                    <label class="control-label"><%$arrayLaguage['room_layout_max_people']['page_laguage_value']%> :</label>
                    <div class="controls"><input type="text" class="span1" placeholder="<%$arrayLaguage['room_layout_max_people']['page_laguage_value']%>" name="room_layout_max_people" id="room_layout_max_people" value="<%$arrayDataInfo['room_layout_max_people']%>" /> </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['room_layout_max_children']['page_laguage_value']%> :</label>
                    <div class="controls"><input type="text" class="span1" placeholder="<%$arrayLaguage['room_layout_max_children']['page_laguage_value']%>" name="room_layout_max_children" id="room_layout_max_children" value="<%$arrayDataInfo['room_layout_max_children']%>" /> </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['room_layout_extra_bed']['page_laguage_value']%> :</label>
                    <div class="controls"><input type="text" class="span1" placeholder="<%$arrayLaguage['room_layout_extra_bed']['page_laguage_value']%>" name="room_layout_extra_bed" id="room_layout_extra_bed" value="<%$arrayDataInfo['room_layout_extra_bed']%>" /> </div>
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
                    <button type="submit" id="save_info" class="btn btn-primary pagination-centered save_info"><%$arrayLaguage['next_rooms_attribute_setting']['page_laguage_value']%></button>
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
                             	<%section name=attrValue loop=$arrayAttribute[attr].childen[attr_childen].values%>
                             	<input type="text" name="<%$arrayAttribute[attr].room_layout_attribute_id%>[<%$arrayAttribute[attr].childen[attr_childen].room_layout_attribute_id%>][]" class="span2" 
                                	value="<%$arrayAttribute[attr].childen[attr_childen].values[attrValue].room_layout_attribute_value%>">
                                <%/section%>
                                <input type="text" name="<%$arrayAttribute[attr].room_layout_attribute_id%>[<%$arrayAttribute[attr].childen[attr_childen].room_layout_attribute_id%>][]" class="span2" value=""> <a href="#addAttr" class="btn btn-primary btn-mini addAttr"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_attribute_value']['page_laguage_value']%></a>
                             </div>
                        	<%/section%>
                        	<!--<label class="control-label"><span><a href="#add" class="btn btn-primary btn-mini"><i class="icon-plus-sign"></i> <%$arrayLaguage['add_customize_attr']['page_laguage_value']%></a></span></label>-->
                            
                        </div>
                    </div>
                <%/section%>
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
           <div id="tab3" class="tab-pane">
               <div class="widget-content">
                <ul class="quick-actions" id="rooms">
                <%section name=room loop=$arrayRoom%>
                <li> 
                <a> <i class="icon-home"></i> <input id="<%$arrayRoom[room].room_id%>" data-id="<%$arrayRoom[room].room_id%>" class="span1" type="checkbox"<%if $arrayRoom[room].checked!='0'%> checked <%/if%>value="<%$arrayRoom[room].room_id%>"> <%$arrayRoom[room].room_name%>
                </a>
                <table>
                <tr>
                    <td align="right"><%$arrayLaguage['room_layout_max_people']['page_laguage_value']%> :</td>
                    <td align="left"><input type="text" class="span3" id="max_people_<%$arrayRoom[room].room_id%>" data-id="<%$arrayRoom[room].room_id%>" value="<%$arrayRoom[room].room_layout_room_max_people%>"></td>
                </tr>
                <tr>
                    <td align="right"><%$arrayLaguage['room_layout_max_children']['page_laguage_value']%> :</td>
                    <td align="left"><input type="text" class="span3" id="max_children_<%$arrayRoom[room].room_id%>" data-id="<%$arrayRoom[room].room_id%>" value="<%$arrayRoom[room].room_layout_room_max_children%>">
                    </td>
                </tr>
                <tr>
                    <td align="right"><%$arrayLaguage['room_layout_extra_bed']['page_laguage_value']%>: </td>
                    <td align="left"><input type="text" class="span3" id="extra_bed_<%$arrayRoom[room].room_id%>" data-id="<%$arrayRoom[room].room_id%>" value="<%$arrayRoom[room].room_layout_room_extra_bed%>">
                    </td>
                </tr>
                </table>
                </li> 
                <%/section%>
                </ul>
                </div>
           		<div class="control-group">
                    <div class="controls form-actions pagination-centered btn-icon-pg">
            	<!--<ul><li class="btn btn-primary" id="hotel_attribute_setting_btn">  </li></ul>-->
                    <button type="submit" id="room_next" class="btn btn-primary pagination-centered"><%$arrayLaguage['save_next']['page_laguage_value']%></button>
                    </div>
                </div>
            </div>
           <div id="tab4" class="tab-pane">
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
			},
			room_layout_max_people:{
				required:true,
				number:true,
				minlength:1,
				maxlength:5
			},
			room_layout_max_children:{
				required:true,
				number:true
			},
			room_layout_extra_bed:{
				required:true,
				number:true
			}
		},
		messages: {
			room_layout_name:"请输入房型名称，2~50个字符",
			room_layout_area:"必须是整数",
			room_layout_orientations:"请选择朝向",
			room_layout_max_people:"请输最多住几人，只能是整数",
			room_layout_max_children:"请输最多住几个小孩，必须是0和整数",
			room_layout_extra_bed:"请输可加床数，必须是0和整数"
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
			$('#room_layout_attr a').tab('show');
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
	$('#set_room').click(function() {
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
			var param = $("#add_room_layout_form").serialize();
			$.ajax({
			   url : url,
			   type : "post",
			   dataType : "json",
			   data: param,
			   success : function(data) {
			       if(data.success == 1) {
					   room_layout_id = data.itemData.room_layout_id;
					   saveRoomLayoutAttrValue();
					   /*$('#modal_fail').modal('hide');
					   $('#modal_success').modal('show');
					   $('#modal_success_message').html(data.message);
					   $('#modal_success').on('hidden.bs.modal', function () {
							
					   })*/
			       } else {
					   $('#modal_fail').modal('show');
					   $('#modal_fail_message').html(data.message);
			       }
			   }
			 });
			 
			
		}
	});
	function saveRoomLayoutAttrValue() {
		var param = $("#add_room_layout_attr_form").serialize();
        var view = '<%$view%>';
		$.ajax({
		   url : '<%$add_room_layout_attr_url%>&room_layout_id=' + room_layout_id,
		   type : "post",
		   dataType : "json",
		   data: param,
		   success : function(data) {
			   if(data.success == 1) {
				   //$('#modal_fail').modal('hide');
				   $('#modal_success').modal('show');
				   $('#modal_success_message').html(data.message)
				   $('#modal_success').on('hidden.bs.modal', function () {
					    if(view == 'add') {
                            if(data.redirect != '') {
                               window.location = data.redirect;
                            }
                        } else {
							$('#set_room a').tab('show');
                        }
				   })
			   } else {
				   //$('#modal_success').modal('hide');
				   $('#modal_fail').modal('show');
				   $('#modal_fail_message').html(data.message);
			   }
		   }
		 });
	}
    var step = '<%$step%>';
	if(step == 'upload_images') {$('#room_layout_images a').tab('show');}
	$('.addAttr').click(function(e) {
		$(this).before(" ").prev().clone().insertBefore(this).after(" ");
    });
    <%if $view!='1'%>
    $('#rooms :checkbox').click(function(e) {
        var extra_bed = $('#extra_bed_' + this.value).val();
        if(typeof(extra_bed) == 'undefined') extra_bed = 0;
        var url = '<%$add_room_layout_url%>&act=setRoomLayoutRoom&checked=' + this.checked + '&room_id=' + this.value + '&extra_bed=' + extra_bed;
        $.getJSON(url, function(result) {
            data = result;
        })
    });
    $('#rooms :text').keyup(function(e) {
        var checked = $('#'+$(this).attr('data-id')).attr('checked');
        if(checked == 'checked' || checked == true) {
            checked = 'true';
            var extra_bed = this.value;
            if(typeof(extra_bed) == 'undefined') extra_bed = 0;
            var url = '<%$add_room_layout_url%>&act=setRoomLayoutRoom&checked=' + checked + '&room_id=' + $(this).attr('data-id') + '&extra_bed=' + extra_bed;
            $.getJSON(url, function(result) {
                data = result;
            })
        }
    });
    $('#room_next').click(function(e) {
        $('#room_layout_images a').tab('show');
    });
    <%/if%>
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
function uploadSuccess(img_url, id) {
	if(id == '') {
		img_url = img_url.replace('/data/images/', '');//<%$upload_images_url%>
		$.getJSON(url + '&act=updateLayoutImages&room_layout_id=' 
				  + room_layout_id + '&url=' + img_url, function(data){
			if(data.success == 1) {
			   id = data.itemData.room_layout_images_id;
			   addLayoutImages(img_url, id);
			} else {
			   $('#modal_success').modal('hide');
			   $('#modal_fail').modal('show');
			   $('#modal_fail_message').html(data.message);
			}
		});
	} else {
		addLayoutImages(img_url, id);
	}

}

function addLayoutImages(img_url, id) {
	var html = '<li class="span2"><a class="thumbnail lightbox_trigger" href="'+img_url
	          +'"><img id="room_layout_'+id+'" src="<%$__IMGWEB%>'+img_url+'" alt="" ></a>'
              +'<div class="actions">'
              +'<a title="" href="#"><i class="icon-pencil icon-white"></i></a>'
              +'<a title="" href="#"><i class="icon-remove icon-white"></i></a>'
              +'</div></li>';
	$('.thumbnails').append(html);
}
</script>
</body>
</html>