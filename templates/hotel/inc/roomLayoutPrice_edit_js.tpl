<script language="javascript">
$(document).ready(function(){
    //
    $('#room_layout_date_month').val('<%$thisMonth%>');
    function leapYear(year){
        var isLeap = year%100==0 ? (year%400==0 ? 1 : 0) : (year%4==0 ? 1 : 0);
        return new Array(31,28+isLeap,31,30,31,30,31,31,30,31,30,31);
    }
    function setKalendar(select_month) {
        var year = $('#room_layout_date_year').val();
        var month = $('#room_layout_date_month').val();
        var arrayMonth = leapYear(year);
        var days = arrayMonth[month - 1];
        var kalendar_html = '';
        var month_option = '';
        var thisMonth = '<%$thisMonth%>';
        var thisYear = '<%$thisYear%>';
        var iMonth = year > thisYear ? 1 : thisMonth;
        var toDay = '<%$thisToday%>';
        var iDay = (year == thisYear && month == thisMonth) ? toDay : 1;
        for(var i = iDay; i <= days; i++ ) {
            var l = i;
            if(i < 10) l = '0' + i;
            kalendar_html += '<li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> '+l+'</i> '
                    +'<input id="event-name" class="span9" type="text" /></a> </li>';
        }
        $('#room_layout_price_kalendar').html(kalendar_html);
        //room_layout_date_month <option value="1">1</option>
        var selected = ''
        
        for(var i = iMonth; i <= 12; i++) {
            if(i == select_month) selected = "selected";
            month_option += '<option value="'+i+'" '+selected+'>'+i+'</option>';
            selected = '';
        }
        $('#room_layout_date_month').html(month_option);        
    }
    function setKalendarWeek() {
        var kalendar_html = '';
        for(var i = 1; i <= 7; i++ ) {
            var l = i;
            if(i < 10) l = '0' + i;
            kalendar_html += '<li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> '+l+'</i> '
                    +'<input id="event-name" class="span9" type="text" /></a> </li>';
        }
        $('#room_layout_price_week').html(kalendar_html);
    }
    setKalendar('');
    $('#room_layout_date_month,#room_layout_date_year').change(function(e) {
        var month = $(this).val();
        if(month > 12) month = 1;
        setKalendar(month);
    });
    
    //日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() - 1);
	$('#time_begin').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false,
		beforeShowDay: function(date) {
			if (date.getTime() < dateToDisable.getTime()) {
				return [false, ""];
			} 
            if(date.getDay() != 1) {
                return [false, ""];
            }
            return [true];
			//return [true, ""];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        }
	});
	$('#time_end').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false,
		beforeShowDay: function(date) {//new Date($('#book_check_int').val()).getDate()
			var dateToDisable = new Date($('#time_begin').val());
			if (date.getTime() < (dateToDisable.getTime() - 0 + 36000 * 24 * 6)) {
                //alert((date.getTime() + '----' + (dateToDisable.getTime() - 0 + 36000 * 24 * 6)));
				return [false];
			}
			return [true, ""];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        }
	});
    $('#history_begin').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false,
		beforeShowDay: function(date) {
            var dateToDisable = new Date();
			if (date.getTime() > dateToDisable.getTime()) {
				return [false, ""];
			}
            return [true];
			//return [true, ""];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        }
	});
    $('#history_end').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false,
		beforeShowDay: function(date) {//new Date($('#book_check_int').val()).getDate()
            var dateToDisable = new Date();
			var dateToBeginDisable = new Date($('#history_begin').val());
			if (date.getTime() > dateToDisable.getTime() || date.getTime() < dateToBeginDisable.getTime()) {
				return [false];
			}
			return [true, ""];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        }
	});
	//select2
    $('#room_layout,#room_layout_id').select2();
    //增加价格体系
    $("[data-toggle='popover']").popover({'trigger':'hover'});
    $('.system_prices').click(function(e) {
        $('.system_prices i').removeClass('am-icon-dot-circle-o');
        $('.system_prices i').addClass('am-icon-circle-o');
        $(this).find('i').removeClass('am-icon-circle-o');
        $(this).find('i').addClass('am-icon-dot-circle-o');
    });
    $('.system_prices_edit').click(function(e) {
        $('#addSystemPrice').collapse({toggle: true})
        $('#addSystemPrice').collapse('show');
        layout_id = $(this).parent().parent().attr('layout-id');
        $('#room_layout_id').val(layout_id);
        $('#price_system_name').val($(this).parent().parent().attr('data-name'));
        var layout_name = $('#room_layout option[value="'+layout_id+'"]').text();
        layout_name = layout_name == '' ? "<%$arrayLaguage['common_room_layout']['page_laguage_value']%>" : layout_name;
        $('#s2id_room_layout_id span').text(layout_name);
        $('#room_layout_id').attr("disabled",true); 
        $('#room_layout_id').select2();
        $(":checkbox").attr('checked', false);
        $(this).parent().parent().find('.am-icon-check-square-o').each(function(index, element) {
            var data_id = $(this).attr('data-id');
            $(":checkbox").each(function(index, element) {
                if($(this).val() == data_id) {
                    $(this).attr('checked', true);
                }
            });
        });
    });
    $('#add_edit_system').click(function(e) {
        $('#addSystemPrice').collapse({toggle: true})
        $('#addSystemPrice').collapse('show');
        $('#room_layout_id').attr("disabled",false); 
        $('#room_layout_id').val(0);
        $('#price_system_name').val('');
        $('#s2id_room_layout_id span').text("<%$arrayLaguage['common_room_layout']['page_laguage_value']%>");
        $('#room_layout_id').select2();
    });
    $('.system_prices_delete').click(function(e) {
        //alert($(this).parent().parent().attr('data-id'));        
    });
    var hotel_service_values = {};
    var layout_id = 0;
    $('#addSystemPrice').on('show.bs.collapse', function () {
        if(typeof(hotel_service_values['html']) == 'undefined') {
            $.getJSON('<%$add_roomLayoutPriceSystem_url%>&search=hotel_service', function(result) {
                data = result;
                if(data.success == 1) {
                    var hotel_service_html = '';
                    for(i in data.itemData) {
                        if(data.itemData[i].hotel_service_id != data.itemData[i].hotel_service_father_id) {
                            hotel_service_html += '<input value="'+data.itemData[i].hotel_service_id+'" name="hotel_service_id[]" type="checkbox">' 
                                               + data.itemData[i].hotel_service_name + ' ￥' + data.itemData[i].hotel_service_price;
                        }
                    }
                    hotel_service_values['html'] = hotel_service_html;
                    $('#hotel_service').html(hotel_service_html);
                } else {
                    $('#modal_success').modal('hide');
                    $('#modal_fail').modal('show');
                    $('#modal_fail_message').html(data.message);
                }
            });
        } else {
            $('#hotel_service').html(hotel_service_values['html']);
        }
    })
    
    var room_layout_price_system_validate = $("#room_layout_price_system").validate({
		rules: {
			price_system_name: {required: true},
		},
		messages: {
			price_system_name:"",
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
            var param = $("#room_layout_price_system").serialize();
            $.ajax({
                url : '<%$editSystem_url%>',type : "post",dataType : "json",data: param,
                success : function(data) {
                    if(data.success == 1) {
                        $('#modal_fail').modal('hide');
                        $('#modal_success').modal('show');
                        $('#modal_success').html(data.message);
                        $('#addSystemPrice').collapse('hide');
                        $('#price_system_name').val('');
                        $(":checkbox").attr('checked', false);
                    } else {
                        $('#modal_success').modal('hide');
                        $('#modal_fail').modal('show');
                        $('#modal_fail_message').html(data.message);
                    }
                }
            });
		}
	});
})
</script>