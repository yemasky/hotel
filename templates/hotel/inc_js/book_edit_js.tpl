<script language="javascript">
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
			book_check_int:{required:true},
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
	$('#search_room_layout').click(function(e) {
		$('#contact_form').submit();
		if(contact_validate.form()) {
			ajaxGetRoomLayout();
		}
	});
	//搜索房型
	table = $('#room_layout').DataTable({
		paging: false
	});
	function ajaxGetRoomLayout() {
		$.ajax({
			url : '<%$searchBookInfoUrl%>&search=searchRoomLayout&discount=' + $('#discount').val(),
			type : "post",
			data : 'book_check_int=' + $('#book_check_int').val()
			+ '&book_check_out=' + $('#book_check_out').val(),
			dataType : "json",
			success : function(result) {
				$('#book_form div').show();
				data = result;
				if(data.success == 1) {
					$('#room_layout_table').show();
					table.destroy();
					$('#room_layout_data').html(resolverRoomLayoutData(data.itemData));
					table = $('#room_layout').DataTable({
						"pagingType":   "numbers"
					})
					$('#room_layout_length').hide();
				} else {
					$('#modal_fail').modal('show');
					$('#modal_fail_message').html(data.message);
				}
			}
		});
	}
	function resolverRoomLayoutData(data) {
		var html = '';
		var td1 = td2 = td3 = option = '';
		for(i in data) {
			td1 = '<a href="#room" class="select_room">' + data[i].room_layout_name;
			td1 = td1 +' <i class="am-icon-search am-blue-16A2EF"></i></a>';
			td2 = '<input type="text" class="span2 book_price layout_price" id="book_price_' + data[i].room_layout_id + '"'
				 +' name="layout_price['+ data[i].room_layout_id + ']"'
				 +' value="'+ data[i].room_layout_price + '" '
				 +' room_layout="' + data[i].room_layout_id + '" />'
				 +'';
			td2 = td2+'<span class="hide">' + data[i].room_layout_price + '</span>';
			td3 = '<input type="text" class="span2 book_price extra_bed_price" id="book_extra_bed_price_'+ data[i].room_layout_id + '"'
				 +' name="extra_bed_price['+ data[i].room_layout_id + ']"'
				 +' value="' + data[i].room_layout_extra_bed_price + '" '
				 +'  room_layout="' + data[i].room_layout_id + '" />'
			     +'';
            td3 = td3 + '<span class="hide">' 
				 + data[i].room_layout_extra_bed_price + '</span>';
			html += '<tr room_layout_id="'+data[i].room_layout_id+'" extra_bed="'+data[i].room_layout_extra_bed+'">'+
						'<td class="details-control">'+td1+'</td>'+
						'<td>'+td2+'</td>'+
						'<td>'+td3+'</td>'+
					'</tr>';
			td1 = td2 = td3 = option = '';
		}
		return html;
	}
	//book_user_room
	var bookSelectRoom = {};
	//table点击
	$('#room_layout tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = table.row( tr );
        var _this = this;
        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
        } else {
            // Open this row 	row.data()
			$.getJSON('<%$searchBookInfoUrl%>&search=searchRoom&room_layout_id='+$(this).parent().attr('room_layout_id'), function(result){
				row.child(format(result)).show();
				row.child().children().addClass('nopadding');
				row.child().children().attr('id', 'noBodyLeft');
				//row.child().children().attr('id', 'noBodyLeft');
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
								//$('#room_name_data').removeData(room_id);
								//$(this).closest('.checker > span').removeClass('checked');
							}
							if (this.checked && typeof(room_layout_id) != 'undefined') {
								var room_lauout_input = '<input type="hidden" id="room_'+room_layout_id+'_'+room_id+'" '
													   +'name="room_layout_id['+room_layout_id+'][]" value="'+room_id+'" '
													   +'layout="room" room_layout="'+room_layout_id+'" />';
								$('#room_layout_html').append(room_lauout_input);
								$('#room_data').data(room_id, room_layout_id);
								bookSelectRoom[room_id] = room_name;
								//$(this).closest('.checker > span').addClass('checked');
							}
                            //设置disable
                            resetRoomStatus(room_id, room_layout_id, this.checked);
						}
					});
					//计算价格
					setBookPrice();
				});	
				
				$(_this).parent().next().find('td input:checkbox').click(function(e) {
					var room_id = $(this).val();
					var room_layout_id = $(this).attr('room_layout');
					var room_name = $(this).attr('title');
					if(room_id == 'on') return;
					if (this.checked) {
					    //选中状态
						var room_lauout_input = '<input type="hidden" id="room_'+room_layout_id+'_'+room_id+'" '
											   +'name="room_layout_id['+room_layout_id+'][]" value="'+room_id+'" '
											   +'layout="room" room_layout="'+room_layout_id+'" />';
						$('#room_layout_html').append(room_lauout_input);
						$('#room_data').data(room_id, room_layout_id);
						bookSelectRoom[room_id] = room_name;
                        //设置disable
                        resetRoomStatus(room_id, room_layout_id, this.checked);
					} else {
						$('#room_'+room_layout_id+'_'+room_id).remove();
						$("#room_data").removeData(room_id);  //移除
						//$('#room_name_data').removeData(room_id);
                        //设置disable
                        resetRoomStatus(room_id, room_layout_id, this.checked);
					}
					//计算价格
					setBookPrice();
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
					setBookPrice();
                });
				$('.book_price').keyup(function(e) {
					setBookPrice();
				});
				//计算价格
			})
        }
    } );
	
	function format (data) {
		var html = '';
		if(data.success == 1) {
		   if(data.itemData != null && data.itemData != '') {
			   itemData = data.itemData;
			   var selectHtml = '';
			   for(i in data.itemData) {
				    var addBedSelect = '';
					selectHtml = '<select class="span2 room_extra_bed" room_layout="'+itemData[i].room_layout_id+'" room="'+itemData[i].room_id+'">';
					for(j = 0; j <= itemData[i].room_layout_room_extra_bed; j++) {
						if($('#addBed_data').data(itemData[i].room_layout_id+'_'+itemData[i].room_id) == j) {
							addBedSelect = 'selected';
						}
						selectHtml += '<option value="'+j+'" '+addBedSelect+'>'+j+'</option>';
						addBedSelect = '';
					}
					selectHtml += '</select>';
					//设置是否是已使用的checked
					var checked_room = '';
					if(typeof($('#room_data').data(itemData[i].room_id)) != 'undefined') {//undefined
						if($('#room_data').data(itemData[i].room_id) == itemData[i].room_layout_id) {
							checked_room = 'checked';
						} else {
							checked_room = 'disabled';
						}
					}
					html += '<tr>'
						 +'<td>'
						 +'<input '+checked_room+' type="checkbox" value="'+itemData[i].room_id+'" room_layout="'+itemData[i].room_layout_id+'"'
						 +' title="'+itemData[i].room_number+'" />'
						 +'</td>'
						 +'<td>'+itemData[i].room_number+'</td>'
						 +'<td>'+itemData[i].room_mansion+'</td>'
						 +'<td>'+itemData[i].room_floor+'</td>'
						 +'<td>'+selectHtml+'</td>'
						 +'</tr>';
					selectHtml = '';
			   }
			   html = '<table class="table table-bordered table-striped with-check">'
					  +'<thead>'
					  +'<tr>'
					  +'<th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox" /></th>'
					  +'<th><%$arrayLaguage["room_number"]["page_laguage_value"]%></th>'
					  +'<th><%$arrayLaguage["room_mansion"]["page_laguage_value"]%></th>'
					  +'<th><%$arrayLaguage["room_floor"]["page_laguage_value"]%></th>'
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
	}
	
	function resetRoomStatus(room_id, room_layout_id, status) {
		var checkbox = $('#room_layout_data td input:checkbox');
		checkbox.each(function() {
            if($(this).val() == room_id) {
				if($(this).attr('room_layout') != room_layout_id)  {
					if(!status) this.disabled = false;
                    if(status) this.disabled = true;
				}
			}
		})
	}
	
	//计算价格
	var max_man = 0;//最多人数
	function setBookPrice() {
		max_man = 0;
		var room_price = 0;
		var select_html = ' <select class="span1 bookSelectRoom" name="book_user_room[]">';
		var option = '';
		$("#room_layout_html input").each(function (i) {
			var val = $(this).val() - 0; //获取单个value
			if(val > 0) {
				var layout = $(this).attr('layout');//room or bed
				var room_layout = $(this).attr('room_layout');//room_layout id
				if(layout == 'room') {
					$('.layout_price').each(function(index, element) {//房型价格
						if($(this).attr('room_layout') == room_layout) {//相同room_layout
							room_price = $(this).val() - 0 + room_price;
							//console.log(bookSelectRoom[val]);
							option += '<option value="'+val+'">'+bookSelectRoom[val]+'</option>';
							max_man++;
						}
					});
				}
				if(layout == 'bed') {
					var room_id = $(this).attr('room');
					var room_layout_id = $('#room_data').data(room_id);
					$('.extra_bed_price').each(function(index, element) {//房型价格
						//console.log(this);
						if($(this).attr('room_layout') == room_layout && $(this).attr('room_layout') == room_layout_id) {//相同room_layout
							room_price = ($(this).val() - 0) * val + room_price;
							for(i = 1; i <= val; i++) {
								option += '<option value="'+room_id+'">'+bookSelectRoom[room_id]+'</option>';	
								max_man++;
							}
						}
					});
				}
			}
		});
		select_html += option + '</select>';
		var check_out = $('#book_check_out').val();
		var check_in = $('#book_check_int').val();

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
		console.log(days);
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

	//联系信息事件
	$('#contact_mobile,#contact_name,#contact_email,#begin_book').bind("keyup click", function(e) {
        if($('#contact_mobile').val().length == 11) {
			$.ajax({url : "<%$searchBookInfoUrl%>&search=searchUserMemberLevel",type : "post",
			   dataType : "json",
			   data: "book_contact_mobile=" + $('#contact_mobile').val() + "&book_contact_email=" + $('#contact_email').val(),
			   success : function(result) {
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
					   setBookPrice();
				   } else {
					   $('#modal_fail').modal('show');
					   $('#modal_fail_message').html(data.message);
				   }
			   }
			 });
		}
    });
	//协议公司
	var book_discount_list = {};
	$('#book_type_id').change(function(e) {
		$('#book_discount_id,.book_discount_id').remove();
		var book_type_id = $(this).val();
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
			})
		} else {
			$('#book_type_id').after(book_discount_list[book_type_id]);
			$('.select_discount').change(function(e) {
				$('#discount').val(book_discount_list[$(this).val() + '_0']);
			})
			$('#discount').val(book_discount_list[book_type_id + '_']);
		}
		//计算价格
		setBookPrice();
		//console.log(book_discount_list);
    });
	
	//增加减少人数
	var BookUser_num = 1;
	$('#addBookUser').click(function(e) {
		if(BookUser_num >= max_man) return;
        $(this).parent().prev().clone().insertBefore($(this).parent());
		BookUser_num++;
    });
	$('#reduceBookUser').click(function(e) {
		if(BookUser_num == 1) return;
        $(this).parent().prev().remove();
		BookUser_num--;
    });
	//日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() - 1);
	$('#book_check_int').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
		beforeShowDay: function(date) {
			if (date.getTime() < dateToDisable.getTime()) {
				return [false, ""];
			}
			return [true, ""];
		}
	});
	$('#book_check_out').datetimepicker({theme:'dark', format: 'Y-m-d H:i:s', formatDate:'Y-m-d H:i:s',
		beforeShowDay: function(date) {//new Date($('#book_check_int').val()).getDate()
			var dateToDisable = new Date($('#book_check_int').val());
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
    var BookEditClass = {
        hotel_service: {},
        instance: function() {
            var bookEdit = {};
            bookEdit.initParameter = function() {
            },
            bookEdit.init = function() {
                $('.edit_checkbox').click(function(e) {
                    hotel_server_id = $(this).attr('data-id');
                    var hotel_service = BookEditClass.hotel_service;
                    if(typeof(hotel_service[hotel_server_id]) == 'undefined' || hotel_service[hotel_server_id] == '') {
                        $(this).find('.edit_btn').addClass('am-icon-check-square-o');
                        $(this).find('.edit_btn').removeClass('am-icon-square-o');
                        BookEditClass.hotel_service[hotel_server_id] = 1;
                    } else {
                        $(this).find('.edit_btn').removeClass('am-icon-check-square-o');
                        $(this).find('.edit_btn').addClass('am-icon-square-o');
                        BookEditClass.hotel_service[hotel_server_id] = '';
                    }
                });
                
            };
            return bookEdit;
        },
    }
    var bookEdit = BookEditClass.instance();
    bookEdit.initParameter();
    bookEdit.init();
});
</script>