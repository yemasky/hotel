<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">
.modal-body{ padding:1px;}
.widget-box{margin-bottom:1px; margin-top:1px;}
</style>
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
                    <span class="icon">
                        <i class="icon-th-list"></i>
                    </span>
                    <h5><%$arrayLaguage['book_info']['page_laguage_value']%> <%$today%></h5>
                </div>
                <div class="widget-content nopadding">
                    <form action="#" method="get" class="form-horizontal">
                    	<div class="control-group">
                            <label class="control-label"><%$arrayLaguage['contact_information']['page_laguage_value']%> :</label>
                            <div class="controls">
                            <input type="text"  class="span2" placeholder="<%$arrayLaguage['contacts']['page_laguage_value']%>"  /> 
                            <%$arrayLaguage['mobile']['page_laguage_value']%> : 
                            <input type="text"  class="span2" placeholder="<%$arrayLaguage['mobile']['page_laguage_value']%>"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['booking_information']['page_laguage_value']%> :</label>
                            <div class="controls">
                                
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['check_in_information']['page_laguage_value']%> :</label>
                            <div class="controls">
                            	<input name="book_user_name" value="" type="text" class="span2" placeholder="<%$arrayLaguage['name']['page_laguage_value']%>" /> 
                                <%$arrayLaguage['sex']['page_laguage_value']%> : 
                                <select name="book_user_sex" class="span1">
                                	<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                    <option value="1"><%$arrayLaguage['male']['page_laguage_value']%></option>
                                    <option value="0"><%$arrayLaguage['female']['page_laguage_value']%></option>
                                </select>
                                <%$arrayLaguage['identity_information']['page_laguage_value']%> : 
                                <select name="book_user_id_card_type" class="span1">
                                	<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                    <%section name=card_type loop=$idCardType%>
                                    <option value="<%$idCardType[card_type]%>"><%$arrayLaguage[$idCardType[card_type]]['page_laguage_value']%></option>
                                    <%/section%>
                                </select>
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['identification_number']['page_laguage_value']%>"/> 
                            </div>
                            <div class="controls">
                            <a href="#addAttr" class="btn btn-primary btn-mini addAttr"><i class="icon-plus-sign"></i> 增加属性值</a>
                            </div>
                            
                            
                        </div>                       
                        
                        
                        
                        
                        <div class="form-actions">
                            <button type="submit" class="btn btn-success">Save</button>
                        </div>
                    </form>
                </div>
            </div>   
        </div>
					
	  </div>
    
    </div>
</div>
</div>
<div id="addLayoutAttr" class="modal hide" style="display: none;" aria-hidden="true">
<form action="" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_attr_classes" id="add_attr_classes" novalidate>
  <div class="modal-header">
    <button data-dismiss="modal" class="close" type="button">×</button>
    <h3><%$arrayLaguage['add_customize_attr']['page_laguage_value']%></h3>
  </div>
  <div class="modal-body">
      <div class="widget-box">
        <div class="widget-content tab-content nopadding">
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['attr_classes']['page_laguage_value']%> :</label>
                    <div class="controls">
                        <select id="room_layout_attribute_id" name="room_layout_attribute_id" class="span2">
                            <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                            <!--<option value="0"><%$arrayLaguage['add_attr_classes']['page_laguage_value']%></option>-->
                            <%section name=attr loop=$arrayAttribute%>
                            <option value="<%$arrayAttribute[attr].room_layout_attribute_id%>"><%$arrayAttribute[attr].room_layout_attribute_name%></option>
                            <%/section%>
                         </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><%$arrayLaguage['attr_name']['page_laguage_value']%> :</label>
                    <div class="controls">
                        <input id="room_layout_attribute_name" name="room_layout_attribute_name" class="span2" placeholder="" value="" type="text">
                    </div>
                </div>
         </div>
      </div>
  </div>
  <div class="modal-footer"> <button type="submit" id="save_info" class="btn btn-success pagination-centered">Save</button> <a data-dismiss="modal" class="btn" href="#">Cancel</a> </div>
</form>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<script language="javascript">
$(document).ready(function(){	
	$('.addLayoutAttr').click(function(e) {
        $('#identifier').modal('show')
    });
	
	$("#add_attr_classes").validate({
		rules:{
			room_layout_attribute_id:{
				required:true
			},
			room_layout_attribute_name:{
				required:true
			}
		},
		messages: {
			room_layout_attribute_id:"请选择属性类别",
			room_layout_attribute_name:"请填写属性名称",
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
			var param = $("#add_attr_classes").serialize();
			$.ajax({
			   url : "<%$add_room_attribute_url%>",
			   type : "post",
			   dataType : "json",
			   data: param,
			   success : function(data) {
			       if(data.success == 1) {
					   $('#addLayoutAttr').modal('hide');
					   $('#modal_success').modal('show');
					   $('#modal_success_message').html(data.message);
					   $('#modal_success').on('hide.bs.modal', function () {
							window.location.reload();
					   });
					   $('#room_layout_attribute_name').val('');
			       } else {
					   $('#modal_fail').modal('show');
					   $('#modal_fail_message').html(data.message);
			       }
			   }
			 });
		}
	});
});//add_attr_classes

function update_sumbit() {		
	var param = $("#modify_attr_classes").serialize();
	$.ajax({
	   url : "<%$delete_room_attribute_url%>",
	   type : "post",
	   dataType : "json",
	   data: param,
	   success : function(data) {
		   if(data.success == 1) {
			   $('#addLayoutAttr').modal('hide');
			   $('#modal_success').modal('show');
			   $('#modal_success_message').html(data.message);
			   $('#modal_success').on('hide.bs.modal', function () {
					window.location.reload();
			   });
			   $('#room_layout_attribute_name').val('');
		   } else {
			   $('#modal_fail').modal('show');
			   $('#modal_fail_message').html(data.message);
		   }
	   }
	 });
}
</script>

</body>
</html>