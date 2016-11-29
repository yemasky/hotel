<script language="javascript">
$(document).ready(function(){
	//日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() - 1);
	$('#book_check_in').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
		beforeShowDay: function(date) {
			if (date.getTime() < dateToDisable.getTime()) {
				return [false];
			}
			return [true];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        },
        onSelectTime:function( ct ){
            computeCheckDate($('#book_check_out').val());
            bookEdit.computeBookPrice(false);
        }
	});
	$('#book_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
		beforeShowDay: function(date) {
            //new Date($('#book_check_in').val()).getDate()
			//var dateToDisable = new Date($('#book_check_in').val());
			if (date.getTime() < dateToDisable.getTime()) {
				return [false];
			}
			return [true];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        },
        onSelectTime:function(date) {
            if(new Date(this.getValue()) <= new Date($('#book_check_in').val())) {
                $('#modal_fail').modal('show');
                $('#modal_fail_message').html("抱歉，这个时间不正确！");
                return false;
            }
            computeCheckDate(this.getValue());
        }
	});
	//日历 时间控制
	$('#book_order_retention_time').datetimepicker({
		datepicker:false,format:'H:i',step:30
	});
    $('#half_price').datetimepicker({
		datepicker:false,format:'H:i',step:30
	});
    
    function computeCheckDate(computeDate) {
        //console.log(date + '-====-' + nextWeekDateToDisable + '----'+ week_differ + '-----2016-11-22');
        var outDate = new Date(computeDate);
        var inDate = new Date($('#book_check_in').val());
        var outDateTime =new Date(outDate.getFullYear() + '-' + (outDate.getMonth() - 0 + 1) + '-' + outDate.getDate() + ' 00:00:00');
        var itDateTime =new Date(inDate.getFullYear() + '-' + (inDate.getMonth() - 0 + 1) + '-' + inDate.getDate() + ' 00:00:00');
        var days = Math.floor((outDateTime.getTime() - itDateTime.getTime())/(24*3600*1000));
        var halfPrice = $('#half_price').val().substr(0, 2) - 0;
        var checkout = '<%$hotel_checkout%>';
        //标准结算日期
        var  balance_date = new Date(computeDate);
        balance_date.setDate(balance_date.getDate() - 1);
        if((outDate.getHours() - 0) > halfPrice) {
            //算1天
            outDateTime.setDate(outDateTime.getDate() + 1);
            days = days - 0 + 1;
            //加1天的结算日期
            balance_date.setDate(balance_date.getDate() + 1);
        }
        if((outDate.getHours() - 0) <= halfPrice && (outDate.getHours() - 0) > checkout.substr(0, 2)) {
            //算0.5天
            outDateTime.setDate(outDateTime.getDate() + 1);
            days = days - 0 + 0.5;
            //加0.5天的结算日期
            balance_date.setDate(balance_date.getDate() + 1);
        }
        $('#book_days_total').val(days);
        
        var day = outDateTime.getDate();
        day = day < 10 ? '0' + day : day;
        var month = outDateTime.getMonth() + 1;
        month = month < 10 ? '0' + month : month;
        $('#max_date').val(outDateTime.getFullYear() + '-' + month + '-' + day);
        
        var day = balance_date.getDate();
        day = day < 10 ? '0' + day : day;
        var month = balance_date.getMonth() + 1;
        month = month < 10 ? '0' + month : month;
        $('#balance_date').val(balance_date.getFullYear() + '-' + month + '-' + day);
        bookEdit.computeBookPrice(true);
    }
	
