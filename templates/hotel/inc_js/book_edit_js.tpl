<script language="javascript">
$(document).ready(function(){
    //日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() - 1);
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
            if(new Date(this.getValue()) <= new Date($('#book_check_in').val())) {
                $('#modal_fail').modal('show');
                $('#modal_fail_message').html("抱歉，这个时间不正确！");
                return false;
            }
            //computeCheckDate(this.getValue());
        }
	});
    
    var BookEditClass = {
        hotel_service: {},book_discount_list: {},bookSelectRoom: {},bookNeed_service:{},lastDate:{},thenRoomPrice:{},
        hotelCheckDate: {},roomSellLayout: {},
	    max_man: 0,//最多人数
        BookUser_num: 1,
        priceSystem:{},
        instance: function() {
            var bookEdit = {};
            bookEdit.initParameter = function() {
                bookEdit.groupSellLayoutSystem();
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
                });
                $('#cancel_add_room').click(function(e) {
                    $('#add_room_tr').hide();
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
                });
                $('#serviceItem').change(function(e) {
                    $(this).parent().next().html('<input type="text" value="'+$(this).find("option:selected").attr('price')+'" class="input-small">');
                    $(this).parent().next().next().html('<input type="text" value="1" class="input-small">');
                    $(this).parent().next().next().next().html('<input type="text" value="100" class="input-small">');
                });
            };
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
            bookEdit.searchBookRoom = function() {
                var room_layout_id = $('#sell_layout').find("option:selected").attr('room_layout');
                var sell_id = $('#sell_layout').val();var system_id = $('#price_system').val();
                var check_in = $('#room_check_in').val(); var check_out = $('#room_check_out').val();
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
                $.ajax({
                    url : '<%$searchBookInfoUrl%>&search=searchRoomLayout&discount=' + $('#discount').val() + '&sell_layout_list=' + sell_id + '-1',
                    type : "post",
                    data : 'book_check_in=' + check_in + '&book_check_out=' + check_out + '&max_check_out=' + max_check_out,
                    dataType : "json",
                    success : function(result) {
                        $('#modal_loading').hide('show');
                        data = result;
                        if(data.success == 1) {
                           bookEdit.resolverRoomLayoutData(data, check_in, check_out)
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
                    bookEdit.formatRoomTable(data, system_id, sell_id)
                    $('#modal_loading').hide();
                    //计算价格
                })   
            };
            bookEdit.formatRoomTable = function(data, system_id, sell_id) {
                var selectRoomhtml = '';
                if(data.itemData != null && data.itemData != '') {
                   itemData = data.itemData;
                   var selectBedHtml = '';
                   var extra_bed_disable = 'disabled';
                   for(i in data.itemData) {
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
                        selectRoomhtml += '<option '+checked_room+' type="checkbox" value="'+itemData[i].room_id+'" system_id="'+system_id+'" sell_id="'+sell_id+'"'
                             +'room_layout="'+itemData[i].room_layout_id+'" max_people="'+itemData[i].max_people+'" max_children="'+itemData[i].max_children+'"'
                             +' title="'+itemData[i].room_number+'" />'
                             +itemData[i].room_name+'['+itemData[i].room_number+']'
                             +BookEditClass.orientations[itemData[i].room_orientations]
                             +' '+itemData[i].room_area+'㎡'
                             +itemData[i].max_people
                             +itemData[i].max_children
                             +'</option>';
                        //selectHtml = '';
                   }
                   selectRoomhtml = '<select>'+ selectRoomhtml+'</select>';	  
                }
                return selectRoomhtml;
            };
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
                var layoutPrice = data.layoutPrice;
                if(layoutPrice == '') {
                    $('#room_layout_data').html('<tr class="gradeX odd" role="row"><td class="sorting_1">无房</td><td></td></tr>');
                    return;
                }
                var room = data.room;
                var priceSystem = BookEditClass.priceSystem;//data.priceSystem;
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
                        td1 = '<a href="#room" class="select_room">' + roomSellLayout[sell_layout_id].room_sell_layout_name + '-' //+ i 
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
                            var day = day_i < 10 ? '0'+day_i : day_i;
                            //var month = layoutPrice[i].this_month < 10 ? '0' + layoutPrice[i].this_month : layoutPrice[i].this_month;
                            var this_day = layoutPrice[i].this_year+'-'+month+'-'+day;
                            var week_date = new Date(this_day);
                            var week = week_date.getDay();
                            
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
                    roomSellLayout[this.value] = {};
                    roomSellLayout[this.value]['room_layout_id'] = $(this).attr('room_layout');
                    roomSellLayout[this.value]['sell_id'] = this.value;
                    roomSellLayout[this.value]['room_sell_layout_name'] = $.trim($(this).text());
                })
                BookEditClass.roomSellLayout = roomSellLayout;
                return roomSellLayout;
            };
            return bookEdit;
        }
    }
    var bookEdit = BookEditClass.instance();
    bookEdit.initParameter();
    bookEdit.init();
});//console.log($('#add_user_tr'));
</script>