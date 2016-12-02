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
    
    var BookEditClass = {
        hotel_service: {},book_discount_list: {},bookSelectRoom: {},bookNeed_service:{},lastDate:{},thenRoomPrice:{},
        hotelCheckDate: {},
	    max_man: 0,//最多人数
        BookUser_num: 1,
        instance: function() {
            var bookEdit = {};
            bookEdit.initParameter = function() {
            };
            bookEdit.init = function() {
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

            };
            return bookEdit;
        }
    }
    var bookEdit = BookEditClass.instance();
    bookEdit.initParameter();
    bookEdit.init();
});//console.log($('#add_user_tr'));
</script>