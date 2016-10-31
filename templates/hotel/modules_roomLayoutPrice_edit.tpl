<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
<style type="text/css">
.quick-actions li a {
    padding: 10px 5px 5px;
}
.pagination-left { text-align:left }
.stat-boxes, .quick-actions, .quick-actions-horizontal, .stats-plain { margin:0px;}
.stat-boxes li, .quick-actions li, .quick-actions-horizontal li{margin:0px 5px 5px 0;}
.quick-actions li{max-width:210px; min-width:210px; width:210px;}
.custom-date-style{ cursor:pointer; color:#666666 !important;}
</style>
</head>
<body>
<%include file="hotel/inc/top_menu.tpl"%>
<div id="content">
<%include file="hotel/inc/navigation.tpl"%>
	<div class="container-fluid">
      <div class="row-fluid">
        <div class="span12">
            <div class="widget-box widget-calendar">
							
                <div class="widget-title">
                    <span class="icon"><i class="am-icon-cubes am-yellow-F58A17"></i></span>
                    <h5><%$arrayLaguage['manager_room_layout_price_system']['page_laguage_value']%></h5>
                    <div class="buttons" id="btn_room_layout">
                        <a class="btn btn-primary btn-mini" href="<%$back_lis_url%>" id="back"><i class="am-icon-plus-square"></i> 
                        &#12288;<%$arrayLaguage['back_list']['page_laguage_value']%></a>
                    </div>
                </div>
                <div class="widget-title">
                    <ul class="nav nav-tabs">
                        <li class="active" id="rooms_layout_setting"><a data-toggle="tab" href="#tab1"><%$arrayLaguage['set_prices_on_a_monthly']['page_laguage_value']%></a></li>
                        <li id="room_layout_attr"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['set_prices_on_a_week']['page_laguage_value']%></a></li>
                    </ul>
                </div>
                <div class="widget-content tab-content nopadding">
                	<div id="tab1" class="tab-pane active">
                    	<form action="<%$add_room_layout_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_room_layout_form" id="add_room_layout_form" novalidate>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <select name="room_layout_date_year" id="room_layout_date_year" class="span1">
                                    <option value="<%$thisYear%>" ><%$thisYear%></option>
                                    <option value="<%$thisYear + 1%>" ><%$thisYear + 1%></option>
                                </select>
                                
                                <select name="room_layout_date_month" id="room_layout_date_month" class="span1">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                        <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <ul class="quick-actions pagination-left" id="room_layout_price_kalendar"></ul>
                            </div>
                        </div>
                        </form>
                    </div>
                    <div id="tab2" class="tab-pane active">
                    	<form action="<%$add_room_layout_url%>" method="post" class="form-horizontal" enctype="multipart/form-data" name="" id="" novalidate>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <input type="text" id="time_begin" value="<%$thisDay%>" />
                                <input type="text" id="time_end" value="<%$toDay%>" />
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <ul class="quick-actions pagination-left" id="room_layout_price_week">
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周一</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周二</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周三</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周四</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周五</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周六</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                    <li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> 周日</i>
                                        <input id="event-name" class="span8" type="text" /></a> 
                                    </li>
                                </ul>
                            </div>
                        </div>
                        </form>
                    </div>
                </div>
                <div class="widget-content">
                    
                </div>
            </div>   
        </div>
					
	  </div>
    
    </div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<script language="javascript">
$(document).ready(function(){
    $('#room_layout_date_month').val('<%$thisMonth%>');
    function leapYear(year){
        var isLeap = year%100==0 ? (year%400==0 ? 1 : 0) : (year%4==0 ? 1 : 0);
        return new Array(31,28+isLeap,31,30,31,30,31,31,30,31,30,31);
    }
    function setKalendar() {
        var year = $('#room_layout_date_year').val();
        var month = $('#room_layout_date_month').val();
        var arrayMonth = leapYear(year);
        var days = arrayMonth[month - 1];
        var kalendar_html = '';
        for(var i = 1; i <= days; i++ ) {
            var l = i;
            if(i < 10) l = '0' + i;
            kalendar_html += '<li> <a href="#"> <i class="am-icon-sm am-icon-calendar-minus-o "> '+l+'</i> '
                    +'<input id="event-name" class="span9" type="text" /></a> </li>';
        }
        $('#room_layout_price_kalendar').html(kalendar_html);
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
    setKalendar();
    $('#room_layout_date_month,#room_layout_date_year').change(function(e) {
        setKalendar();
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
	
})
</script>
</body>
</html>