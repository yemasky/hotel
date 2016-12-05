<script language="javascript">
$(document).ready(function(){
    //日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() - 1);
	$('#user_check_in').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
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
            //computeCheckDate($('#book_check_out').val());
            //bookEdit.computeBookPrice(false);
        }
	});
	$('#user_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
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
            //computeCheckDate(this.getValue());
        }
	});
    
    $('#room_check_in').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
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
            //computeCheckDate($('#book_check_out').val());
            //bookEdit.computeBookPrice(false);
        }
	});
	$('#room_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
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
            //computeCheckDate(this.getValue());
        }
	});
    
    var BookEditClass = {
        hotel_service: {},book_discount_list: {},bookSelectRoom: {},bookNeed_service:{},lastDate:{},thenRoomPrice:{},
        hotelCheckDate: {},
	    max_man: 0,//最多人数
        BookUser_num: 1,
        priceSystem:{},
        instance: function() {
            var bookEdit = {};
            bookEdit.initParameter = function() {
                bookEdit.groupSellLayoutSystem();
            }
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
                });
                $('#serviceItem').change(function(e) {
                    $(this).parent().next().html('<input type="text" value="'+$(this).find("option:selected").attr('price')+'" class="input-small">');
                    $(this).parent().next().next().html('<input type="text" value="1" class="input-small">');
                    $(this).parent().next().next().next().html('<input type="text" value="100" class="input-small">');
                });
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
            }
            return bookEdit;
        }
    }
    var bookEdit = BookEditClass.instance();
    bookEdit.initParameter();
    bookEdit.init();
});//console.log($('#add_user_tr'));
</script>