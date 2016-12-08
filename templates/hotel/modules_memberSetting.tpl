<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">
.btn-group .btn {border: 1px solid #8C8585}
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
            <div class="widget-box widget-calendar">
							
                <div class="widget-title">
                    <span class="icon"><i class="am-icon-cubes am-yellow-F58A17"></i></span>
                    <h5><%$selfNavigation.hotel_modules_name%></h5>
                    <div class="buttons" id="btn_room_layout">
                        <a class="btn btn-primary btn-mini add_data" href="#add"><i class="am-icon-plus-square"></i> 
                        &#12288;<%$arrayLaguage['add_category']['page_laguage_value']%></a>
                    </div>
                </div>
                <div class="widget-content nopadding">
                    <form method="post" class="form-horizontal" enctype="multipart/form-data" novalidate>
                    <div class="control-group">
                     <%section name=i loop=$arrayData%>
                        <label class="control-label">
                        <!--<%$arrayData[i].book_type_name%> :-->
                        
                        </label>
                        <div class="controls _edit">
                        <div class="btn-group">
                            <a class="btn btn-inverse edit_checkbox" href="#view"><i class="am-icon-circle-o"></i> <%$arrayData[i].book_type_name%></a><%if $arrayData[i].hotel_id > 0%><a class="btn btn-inverse dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                            <ul class="dropdown-menu" data-id="<%$arrayData[i].book_type_id%>" data-name="<%$arrayData[i].book_type_name%>" father-id="<%$arrayData[i].book_type_father_id%>"><li class="edit_btn"><a href="#edit"><i class="am-icon-pencil am-yellow-FFAA3C"></i> Edit</a></li><%if $arrayData[i].children==''%><li><a href="#delete"><i class="am-icon-trash am-red-FB0000"></i> Delete</a></li><%/if%></ul><%/if%>
                        </div>
                        <%section name=j loop=$arrayData[i].children%>
                            <div class="btn-group"><a class="btn edit_checkbox" href="#view"><i class="am-icon-circle-o"></i> <%$arrayData[i].children[j].book_type_name%> <!--<i class="am-icon-rmb am-yellow-F58A17"></i> <%$arrayData[i].children[j].type%>--></a><a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a><ul class="dropdown-menu" data-id="<%$arrayData[i].children[j].book_type_id%>" data-name="<%$arrayData[i].children[j].book_type_name%>" father-id="<%$arrayData[i].children[j].book_type_father_id%>" dtype="<%$arrayData[i].children[j].type%>"><li class="edit_btn"><a href="#edit"><i class="am-icon-edit am-yellow-FFAA3C"></i> Edit</a></li><li class="discount_btn"><a href="#discount"><i class="am-icon-puzzle-piece am-red-FB0000"></i> <%$arrayLaguage['discount']['page_laguage_value']%></a></li><li><a href="#delete"><i class="am-icon-trash am-red-FB0000"></i> Delete</a></li></ul></div>
                        <%/section%>    
                        </div>
                        <%/section%>
                        <div class="controls">
                            <a class="btn btn-primary btn-mini add_data"><i class="am-icon-plus-circle"></i> <%$arrayLaguage['add_category']['page_laguage_value']%></a>
                        </div>
                     
                    </div>
                    </form>
                </div>
                <div id="edit_data" class="collapse widget-content nopadding">
                    <div class="control-group">
                        <div class="controls">
                            <form method="post" class="form-horizontal" enctype="multipart/form-data" name="edit_form" id="edit_form" novalidate>
                                <div class="modal-header">
                                    <button data-toggle="collapse" data-target="#edit_data" class="close" type="button">×</button>
                                    <h3><%$arrayLaguage['add_or_edit_category']['page_laguage_value']%></h3>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%$arrayLaguage['select_category']['page_laguage_value']%> :</label>
                                    <div class="controls">
                                        <select name="book_type" id="book_type" class="span2">
                                        <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                        <option value="0"><%$arrayLaguage['new_category']['page_laguage_value']%></option>
                                        <%section name=i loop=$arrayData%>
                                            <option value="<%$arrayData[i].book_type_id%>"><%$arrayData[i].book_type_name%></option>
                                        <%/section%>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%$arrayLaguage['selective_type']['page_laguage_value']%> :</label>
                                    <div class="controls">
                                        <select name="type" id="type" class="span2">
                                        <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                        <%section name=i loop=$memberType%>
                                            <option value="<%$memberType[i]%>"><%$arrayLaguage[$memberType[i]]['page_laguage_value']%></option>
                                        <%/section%>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%$arrayLaguage['apellation']['page_laguage_value']%> :</label>
                                    <div class="controls">
                                        <input id="book_type_name" name="book_type_name" class="span2" placeholder="" value="" type="text">
                                        <input id="book_type_id" name="book_type_id" value="" type="hidden">
                                    </div>
                                </div>
                                <div class="control-group"> 
                                    <div class="controls"><button type="submit" id="save_info" class="btn btn-success pagination-centered">Save</button> <a data-toggle="collapse" data-target="#edit_data" class="btn" href="#">Cancel</a> 
                                    </div>  
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="discount_data" class="collapse widget-content nopadding">
                    <div class="control-group">
                        <div class="controls">
                            sssfafafaf
                        </div>
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
<script language="javascript">
$(document).ready(function(){
    var edit_form_validate = $("#edit_form").validate({
		rules: {
			book_type: {required: true},
            book_type_name: {required: true},
            type: {required: true},
		},
		messages: {
			book_type_name:"",
            book_type:"",
            type:'',
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
            var param = $("#edit_form").serialize();
            var url = '';
            var add = '<%$add_url%>';
            var edit = '<%$edit_url%>';
            url = add;
            if($('#book_type').val() > 0) url = edit;
            $.ajax({
                url : url,
                type : "post",dataType : "json",data: param,
                success : function(result) {
                    data = result;
                    if(data.success == 1) {
                        $('#modal_success').modal('show');
                        $('#modal_success_message').html(data.message);
                        
                    } else {
                        $('#modal_fail').modal('show');
                        $('#modal_fail_message').html(data.message);
                    }
                }
            });
            return;
		}
	});
    
    var MemberSettingClass = {
        instance: function() {
            var memberSetting = {};
            memberSetting.init = function() {
                $('._edit .edit_btn').click(function(e) {
                    $('._edit .edit_checkbox i').removeClass('am-icon-dot-circle-o');
                    $(this).parent().parent().find('i').first().addClass('am-icon-dot-circle-o');
                    $('#book_type').val($(this).parent().attr('father-id'));
                    $('#book_type_name').val($(this).parent().attr('data-name'));
                    $('#book_type_id').val($(this).parent().attr('data-id'));
                    $('#type').val($(this).parent().attr('dtype'));
                    $('#discount_data').collapse({toggle: true})
                    $('#discount_data').collapse('hide');
                    $('#edit_data').collapse({toggle: true})
                    $('#edit_data').collapse('show');
                    
                });
                $('._edit .discount_btn').click(function(e) {
                    $('._edit .edit_checkbox i').removeClass('am-icon-dot-circle-o');
                    $(this).parent().parent().find('i').first().addClass('am-icon-dot-circle-o');
                    $('#edit_data').collapse({toggle: true})
                    $('#edit_data').collapse('hide');
                    $('#discount_data').collapse({toggle: true})
                    $('#discount_data').collapse('show');
                    
                });
                $('.add_data').click(function(e) {
                    $('._edit .edit_checkbox i').removeClass('am-icon-dot-circle-o');
                    $('#book_type').val('');
                    $('#book_type_name').val('');
                    $('#book_type_id').val('');
                    $('#edit_data').collapse({toggle: true})
                    $('#edit_data').collapse('show');
                });
                $('#book_type').change(function(e) {
                    if($(this).val() == 0) {
                        $('#book_type_name').val('');
                        $('#book_type_id').val('');
                    } else {
                        
                    }
                });
            };
            return memberSetting;
        },
        
    }
    var memberSetting = MemberSettingClass.instance();
    memberSetting.init();
    
    

})
</script>
</body>
</html>