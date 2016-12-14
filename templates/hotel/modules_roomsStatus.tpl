<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.peity.min.js"></script>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
<style type="text/css">
#room_status ul{text-align:left;}
#room_status .stat-boxes2{top:0px;}
</style>
</head>
<body>
<%include file="hotel/inc/top_menu.tpl"%>
<div id="content">
<%include file="hotel/inc/navigation.tpl"%>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div class="widget-box">
                <div class="widget-title">
                    <span class="icon">
                        <i class="am-icon-braille am-yellow-E88A26"></i>
                    </span>
                    <h5><%$selfNavigation['hotel_modules_name']%></h5>
                </div>
                <div class="widget-content">
                    <ul class="stat-boxes stat-boxes2">
                      <li>
                        <div class="left peity_bar_better"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>[info]</div>
                        <div class="right"> <strong>预定</strong> Book </div>
                      </li>
                      <li>
                        <div class="left peity_bar_good"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>[info]</div>
                        <div class="right"> <strong>入住</strong> Check in </div>
                      </li>
                      <li>
                        <div class="left peity_bar_neutral"><span><span style="display: none;">12,12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>[info]</div>
                        <div class="right"> <strong>空房</strong> Vacant </div>
                      </li>
                      <li>
                        <div class="left peity_bar_bad"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>[info]</div>
                        <div class="right"> <strong>脏房</strong> Dirty </div>
                      </li>
                      <li>
                        <div class="left peity_bar_little"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>[info]</div>
                        <div class="right"> <strong>维修</strong> Servicing </div>
                      </li>
                    </ul>
                </div>
                <div class="widget-title"><span class="icon"><i class="am-icon-clock-o"></i></span><h5></h5></div>
                <div class="widget-content nopadding">
                    <form action="<%$search_url%>" method="get" class="form-horizontal ui-formwizard" enctype="multipart/form-data">
                        <input type="hidden" value="<%$module%>" name="module">
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <div class="input-prepend input-append">
                                    <span class="add-on am-icon-calendar"></span>
                                    <input class="input-small" type="text" id="time_begin" name="time_begin" value="<%$thisDay%>" />
                                    <span class="add-on am-icon-calendar"></span>
                                    <input class="input-small" type="text" id="time_end" name="time_end" value="<%$toDay%>" />
                                    <button class="btn btn-primary"><i class="am-icon-search"></i> <%$arrayLaguage['search']['page_laguage_value']%></button >
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="widget-title"><span class="icon"><i class="am-icon-bullseye"></i></span><h5><%$selfNavigation['hotel_modules_name']%></h5></div>
                <div class="widget-content nopadding form-horizontal" id="room_status">
                    <div class="control-group">
                        <label class="control-label"><%$arrayLaguage['room_mansion']['page_laguage_value']%> </label>
                        <div class="controls"></div>
                    </div>
                    <%foreach key=room_mansion item=arrayMansion from=$arrayRoom%>
                    <div class="control-group">
                        <label class="control-label"><%$room_mansion%></label>
                        <div class="controls">
                            <%foreach key=room_floor item=room from=$arrayMansion%>
                            <!--<label class="control-label"><%$room_floor%> :</label>-->
                            <ul class="stat-boxes stat-boxes2">
                                <li>
                                    <div class="left peity_line_neutral">
                                    <%$arrayLaguage['room_floor']['page_laguage_value']%>
                                    </div>
                                    <div class="right"> <%$room_floor%> </div>
                                </li>
                                <%section name=i loop=$room%>
                                  <li room_id="<%$room[i].room_id%>" status="<%$room[i].room_status%>">
                                    <!--<div class="left peity_bar_better">
                                        <span>
                                            <span style="display: none;">12,12,12,12,12,12,12</span>
                                            <canvas width="50" height="24"></canvas>
                                        </span>[]
                                    </div>-->
                                    <div class="right"> <%$room[i].room_name%>[<%$room[i].room_number%>] </div>
                                  </li>
                                <%/section%>
                            </ul>
                            <%/foreach%>
                        </div>
                    </div>
                    <%/foreach%>
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
	// === Prepare peity charts === //
	
    //日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable =  new Date('<%$nowDay%>'); 
	$('#time_begin').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false, 
        yearStart: '1980', //yearEnd: '<%$nextYear%>', yearOffset:1,maxDate:'+1970-01-02',
		beforeShowDay: function(date) {
            if (date.getTime() < dateToDisable.getTime()) {
                //alert((date.getTime() + '----' + (dateToDisable.getTime() - 0 + 36000 * 24 * 6)));
				return [false];
			}
            return [true];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        },
        onSelectDate:function(date) {//console.log(date + '-====-' + nextWeekDateToDisable + '----'+ week_differ + '-----<%$thisDay%>');
            var thisDate = new Date(this.getValue());
            var time_end_date = new Date($('#time_end').val());
            if(time_end_date.getTime() < thisDate.getTime()) {
                $('#time_end').val(thisDate);
                $('#time_end').datetimepicker({value:thisDate});
            }
        },
	});
	$('#time_end').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false, //yearEnd: '<%$nextYear%>',
		beforeShowDay: function(date) {//new Date($('#book_check_in').val()).getDate()
			var dateToDisable = new Date($('#time_begin').val());
			if (date.getTime() < dateToDisable.getTime()) {
                //alert((date.getTime() + '----' + (dateToDisable.getTime() - 0 + 36000 * 24 * 6)));
				return [false];
			}
			return [true];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        },
	});
    
    var thisModuleClass = {
        instance: function() {
            var thisModule = {};
            thisModule.initParameter  = function() {
                thisModule.thisYear   = '<%$thisYear%>';
                thisModule.thisMonth  = '<%$thisMonth%>';
                thisModule.time_begin = '<%$thisDay%>';
                thisModule.time_end   = '<%$toDay%>';
                thisModule.roomStatus = $.parseJSON('<%$arrayRoomStatus%>');
            };
            thisModule.init = function() {
                thisModule.setRoomStatus();
                var roomStatus = thisModule.roomStatus;
                for(i in roomStatus) {
                    //console.log(roomStatus[i][0]);
                }
            };
            thisModule.computeCheckDate = function() {
                var inDate = new Date($('#time_begin').val());
                var outDate = new Date($('#time_end').val());
                //var outDateTime =new Date(outDate.getFullYear() + '-' + (outDate.getMonth() - 0 + 1) + '-' + outDate.getDate() + ' 00:00:00');
                //var itDateTime =new Date(inDate.getFullYear() + '-' + (inDate.getMonth() - 0 + 1) + '-' + inDate.getDate() + ' 00:00:00');
                var days = Math.floor((outDate.getTime() - inDate.getTime())/(24*3600*1000));
                return days + 1;
            };
            thisModule.computeRoomStatusDiv = function(className) {//peity_bar_better
                var html = '<div class="left '+className+'"><span><span style="display: none;">12,12,12,12,12,12,12</span>'
                           +'<canvas width="50" height="24"></canvas></span>[]</div>';
                return html;
            };
            thisModule.setRoomStatus = function() {
                var days = thisModule.computeCheckDate();
                
                var roomStatus = thisModule.roomStatus;
                $('#room_status li').each(function(index, element) {
                    var room_id = $(this).attr('room_id');
                    var status = $(this).attr('status');
                    var className = 'peity_bar_neutral';
                    if(typeof(room_id) != 'undefined') {// && typeof(roomStatus[room_id]) != 'undefined'
                        for(i = 0; i < days; i++) {
                            if(typeof(roomStatus[room_id]) != 'undefined') {
                                if(typeof(roomStatus[room_id][i]) != 'undefined' && roomStatus[room_id][i]['status'] == '0') className = 'peity_bar_better';
                                if(typeof(roomStatus[room_id][i]) != 'undefined' && roomStatus[room_id][i]['status'] == '1') className = 'peity_bar_good';
                            }
                            if(status == 1) className = 'peity_bar_bad';
                            if(status == 2) className = 'peity_bar_little';
                            $(this).find('div').last().before(thisModule.computeRoomStatusDiv(className));
                            className = 'peity_bar_neutral';
                        }
                    }
                });
                maruti.peity();
            };
            return thisModule;
        },

    }
    var thisModule = thisModuleClass.instance();
    thisModule.initParameter();
    thisModule.init();
})//console.log();
maruti = {
		// === Peity charts === //
		peity: function(){		
			$.fn.peity.defaults.line = {
				strokeWidth: 1,
				delimeter: ",",
				height: 24,
				max: null,
				min: 0,
				width: 50
			};
			$.fn.peity.defaults.bar = {
				delimeter: ",",
				height: 24,
				max: null,
				min: 0,
				width: 50
			};
			$(".peity_line_good span").peity("line", {
				colour: "#57a532",
				strokeColour: "#459D1C"
			});
            $(".peity_line_better span").peity("line", {
				colour: "#75F35C",
				strokeColour: "#75F35C"
			});
			$(".peity_line_bad span").peity("line", {
				colour: "#FFC4C7",
				strokeColour: "#BA1E20"
			});	
            $(".peity_line_little span").peity("line", {
				colour: "#ff9900",
				strokeColour: "#ff9900"
			});	
			$(".peity_line_neutral span").peity("line", {
				colour: "#CCCCCC",
				strokeColour: "#757575"
			});
			$(".peity_bar_good span").peity("bar", {
				colour: "#459D1C"
			});
            $(".peity_bar_better span").peity("bar", {
				colour: "#75F35C"
			});
			$(".peity_bar_bad span").peity("bar", {
				colour: "#BA1E20"
			});	
            $(".peity_bar_little span").peity("bar", {
				colour: "#ff9900"
			});
			$(".peity_bar_neutral span").peity("bar", {
				colour: "#4fb9f0"
			});
		},

		// === Tooltip for flot charts === //
		flot_tooltip: function(x, y, contents) {
			
			$('<div id="tooltip">' + contents + '</div>').css( {
				top: y + 5,
				left: x + 5
			}).appendTo("body").fadeIn(200);
		}
}
</script>
</body>
</html>