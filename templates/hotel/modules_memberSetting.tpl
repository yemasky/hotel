<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">
.form-horizontal .control-label{padding-top:10px;}
.table-bordered th, .table-bordered td:first-child {border-left: 0px solid #ddd !important;}
.table-bordered td{font-size:12px;}
.table.in-check tr th:first-child, .table.in-check tr td:first-child {width: 45px;}
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
                <div class="widget-title">
                    <ul class="nav nav-tabs">
                        <li class="active" id=""><a data-toggle="tab" href="#tab1">会员及来源</a></li>
                        <li id="discount_tab"><a data-toggle="tab" href="#tab2"><i class="am-icon-puzzle-piece am-red-FB0000"></i> 折扣</a></li>
                    </ul>
                </div>
                <div class="widget-content nopadding tab-content">
                    <div id="tab1" class="tab-pane active">
                        <form method="post" class="form-horizontal" enctype="multipart/form-data" novalidate>
                        <div class="control-group">
                         <%foreach key=book_type_id item=BookType from=$arrayData%>
                            <label class="control-label _edit">
                            <div class="btn-group">
                                <a class="btn btn-inverse edit_checkbox" href="#view"><i class="am-icon-circle-o"></i> <%$BookType.book_type_name%></a><%if $BookType.hotel_id > 0%><a class="btn btn-inverse dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                <ul class="dropdown-menu" data-id="<%$BookType.book_type_id%>" data-name="<%$BookType.book_type_name%>" father-id="<%$BookType.book_type_father_id%>"><li class="edit_btn"><a href="#edit"><i class="am-icon-pencil am-yellow-FFAA3C"></i> Edit</a></li><%if $BookType.children==''%><li><a href="#delete"><i class="am-icon-trash am-red-FB0000"></i> Delete</a></li><%/if%></ul><%/if%>
                            </div>
                            </label>
                            <div class="controls _edit">
                            <%section name=j loop=$BookType.children%>
                                <div class="btn-group"><a class="btn edit_checkbox" href="#view"><i class="am-icon-circle-o"></i> <%$BookType.children[j].book_type_name%> <!--<i class="am-icon-rmb am-yellow-F58A17"></i> <%$BookType.children[j].type%>--></a><a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a><ul class="dropdown-menu" data-id="<%$BookType.children[j].book_type_id%>" data-name="<%$BookType.children[j].book_type_name%>" father-id="<%$BookType.children[j].book_type_father_id%>" dtype="<%$BookType.children[j].type%>"><li class="edit_btn"><a href="#edit"><i class="am-icon-edit am-yellow-FFAA3C"></i> Edit</a></li><li class="discount_btn"><a href="#discount"><i class="am-icon-puzzle-piece am-red-FB0000"></i> <%$arrayLaguage['add_discount']['page_laguage_value']%></a></li><li><a href="#delete"><i class="am-icon-trash am-red-FB0000"></i> Delete</a></li></ul></div>
                            <%/section%>    
                            </div>
                         <%/foreach%>
                            <div class="controls">
                                <a class="btn btn-primary btn-mini add_data"><i class="am-icon-plus-circle"></i> <%$arrayLaguage['add_category']['page_laguage_value']%></a>
                            </div>
                         
                        </div>
                        </form>
                    </div>
                    <div id="tab2" class="tab-pane">
                          <div class="widget-content nopadding">
                            <table class="table table-bordered table-striped with-check">
                              <tbody>
                                <tr>
                                  <td><i class="am-icon-circle"></i></td>
                                  <td><%$arrayLaguage['apellation']['page_laguage_value']%></td>
                                  <td>折扣名称</td>
                                  <td><%$arrayLaguage['discount']['page_laguage_value']%></td>
                                  <td>公司名称</td>
                                  <td></td>
                                </tr>
                              </tbody>
                              <tbody>
                              <%section name=i loop=$arrayDiscount%>
                                <tr class="discount_tr" id="discount_tr<%$arrayDiscount[i].book_discount_id%>">
                                  <td class="discount_td"><div class="checker" id="uniform-undefined"><span><%$smarty.section.i.index+1%></span></div></td>
                                  <td class="discount_td" btype="book_type_name"><%$arrayType[$arrayDiscount[i].book_type_id].book_type_name%></td>
                                  <td class="discount_td" btype="book_discount_name"><%$arrayDiscount[i].book_discount_name%></td>
                                  <td class="discount_td" btype="book_discount"><%$arrayDiscount[i].book_discount%></td>
                                  <td class="discount_td" btype="agreement_company_name"><%$arrayDiscount[i].agreement_company_name%></td>
                                  <td>
                                    <div class="btn-group">
                                       <button data-id="<%$arrayDiscount[i].book_discount_id%>" class="btn btn-mini btn-warning editBtn"><i class="am-icon-edit"></i> 编辑</button> 
                                       <button data-id="<%$arrayDiscount[i].book_discount_id%>" class="btn btn-mini btn-danger removeBtn"><i class="am-icon-minus-circle"></i> 删除</button>
                                    </div>
                                  </td>
                                </tr>
                                <tr class="hide">
                                  <td colspan="6">
                                      <table class="table table-bordered table-striped with-check in-check">
                                          <tbody>
                                            <tr>
                                              <th></th>
                                              <th><%$arrayLaguage['contacts']['page_laguage_value']%></th>
                                              <th><%$arrayLaguage['phone']['page_laguage_value']%></th>
                                              <th><%$arrayLaguage['mobile']['page_laguage_value']%></th>
                                              <th>Email</th>
                                            </tr>
                                            <tr>
                                              <th></th>
                                              <td btype="agreement_company_contacts"><%$arrayDiscount[i].agreement_company_contacts%></td>
                                              <td btype="agreement_company_phone"><%$arrayDiscount[i].agreement_company_phone%></td>
                                              <td btype="agreement_company_mobile"><%$arrayDiscount[i].agreement_company_mobile%></td>
                                              <td btype="agreement_company_email"><%$arrayDiscount[i].agreement_company_email%></td>
                                            </tr>
                                            <tr>
                                              <th>有效时间</th>
                                              <td colspan="5" btype="agreement_active_time">
                                                <%$arrayDiscount[i].agreement_active_time_begin%> <%$arrayDiscount[i].agreement_active_time_end%>
                                              </td>
                                            </tr>
                                            <tr>
                                              <th>介绍</th>
                                              <td colspan="5" btype="agreement_company_introduction"><%$arrayDiscount[i].agreement_company_introduction%></td>
                                            </tr>
                                            <tr>
                                              <th>协议</th>
                                              <td colspan="5" btype="agreement_content"><%$arrayDiscount[i].agreement_content%></td>
                                            </tr>
                                            <tr>
                                              <th><%$arrayLaguage['address']['page_laguage_value']%></th>
                                              <td colspan="5" btype="agreement_company_address"><%$arrayDiscount[i].agreement_company_address%></td>
                                            </tr>
                                          </tbody>
                                      </table>
                                  </td>
                                </tr>
                              <%/section%>  
                              </tbody>
                            </table>
                          </div>
                    </div>
                </div>
                <div id="edit_data" class="panel-collapse collapse widget-content nopadding">
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
                                        <%foreach key=book_type_id item=Data from=$arrayData%>
                                            <option value="<%$Data.book_type_id%>"><%$Data.book_type_name%></option>
                                        <%/foreach%>
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
                                        <input id="book_type_name" name="book_type_name" class="span2" value="" type="text">
                                        <input id="book_type_id" name="book_type_id" value="" type="hidden">
                                    </div>
                                </div>
                                <div class="control-group"> 
                                    <div class="controls"><button type="submit" id="save_info" data-loading-text="Loading..." class="btn btn-success pagination-centered">Save</button> <a data-toggle="collapse" data-target="#edit_data" class="btn" href="#">Cancel</a> 
                                    </div>  
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="discount_data" class="panel-collapse collapse widget-content nopadding">
                <form method="post" class="form-horizontal" enctype="multipart/form-data" name="discount_form" id="discount_form" novalidate>
                    <input type="hidden" value="" name="book_discount_id" id="book_discount_id">
                    <input type="hidden" value="" name="discount_book_type_id" id="discount_book_type_id">
                    <div class="control-group">
                        <label class="control-label"><span id="discount_name"></span><%$arrayLaguage['discount']['page_laguage_value']%></label>
                        <div class="controls"></div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">折扣名称：</label>
                        <div class="controls">
                            <input id="book_discount_name" name="book_discount_name" class="input-medium" value="" type="text">
                            折扣：<input id="book_discount" name="book_discount" class="input-medium" value="" type="text">
                            <a data-toggle="collapse" data-target="#more_option" class="btn btn-primary btn-mini"><i class="am-icon-chevron-circle-down"></i> 更多选项</a>
                        </div>
                    </div>
                    <div class="control-group">
                        <div id="more_option" class="panel-collapse collapse">
                            <label class="control-label">公司\团体名称：</label>
                            <div class="controls">
                            <input id="agreement_company_name" name="agreement_company_name" class="input-large" value="" type="text">
                            </div>
                            <label class="control-label"><%$arrayLaguage['address']['page_laguage_value']%> ： </label>
                            <div class="controls"><input id="" name="" class="span5" value="" type="text"></div>
                            <label class="control-label"><%$arrayLaguage['contacts']['page_laguage_value']%> ： </label>
                            <div class="controls">
                                <input id="agreement_company_contacts" name="agreement_company_contacts" class="input-small" value="" type="text">
                                <%$arrayLaguage['phone']['page_laguage_value']%> ： 
                                <input id="agreement_company_phone" name="agreement_company_phone" class="input-small" value="" type="text">
                                <%$arrayLaguage['mobile']['page_laguage_value']%> ： 
                                <input id="agreement_company_mobile" name="agreement_company_mobile" class="input-small" value="" type="text">
                                Email ： 
                                <input id="agreement_company_email" name="agreement_company_email" class="input-small" value="" type="text">
                            </div>
                            <label class="control-label">公司\团体介绍 ： </label>
                            <div class="controls"><textarea name="agreement_company_introduction" id="agreement_company_introduction" class="span5"></textarea></div>
                            <label class="control-label">协议内容 ： </label>
                            <div class="controls"><textarea name="agreement_content" id="agreement_content" class="span5"></textarea></div>
                            <label class="control-label">有效时间 <i class="am-icon-calendar"></i> ： </label>
                            <div class="controls">
                                <input id="agreement_active_time_begin" name="agreement_active_time_begin" class="input-small" value="" type="text"> - 
                                <input id="agreement_active_time_end" name="agreement_active_time_end" class="input-small" value="" type="text">
                            </div>
                        </div>
                        <div class="controls"><button type="submit" data-loading-text="Loading..." class="btn btn-success pagination-centered">Save</button> <a data-toggle="collapse" data-target="#discount_data" class="btn" href="#">Cancel</a> 
                        </div>  
                    </div>
                </form>    
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
    
    var discount_form_validate = $("#discount_form").validate({
		rules: {
			book_discount_name: {required: true},
            book_discount: {required: true},
		},
		messages: {
			book_discount_name:"",
            book_discount:"",
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
            var param = $("#discount_form").serialize();
            var url = '';
            var add = '<%$add_url%>';
            var edit = '<%$edit_url%>';
            url = add;
            if($('#book_discount_id').val() > 0) url = edit;
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
                //$('.collapse').collapse();
                $('._edit .edit_btn').click(function(e) {
                    $('._edit .edit_checkbox i').removeClass('am-icon-dot-circle-o');
                    $(this).parent().parent().find('i').first().addClass('am-icon-dot-circle-o');
                    $('#book_type').val($(this).parent().attr('father-id'));
                    $('#book_type_name').val($(this).parent().attr('data-name'));
                    $('#book_type_id').val($(this).parent().attr('data-id'));
                    $('#type').val($(this).parent().attr('dtype'));
                    $('#edit_data').collapse('show');
                    $('#discount_data').collapse('hide');
                });
                $('._edit .discount_btn').click(function(e) {
                    $('._edit .edit_checkbox i').removeClass('am-icon-dot-circle-o');
                    $(this).parent().parent().find('i').first().addClass('am-icon-dot-circle-o');
                    $('#edit_data').collapse('hide');
                    $('#discount_data').collapse('show');
                    $('#discount_name').text($(this).parent().attr('data-name'));
                    $('#discount_form input').val('');
                    $('#discount_book_type_id').val($(this).parent().attr('data-id'));
                });
                $('.add_data').click(function(e) {
                    $('._edit .edit_checkbox i').removeClass('am-icon-dot-circle-o');
                    $('#book_type').val('');
                    $('#book_type_name').val('');
                    $('#book_type_id').val('');
                    $('#edit_data').collapse('show');
                    $('#discount_data').collapse('hide');
                });
                $('#book_type').change(function(e) {
                    if($(this).val() == 0) {
                        $('#book_type_name').val('');
                        $('#book_type_id').val('');
                    } else {
                        
                    }
                });
                $('#discount_tab').click(function(e) {
                    $('#discount_data').collapse('hide');$('#edit_data').collapse('hide');
                })
                $('.discount_td').click(function(e) {
                    if($(this).parent().next().hasClass('hide')) {
                        $(this).parent().next().removeClass('hide');
                    } else {
                        $(this).parent().next().addClass('hide');
                    }
                });
                $('.editBtn').click(function(e) {
                    var id = $(this).attr('data-id');
                    $('#book_discount_id').val(id);
                    $('#discount_tr'+id).find('td').each(function(index, element) {
                        memberSetting.editDiscount(this);
                    });
                    $('#discount_tr'+id).next().find('td').each(function(index, element) {
                        memberSetting.editDiscount(this);
                    });
                    $('#discount_data').collapse('show');
                });
                $('.removeBtn').click(function(e) {
                    //$(this).parent().parent().parent().next().addClass('hide');
                }); 
            };
            memberSetting.getDiscount = function(book_type_id) {
                $.getJSON('<%$searchBookInfoUrl%>&search=discount&book_type_id='+book_type_id, function(result) {
                    data = result;
                    if(data.itemData != null && data.itemData != '') {
                        
                    } else {
                        
                    }
                })
            };
            memberSetting.editDiscount = function(_this) {
                if(typeof($(_this).attr('btype') != 'undefined')) {
                    var btype = $(_this).attr('btype');
                    $('#'+btype).val($(_this).text());
                    if(btype == 'agreement_company_name') {
                        if($(_this).text() == '') $('#more_option').collapse('hide');
                        if($(_this).text() != '') $('#more_option').collapse('show');
                    }
                }
            }
            return memberSetting;
        },
        
    }
    var memberSetting = MemberSettingClass.instance();
    memberSetting.init();

})
$('#edit_data').collapse('hide');$('#discount_data').collapse('hide');$('#more_option').collapse('hide');
</script>
</body>
</html>