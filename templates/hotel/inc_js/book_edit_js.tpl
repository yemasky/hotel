<script language="javascript">
$(document).ready(function(){
    //日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable = new Date('<%$thisDay%>');
	//dateToDisable.setDate(dateToDisable.getDate() - 1);
	$('#user_check_in').datetimepicker({theme:'dark', format: 'Y-m-d H:i:00', formatDate:'Y-m-d H:i:00',
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
            var thisDate = new Date(this.getValue());
            var nextDate = new Date(thisDate.setDate(thisDate.getDate() + 1));
            var time_end_date = new Date($('#user_check_out').val());
            if(time_end_date.getTime() < nextDate.getTime()) {
                $('#user_check_out').val(nextDate);
                $('#user_check_out').datetimepicker({value:nextDate});
            }
        }
	});
	$('#user_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:00', formatDate:'Y-m-d H:i:00',
		beforeShowDay: function(date) {
			var dateToDisable = new Date($('#user_check_in').val());
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
        }
	});
    
    $('#room_check_in').datetimepicker({theme:'dark', format: 'Y-m-d H:i:00', formatDate:'Y-m-d H:i:00',
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
            var thisDate = new Date(this.getValue());
            var nextDate = new Date(thisDate.setDate(thisDate.getDate() + 1));
            var time_end_date = new Date($('#room_check_out').val());
            if(time_end_date.getTime() < nextDate.getTime()) {
                $('#room_check_out').val(nextDate);
                $('#room_check_out').datetimepicker({value:nextDate});
            }
        }
	});
	$('#room_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:00', formatDate:'Y-m-d H:i:00',
		beforeShowDay: function(date) {
			var dateToDisable = new Date($('#room_check_in').val());
			if (date.getTime() < dateToDisable.getTime()) {
				return [false];
			}
			return [true];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        },
        onSelectTime:function(date) {
            $('#total_room_rate').val('0');$('#room_layout_data').hide('fast');$('#room_layout_data_price').hide('fast');
            if(new Date(this.getValue()) <= new Date($('#room_check_in').val())) {
                $('#modal_fail').modal('show');
                $('#modal_fail_message').html("抱歉，这个时间不正确！");
                return false;
            }
            if($('#sell_layout').val() > 0) {
                bookEdit.searchBookRoom();
                bookEdit.computeCheckDate();
            }
        }
	});
    
    var BookEditClass = {
        hotel_service: {},book_discount_list: {},bookSelectRoom: {},bookNeed_service:{},lastDate:{},thenRoomPrice:{},tempRoomPrice:{},
        hotelCheckDate: {},roomSellLayout: {},selectBed:{},tempRoomEdit:{},room_info_id:{},
	    max_man: 0,//最多人数
        BookUser_num: 1,
        priceSystem:{},
        instance: function() {
            var bookEdit = {};
            bookEdit.initParameter = function() {
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
                bookEdit.groupSellLayoutSystem();
                BookEditClass.tempRoomEdit['edit'] = '';
            };
            bookEdit.init = function() {
                $('#sell_layout').val('');
                $('#serviceItem').val('');
                $('#add_user').click(function(e) {
                    $('#add_user_tr').show('slow');
                });
                $('#cancel_add_user').click(function(e) {
                    $('#add_user_tr').hide();
                });
                $('#add_room').click(function(e) {
                    $('#add_room_tr').show('slow');
                    BookEditClass.tempRoomEdit['edit'] = 'add_room';
                });
                $('#cancel_add_room').click(function(e) {
                    $('#add_room_tr').hide();
                    $('#room_layout_data').hide();
                    $('#room_layout_data_price').hide();
                    if(BookEditClass.tempRoomEdit == 'add_room') BookEditClass.tempRoomEdit = '';
                });
                $('#add_service').click(function(e) {
                    $('#add_service_tr').show('slow');
                });
                $('#cancel_add_service').click(function(e) {
                    $('#add_service_tr').hide();
                });
                $('#sell_layout').change(function(e) {
                    var priceSystem = BookEditClass.priceSystem;
                    var sell_id = $(this).val();var sellLayout = {};var select_html = '';
                    if(typeof(priceSystem[sell_id]) != 'undefined') {
                        sellLayout[sell_id] = priceSystem[sell_id];
                    }
                    sellLayout[0] = priceSystem[0];
                    for(sellId in sellLayout) {
                        for(systemID in sellLayout[sellId]) {
                            select_html += '<option value="'+systemID+'">'+sellLayout[sellId][systemID]+'</option>';
                        }
                    }
                    $('#price_system').html(select_html);
                    bookEdit.searchBookRoom();
                    bookEdit.computeCheckDate();
                });
                $('#price_system').change(function(e) {
                    bookEdit.searchBookRoom();
                    bookEdit.computeCheckDate();
                });
                $('#search_room').click(function(e) {
                    if($('#sell_layout').val() == '') {
                        $('#modal_info').modal('show');
                        $('#modal_info_message').html('请选择入住房型！');
                        return;
                    }
                    bookEdit.searchBookRoom();
                    bookEdit.computeCheckDate();
                });
                $('#serviceItem').change(function(e) {
                    $(this).parent().next().html('<input type="text" value="'+$(this).find("option:selected").attr('price')+'" class="input-small">');
                    $(this).parent().next().next().html('<input type="text" value="1" class="input-small">');
                    $(this).parent().next().next().next().html('<input type="text" value="100" class="input-small">');
                });
                $('#save_add_room').click(function(e) {
                    bookEdit.saveAddRoom();
                });
                $('.change_room').click(function(e) {
                    $('#add_room_tr').show('slow');
                    $(this).parent().prev().prev().html('<i class="am-icon-circle am-red-FA0A0A"></i>' + $(this).children().text());
                    bookEdit.changeRoom('change_room', this);
                });
                $('.continued_room').click(function(e) {
                    $('#add_room_tr').show('slow');
                    $(this).parent().prev().prev().html('<i class="am-icon-circle am-yellow-EBC012"></i>' + $(this).children().text());
                    bookEdit.changeRoom('continued_room', this);
                });
                $('.check_out_room').click(function(e) {
                    $('#add_room_tr').show('slow');
                    $(this).parent().prev().prev().html('<i class="am-icon-circle am-yellow-FFAA3C"></i>' + $(this).children().text());
                    bookEdit.changeRoom('check_out_room', this);
                });
                $('.cancel_room').click(function(e) {
                    $(this).parent().prev().prev().html('<i class="am-icon-circle-o"></i> 管理');
                    BookEditClass.tempRoomEdit['edit'] = '';
                });
                $('#am-icon-calculator').click(function(e) {
                    $('#rate_calculation').show('fast');
                });
            };
            bookEdit.roomInfoId = function() {
                $('.room_info_id').each(function(index, element) {
                    var room_id = $(this).attr('room_id');
                    BookEditClass.room_info_id[room_id] = room_id;
                });
            };
            bookEdit.changeRoom = function(type, _this) {
                var room_id = $(_this).parent().attr('room_id');
                if(BookEditClass.tempRoomEdit['edit'] != '') {
                }
                BookEditClass.tempRoomEdit['edit'] = type;
                BookEditClass.tempRoomEdit['room_id'] = room_id;
                BookEditClass.tempRoomEdit['book_id'] = $(_this).parent().attr('book_id');
            }
            bookEdit.groupSellLayoutSystem = function() {
                var priceSystem = BookEditClass.priceSystem;
                $('#price_system').children('option').each(function(index, element) {
                    var sell_id = $(this).attr('sell_id');
                    if(typeof(priceSystem[sell_id]) == 'undefined') {
                        priceSystem[sell_id] = {};
                        priceSystem[sell_id][$(this).val()] = $(this).text();
                    } else {
                        priceSystem[sell_id][$(this).val()] = $(this).text();
                    }
                    $('#price_system').html('');
                });
            };
            bookEdit.maxCheckOut = function(check_out) {
                var max_check_out = $('#room_check_out').val();
                var checkOutDate = new Date(check_out);var today = checkOutDate.getDate();var thisHours = checkOutDate.getHours();
                var halfPrice = $('#half_price').val().replace(':00', '');
                if(thisHours > halfPrice) {
                    //算半天
                    checkOutDate.setDate(checkOutDate.getDate()+1);
                    var month = checkOutDate.getMonth() - 0 + 1; month = month < 10 ? '0' + month : month;
                    var day = checkOutDate.getDate();day = day < 10 ? '0' + day : day;
                    max_check_out = checkOutDate.getFullYear() + '-' + month + '-' + day;                    
                }  
                return max_check_out;
            };
            bookEdit.searchBookRoom = function() {
                var room_layout_id = $('#sell_layout').find("option:selected").attr('room_layout');
                var sell_id = $('#sell_layout').val();var system_id = $('#price_system').val();
                var check_in = $('#room_check_in').val(); var check_out = $('#room_check_out').val();
                if(check_in == '' || check_out == ''){
                    $('#modal_info').modal('show');
                    $('#modal_info_message').html('请选择入住日期/离店日期！');
                    return;
                }
                if(new Date(check_out) <= new Date(check_in)) {
                    $('#modal_fail').modal('show');
                    $('#modal_fail_message').html("抱歉，这个时间不正确！");
                    return false;
                }
                if(sell_id == '') {
                    return;   
                }
                var max_check_out = bookEdit.maxCheckOut(check_out);
                $.ajax({
                    url : '<%$searchBookInfoUrl%>&search=searchRoomLayout&discount=' + $('#discount').val() + '&sell_layout_list=' + sell_id + '-' + system_id,
                    type : "post",
                    data : 'book_check_in=' + check_in + '&book_check_out=' + check_out + '&max_check_out=' + max_check_out,
                    dataType : "json",
                    success : function(result) {
                        $('#modal_loading').hide('show');
                        data = result;
                        if(data.success == 1) {
                           var html = bookEdit.resolverRoomLayoutData(data, check_in, check_out);
                           $('#room_layout_data').html('<td colspan="8"><table>' + html + '</table></td>');
                           $('#room_layout_data').show('fast');
                           $('#room_layout_data_price').show('fast');
                        } else {
                            $('#modal_fail').modal('show');
                            $('#modal_fail_message').html(data.message);
                        }
                    }
                });
                $.getJSON('<%$searchBookInfoUrl%>&search=searchRoom&room_layout_id='+room_layout_id
                                +'&sell_id='+sell_id+'&book_check_in='+check_in+'&book_check_out='+check_out,
                  function(result){
                    data = result;
                    var selectRoomhtml = bookEdit.formatRoomTable(data, system_id, sell_id);
                    $('#layout_room').html(selectRoomhtml);
                    $('#extra_bed').html(BookEditClass.selectBed[$('#select_room').val()]);
                    $('#select_room').change(function(e) {
                        $('#extra_bed').html(BookEditClass.selectBed[this.value]);
                    });
                    $('#modal_loading').hide();
                    //计算价格
                })   
                //清空价格
                $('#total_room_rate').val('');
            };
            bookEdit.formatRoomTable = function(data, system_id, sell_id) {
                var selectRoomhtml = '';var selectBed = BookEditClass.selectBed;
                if(data.itemData != null && data.itemData != '') {
                   itemData = data.itemData;
                   var selectBedHtml = '';
                   var extra_bed_disable = 'disabled';
                   for(i in data.itemData) {
                        if(BookEditClass.room_info_id[itemData[i].room_id] > 0 ) {continue;}
                        var addBedSelect = '';
                        if(itemData[i].extra_bed > 0) {
                            extra_bed_disable = '';
                        }
                        selectBedHtml = '<select '+extra_bed_disable+' class="input-mini room_extra_bed" room_layout="'+itemData[i].room_layout_id+'" system_id="'+system_id+'" '
                                    +'room="'+itemData[i].room_id+'" sell_id="'+sell_id+'">';
                        for(j = 0; j <= itemData[i].extra_bed; j++) {
                            if($('#addBed_data').data(sell_id+'_'+itemData[i].room_id) == j) {
                                addBedSelect = 'selected';
                            }
                            selectBedHtml += '<option value="'+j+'" '+addBedSelect+'>'+j+'</option>';
                            addBedSelect = '';
                        }
                        selectBedHtml += '</select>';
                        extra_bed_disable = 'disabled';
                        selectBed[itemData[i].room_id] = selectBedHtml;
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
                        selectRoomhtml += '<option '+checked_room+' value="'+itemData[i].room_id+'" system_id="'+system_id+'" sell_id="'+sell_id+'"'
                             +'room_layout="'+itemData[i].room_layout_id+'" max_people="'+itemData[i].max_people+'" max_children="'+itemData[i].max_children+'"'
                             +' title="'+itemData[i].room_number+'" >'
                             +itemData[i].room_name+'['+itemData[i].room_number+']'
                             //+BookEditClass.orientations[itemData[i].room_orientations]
                             //+' '+itemData[i].room_area+'㎡'
                             +itemData[i].max_people
                             +itemData[i].max_children
                             +'</option>';
                        //selectHtml = '';
                   }
                   BookEditClass.selectBed = selectBed;
                   if(selectRoomhtml == '') selectRoomhtml = '<option value="">无房</option>';
                   selectRoomhtml = '<select id="select_room">'+ selectRoomhtml+'</select>';	  
                }
                return selectRoomhtml;
            };
            //分解房型、价格体系数据 
            bookEdit.resolverRoomLayoutData = function(data, check_in, check_out) {
                var data = data.itemData;
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
                var layoutPrice = data.layoutPrice;
                
                if(layoutPrice == '' || typeof(layoutPrice) == 'undefined' || layoutPrice[0] == '') {
                    return '-1';//无价格
                }
                var priceSystem = bookEdit.getSellLayoutSystem();
                //var roomSellLayout = data.roomSellLayout;
                var roomSellLayout = bookEdit.getRoomSellLayout();
                var tmpExtraBedPrice = data.extraBedPrice; 
                var extraBedPrice = {};
                if(tmpExtraBedPrice != '') {
                    for(i in tmpExtraBedPrice) {
                        //][][
                        var id = tmpExtraBedPrice[i].sell_layout_id  +'-'+ tmpExtraBedPrice[i].room_layout_price_system_id +'-'
                               + tmpExtraBedPrice[i].this_year +'-'+ tmpExtraBedPrice[i].this_month;
                        extraBedPrice[id] = tmpExtraBedPrice[i];
                    }
                }
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
                        td1 = '' + roomSellLayout[sell_layout_id].room_sell_layout_name + '-' //+ i 
                        //roomSellLayout[sell_layout_id].room_layout_name + 
                             + priceSystem[system_id].room_layout_price_system_name;
                        td1 = td1 +' ';
                    }
                    //td2 begin
                    td2 += '<ul class="stat-boxes stat-boxes2">';
                    td2 += '<li><div class="left peity_bar_bad"><span>'+layoutPrice[i].this_month+'</span>'
                            +layoutPrice[i].this_year+'</div><div class="right price"><span><%$arrayLaguage["room_price"]["page_laguage_value"]%></span></div></li>';
                    if(in_year == out_year) {
                        //相同的年
                        if(in_month == out_month) {
                            //相同的月
                            loop_day = out_day;
                        } else {
                            //不同的月
                            if(in_month < out_month) loop_day = in_months[in_month - 1];
                            if(out_month == layoutPrice[i].this_month) loop_day = out_day;
                            if(in_month < layoutPrice[i].this_month) {
                                in_day = 1;
                            } else {
                                in_day = in_date.getDate();  
                            }
                        }
                    } else {
                        //不同的年
                        loop_day = in_months[layoutPrice[i].this_month - 1];
                        if(out_month == layoutPrice[i].this_month && out_year == layoutPrice[i].this_year) loop_day = out_day;
                        if(i > 0) {
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
                    var month = layoutPrice[i].this_month < 10 ? '0' + layoutPrice[i].this_month : layoutPrice[i].this_month;
                    for(var day_i = in_day; day_i<= loop_day; day_i++) {
                        var day = day_i < 10 ? '0'+day_i : day_i;
                        var this_day = layoutPrice[i].this_year+'-'+month+'-'+day;
                        var week_date = new Date(this_day);
                        var week = week_date.getDay();//room_layout_id="'++'"
                        var div_class = week == 0 || week == 6 ? 'peity_bar_good' : '';
                        td2 += '<li><div class="left '+div_class+'"><span>'+day+'</span>'+weekday[week]+'</div><div class="right">'
                            +'<input value="'+layoutPrice[i][day+'_day']+'" rdate="'+this_day+'" '
                            +'room_layout="'+roomSellLayout[sell_layout_id].room_layout_id+'" system_id="'+system_id+'" sell_layout="'+sell_layout_id+'"'
                            +'class="layout_price span12" type="text" readonly ></div></li>';
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
                            var day = day_i < 10 ? '0'+day_i : day_i;
                            //var month = layoutPrice[i].this_month < 10 ? '0' + layoutPrice[i].this_month : layoutPrice[i].this_month;
                            var this_day = layoutPrice[i].this_year+'-'+month+'-'+day;
                            var week_date = new Date(this_day);
                            var week = week_date.getDay();
                            
                            var div_class = week == 0 || week == 6 ? 'peity_bar_good' : '';
                            td_bed += '<li><div class="left '+div_class+'"><span>'+day+'</span>'+weekday[week]+'</div><div class="right">'
                                +'<input value="'+bed[day+'_day']+'" beddate="'+this_day+'" '
                                +'room_layout="'+roomSellLayout[sell_layout_id].room_layout_id+'" system_id="'+system_id+'" sell_layout="'+sell_layout_id+'"'
                                +'class="span12 extra_bed_price" type="text" readonly >'
                                +'</div></li>';
                        }    
                        td_bed += '</ul>';
                    }
                    //end  bed
                    //td_bed = '';
                    same_layout_system = sell_layout_id + '_' + system_id;
                }
                var pledge = '<ul class="stat-boxes stat-boxes2"><li><div class="left peity_bar_bad cash_pledge"><%$arrayLaguage["cash_pledge"]["page_laguage_value"]%></div>'
                                        +'<div class="right pledge_price"><span>'
                                        +'<input system_id="'+system_id+'" sell_layout="'+sell_layout_id+'" value="'+cash_pledge[sell_layout_id+'-'+system_id]+'" class="span12" type="text"></span></div></li></ul>';//+' max_people="'+roomLayout[_room_layout_id].max_people+'"  max_children="'+roomLayout[_room_layout_id]..max_children+'">'+
                html += '<tr room_layout_id="'+roomSellLayout[sell_layout_id].room_layout_id+'" sell_layout_id="'+sell_layout_id+'" system_id="'+system_id+'">'+
                            '<td class="details-control">'+td1+'</td>'+
                            '<td>'+td2 + td_bed + pledge + '</td>'+
                            //'<td>'+td_bed+'</td>'+
                        '</tr>';
                return html;
            };
            bookEdit.getRoomSellLayout = function() {
                //if(BookEditClass.roomSellLayout != '') return BookEditClass.roomSellLayout;
                var roomSellLayout = BookEditClass.roomSellLayout;
                $('#sell_layout').children('option').each(function(index, element) {
                    var room_layout_id = $(this).attr('room_layout');
                    if(room_layout_id >= 0) {
                        roomSellLayout[this.value] = {};
                        roomSellLayout[this.value]['room_layout_id'] = $(this).attr('room_layout');
                        roomSellLayout[this.value]['sell_id'] = this.value;
                        roomSellLayout[this.value]['room_sell_layout_name'] = $.trim($(this).text());
                    }
                })
                BookEditClass.roomSellLayout = roomSellLayout;
                return roomSellLayout;
            };
            bookEdit.getSellLayoutSystem = function() {
                var priceSystem = BookEditClass.priceSystem;
                var allSellLayoutSystem = {};
                for(sell_id in priceSystem) {
                    for(system_id in priceSystem[sell_id]) {
                        allSellLayoutSystem[system_id] = {};
                        allSellLayoutSystem[system_id]['room_layout_price_system_name'] = priceSystem[sell_id][system_id];
                    }
                }
                return allSellLayoutSystem;
            };
            bookEdit.computeCheckDate = function() {
                var outDate = new Date($('#room_check_out').val());
                var inDate = new Date($('#room_check_in').val());
                var outDateTime =new Date($('#room_check_out').val().substr(0, 10) + ' 00:00:00');
                var inDateTime  =new Date($('#room_check_in').val().substr(0, 10) + ' 00:00:00');
                var days = Math.floor((outDateTime.getTime() - inDateTime.getTime())/(24*3600*1000));
                var halfPrice = $('#half_price').val().substr(0, 2) - 0;
                var checkout = '<%$hotel_checkout%>';
                //标准结算日期
                var  balance_date = new Date($('#room_check_out').val());
                balance_date.setDate(balance_date.getDate() - 1);
                if((outDate.getHours() - 0) > halfPrice) {
                    //算1天
                    days = days - 0 + 1;
                    //加1天的结算日期
                    balance_date.setDate(balance_date.getDate() + 1);
                }
                if((outDate.getHours() - 0) <= halfPrice && (outDate.getHours() - 0) > checkout.substr(0, 2)) {
                    //算0.5天
                    days = days - 0 + 0.5;
                    //加0.5天的结算日期
                    balance_date.setDate(balance_date.getDate() + 1);
                }
                $('#book_days_total').val(days);
                var day = balance_date.getDate();
                day = (day - 0) < 10 ? '0' + day : day;
                var month = balance_date.getMonth() + 1;
                month = month < 10 ? '0' + month : month;
                $('#balance_date').val(balance_date.getFullYear() + '-' + month + '-' + day);
            };
            $('#room_rate_calculation').click(function(e) {
                bookEdit.computeBookPrice();
            });
            //计算价格
            bookEdit.computeBookPrice = function() {
                if(typeof($('.layout_price')) == 'undefined') return;
                //var thenRoomPrice = BookEditClass.thenRoomPrice;
                var tempRoomPrice = BookEditClass.tempRoomPrice;
                tempRoomPrice['room'] = {};
                var balance_date = new Date($('#balance_date').val());//结算日
                var balance_date_time = balance_date.getTime();
                var days = $('#book_days_total').val();//总共住多少天
                var discount = $('#discount').val();
                var is_half = days.indexOf(".") > 0 ? true : false;
                var select_room = {};
                var room_price = bed_price =  0;//客房价格 押金 需要的服务费
                var room_layout = $('#sell_layout').find('option:selected').attr('room_layout');
                var system_id = $('#price_system').val();
                var sell_id = $('#sell_layout').val();
                var room_key = sell_id + '-' + room_layout + '-' + system_id;
                tempRoomPrice['room']['room_key'] = room_key;
                $('.layout_price').each(function(index, element) {
                    //房型价格  thenRoomPrice 正在订房当时的价格
                    var rdate = $(this).attr('rdate');
                    var now_date = new Date(rdate);
                    var now_date_time = now_date.getTime();
                    if(now_date_time <= balance_date_time) {
                        var price = $(this).val() - 0;
                        tempRoomPrice['room'][rdate] = price;//房费
                        if(now_date_time == balance_date_time && is_half) {
                            price = price * 0.5;
                        }
                        room_price += price;
                    }
                });
                room_price = room_price * discount / 100;
                tempRoomPrice['room']['room_price'] = room_price;
                tempRoomPrice['room']['room_id'] = $('#select_room').val();
                tempRoomPrice['room']['total_room_rate'] = room_price;
                tempRoomPrice['room']['totle_price'] = room_price;
                var val = $('#extra_bed select').val();
                if(val > 0) {
                    tempRoomPrice['bed'] = {};
                    tempRoomPrice['bed']['room_key'] = room_key;
                    var room_id = $('#extra_bed select').attr('room');
                    if(tempRoomPrice['room']['room_id'] == room_id) {
                        $('.extra_bed_price').each(function(index, element) {
                            //房型价格
                            //相同room_layout
                            var beddate = $(this).attr('beddate');
                            var now_date = new Date(beddate);
                            var now_date_time = now_date.getTime();
                            if(now_date_time <= balance_date_time) {
                                var price = $(this).val() - 0;
                                tempRoomPrice['bed'][beddate] = price;//加床
                                if(now_date_time == balance_date_time && is_half) {
                                    price = price * 1;
                                }
                                bed_price = price * val + bed_price;
                            }
                        });
                        tempRoomPrice['bed']['bed_price'] = bed_price;
                        tempRoomPrice['bed']['room_id'] = $('#select_room').val();
                        tempRoomPrice['room']['totle_price'] = tempRoomPrice['room']['totle_price'] + bed_price;
                    }
                }
                $('#total_extra_bed_price').val(bed_price);
                $('#total_room_rate').val(tempRoomPrice['room']['total_room_rate']);
                BookEditClass.tempRoomPrice = tempRoomPrice;
            };
            bookEdit.saveAddRoom = function() {
                var tempPrice = $('#total_room_rate').val();
                if(tempPrice == '' || tempPrice == 0) {
                    $('#modal_info').modal('show');
                    $('#modal_info_message').html("抱歉，请计算房费！");
                    return;
                }
                var check_in = $('#room_check_in').val();var check_out = $('#room_check_out').val();
                var sell_layout_name = $.trim($('#sell_layout').find('option:selected').text());
                var price_system_name = $.trim($('#price_system').find('option:selected').text());
                var room_name = $.trim($('#select_room').find('option:selected').text());
                var extra_bed = $.trim($('#extra_bed').find('option:selected').text());
                var room_id = $('#select_room').val();
                var html = '<tr>';
                html += '<td>'+check_in+'</td><td>'+check_out+'</td><td>'+sell_layout_name+'</td>'
                       +'<td>'+price_system_name+'</td><td>'+room_name+'</td><td>'+extra_bed+'</td>'
                       +'<td><code class="fr"><%$arrayLaguage["new_add_room"]["page_laguage_value"]%></code></td>'
                       +'<td><a id="cancel_add_room'+room_id+'" class="btn btn-warning btn-mini fr">'
                       +'<i class="am-icon-minus-circle"></i><%$arrayLaguage["cancel"]["page_laguage_value"]%></a></td></tr>';
                $('#add_room_tr').before(html);
                $('#sell_layout').val('');$('#room_layout_data').hide('fast');$('#room_layout_data_price').hide('fast');
                $('#cancel_add_room'+room_id).click(function(e) {
                    $(this).parent().parent().remove();
                    BookEditClass.thenRoomPrice[room_id] = '';
                    BookEditClass.thenRoomPrice[room_id + '_data'] = '';
                    BookEditClass.room_info_id[room_id] = '';//移除使用房间
                });
                var tempRoomPrice = BookEditClass.tempRoomPrice;
                BookEditClass.thenRoomPrice[tempRoomPrice['room']['room_id']] = tempRoomPrice['room']['room_id'];
                BookEditClass.thenRoomPrice[tempRoomPrice['room']['room_id'] + '_data'] = tempRoomPrice;
                BookEditClass.thenRoomPrice[tempRoomPrice['room']['room_id'] + '_type'] = BookEditClass.tempRoomEdit['edit'];
                BookEditClass.tempRoomPrice = {};
                BookEditClass.tempRoomEdit['edit'] = '';
                BookEditClass.room_info_id[tempRoomPrice['room']['room_id']] = tempRoomPrice['room']['room_id'];//这个房号已经使用
            }
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
});//console.log($('#add_user_tr'));
$(function(){
    $('body #rate_calculation').each(function(){
        $(this).dragging({
            move : 'both',
            randomPosition : false
        });
    });
});
</script>