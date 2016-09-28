/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
jQuery.validator.addMethod("isMobile", function(value, element) {
		var length = value.length;
		var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
		return this.optional(element) || (length == 11 && mobile.test(value));
	}, "请正确填写您的手机号码");
$(document).ready(function(){

	// Form Validation
    $("#company_form").validate({
		rules:{
			company_name:{
				required:true
			},
			company_town:{
				required:true
			},
			company_mobile:{
				required:true,
				number:true,
				isMobile:true
			},
			company_address:{
				required:true,
				minlength:5,
			}
		},
		messages: {
			company_name:"请输入名称",
			company_town:"请选择所在位置",
			company_mobile:"请输入正确移动电话号码",
			company_address:"请输入公司地址"
		},
		errorClass: "help-inline",
		errorElement: "span",
		highlight:function(element, errorClass, validClass) {
			$(element).parents('.control-group').addClass('error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('error');
			$(element).parents('.control-group').addClass('success');
		}
	});
	
});
