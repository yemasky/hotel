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
                    +'<input id="'+l+'_day" name="'+l+'_day" class="span9" type="text" /></a> </li>';
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
                    +'<input id="week_'+l+'" name="week_'+l+'" class="span9" type="text" /></a> </li>';
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
	var dateToDisable = new Date('<%$thisDay%>');
    var nowDateToDisable = new Date(dateToDisable.setDate(dateToDisable.getDate() + (6 - dateToDisable.getDay())));
	dateToDisable.setDate(dateToDisable.getDate() - 1);
	$('#time_begin').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false, 
        yearStart: 2015, yearEnd: 2020, yearOffset:1,maxDate:'+1970-01-02',
		beforeShowDay: function(date) {
			if (date.getTime() < dateToDisable.getTime()) {
				return [false, ""];
			}
            if(date.getDay() != 1 && date.getTime() > nowDateToDisable.getTime()) {
                return [false, ""];
            }
            return [true];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        },
        onSelectDate:function(date) {alert(date + '-====-' + nowDateToDisable);
            var thisDate = new Date(this.getValue());
            var nextDate = new Date(thisDate.setDate(thisDate.getDate() + 6));
            var time_end_date = new Date($('#time_end').val());
            if(time_end_date.getTime() < nextDate.getTime()) {
                $('#time_end').val(nextDate);
                $('#time_end').datetimepicker({value:nextDate});
            }
        }
       
	});
	$('#time_end').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false, yearStart: 2016, yearEnd: 2020,
		beforeShowDay: function(date) {//new Date($('#book_check_int').val()).getDate()
			var dateToDisable = new Date($('#time_begin').val());
            dateToDisable.setDate(dateToDisable.getDate() + 6);
			if (date.getTime() < dateToDisable.getTime()) {
                //alert((date.getTime() + '----' + (dateToDisable.getTime() - 0 + 36000 * 24 * 6)));
				return [false];
			}
			return [true, ""];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        },
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
    //选择对应的房型和价格体系
    var room_layout_data = {};
    var room_layout = 0;
    var is_extra_bed = false;
    $('#room_layout').change(function(e) {
        system_id = 0;
        room_layout = $(this).val();//3. $("#select_id option[text='jQuery']").attr("selected", true); 
        var extra_bed = $("#room_layout option[value='"+room_layout+"']").attr("extra_bed");
        $('.extra_bed').hide();
        is_extra_bed = false;
        if(extra_bed > 0) {
            $('.extra_bed').show();
            is_extra_bed = true;
        }
        if(typeof(room_layout_data[room_layout]) == 'undefined') {
            $.getJSON('<%$add_roomLayoutPriceSystem_url%>&search=systemPrices&room_layout_id='+room_layout, function(result) {
                data = result;
                if(data.success == 1) {
                    room_layout_data[room_layout] = data.itemData;
                    $('#system_prices_html').html(createSystemPriceHtml(data.itemData));
                    $('.system_prices').click(function(e) {
                        systemPriceClick(this);
                    });
                    $('.system_prices_edit').click(function(e) {
                        systemPricesEditClick(this);
                    });
                } else {
                    $('#modal_success').modal('hide');
                    $('#modal_fail').modal('show');
                    $('#modal_fail_message').html(data.message);
                }
            })
        } else {
            $('#system_prices_html').html(createSystemPriceHtml(room_layout_data[room_layout]));
            $('.system_prices').click(function(e) {
                systemPriceClick(this);
            });
            $('.system_prices_edit').click(function(e) {
                systemPricesEditClick(this);
            });
        }
    });
    function createSystemPriceHtml(htmlData) {
        var html = '<div class="btn-group system_prices" data-id="1"><a class="btn" href="#system_prices"><i class="am-icon-circle-o"></i> 基本房费</a></div> ';
        for(i in htmlData) {
            var id = htmlData[i].room_layout_price_system_id;
            var name = htmlData[i].room_layout_price_system_name;
            html += '<div class="btn-group system_prices" data-id="'+id+'">'
                   +'<a class="btn" href="#system_prices"><i class="am-icon-circle-o"></i> '+name+'</a>'
                   +'<a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>'
                   +'<ul class="dropdown-menu" data-id="'+id+'" layout-id="'+htmlData[i].room_layout_id+'" data-name="'+name+'">'
                   +'<li><a href="#" class="system_prices_edit"><i class="am-icon-pencil am-yellow-FFAA3C"></i> Edit</a></li>'
                   +'<li><a href="#" class="system_prices_delete"><i class="am-icon-trash am-red-FB0000"></i> Delete</a></li>'
                   +'<li class="divider"></li>'
                   +'<li><a href="#"><i class="i"></i>';
                    for(j in htmlData[i].hotel_service_id) {
                        html += '<i class="am-icon-check-square-o" data-id="'+htmlData[i].hotel_service_id[j]+'"></i>' + htmlData[i].hotel_service_name[j];
                    }
             html += '</a></li></ul></div> ';
        }
        return html;
    }
    //增加价格体系
    var system_id = 0;
    $("[data-toggle='popover']").popover({'trigger':'hover'});
    $('.system_prices').click(function(e) {
        systemPriceClick(this);
    });
    function systemPriceClick(_this) {
        system_id = $(_this).attr('data-id');
        $('.system_prices .btn i').removeClass('am-icon-dot-circle-o');
        $('.system_prices .btn i').addClass('am-icon-circle-o');
        $(_this).find('.btn i').removeClass('am-icon-circle-o');
        $(_this).find('.btn i').addClass('am-icon-dot-circle-o');
    }
    var layout_id = 0;
    $('.system_prices_edit').click(function(e) {
        systemPricesEditClick(this);
    });
    function systemPricesEditClick(_this){
        $('#addSystemPrice').collapse({toggle: true})
        $('#addSystemPrice').collapse('show');
        layout_id = $(_this).parent().parent().attr('layout-id');
        $('#room_layout_id').val(layout_id);
        $('#update_system_id').val($(_this).parent().parent().attr('data-id'));
        $('#price_system_name').val($(_this).parent().parent().attr('data-name'));
        var layout_name = $('#room_layout option[value="'+layout_id+'"]').text();
        layout_name = layout_name == '' ? "<%$arrayLaguage['common_room_layout']['page_laguage_value']%>" : layout_name;
        $('#s2id_room_layout_id span').text(layout_name);
        $('#room_layout_id').attr("disabled",true); 
        $('#room_layout_id').select2();
        getHotelService();
        //var _this = this;
        var hotel_serviceInterval = setInterval(function(){
            var hotel_service_html = $('#hotel_service').html();
            if(hotel_service_html != '') {
                $(":checkbox").attr('checked', false);
                $(_this).parent().parent().find('.am-icon-check-square-o').each(function(index, element) {
                    var data_id = $(this).attr('data-id');
                    $("#hotel_service :checkbox").each(function(index, element) {
                        if($(this).val() == data_id) {
                            $(this).attr('checked', true);
                        }
                    });
                });
                clearInterval(hotel_serviceInterval);
                //console.log('1');
            }
        },500);
    }
    $('#add_edit_system').click(function(e) {
        getHotelService();
        $('#addSystemPrice').collapse({toggle: true})
        $('#addSystemPrice').collapse('show');
        $('#room_layout_id').attr("disabled",false); 
        $('#room_layout_id').val(0);
        $('#price_system_name').val('');
        $('#s2id_room_layout_id span').text("<%$arrayLaguage['common_room_layout']['page_laguage_value']%>");
        $('#room_layout_id').select2();
        $('#update_system_id').val('');//
    });
    $('.system_prices_delete').click(function(e) {
        //alert($(this).parent().parent().attr('data-id'));        
    });
    $('#addSystemPrice').on('show.bs.collapse', function () {
        //getHotelService();
    })
    var hotel_service_values = {};
    function getHotelService() {
        if(typeof(hotel_service_values['html']) == 'undefined') {
            $.getJSON('<%$add_roomLayoutPriceSystem_url%>&search=hotel_service', function(result) {
                data = result;
                if(data.success == 1) {
                    var hotel_service_html = '';
                    for(i in data.itemData) {
                        if(data.itemData[i].hotel_service_id != data.itemData[i].hotel_service_father_id) {
                            hotel_service_html += '<input value="'+data.itemData[i].hotel_service_id+'" name="hotel_service_id[]" type="checkbox"> ' 
                                               + '<label>'+ data.itemData[i].hotel_service_name + '</label>'
                                               + '<label> ￥' + data.itemData[i].hotel_service_price + '</label>';
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
    }
    
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
                        $('#modal_success_message').html(data.message);
                        $('#addSystemPrice').collapse('hide');
                        var update_system_id = $('#update_system_id').val();
                        if(update_system_id > 0) {//update
                            $('#update_system_id').val('');//system_id
                            $('.system_prices').each(function(index, element) {
                                if($(this).attr('data-id') == system_id) {
                                    $(this).children().first().html('<i class="am-icon-dot-circle-o"></i> ' + $('#price_system_name').val());
                                    var haveHotelService = '<i class="i"></i>';
                                    $("#hotel_service :checkbox").each(function(index, element) {
                                        if($(this).attr('checked')) {
                                            haveHotelService += '<i class="am-icon-check-square-o" data-id="'+$(this).val()+'"></i>'
                                                             + $(this).next().text() + ' ';
                                        }
                                    });
                                    $(this).find('.i').parent().html(haveHotelService);
                                    $(this).find('ul').attr('data-name', $('#price_system_name').val());
                                    return false;
                                }
                            });
                           
                        } else {//add 
                            var add_room_layout = $('#room_layout_id').val();
                            var name = $('#price_system_name').val();
                            var html = '';
                            if(add_room_layout == 0 || add_room_layout == room_layout){
                                html += '<div class="btn-group system_prices" data-id="'+data.itemData+'">'
                                       +'<a class="btn" href="#system_prices"><i class="am-icon-circle-o"></i> '+name+'</a>'
                                       +'<a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>'
                                       +'<ul class="dropdown-menu" data-id="'+data.itemData+'" layout-id="'+add_room_layout+'" data-name="'+name+'">'
                                       +'<li><a href="#" class="system_prices_edit"><i class="am-icon-pencil am-yellow-FFAA3C"></i> Edit</a></li>'
                                       +'<li><a href="#" class="system_prices_delete"><i class="am-icon-trash am-red-FB0000"></i> Delete</a></li>'
                                       +'<li class="divider"></li>'
                                       +'<li><a href="#"><i class="i"></i>';
                                       $("#hotel_service :checkbox").each(function(index, element) {
                                            if($(this).attr('checked')) {
                                                html += '<i class="am-icon-check-square-o" data-id="'+$(this).val()+'"></i>' + $(this).next().text();
                                            }
                                        });
                                 html += '</a></li></ul></div> ';
                            };
                            if(html != '') {
                                $('#system_prices_html').append(html);
                                $('.system_prices').click(function(e) {
                                    systemPriceClick(this);
                                });
                                $('.system_prices_edit').click(function(e) {
                                    systemPricesEditClick(this);
                                });
                            }
                        }
                        $('#price_system_name').val('');
                        $("#hotel_service :checkbox").attr('checked', false);
                        room_layout_data = {};
                    } else {
                        $('#modal_success').modal('hide');
                        $('#modal_fail').modal('show');
                        $('#modal_fail_message').html(data.message);
                    }
                }
            });
		}
	});
    //
    $('.select_extra_bed_week').click(function(e) {
        $('.select_extra_bed_week i').removeClass('am-icon-dot-circle-o');
        $(this).find('i').addClass('am-icon-dot-circle-o');
        if($(this).attr('id') == 'same_week') {
            $('#same_price_week').show();
            $('#different_price_week').hide();
        } else {
            $('#same_price_week').hide();
            $('#different_price_week').show();
        }
    });
    $('.select_extra_bed_month').click(function(e) {
        $('.select_extra_bed_month i').removeClass('am-icon-dot-circle-o');
        $(this).find('i').addClass('am-icon-dot-circle-o');
    });
    var prices_week_validate = $("#prices_week").validate({
		rules: {
			
		},
		messages: {
			
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
            if(system_id == 0) {
                $('#modal_success').modal('hide');
                $('#modal_fail').modal('show');
                $('#modal_fail_message').html('请选择价格体系！');
                return;
            }
            //var week_begin = 
            var param = $("#prices_week").serialize();
            $.ajax({
                url : '<%$add_roomLayoutPriceSystem_url%>&search=prices_week',type : "post",dataType : "json",data: param,
                success : function(result) {
                    data = result;
                }
            });
		}
	});
    
    var prices_month_validate = $("#prices_month").validate({
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
            var param = $("#prices_month").serialize();
            $.ajax({
                url : '<%$add_roomLayoutPriceSystem_url%>&search=prices_month',type : "post",dataType : "json",data: param,
                success : function(result) {
                    data = result;
                }
            });
		}
	});
    
    var search_history_validate = $("#search_history").validate({
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
            
		}
	});
})
</script>