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
		    var sales_type_id = $('#book_sales_type_id').val();
            if(sales_type_id == '') {
                $('#modal_info').modal('show');
                $('#modal_info_message').html('请选择客人来源！')
                return;
            }
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
        type_select:{},
        instance: function() {
            var memberSetting = {};
            memberSetting.init = function() {
                //$('.collapse').collapse();
                $('._edit .edit_btn').click(function(e) {
                    $('._edit .edit_checkbox i').removeClass('am-icon-dot-circle-o');
                    $(this).parent().parent().find('i').first().addClass('am-icon-dot-circle-o');
                    $('#book_type').val($(this).parent().attr('father-id'));
                    $('#book_type_select').val($(this).parent().attr('father-id'));
                    $('#book_type_name').val($(this).parent().attr('data-name'));
                    $('#book_type_id').val($(this).parent().attr('data-id'));
                    $('#type').val($(this).parent().attr('dtype'));
                    $('.set_type i').removeClass('am-icon-check-circle').addClass('am-icon-circle-thin');
                    $('#type_'+$(this).parent().attr('sales_type')).find('i').removeClass('am-icon-circle-thin').addClass('am-icon-check-circle');
                    $('#book_sales_type_id').val($(this).parent().attr('sales_type'));
                    $('#edit_data').collapse('show');
                    $('#discount_data').collapse('hide');
                    $("#book_type_select").attr("disabled",true);
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
                    $('#edit_data').collapse('show');
                    $('#discount_data').collapse('hide');
                    $("#book_type_select").attr("disabled",false);
                    $('.set_type i').addClass('am-icon-circle-thin').removeClass('am-icon-check-circle');
                    $('#edit_form input').val('');$('#book_type_select').val('');
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
                    var type = $(this).attr('type');
                    $('#book_discount_id').val(id);
                    $('#book_discount_type').val(type);
                    $('#discount_tr'+id).find('td').each(function(index, element) {
                        memberSetting.editDiscount(this);
                    });
                    $('#discount_tr'+id).next().find('td').each(function(index, element) {
                        memberSetting.editDiscount(this);
                    });
                    $('#discount_data').collapse('show');
                    $('#book_discount_add_on').text('%');
                    if(type == 1) {
                        $('#book_discount_add_on').text('元');
                    }
                });
                $('#book_discount_type').change(function () {
                    $('#book_discount_add_on').text('%');
                    if(this.value == 1) {
                        $('#book_discount_add_on').text('元');
                    }
                })
                $('.removeBtn').click(function(e) {
                    //$(this).parent().parent().parent().next().addClass('hide');
                });
                $('.set_type').click(function () {
                    if($('#book_type_select').attr('disabled')) {
                        //$('#modal_info').modal('show');
                        //$('#modal_info_message').html('只有新增状态才能改变选择！')
                        return;
                    }
                    memberSetting.setType(this);
                });
                $('#book_type_select').change(function(){
                    $('#book_type').val(this.value);
                });
            };
            memberSetting.setType = function(_this) {
                $('.set_type i').removeClass('am-icon-check-circle').addClass('am-icon-circle-thin');
                $(_this).find('i').removeClass('am-icon-circle-thin').addClass('am-icon-check-circle');
                $('#book_sales_type_id').val($(_this).attr('value'));
                $('#type').val($(_this).attr('type'));
            }
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