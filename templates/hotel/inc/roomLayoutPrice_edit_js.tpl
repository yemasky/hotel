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
    $('#room_layout').select2();
    //增加价格体系
    $("[data-toggle='popover']").popover({'trigger':'hover'});
    $('.system_prices').click(function(e) {
        $('.system_prices .am-icon-heart').removeClass('am-red-EA5555');
        $(this).find('.am-icon-heart').addClass('am-red-EA5555');
    });
    $('#addSystemPrice').on('show.bs.collapse', function () {
        $.getJSON('<%$addoomLayoutPriceSystemUrl%>&search=hotel_service', function(result) {
            data = result;
            if(data.success == 1) {
                var hotel_service_html = '';
                for(i in data.itemData) {
                    if(data.itemData[i].hotel_service_id != data.itemData[i].hotel_service_father_id) {
                        hotel_service_html += '<input value="'+data.itemData[i].hotel_service_id+'" name="hotel_service_id" type="checkbox">' 
                                           + data.itemData[i].hotel_service_name + ' ￥' + data.itemData[i].hotel_service_price;
                    }
                }
                $('#hotel_service').html(hotel_service_html);
                $('#room_layout_name').val($('#room_layout option:selected').text());
                $('#room_layout_id').val($('#room_layout').val());
            } else {
                $('#modal_success').modal('hide');
                $('#modal_fail').modal('show');
                $('#modal_fail_message').html(data.message);
            }
        });
    })
    $('#room_layout').change(function(e) {
        $('#room_layout_name').val($('#room_layout option:selected').text());
        $('#room_layout_id').val($('#room_layout').val());
    });
    
    var hotel_service_validate = $("#add_hotel_service").validate({
		rules: {
			hotel_service_name: {required: true},
		},
		messages: {
			hotel_service_name:"",
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
            $('#book_contact_mobile').val($('#contact_mobile').val());
            $('#book_contact_name').val($('#contact_name').val());
            var param = $("#book_form").serialize();
            $.ajax({
                url : '<%$book_url%>',type : "post",dataType : "json",data: param,
                success : function(data) {
                    if(data.success == 1) {
                        room_layout_id = data.itemData.room_layout_id;
                        /*$('#modal_fail').modal('hide');
                         $('#modal_success').modal('show');
                         $('#modal_success_message').html(data.message);
                         $('#modal_success').on('hidden.bs.modal', function () {

                         })*/
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