<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">
.modal-body{ padding:1px;}
.widget-box{margin-bottom:1px; margin-top:1px;}
</style>
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
<!--<script src="<%$__RESOURCE%>js/jquery.dataTables.min.js"></script>-->
<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
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
                            <label class="control-label"><%$arrayLaguage['checkin']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <input type="text" class="span2" id="book_check_int" name="book_check_int"/>
                                <%$arrayLaguage['checkout']['page_laguage_value']%> : 
                                <input type="text" class="span2" id="book_check_out" name="book_check_out "/>
                                <a href="#search" id="search_room_layout" class="btn btn-primary btn-mini"><i class="icon-plus-sign"></i> <%$arrayLaguage['find_room']['page_laguage_value']%></a>
                            </div>
                        </div>
             <div class="control-group">
             	<div class="controls">
                 <table class="table table-bordered data-table" id="room_layout">
                  <thead>
                    <tr>
                      <th><%$arrayLaguage['room_layout_name']['page_laguage_value']%></th>
                      <th><%$arrayLaguage['price']['page_laguage_value']%></th>
                      <th><%$arrayLaguage['book']['page_laguage_value']%></th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr class="gradeX">
                      <td>Trident</td>
                      <td>Internet
                        Explorer 4.0</td>
                      <td>Win 95+</td>
                    </tr>
                    <tr class="gradeC">
                      <td>Trident</td>
                      <td>Internet
                        Explorer 5.0</td>
                      <td>Win 95+</td>
                    </tr>
                    <tr class="gradeA">
                      <td>Trident</td>
                      <td>Internet
                        Explorer 5.5</td>
                      <td>Win 95+</td>
                    </tr>
                    <tr class="gradeA">
                      <td>Trident</td>
                      <td>Internet
                        Explorer 6</td>
                      <td>Win 98+</td>
                    </tr>
                    <tr class="gradeA">
                      <td>Trident</td>
                      <td>Internet Explorer 7</td>
                      <td>Win XP SP2+</td>
                    </tr>
                  </tbody>
                </table>  
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
	$.datetimepicker.setLocale('ch');
	var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() - 1);
	$('#book_check_int').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
		beforeShowDay: function(date) {
			if (date.getMonth() < dateToDisable.getMonth() || (date.getMonth() == dateToDisable.getMonth() && date.getDate() <= dateToDisable.getDate())) {
				return [false, ""];
			}
			return [true, ""];
		}
	});
	$('#book_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s'});
	
	$('#search_room_layout').click(function(e) {
        
    });
	
	$('#room_layout').DataTable({"paging": false});
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