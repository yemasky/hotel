<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
<script src="<%$__RESOURCE%>js/jquery.dataTables.min.1.10.12.js"></script>
<!--<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>-->
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.dataTables.min.1.10.12.css" />
<style type="text/css">
.modal-body{ padding:1px;}
.widget-box{margin-bottom:1px; margin-top:1px;}
#room_layout_paginate a{border:1px solid #BFBDBD;}
.dataTables_wrapper .dataTables_paginate .paginate_button {border-radius: 0;margin-left: 0;min-width: 0;padding: 0.1em 0.5em;}
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
                        <i class="icon-th-list"></i>
                    </span>
                    <h5><%$arrayLaguage['book_info']['page_laguage_value']%> <%$today%></h5>
                </div>
                <div class="widget-content nopadding">
                    <form action="#" method="post" class="form-horizontal" enctype="multipart/form-data" name="book_form" id="book_form">
                    	<div class="control-group">
                            <label class="control-label"><%$arrayLaguage['contact_information']['page_laguage_value']%> :</label>
                            <div class="controls">
                            <input type="text" id="book_contact_name" name="book_contact_name" class="span2" placeholder="<%$arrayLaguage['contacts']['page_laguage_value']%>"  /> 
                            <%$arrayLaguage['mobile']['page_laguage_value']%> : 
                            <input type="text" id="book_contact_mobile" name="book_contact_mobile" class="span2" placeholder="<%$arrayLaguage['mobile']['page_laguage_value']%>"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['book_type']['page_laguage_value']%> :</label>
                            <div class="controls">
                            	 <select name="book_type_id" id="book_type_id" class="span2">
                                 <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                 <%section name=type loop=$arrayBookType%>
                                 	<%if $arrayBookType[type].book_type_father_id!=$arrayBookType[type].book_type_id%>
                                	<option value="<%$arrayBookType[type].book_type_id%>"><%$arrayBookType[type].book_type_name%></option>
                                    <%/if%>
                                 <%/section%>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['discount']['page_laguage_value']%> :</label>
                            <div class="controls">
                            	 <input type="text" id="discount" class="span1" placeholder="<%$arrayLaguage['discount']['page_laguage_value']%>"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['checkin']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <input type="text" class="span2" id="book_check_int" name="book_check_int" value="<%$book_check_int%>"/>
                                <%$arrayLaguage['checkout']['page_laguage_value']%> : 
                                <input type="text" class="span2" id="book_check_out" name="book_check_out" value="<%$book_check_out%>"/>
                                <!--<%$arrayLaguage['number_of_people']['page_laguage_value']%> : 
                                <input type="text" class="span1" id="room_layout_max_people" name="room_layout_max_people" placeholder="<%$arrayLaguage['number_of_people']['page_laguage_value']%>"  />-->
                                <a href="#search" id="search_room_layout" class="btn btn-primary btn-mini" data-style="expand-left"><i class="am-icon-search"></i> <%$arrayLaguage['find_room']['page_laguage_value']%></a>
                            </div>
                        </div>
                         <div class="control-group" id="room_layout_table">
                            <div class="controls">
                             <table class="table table-bordered data-table" id="room_layout">
                              <thead>
                                <tr>
                                  <th><%$arrayLaguage['room_layout_name']['page_laguage_value']%></th>
                                  <th><%$arrayLaguage['price']['page_laguage_value']%></th>
                                  <th><%$arrayLaguage['book']['page_laguage_value']%></th>
                                </tr>
                              </thead>
                              <tbody id='room_layout_data'>
                                <tr class="gradeX">
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                </tr>
                              </tbody>
                            </table>  
                          </div>
                        </div>
                        <div class="control-group">
                        	<label class="control-label"><%$arrayLaguage['total_price']['page_laguage_value']%> :</label>
                            <div class="controls">
                             <input value="" type="text" class="span1" id="total_price" /> 
                             <%$arrayLaguage['prepayment']['page_laguage_value']%> :
                             <input value="" type="text" class="span1" id="prepayment" /> 
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
                            <a href="#addBookUser" id="addBookUser" class="btn btn-primary btn-mini"><i class="am-icon-plus-circle"></i> <%$arrayLaguage['add_number_of_people']['page_laguage_value']%></a>
                            <a href="#reduceBookUser" id="reduceBookUser" class="btn btn-waring btn-mini"><i class="am-icon-minus-circle"></i> <%$arrayLaguage['add_number_of_people']['page_laguage_value']%></a>
                            </div>
                            
                        </div>                      
                        <div class="form-actions pagination-centered">
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
	var contact_info_validate = $("#book_form").validate({
		rules:{
			book_contact_name:{
				required:true
			},
			book_contact_mobile:{
				required:true,
				isMobile:true
			}
		},
		messages: {
			book_contact_name:"请填写联系人",
			book_contact_mobile:"请填写正确的移动电话号码",
		},
		errorClass: "text-error",
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
			
		}
	});
	//日历
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
	$('#book_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
		beforeShowDay: function(date) {
			if (date.getMonth() < dateToDisable.getMonth() || (date.getMonth() == dateToDisable.getMonth() && date.getDate() <= dateToDisable.getDate())) {
				return [false, ""];
			}
			return [true, ""];
		}
	});
	
	//搜索
	table = $('#room_layout').DataTable( {
		paging: false
	} );
	$('#search_room_layout').click(function(e) {
		if(contact_info_validate.form()) {
			ajaxGetRoomLayout();
		} else {
			return false;
		}
		
    });
	function ajaxGetRoomLayout() {
		$.ajax({
		   url : '<%$searchBookInfoUrl%>&search=searchRoomLayout&discount=' + $('#discount').val(),
					  // + '&room_layout_max_people=' + $('#room_layout_max_people').val()
		   type : "post",
		   data : 'book_check_int=' + $('#book_check_int').val() 
					  + '&book_check_out=' + $('#book_check_out').val(),
		   dataType : "json",
		   success : function(data) {
			   if(data.success == 1) {
				   $('#room_layout_table').show();
				    table.destroy();
					$('#room_layout_data').html(data.itemData);
					table = $('#room_layout').DataTable({
						"pagingType":   "numbers"
					})
					$('#room_layout_length').hide();
					$('.room_layout_id').change(function(e) {
						 var all_val = 0; //定义变量全部保存
						 $(".room_layout_id").each(function () {
							 var val = $(this).val() - 0; //获取单个value
							 all_val += val;
						 });
						 $('#total_price').val(all_val);
                    });
			   } else {
				   $('#modal_fail').modal('show');
				   $('#modal_fail_message').html(data.message);
			   }
		   }
		});
	}
	
	$('#book_contact_mobile').keyup(function(e) {
        if($('#book_contact_mobile').val().length == 11) {
			$.ajax({
			   url : "<%$searchBookInfoUrl%>&search=searchUserMemberLevel",
			   type : "post",
			   dataType : "json",
			   data: "book_contact_mobile=" + $('#book_contact_mobile').val(),
			   success : function(data) {
				   if(data.success == 1) {
					   if(data.itemData != '') {
						   $('#agreement_company').remove();
						   $('#book_type_id').val(data.itemData.book_type_id);
						   $('#discount').val(data.itemData.book_discount);
						   if(data.itemData.agreement_company_name != '') {
							   var agreement_company = ' <input readonly id="agreement_company" value="'+
							                           data.itemData.agreement_company_name+'" type="text" class="span2"/> '
							   $('#book_type_id').after(agreement_company);
						   } else {
								var agreement_company = ' <input readonly id="agreement_company" value="'+
														   data.itemData.book_discount_name+'" type="text" class="span2"/> '
								$('#book_type_id').after(agreement_company);
						   }
					   }
				   } else {
					   $('#modal_fail').modal('show');
					   $('#modal_fail_message').html(data.message);
				   }
			   }
			 });
		}
    });
	var BookUser_num = 1;
	$('#addBookUser').click(function(e) {
        $(this).parent().prev().clone().insertBefore($(this).parent());
		BookUser_num++;
    });
	$('#reduceBookUser').click(function(e) {
		if(BookUser_num == 1) return;
        $(this).parent().prev().remove();
		BookUser_num--;
    });
	
});//add_attr_classes

function update_sumbit() {		
	/*var param = $("#modify_attr_classes").serialize();
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
	 });*/
}
</script>

</body>
</html>