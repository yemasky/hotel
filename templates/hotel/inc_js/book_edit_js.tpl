<script language="javascript">
$(document).ready(function(){
	//日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() - 1);
	$('#book_check_in').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
		beforeShowDay: function(date) {
			if (date.getTime() < dateToDisable.getTime()) {
				return [false, ""];
			}
			return [true, ""];
		}
	});
	$('#book_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
		beforeShowDay: function(date) {//new Date($('#book_check_in').val()).getDate()
			var dateToDisable = new Date($('#book_check_in').val());
			if (date.getTime() < dateToDisable.getTime()) {
				return [false, ""];
			}
			return [true, ""];
		}
	});
	//日历 时间控制
	$('#book_order_retention_time').datetimepicker({
		datepicker:false,format:'H:i',step:30
	});
	
});//add_attr_classes
$(document).ready(function(){
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
			if(contact_validate.form()) {
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
        hotelCheckDate: {'hotel_checkin':'<%$hotel_checkin%>', 'hotel_checkout':'<%$hotel_checkout%>'},
	    max_man: 0,//最多人数
        BookUser_num: 1,
        instance: function() {
            var bookEdit = {};
            bookEdit.initParameter = function() {
                BookEditClass.hotel_service[-1] = 1;
                BookEditClass.weekday=new Array(7)
                BookEditClass.weekday[0]="日"
                BookEditClass.weekday[1]="一"
                BookEditClass.weekday[2]="二"
                BookEditClass.weekday[3]="三"
                BookEditClass.weekday[4]="四"
                BookEditClass.weekday[5]="五"
                BookEditClass.weekday[6]="六"
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
                $('#contact_mobile,#contact_name,#contact_email,#begin_book').bind("keyup click", function(e) {
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
                                   bookEdit.computeBookPrice();
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
                        })
                    } else {
                        $('#book_type_id').after(book_discount_list[book_type_id]);
                        $('.select_discount').change(function(e) {
                            $('#discount').val(book_discount_list[$(this).val() + '_0']);
                        })
                        $('#discount').val(book_discount_list[book_type_id + '_']);
                        if(booktype == 'OTA') 
                            $('#book_type_id').after('<span id="order_number_ourter"> <%$arrayLaguage["order_number_ourter"]["page_laguage_value"]%> : <input name="book_order_number_ourter" value="" class="span2" type="text"></span>');
                    }
                    //console.log(BookEditClass.book_discount_list);
                    //计算价格
                    bookEdit.computeBookPrice();
                    //console.log(book_discount_list);
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
                    var bookSelectRoom = BookEditClass.bookSelectRoom;
                    var tr = $(this).closest('tr');
                    var row = table.row( tr );
                    var _this = this;
                    if ( row.child.isShown() ) {
                        // This row is already open - close it
                        row.child.hide();
                        tr.removeClass('shown');
                    } else {
                        var system_id = $(_this).parent().attr('system_id');
                        // Open this row 	row.data()
                        $('#modal_loading').show();
                        $.getJSON('<%$searchBookInfoUrl%>&search=searchRoom&room_layout_id='+$(this).parent().attr('room_layout_id'), 
                          function(result){
                            $('#modal_loading').hide();
                            row.child(bookEdit.formatRoomTable(result, system_id)).show();
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
                                            $('#room_'+room_layout_id+'_'+room_id).remove();
                                            $("#room_data").removeData(room_id);  //移除
                                            //$(this).closest('.checker > span').removeClass('checked');
                                        }
                                        if (this.checked && typeof(room_layout_id) != 'undefined') {
                                            var room_lauout_input = '<input type="hidden" id="room_'+room_layout_id+'_'+room_id+'" '
                                                          +'name="room_layout_id['+room_layout_id+']['+system_id+'-'+room_id+']" value="'+room_id+'" '
                                                          +'layout="room" room_layout="'+room_layout_id+'" system_id="'+system_id+'" />';
                                            $('#room_layout_html').append(room_lauout_input);
                                            $('#room_data').data(room_id, room_layout_id+'-'+ system_id);
                                            bookSelectRoom[room_id] = room_name;
                                            //$(this).closest('.checker > span').addClass('checked');
                                        }
                                        //设置disable
                                        bookEdit.resetRoomStatus(room_id, room_layout_id, system_id, this.checked);
                                    }
                                });
                                //计算价格
                                bookEdit.computeBookPrice();
                            });	
                            
                            $(_this).parent().next().find('td input:checkbox').click(function(e) {
                                var room_id = $(this).val();
                                var room_layout_id = $(this).attr('room_layout');
                                var room_name = $(this).attr('title');
                                if(room_id == 'on') return;
                                if (this.checked) {
                                    //选中状态
                                    var room_lauout_input = '<input type="hidden" id="room_'+room_layout_id+'_'+room_id+'" '
                                                         +'name="room_layout_id['+room_layout_id+']['+system_id+'-'+room_id+']" value="'+room_id+'" '
                                                         +'layout="room" room_layout="'+room_layout_id+'" system_id="'+system_id+'" />';
                                    $('#room_layout_html').append(room_lauout_input);
                                    $('#room_data').data(room_id, room_layout_id+'-'+ system_id);
                                    bookSelectRoom[room_id] = room_name;
                                    //设置disable
                                    bookEdit.resetRoomStatus(room_id, room_layout_id, system_id, this.checked);
                                } else {
                                    $('#room_'+room_layout_id+'_'+room_id).remove();
                                    $("#room_data").removeData(room_id);  //移除
                                    //设置disable
                                    bookEdit.resetRoomStatus(room_id, room_layout_id, system_id, this.checked);
                                }
                                //计算价格
                                bookEdit.computeBookPrice();
                            });
                            $('.room_extra_bed').change(function(e) {
                                var extra_bed_val = $(this).val();
                                var room_id = $(this).attr('room');
                                var room_layout_id = $(this).attr('room_layout');
                                $('#extra_bed_'+room_layout_id+'_'+room_id).remove();
                                $('#addBed_data').removeData(room_layout_id+'_'+room_id);
                                if(extra_bed_val == 0) {						
                                } else {
                                    var extra_bed_input = '<input type="hidden" id="extra_bed_'+room_layout_id+'_'+room_id+'" '
                                                         +'name="extra_bed['+room_layout_id+']['+room_id+']" value="'+extra_bed_val+'" '
                                                         +'layout="bed" room_layout="'+room_layout_id+'" room="'+room_id+'" />';
                                    $('#room_layout_html').append(extra_bed_input);
                                    $('#addBed_data').data(room_layout_id+'_'+room_id, extra_bed_val);
                                }
                                //计算价格
                                bookEdit.computeBookPrice();
                            });
                            $('.book_price').keyup(function(e) {
                                bookEdit.computeBookPrice();
                            });
                            //计算价格
                        })
                    }
                } );
                //增加减少人数
                $('#addBookUser').click(function(e) {
                    var max_man = BookEditClass.max_man;
                    var BookUser_num = BookEditClass.BookUser_num;
                    if(BookUser_num >= max_man) return;
                    $(this).parent().prev().clone().insertBefore($(this).parent());
                    BookUser_num++;
                });
                $('#reduceBookUser').click(function(e) {
                    var max_man = BookEditClass.max_man;
                    var BookUser_num = BookEditClass.BookUser_num;
                    if(BookUser_num == 1) return;
                    $(this).parent().prev().remove();
                    BookUser_num--;
                });
            },
            //搜索RoomLayout
            bookEdit.ajaxGetRoomLayout = function() {
                $('#modal_loading').show();
                var hotel_service = '';//JSON.stringify(BookEditClass.hotel_service, false, 4)
                for(i in BookEditClass.hotel_service) {
                    if(BookEditClass.hotel_service[i] == 1) hotel_service += i + ',';
                }
                var check_in = $('#book_check_in').val();
                var check_out = $('#book_check_out').val();
                //$('#book_form div').hide();
                $.ajax({
                    url : '<%$searchBookInfoUrl%>&search=searchRoomLayout&discount=' + $('#discount').val() + '&hotel_service=' + hotel_service,
                    type : "post",
                    data : 'book_check_in=' + check_in
                    + '&book_check_out=' + check_out,
                    dataType : "json",
                    success : function(result) {
                        $('#modal_loading').hide();
                        $('#book_form div').show();
                        data = result;
                        if(data.success == 1) {
                            $('#room_layout_table').show();
                            table.destroy();
                            $('#room_layout_data').html(bookEdit.resolverRoomLayoutData(data.itemData,check_in,check_out));
                            table = $('#room_layout').DataTable({
                                "pagingType":   "numbers"
                            })
                            $('#room_layout_length').hide();
                            $('#room_layout_filter input').addClass('span8');
                        } else {
                            $('#modal_fail').modal('show');
                            $('#modal_fail_message').html(data.message);
                        }
                    }
                });
            },
            //分解房型、价格体系数据
            bookEdit.resolverRoomLayoutData = function(data, check_in, check_out) {
                var html = td1 = td2 = td_bed = option = pledge = '';
                var cash_pledge = {};
                var in_date = new Date(check_in);
                var in_day = in_date.getDate();var in_month = in_date.getMonth() - 0 + 1;var in_year = in_date.getFullYear();
                var out_date = new Date(check_out);
                var out_day = out_date.getDate();var out_month = out_date.getMonth() - 0 + 1;var out_year = out_date.getFullYear();
                var layoutPrice = data.layoutPrice;var room = data.room;var priceSystem = data.priceSystem;var roomLayout = data.roomLayout;
                var tmpExtraBedPrice = data.extraBedPrice; var extraBedPrice = {};
                if(tmpExtraBedPrice != '') {
                    for(i in tmpExtraBedPrice) {//][][
                        var id = tmpExtraBedPrice[i].room_layout_id  +'-'+ tmpExtraBedPrice[i].room_layout_price_system_id +'-'
                               + tmpExtraBedPrice[i].this_year +'-'+ tmpExtraBedPrice[i].this_month;
                        extraBedPrice[id] = tmpExtraBedPrice[i];
                    }
                }
                var weekday = BookEditClass.weekday;
                var in_months = BookEditClass.leapYear();
                var same_layout_system = ''; //room_layout_price_system_id
                for(i in layoutPrice) {//
                    var room_layout_id = layoutPrice[i].room_layout_id;
                    var system_id = layoutPrice[i].room_layout_price_system_id;
                    var extraBedid = room_layout_id  +'-'+ system_id +'-'+ layoutPrice[i].this_year +'-'+ layoutPrice[i].this_month;
                    if((room_layout_id + '_' + system_id) == same_layout_system) {
                        //td2 += td2; 与上一个相同的房型和价格体系
                    } else {
                        if(i > 0) {
                            var pledge = '<ul class="stat-boxes stat-boxes2"><li><div class="left peity_bar_bad cash_pledge"><%$arrayLaguage["cash_pledge"]["page_laguage_value"]%></div>'
                                        +'<div class="right price"><span><input value="'+cash_pledge[layoutPrice[i - 1].room_layout_id+'-'+layoutPrice[i - 1].room_layout_price_system_id]+'" class="span12" type="text"></span></div></li></ul>';
                            //cash_pledge[room_layout_id+'-'+system_id] = layoutPrice[i][day+'_day'];
                            var _room_layout_id = layoutPrice[i - 1].room_layout_id;
                            html += '<tr room_layout_id="'+_room_layout_id+'" system_id="'+layoutPrice[i - 1].room_layout_price_system_id+'"'
                                    +' max_people="'+roomLayout[_room_layout_id].max_people+'"  max_children="'+roomLayout[_room_layout_id].max_children+'">'+
                                        '<td class="details-control">'+td1+'</td>'+
                                        '<td>'+td2 + td_bed + pledge + '</td>'+
                                        //'<td>'+td_bed+'</td>'+
                                    '</tr>';
                            td1 = td2 = td_bed = option = pledge = '';   
                        }
                        td1 = '<a href="#room" class="select_room">' + roomLayout[room_layout_id].room_layout_name + ' &#8226; ' 
                             + priceSystem[system_id].room_layout_price_system_name;
                        td1 = td1 +' <i class="am-icon-search am-blue-16A2EF"></i></a>';
                    }
                    //td2 begin
                    td2 += '<ul class="stat-boxes stat-boxes2">';
                    td2 += '<li><div class="left peity_bar_bad"><span>'+layoutPrice[i].this_month+'</span>'
                            +layoutPrice[i].this_year+'</div><div class="right price"><span><%$arrayLaguage["room_price"]["page_laguage_value"]%></span></div></li>';
                    if(in_year == out_year) {
                        if(in_month == out_month) {
                            loop_day = out_day;
                        } else {
                            if(in_month < out_month) loop_day = in_months[in_month - 1];
                            if(out_month == layoutPrice[i].this_month) loop_day = out_day;
                            if(in_month < layoutPrice[i].this_month) in_day = 1;
                        }
                    } else {
                        //console.log(layoutPrice[i].this_month);
                        loop_day = in_months[layoutPrice[i].this_month - 1];
                        if(out_month == layoutPrice[i].this_month && out_year == layoutPrice[i].this_year) loop_day = out_day;
                        if(i > 0) in_day = 1;
                        if(in_year == layoutPrice[i].this_year && in_month == layoutPrice[i].this_month) in_day = in_date.getDate();
                    }
                    
                    for(var day_i = in_day; day_i<= loop_day; day_i++) {
                        var this_day = layoutPrice[i].this_year+'-'+layoutPrice[i].this_month+'-'+day_i;
                        var week_date = new Date(this_day);
                        var week = week_date.getDay();
                        var day = day_i < 10 ? '0'+day_i : day_i;
                        var div_class = week == 0 || week == 6 ? 'peity_bar_good' : '';
                        td2 += '<li><div class="left '+div_class+'"><span>'+day+'</span>'+weekday[week]+'</div><div class="right">'
                            +'<input value="'+layoutPrice[i][day+'_day']+'" room="price['+room_layout_id+']['+system_id+']['+this_day+']" '
                            +'room_layout="'+room_layout_id+'" system_id="'+system_id+'"'
                            +'class="layout_price span12" type="text" ></div></li>';
                        if(typeof(cash_pledge[room_layout_id+'-'+system_id]) == 'undefined') {
                            cash_pledge[room_layout_id+'-'+system_id] = layoutPrice[i][day+'_day'];
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
                                +'<input value="'+bed[day+'_day']+'" bed="bed['+room_layout_id+']['+system_id+']['+this_day+']" '
                                +'room_layout="'+room_layout_id+'" system_id="'+system_id+'"'
                                +'class="span12 extra_bed_price" type="text" >'
                                +'</div></li>';
                        }    
                        td_bed += '</ul>';
                    }
                    //end  bed
                    //td_bed = '';
                    same_layout_system = room_layout_id + '_' + system_id;
                }
                var pledge = '<ul class="stat-boxes stat-boxes2"><li><div class="left peity_bar_bad cash_pledge"><%$arrayLaguage["cash_pledge"]["page_laguage_value"]%></div>'
                                        +'<div class="right price"><span>'
                                        +'<input value="'+cash_pledge[layoutPrice[i].room_layout_id+'-'+layoutPrice[i].room_layout_price_system_id]+'" class="span12" type="text"></span></div></li></ul>';//+' max_people="'+roomLayout[_room_layout_id].max_people+'"  max_children="'+roomLayout[_room_layout_id]..max_children+'">'+
                html += '<tr room_layout_id="'+room_layout_id+'" system_id="'+system_id+'"'
                        +' max_people="'+roomLayout[room_layout_id].max_people+'"  max_children="'+roomLayout[room_layout_id].max_children+'">'+
                            '<td class="details-control">'+td1+'</td>'+
                            '<td>'+td2 + td_bed + pledge + '</td>'+
                            //'<td>'+td_bed+'</td>'+
                        '</tr>';
                return html;
            },
            bookEdit.formatRoomTable = function(data, system_id) {
                var html = '';
                if(data.success == 1) {
                   if(data.itemData != null && data.itemData != '') {
                       itemData = data.itemData;
                       var selectHtml = '';
                       for(i in data.itemData) {
                            var addBedSelect = '';
                            if(itemData[i].extra_bed > 0) {
                                selectHtml = '<select class="span2 room_extra_bed" room_layout="'+itemData[i].room_layout_id+'" system_id="'+system_id+'" '
                                            +'room="'+itemData[i].room_id+'">';
                                for(j = 0; j <= itemData[i].extra_bed; j++) {
                                    if($('#addBed_data').data(itemData[i].room_layout_id+'_'+itemData[i].room_id) == j) {
                                        addBedSelect = 'selected';
                                    }
                                    selectHtml += '<option value="'+j+'" '+addBedSelect+'>'+j+'</option>';
                                    addBedSelect = '';
                                }
                                selectHtml += '</select>';
                            }
                            //设置是否是已使用的checked
                            var checked_room = '';
                            if(typeof($('#room_data').data(itemData[i].room_id)) != 'undefined') {//undefined
                                if($('#room_data').data(itemData[i].room_id) == (itemData[i].room_layout_id+'-'+ system_id) ) {
                                    checked_room = 'checked';
                                } else {
                                    checked_room = 'disabled';
                                }
                            }
                            html += '<tr>'
                                 +'<td>'
                                 +'<input '+checked_room+' type="checkbox" value="'+itemData[i].room_id+'" system_id="'+system_id+'" '
                                 +'room_layout="'+itemData[i].room_layout_id+'" max_people="'+itemData[i].max_people+'" max_children="'+itemData[i].max_children+'"'
                                 +' title="'+itemData[i].room_number+'" />'
                                 +'</td>'
                                 +'<td>'+itemData[i].room_name+'</td>'
                                 +'<td>'+itemData[i].room_number+'</td>'
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
                              +'<th><%$arrayLaguage["room_name"]["page_laguage_value"]%></th>'
                              +'<th><%$arrayLaguage["room_number"]["page_laguage_value"]%></th>'
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
            bookEdit.resetRoomStatus = function(room_id, room_layout_id, system_id, status) {
                var checkbox = $('#room_layout_data td input:checkbox');
                checkbox.each(function() {
                    if($(this).val() == room_id) {
                        if($(this).attr('room_layout') == room_layout_id && $(this).attr('system_id') == system_id)  {
                        } else {
                            if(status) this.disabled = true;
                            if(!status) this.disabled = false;
                        }
                    }
                })
            },
            //计算价格
            bookEdit.computeBookPrice = function() {
                var bookSelectRoom = BookEditClass.bookSelectRoom;
                var max_man = BookEditClass.max_man;
                var room_price = 0;
                var select_html = ' <select class="span1 bookSelectRoom" name="book_user_room[]">';
                var option = '';
                $("#room_layout_html input").each(function (i) {
                    var val = $(this).val() - 0; //获取单个value
                    var select_room = {};
                    if(val > 0) {
                        var layout = $(this).attr('layout');//room or bed
                        var room_layout = $(this).attr('room_layout');//room_layout id
                        var system_id = $(this).attr('system_id');
                        select_room[val] = 0;
                        select_room[val + '_bed'] = 0;
                        //var room_key = 
                        if(layout == 'room') {
                            $('.layout_price').each(function(index, element) {//房型价格
                                if($(this).attr('room_layout') == room_layout && $(this).attr('system_id') == system_id) {//相同room_layout
                                    room_price = $(this).val() - 0 + room_price;
                                    //console.log(bookSelectRoom[val]);
                                    if(select_room[val] == 0) {
                                        option += '<option value="'+val+'">'+bookSelectRoom[val]+'</option>';
                                        max_man++;
                                    }
                                    select_room[val] = 1;
                                }
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
                            $('.extra_bed_price').each(function(index, element) {//房型价格
                                if($(this).attr('room_layout') == room_layout_id && $(this).attr('system_id') == system_id) {//相同room_layout
                                    room_price = ($(this).val() - 0) * val + room_price;
                                    if(select_room[val + '_bed'] == 0) {
                                        for(i = 1; i <= val; i++) {
                                            option += '<option value="'+room_id+'">'+bookSelectRoom[room_id]+'</option>';	
                                            max_man++;
                                        }
                                    }
                                    select_room[val + '_bed'] = 1;
                                }
                            });
                        }
                    }
                });
                select_html += option + '</select>';
                var check_out = $('#book_check_out').val();
                var check_in = $('#book_check_in').val();
        
                var arrayCheckOut = check_out.split(' ');
                var check_out_date = arrayCheckOut[0] + ' <%$hotel_checkout%>';
                var user_check_out_day = new Date(check_out);
                var book_check_out_day = new Date(check_out_date);
                
                var arrayCheckIn = check_in.split(' ');
                var check_in_date = arrayCheckIn[0] + ' <%$hotel_checkin%>';
                var user_check_in_day = new Date(check_in);
                var book_check_in_day = new Date(check_in_date);
                
                var hotel_overtime = new Date(arrayCheckOut[0] + ' <%$hotel_overtime%>');
                
                if(book_check_out_day <= book_check_in_day) {
                    $('#modal_fail').modal('show');
                    $('#modal_fail_message').html("抱歉，这个时间不正确！");
                    return false;
                }
                days = parseInt ((book_check_out_day.getTime() - book_check_in_day.getTime()) / (1000 * 60 * 60 * 24));
                if(user_check_out_day.getTime() > book_check_out_day.getTime()) {
                    if(user_check_out_day.getTime() > hotel_overtime.getTime()) {
                        days +=1;
                    } else {
                        days +=0.5;
                    }
                }
                if(days == 0) {//当天12点后入住
                    days = 1;
                }
                //console.log(days);
                room_price = days * room_price * ($('#discount').val() - 0) / 100;
                var book_service_charge = $('#book_service_charge').val() - 0;
                room_price = book_service_charge + room_price;
                /////////
                
                ////
                $('#total_price').val(room_price);
                $('#prepayment').val(room_price);
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