//});//add_attr_classes
//$(document).ready(function(){
    var contact_validate = $("#contact_form").validate({
		rules: {
			contact_name: {required: true},
			contact_mobile: {required: true,isMobile: true},
            //contact_email: {email: true},
		},
		messages: {
			contact_name:"请填写联系人",
			contact_mobile:"请填写正确的移动电话号码",
            //contact_email:""
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
	var book_validate = $("#book_form").validate({
		rules:{
			book_type_id:{required:true},
			book_discount:{required:true},
			book_check_in:{required:true},
			book_check_out:{required:true},
			book_total_price:{required:true},
			payment:{required:true},
			payment_type:{required:true},
			is_pay:{required:true}
		},
		messages: {
			book_type_id:"请选择来源",
			book_discount:"请填写折扣",
			book_total_price:"",
			payment:"",
			payment_type:"",
			is_pay:"",
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
            if(new Date($('#book_check_out').val()) <= new Date($('#book_check_in').val())) {
                $('#modal_fail').modal('show');
                $('#modal_fail_message').html("抱歉，这个时间不正确！");
                return false;
            }
            
			if(contact_validate.form()) {
				$('#book_contact_mobile').val($('#contact_mobile').val());
				$('#book_contact_name').val($('#contact_name').val());
                var have_room  = false;
                $('#room_layout_html input').each(function(index, element) {
                    if($(this).attr('layout') == 'room'){
                        have_room = true;
                        return;
                    }
                });
                if(!have_room) {
                    $('#modal_info_message').html("没有选择客房！");
                    $('#modal_info').modal('show');
                    return;
                }
				var param = $("#book_form").serialize();
				$.ajax({
					url : '<%$book_url%>',type : "post",dataType : "json",data: param,
					success : function(data) {
						if(data.success == 1) {
							room_layout_id = data.itemData.room_layout_id;
							 $('#modal_success').modal('show');
							 $('#modal_success_message').html(data.message);
							 /*$('#modal_success').on('hidden.bs.modal', function () {

							 })*/
						} else {
							$('#modal_fail').modal('show');
							$('#modal_fail_message').html(data.message);
						}
					}
				});
			}
		}
	});
	//$('.book_form_step1 .book_form_step2').hide();
	
	//搜索房型
	table = $('#room_layout').DataTable({
		paging: false
	});
    
    var BookEditClass = {
        hotel_service: {},
        book_discount_list: {},
        bookSelectRoom: {},
        bookNeed_service:{},
        lastDate:{},
        hotelCheckDate: {'hotel_checkin':'<%$hotel_checkin%>', 'hotel_checkout':'<%$hotel_checkout%>'},
	    max_man: 0,//最多人数
        BookUser_num: 1,
        instance: function() {
            var bookEdit = {};
            bookEdit.initParameter = function() {
                BookEditClass.hotel_service[-1] = 1;
                BookEditClass.weekday=new Array(7);
                BookEditClass.weekday[0]="日"
                BookEditClass.weekday[1]="一"
                BookEditClass.weekday[2]="二"
                BookEditClass.weekday[3]="三"
                BookEditClass.weekday[4]="四"
                BookEditClass.weekday[5]="五"
                BookEditClass.weekday[6]="六";
                BookEditClass.orientations=new Array(7);
                BookEditClass.orientations['east']='东';
                BookEditClass.orientations['south']='南';
                BookEditClass.orientations['west']='西';
                BookEditClass.orientations['north']='北';
                BookEditClass.orientations['southeast']='东南';
                BookEditClass.orientations['northeast']='东北';
                BookEditClass.orientations['southwest']='西南';
                BookEditClass.orientations['northwest']='西北';
                BookEditClass.orientations['no']='无';
            },
            bookEdit.init = function() {
                $('.edit_checkbox').click(function(e) {
                    hotel_server_id = $(this).attr('data-id');
                    var hotel_service = BookEditClass.hotel_service;
                    var length = 0;
                    for(i in hotel_service) {
                        if(hotel_service[i] == 1) length++;
                    }
                    if(typeof(hotel_service[hotel_server_id]) == 'undefined' || hotel_service[hotel_server_id] == '') {
                        $(this).find('.edit_btn').addClass('am-icon-check-square-o');
                        $(this).find('.edit_btn').removeClass('am-icon-square-o');
                        hotel_service[hotel_server_id] = 1;
                    } else {
                        if(length <= 1) {
                            $('#modal_info').modal('show');
                            $('#modal_info_message').html('不能全部取消包含服务，必须包含一项服务！');
                            return;
                        }
                        $(this).find('.edit_btn').removeClass('am-icon-check-square-o');
                        $(this).find('.edit_btn').addClass('am-icon-square-o');
                        hotel_service[hotel_server_id] = '';
                    }
                });
                //联系信息事件
                //$('#contact_mobile,#contact_name,#contact_email').bind("keyup") = 
                $('#begin_book').bind("click", function(e) {
                    if($('#contact_mobile').val().length == 11) {
                        $('#modal_loading').show();
                        $.ajax({url : "<%$searchBookInfoUrl%>&search=searchUserMemberLevel",type : "post",
                           dataType : "json",
                           data: "book_contact_mobile=" + $('#contact_mobile').val() + "&book_contact_email=" + $('#contact_email').val(),
                           success : function(result) {
                               $('#modal_loading').hide();
                               $('.book_form_step1').show();
                               data = result;
                               if(data.success == 1) {
                                   if(data.itemData != null && data.itemData != '' && data.itemData != 'null') {
                                       $('#book_discount_id,.book_discount_id').remove();
                                       $('#book_type_id').val(data.itemData.book_type_id);
                                       $('#discount').val(data.itemData.book_discount);
                                       if(data.itemData.agreement_company_name != '') {
                                           var book_discount_id = ' <input readonly id="book_discount_id" value="'
                                                + data.itemData.book_discount_name + data.itemData.agreement_company_name+'" type="text" class="span2"/> '
                                                +' <input name="book_discount_id" value="'
                                                + data.itemData.book_discount_id+'" type="hidden" class="book_discount_id" /> ';
                                           $('#book_type_id').after(book_discount_id);
                                       } else {
                                            var book_discount_id = ' <input readonly id="book_discount_id" value="'
                                                + data.itemData.book_discount_name+'" type="text" class="span2"/> '
                                                +' <input name="book_discount_id" value="'
                                                + data.itemData.book_discount_id+'" type="hidden" class="book_discount_id" /> ';
                                            $('#book_type_id').after(book_discount_id);
                                       }
                                   } else {
                                       $('#book_discount_id,.book_discount_id').remove();
                                       $('#book_type_id').val('');
                                       $('#discount').val(100);
                                   }
                                   //计算价格
                                   bookEdit.computeBookPrice(true);
                               } else {
                                   $('#modal_fail').modal('show');
                                   $('#modal_fail_message').html(data.message);
                               }
                           }
                         });
                    }
                });
                //协议公司
                var book_discount_list = BookEditClass.book_discount_list;
                $('#book_type_id').change(function(e) {
                    $('#book_discount_id,.book_discount_id,#order_number_ourter').remove();
                    var book_type_id = $(this).val();
                    var booktype = $(this).find('option:selected').attr('booktype')
                    if(typeof(book_discount_list[book_type_id]) == 'undefined') {
                        $.getJSON('<%$searchBookInfoUrl%>&search=discount&book_type_id='+book_type_id, function(result) {
                            data = result;
                            if(data.itemData != null && data.itemData != '') {
                                var discount_html = ' <select name="book_discount_id" class="span2 book_discount_id select_discount">';
                                var option = '';
                                for(i in data.itemData) {
                                    option += '<option value="'+data.itemData[i].book_discount_id+'">'
                                           +data.itemData[i].book_discount_name + data.itemData[i].agreement_company_name +'</option>';
                                    book_discount_list[data.itemData[i].book_discount_id + '_0'] = data.itemData[i].book_discount;
                                    if(i == 0) {
                                        $('#discount').val(data.itemData[i].book_discount);
                                        book_discount_list[book_type_id + '_'] = data.itemData[i].book_discount;
                                    }
                                }
                                discount_html += option + '</section>';
                                //console.log(discount_html);
                                book_discount_list[book_type_id] = discount_html;
                                $('#book_type_id').after(discount_html);
                                $('.select_discount').change(function(e) {
                                    $('#discount').val(book_discount_list[$(this).val() + '_0']);
                                })
                            } else {
                                book_discount_list[book_type_id] = '';
                                book_discount_list[book_type_id + '_'] = 100;
                                $('#discount').val(100);
                            }
                            if(booktype == 'OTA') 
                                $('#book_type_id').after('<span id="order_number_ourter"> <%$arrayLaguage["order_number_ourter"]["page_laguage_value"]%> : <input  name="book_order_number_ourter" value="" class="span2" type="text"></span>');
                            bookEdit.computeBookPrice(true);
                        })
                    } else {
                        $('#book_type_id').after(book_discount_list[book_type_id]);
                        $('.select_discount').change(function(e) {
                            $('#discount').val(book_discount_list[$(this).val() + '_0']);
                        })
                        $('#discount').val(book_discount_list[book_type_id + '_']);
                        if(booktype == 'OTA') 
                            $('#book_type_id').after('<span id="order_number_ourter"> <%$arrayLaguage["order_number_ourter"]["page_laguage_value"]%> : <input name="book_order_number_ourter" value="" class="span2" type="text"></span>');
                        bookEdit.computeBookPrice(true);
                    }
                    //console.log(BookEditClass.book_discount_list);
                });
                //搜索客房价格
                $('#search_room_layout').click(function(e) {
                    $('#contact_form').submit();
                    if(contact_validate.form()) {
                        bookEdit.ajaxGetRoomLayout();
                    }
                });
                //book_user_room
                //table点击
                $('#room_layout tbody').on('click', 'td.details-control', function () {
                    var _this = this;
                    var system_id = $(_this).parent().attr('system_id');
                    var sell_id = $(this).parent().attr('sell_layout_id');
                    var lastDate = new Date(BookEditClass.lastDate[sell_id+'-'+system_id]);
                    var outDate = new Date($('#book_check_out').val().substr(0,10));
                    if(lastDate.getTime() < outDate.getTime()) {
                        $('#modal_info_message').html('设置的价格日期和离店日期不符合，请设置相符的日期价格!');
                        $('#modal_info').modal('show');
                        return;
                    }
                    var bookSelectRoom = BookEditClass.bookSelectRoom;
                    var tr = $(this).closest('tr');
                    var row = table.row( tr );
                    if ( row.child.isShown() ) {
                        // This row is already open - close it
                        row.child.hide();
                        tr.removeClass('shown');
                    } else {
                        // Open this row 	row.data()
                        $('#modal_loading').show();
                        $.getJSON('<%$searchBookInfoUrl%>&search=searchRoom&room_layout_id='+$(this).parent().attr('room_layout_id')
                                +'&sell_id='+sell_id,
                          function(result){
                            $('#modal_loading').hide();
                            row.child(bookEdit.formatRoomTable(result, system_id, sell_id)).show();
                            row.child().children().addClass('nopadding');
                            row.child().children().attr('id', 'noBodyLeft');
                            tr.addClass('shown');
                            $(_this).parent().next().find('th input:checkbox').click(function() {
                                var checkedStatus = this.checked;
                                var checkbox = $(this).parent().parent().parent().next().find('tr td:first-child input:checkbox');
                                checkbox.each(function() {
                                    if(this.disabled) {
                                    } else {
                                        this.checked = checkedStatus;
                                        var room_id = $(this).val();
                                        var room_layout_id = $(this).attr('room_layout');
                                        var room_name = $(this).attr('title');
                                        if (checkedStatus == this.checked) {
                                            $('#room_'+sell_id+'_'+room_id).remove();
                                            $("#room_data").removeData(room_id);  //移除
                                            //$(this).closest('.checker > span').removeClass('checked');
                                        }
                                        if (this.checked && typeof(room_layout_id) != 'undefined') {
                                            var room_lauout_input = '<input type="hidden" id="room_'+sell_id+'_'+room_id+'" '
                                                          +'name="room_layout_id['+sell_id +'-'+ room_layout_id+'-'+system_id+']['+room_id+']" value="'+room_id+'" '
                                                          +'layout="room" room_layout="'+room_layout_id+'" system_id="'+system_id+'" sell_id="'+sell_id+'" />';
                                            $('#room_layout_html').append(room_lauout_input);
                                            $('#room_data').data(room_id, sell_id+'-'+ system_id);
                                            bookSelectRoom[room_id] = room_name;
                                            //$(this).closest('.checker > span').addClass('checked');
                                        }
                                        //设置disable
                                        bookEdit.resetRoomStatus(room_id, sell_id, system_id, this.checked);
                                    }
                                });
                                //计算价格
                                bookEdit.computeBookPrice(true);
                            });	
                            
                            $(_this).parent().next().find('td input:checkbox').click(function(e) {
                                var room_id = $(this).val();
                                var room_layout_id = $(this).attr('room_layout');
                                var room_name = $(this).attr('title');
                                if(room_id == 'on') return;
                                if (this.checked) {
                                    //选中状态
                                    var room_lauout_input = '<input type="hidden" id="room_'+sell_id+'_'+room_id+'" '
                                                         +'name="room_layout_id['+sell_id +'-'+ room_layout_id+'-'+system_id+']['+room_id+']" value="'+room_id+'" '
                                                         +'layout="room" room_layout="'+room_layout_id+'" system_id="'+system_id+'" sell_id="'+sell_id+'" />';
                                    $('#room_layout_html').append(room_lauout_input);
                                    $('#room_data').data(room_id, sell_id+'-'+ system_id);
                                    bookSelectRoom[room_id] = room_name;
                                    //设置disable
                                    bookEdit.resetRoomStatus(room_id, sell_id, system_id, this.checked);
                                } else {
                                    $('#room_'+sell_id+'_'+room_id).remove();
                                    $("#room_data").removeData(room_id);  //移除
                                    //设置disable
                                    bookEdit.resetRoomStatus(room_id, sell_id, system_id, this.checked);
                                }
                                //计算价格
                                bookEdit.computeBookPrice(true);
                            });
                            $('.room_extra_bed').change(function(e) {
                                var extra_bed_val = $(this).val();
                                var room_id = $(this).attr('room');
                                var room_layout_id = $(this).attr('room_layout');
                                $('#extra_bed_'+sell_id+'_'+room_id).remove();
                                $('#addBed_data').removeData(sell_id+'_'+room_id);
                                if(extra_bed_val == 0) {						
                                } else {
                                    var extra_bed_input = '<input type="hidden" id="extra_bed_'+sell_id+'_'+room_id+'" '
                                                         +'name="extra_bed['+sell_id+']['+room_id+']" value="'+extra_bed_val+'" '
                                                         +'layout="bed" room_layout="'+room_layout_id+'" room="'+room_id+'" sell_id="'+sell_id+'" />';
                                    $('#room_layout_html').append(extra_bed_input);
                                    $('#addBed_data').data(sell_id+'_'+room_id, extra_bed_val);
                                }
                                //计算价格
                                bookEdit.computeBookPrice(true);
                            });
                            $('.book_price').keyup(function(e) {
                                bookEdit.computeBookPrice(true);
                            });
                            //计算价格
                        })
                    }
                });
                $('#need_service').change(function(e) {
                    var thisVal = $(this).val();
                    if(BookEditClass.bookNeed_service[thisVal] == 1 || thisVal == '') return;
                    //bookNeed_service
                    var need_service_id = $('#need_service_id').attr('id');
                    if(typeof(need_service_id) == 'undefined') {
                        $(this).parent().append('<div class="btn-icon-pg"><ul id="need_service_id"></ul></div>');
                    }
                    var html = '<li><i class="am-icon-check-square"></i>'+$(this).find("option:selected").attr('title')
                              +' ￥ :  <input class="input-mini service_price" service_id="'+thisVal+'" value="'+$(this).find("option:selected").attr('price')+'" type="text">   '
                              +'数量 : <input class="input-mini" value="1" type="text"> 折扣 : <input class="input-mini" value="100" type="text"> '
                              +'备注 : <input class="input-large" value="" type="text"> <i class="am-icon-minus-square am-red-E43737 service_del"></i></li>';
                    $('#need_service_id').append(html);
                    BookEditClass.bookNeed_service[thisVal] = 1;
                    $('.service_del').click(function(e) {
                        $(this).parent().remove();
                        BookEditClass.bookNeed_service[thisVal] = 0;
                        if($('#need_service_id').html() == '') {
                            $('#need_service_id').parent().remove();
                        }
                    });                 
                });

                //增加减少人数
                $('#addBookUser').click(function(e) {
                    var max_man = BookEditClass.max_man;
                    console.log('max_man:' + max_man);
                    if(BookEditClass.BookUser_num >= max_man) return;
                    $(this).parent().prev().clone().insertBefore($(this).parent());
                    BookEditClass.BookUser_num++;
                });
                $('#reduceBookUser').click(function(e) {
                    var max_man = BookEditClass.max_man;
                    if(BookEditClass.BookUser_num == 1) return;
                    $(this).parent().prev().remove();
                    BookEditClass.BookUser_num--;
                });
            },
            //搜索RoomLayout
            bookEdit.ajaxGetRoomLayout = function() {
                $('#room_layout_data').html('<tr class="gradeX odd" role="row"><td class="sorting_1"></td><td></td></tr>');
                $('#modal_loading').show();
                var hotel_service = '';//JSON.stringify(BookEditClass.hotel_service, false, 4)
                for(i in BookEditClass.hotel_service) {
                    if(BookEditClass.hotel_service[i] == 1) hotel_service += i + ',';
                }
                var check_in = $('#book_check_in').val();var check_out = $('#book_check_out').val();
                var checkOutDate = new Date(check_out);var today = checkOutDate.getDate();var thisHours = checkOutDate.getHours();
                var halfPrice = $('#half_price').val().replace(':00', '');
                if(thisHours > halfPrice) {
                    //算半天
                    checkOutDate.setDate(checkOutDate.getDate()+1);
                    check_out = checkOutDate.getFullYear() + '-' + (checkOutDate.getMonth() - 0 + 1) + '-' + checkOutDate.getDate();                    
                }
                //$('#book_form div').hide();
                $.ajax({
                    url : '<%$searchBookInfoUrl%>&search=searchRoomLayout&discount=' + $('#discount').val() + '&hotel_service=' + hotel_service,
                    type : "post",
                    data : 'book_check_in=' + check_in
                    + '&book_check_out=' + check_out,
                    dataType : "json",
                    success : function(result) {
                        $('#modal_loading').hide('show');
                        $('#book_form div').show('show');
                        data = result;
                        if(data.success == 1) {
                            $('#room_layout_table').show();
                            table.destroy();
                            $('#room_layout_data').html(bookEdit.resolverRoomLayoutData(data.itemData,check_in,check_out));
                            table = $('#room_layout').DataTable({
                                "pagingType":   "numbers"
                            })
                            $('#room_layout_length').hide();
                            $('#room_layout_filter input').addClass('input-medium');
                        } else {
                            $('#modal_fail').modal('show');
                            $('#modal_fail_message').html(data.message);
                        }
                    }
                });
            },
            //分解房型、价格体系数据 
            bookEdit.resolverRoomLayoutData = function(data, check_in, check_out) {
                BookEditClass.lastDate = {};
                var html = td1 = td2 = td_bed = option = pledge = '';
                var cash_pledge = {};
                var in_date = new Date(check_in);
                var in_day = in_date.getDate();
                var in_month = in_date.getMonth() - 0 + 1;
                var in_year = in_date.getFullYear();
                var out_date = new Date(check_out);
                var out_day = out_date.getDate();
                var out_month = out_date.getMonth() - 0 + 1;
                var out_year = out_date.getFullYear();
                var layoutPrice = data.layoutPrice;var room = data.room;var priceSystem = data.priceSystem;
                if(layoutPrice == '') {
                    $('#room_layout_data').html('<tr class="gradeX odd" role="row"><td class="sorting_1">无房</td><td></td></tr>');
                    return;
                }
                var roomSellLayout = data.roomSellLayout;
                var tmpExtraBedPrice = data.extraBedPrice; var extraBedPrice = {};
                if(tmpExtraBedPrice != '') {
                    for(i in tmpExtraBedPrice) {
                        //][][
                        var id = tmpExtraBedPrice[i].sell_layout_id  +'-'+ tmpExtraBedPrice[i].room_layout_price_system_id +'-'
                               + tmpExtraBedPrice[i].this_year +'-'+ tmpExtraBedPrice[i].this_month;
                        extraBedPrice[id] = tmpExtraBedPrice[i];
                    }
                }
                //console.log(extraBedPrice);
                var weekday = BookEditClass.weekday;
                var in_months = BookEditClass.leapYear();
                var same_layout_system = ''; //room_layout_price_system_id
                for(i in layoutPrice) {
                    var sell_layout_id = layoutPrice[i].sell_layout_id;
                    var system_id = layoutPrice[i].room_layout_price_system_id;
                    var extraBedid = sell_layout_id  +'-'+ system_id +'-'+ layoutPrice[i].this_year +'-'+ layoutPrice[i].this_month;
                    if((sell_layout_id + '_' + system_id) == same_layout_system) {
                        //td2 += td2; 与上一个相同的房型和价格体系
                    } else {
                        if(i > 0) {
                            var _sell_layout_id = layoutPrice[i - 1].sell_layout_id;
                            var _system_id = layoutPrice[i - 1].room_layout_price_system_id;
                            var html_id = 'room_layout_id="'+roomSellLayout[_sell_layout_id].room_layout_id+'" sell_layout_id="'+_sell_layout_id+'" system_id="'+_system_id+'"';
                            var pledge = '<ul class="stat-boxes stat-boxes2"><li><div class="left peity_bar_bad cash_pledge"><%$arrayLaguage["cash_pledge"]["page_laguage_value"]%></div>'
                                        +'<div class="right pledge_price"><span><input system_id="'+_system_id+'" sell_layout="'+_sell_layout_id+'" value="'+cash_pledge[_sell_layout_id+'-'+_system_id]+'" class="span12" type="text"></span></div></li></ul>';
                            //cash_pledge[room_layout_id+'-'+system_id] = layoutPrice[i][day+'_day'];
                            html += '<tr '+html_id+'>'+
                                        '<td class="details-control">'+td1+'</td>'+
                                        '<td>'+td2 + td_bed + pledge + '</td>'+
                                        //'<td>'+td_bed+'</td>'+
                                    '</tr>';
                            td1 = td2 = td_bed = option = pledge = '';   
                        }
                        td1 = '<a href="#room" class="select_room">' + roomSellLayout[sell_layout_id].room_sell_layout_name + ' &#8226; ' //+ i 
                        //roomSellLayout[sell_layout_id].room_layout_name + 
                             + priceSystem[system_id].room_layout_price_system_name;
                        td1 = td1 +' <i class="am-icon-search am-blue-16A2EF"></i></a>';
                    }
                    //td2 begin
                    td2 += '<ul class="stat-boxes stat-boxes2">';
                    td2 += '<li><div class="left peity_bar_bad"><span>'+layoutPrice[i].this_month+'</span>'
                            +layoutPrice[i].this_year+'</div><div class="right price"><span><%$arrayLaguage["room_price"]["page_laguage_value"]%></span></div></li>';
                    if(in_year == out_year) {//相同的年
                        if(in_month == out_month) {//相同的月
                            loop_day = out_day;
                        } else {//不通的月
                            if(in_month < out_month) loop_day = in_months[in_month - 1];
                            if(out_month == layoutPrice[i].this_month) loop_day = out_day;
                            if(in_month < layoutPrice[i].this_month) {
                                in_day = 1;
                            } else {
                                in_day = in_date.getDate();  
                            }
                        }
                    } else {//不同的年
                        loop_day = in_months[layoutPrice[i].this_month - 1];
                        if(out_month == layoutPrice[i].this_month && out_year == layoutPrice[i].this_year) loop_day = out_day;
                        if(i > 0) {
                            //console.log(layoutPrice[i].this_year +'=='+ in_year +'&&'+ layoutPrice[i].this_month +'=='+ in_month);
                            if(layoutPrice[i].this_year == in_year && layoutPrice[i].this_month == in_month)  {
                                in_day = in_date.getDate();
                            } else {
                                in_day = 1;
                            }
                        }
                        if(in_year == layoutPrice[i].this_year && in_month == layoutPrice[i].this_month) in_day = in_date.getDate();
                    }
                    var lastYear = layoutPrice[i].this_year;var lastMonth = (layoutPrice[i].this_month - 0) < 10 ? '0' + layoutPrice[i].this_month : layoutPrice[i].this_month;
                    var lastDay = (loop_day - 0) < 10 ? '0' + loop_day : loop_day;
                    BookEditClass.lastDate[sell_layout_id + '-' + system_id] = lastYear + '-' + lastMonth + '-' + lastDay;
                    for(var day_i = in_day; day_i<= loop_day; day_i++) {
                        var day = day_i < 10 ? '0'+day_i : day_i;
                        var month = layoutPrice[i].this_month < 10 ? '0' + layoutPrice[i].this_month : layoutPrice[i].this_month;
                        var this_day = layoutPrice[i].this_year+'-'+month+'-'+day;
                        var week_date = new Date(this_day);
                        var week = week_date.getDay();//room_layout_id="'++'"
                        var div_class = week == 0 || week == 6 ? 'peity_bar_good' : '';
                        td2 += '<li><div class="left '+div_class+'"><span>'+day+'</span>'+weekday[week]+'</div><div class="right">'
                            +'<input value="'+layoutPrice[i][day+'_day']+'" rdate="'+this_day+'" '
                            +'room_layout="'+roomSellLayout[sell_layout_id].room_layout_id+'" system_id="'+system_id+'" sell_layout="'+sell_layout_id+'"'
                            +'class="layout_price span12" type="text" ></div></li>';
                        if(typeof(cash_pledge[sell_layout_id+'-'+system_id]) == 'undefined') {
                            cash_pledge[sell_layout_id+'-'+system_id] = layoutPrice[i][day+'_day'];
                        }
                    }
                    td2 += '</ul>';
                    //td2 end
                    //bed begin
                    if(typeof(extraBedPrice[extraBedid]) != 'undefined') {
                        var bed = extraBedPrice[extraBedid];
                        td_bed += '<ul class="stat-boxes stat-boxes2">';
                        td_bed += '<li><div class="left peity_bar_bad"><span>'+layoutPrice[i].this_month+'</span>'
                            +layoutPrice[i].this_year+'</div><div class="right price"><span><%$arrayLaguage["extra_bed"]["page_laguage_value"]%></span></div></li>';
                        for(var day_i = in_day; day_i<= loop_day; day_i++) {
                            var this_day = layoutPrice[i].this_year+'-'+layoutPrice[i].this_month+'-'+day_i;
                            var week_date = new Date(this_day);
                            var week = week_date.getDay();
                            var day = day_i < 10 ? '0'+day_i : day_i;
                            var div_class = week == 0 || week == 6 ? 'peity_bar_good' : '';
                            td_bed += '<li><div class="left '+div_class+'"><span>'+day+'</span>'+weekday[week]+'</div><div class="right">'
                                +'<input value="'+bed[day+'_day']+'" beddate="'+this_day+'" '
                                +'room_layout="'+roomSellLayout[sell_layout_id].room_layout_id+'" system_id="'+system_id+'" sell_layout="'+sell_layout_id+'"'
                                +'class="span12 extra_bed_price" type="text" >'
                                +'</div></li>';
                        }    
                        td_bed += '</ul>';
                    }
                    //end  bed
                    //td_bed = '';
                    same_layout_system = sell_layout_id + '_' + system_id;
                }
                //console.log(BookEditClass.lastDate);
                var pledge = '<ul class="stat-boxes stat-boxes2"><li><div class="left peity_bar_bad cash_pledge"><%$arrayLaguage["cash_pledge"]["page_laguage_value"]%></div>'
                                        +'<div class="right pledge_price"><span>'
                                        +'<input system_id="'+system_id+'" sell_layout="'+sell_layout_id+'" value="'+cash_pledge[sell_layout_id+'-'+system_id]+'" class="span12" type="text"></span></div></li></ul>';//+' max_people="'+roomLayout[_room_layout_id].max_people+'"  max_children="'+roomLayout[_room_layout_id]..max_children+'">'+
                html += '<tr room_layout_id="'+roomSellLayout[sell_layout_id].room_layout_id+'" sell_layout_id="'+sell_layout_id+'" system_id="'+system_id+'">'+
                            '<td class="details-control">'+td1+'</td>'+
                            '<td>'+td2 + td_bed + pledge + '</td>'+
                            //'<td>'+td_bed+'</td>'+
                        '</tr>';
                return html;
            },
            bookEdit.formatRoomTable = function(data, system_id, sell_id) {
                var html = '';
                if(data.success == 1) {
                   if(data.itemData != null && data.itemData != '') {
                       itemData = data.itemData;
                       var selectHtml = '';
                       var extra_bed_disable = 'disabled';
                       for(i in data.itemData) {
                            var addBedSelect = '';
                            if(itemData[i].extra_bed > 0) {
                                extra_bed_disable = '';
                            }
                            selectHtml = '<select '+extra_bed_disable+' class="input-mini room_extra_bed" room_layout="'+itemData[i].room_layout_id+'" system_id="'+system_id+'" '
                                        +'room="'+itemData[i].room_id+'" sell_id="'+sell_id+'">';
                            for(j = 0; j <= itemData[i].extra_bed; j++) {
                                if($('#addBed_data').data(sell_id+'_'+itemData[i].room_id) == j) {
                                    addBedSelect = 'selected';
                                }
                                selectHtml += '<option value="'+j+'" '+addBedSelect+'>'+j+'</option>';
                                addBedSelect = '';
                            }
                            selectHtml += '</select>';
                            extra_bed_disable = 'disabled';
                            //}
                            //设置是否是已使用的checked
                            var checked_room = '';
                            if(typeof($('#room_data').data(itemData[i].room_id)) != 'undefined') {
                                if($('#room_data').data(itemData[i].room_id) == (sell_id+'-'+ system_id) ) {
                                    checked_room = 'checked';
                                } else {
                                    checked_room = 'disabled';
                                }
                            }
                            html += '<tr>'
                                 +'<td>'
                                 +'<input '+checked_room+' type="checkbox" value="'+itemData[i].room_id+'" system_id="'+system_id+'" sell_id="'+sell_id+'"'
                                 +'room_layout="'+itemData[i].room_layout_id+'" max_people="'+itemData[i].max_people+'" max_children="'+itemData[i].max_children+'"'
                                 +' title="'+itemData[i].room_number+'" />'
                                 +'</td>'
                                 +'<td>'+itemData[i].room_name+'['+itemData[i].room_number+']<i class="am-icon-location-arrow am-blue-3F91DD"></i>'
                                 +BookEditClass.orientations[itemData[i].room_orientations]
                                 +' '+itemData[i].room_area+'㎡</td>'
                                 +'<td>'+itemData[i].max_people+'</td>'
                                 +'<td>'+itemData[i].max_children+'</td>'
                                 /*+'<td>'+itemData[i].room_mansion+'</td>'
                                 +'<td>'+itemData[i].room_floor+'</td>'*/
                                 +'<td>'+selectHtml+'</td>'
                                 +'</tr>';
                            selectHtml = '';
                       }
                       html = '<table class="table table-bordered table-striped with-check">'
                              +'<thead>'
                              +'<tr>'
                              +'<th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox" /></th>'
                              +'<th><%$arrayLaguage["room_name"]["page_laguage_value"]%>[<%$arrayLaguage["room_number"]["page_laguage_value"]%>]</th>'
                              +'<th><%$arrayLaguage["max_people"]["page_laguage_value"]%></th>'
                              +'<th><%$arrayLaguage["children"]["page_laguage_value"]%></th>'
                              /*+'<th><%$arrayLaguage["room_mansion"]["page_laguage_value"]%></th>'
                              +'<th><%$arrayLaguage["room_floor"]["page_laguage_value"]%></th>'*/
                              +'<th><%$arrayLaguage["extra_bed"]["page_laguage_value"]%></th>'
                              +'</tr>'
                              +'</thead>'
                              +'<tbody>'
                              + html
                              +'</tbody>'
                              +'</table>';	  
                   }
                   return html;
               } else {
                   $('#modal_fail').modal('show');
                   $('#modal_fail_message').html(data.message);
                   return html;
               }
            },
            bookEdit.resetRoomStatus = function(room_id, sell_id, system_id, status) {
                var checkbox = $('#room_layout_data td input:checkbox');
                checkbox.each(function() {
                    if($(this).val() == room_id) {
                        if($(this).attr('sell_id') == sell_id && $(this).attr('system_id') == system_id)  {
                        } else {
                            if(status) this.disabled = true;
                            if(!status) this.disabled = false;
                        }
                    }
                })
            },
            //计算价格
            bookEdit.computeBookPrice = function(checkDate) {
                if(checkDate == false) {
                } else {
                    if(new Date($('#book_check_out').val()) <= new Date($('#book_check_in').val())) {
                        $('#modal_fail').modal('show');
                        $('#modal_fail_message').html("抱歉，这个时间不正确！");
                        return false;
                    }
                }
                
                var bookSelectRoom = BookEditClass.bookSelectRoom;
                var room_price = pledge_price = service_price = 0;//客房价格 押金 需要的服务费
                var select_html = ' <select class="input-small bookSelectRoom" name="book_user_room[]">';//用户选择房间号
                var option = '';//选项
                var days = $('#book_days_total').val();//总共住多少天
                var is_half = days.indexOf(".") > 0 ? true : false;
                var in_date = $('#book_check_in').val().substr(0, 10);var out_date = $('#book_check_out').val().substr(0, 10);
                var balance_date = new Date($('#balance_date').val());//结算日
                var balance_date_time = balance_date.getTime();
                BookEditClass.max_man = 0;//人数
                console.log(in_date + '  ' + out_date + ' ' + balance_date);
                $("#room_layout_html input").each(function (i) {
                    var val = $(this).val() - 0; //获取单个value 如果大于0 表示有客房
                    var select_room = {};
                    if(val > 0) {
                        console.log('room_price begin:' + room_price);
                        var layout = $(this).attr('layout');//room or bed
                        var room_layout = $(this).attr('room_layout');//room_layout id
                        var system_id = $(this).attr('system_id');
                        var sell_id = $(this).attr('sell_id');
                        select_room[val] = 0;//是否已经选择room
                        select_room[val + '_bed'] = 0;//是否有加床
                        //var room_key = 
                        if(layout == 'room') {
                            $('.layout_price').each(function(index, element) {
                                //房型价格
                                if($(this).attr('sell_layout') == sell_id && $(this).attr('system_id') == system_id) {//房型和systemID对应上
                                    var now_date = new Date($(this).attr('rdate'));
                                    var now_date_time = now_date.getTime();
                                    //console.log(now_date_time >= max_date_time);
                                    if(now_date_time <= balance_date_time) {
                                        var price = $(this).val() - 0;
                                        if(now_date_time == balance_date_time && is_half) {
                                            price = price * 0.5;
                                        }
                                        room_price += price;
                                        if(select_room[val] == 0) {
                                            option += '<option value="'+val+'">'+bookSelectRoom[val]+'</option>';
                                            BookEditClass.max_man++;
                                            select_room[val] = 1;
                                        }
                                        console.log('room_price room:' + room_price + ' ' + $(this).attr('rdate'));
                                    }
                                }
                            });
                            $('.pledge_price input').each(function(index, element) {
                                //押金
                                if($(this).attr('sell_layout') == sell_id && $(this).attr('system_id') == system_id) {//房型和systemID对应上
                                    pledge_price += ($(this).val() - 0);
                                }
                            });
                            $('.service_price').each(function(index, element) {
                                //需要的服务费
                                service_price += ($(this).val() - 0);
                            });
                        }
                        if(layout == 'bed') {
                            var room_id = $(this).attr('room');
                            console.log($('#room_data').data());
                            if(typeof($('#room_data').data(room_id)) == 'undefined') return;
                            var room_layout_system = $('#room_data').data(room_id);// +'-'+ system_id
                            var room_layout_system = room_layout_system.split('-');
                            room_layout_id = room_layout_system[0];
                            system_id = room_layout_system[1];
                            $('.extra_bed_price').each(function(index, element) {
                                //房型价格
                                if($(this).attr('sell_layout') == sell_id && $(this).attr('system_id') == system_id) {
                                    //相同room_layout
                                    var now_date = new Date($(this).attr('beddate'));
                                    var now_date_time = now_date.getTime();
                                    if(now_date_time <= balance_date_time) {
                                        var price = $(this).val() - 0;
                                        if(now_date_time == balance_date_time && is_half) {
                                            price = price * 0.5;
                                        }
                                        room_price = price * val + room_price;
                                        if(select_room[val + '_bed'] == 0) {
                                            for(i = 1; i <= val; i++) {
                                                option += '<option value="'+room_id+'">'+bookSelectRoom[room_id]+'</option>';	
                                                BookEditClass.max_man++;
                                            }
                                            select_room[val + '_bed'] = 1;
                                        }
                                        console.log('bed:' + room_price);
                                    }
                                }
                            });
                        }
                    }
                });
                select_html += option + '</select>';
                $('#total_room_rate').val(room_price);
                $('#book_total_cash_pledge').val(pledge_price);
                $('#need_service_price').val(service_price);
                console.log(room_price);
                //room_price = days * room_price * ($('#discount').val() - 0) / 100;
                var book_service_charge = $('#book_service_charge').val() - 0;
                var total_price = book_service_charge + room_price;
                /////////
                
                ////
                $('#total_price').val(total_price);
                $('#prepayment').val(room_price);//预付金
                //$('#room_layout_html').html(room_layout_html);	
                $('.bookSelectRoom').remove();
                $('.book_user_info').append(select_html);
            }
            ;
            return bookEdit;
        },
        leapYear: function(year){
            var isLeap = year%100==0 ? (year%400==0 ? 1 : 0) : (year%4==0 ? 1 : 0);
            return new Array(31,28+isLeap,31,30,31,30,31,31,30,31,30,31);
        }
    }
    var bookEdit = BookEditClass.instance();
    bookEdit.initParameter();
    bookEdit.init();
});
</script>