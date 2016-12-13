<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.peity.min.js"></script>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
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
                        <div class="left peity_bar_better"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>+70%</div>
                        <div class="right"> <strong>预定</strong> Book </div>
                      </li>
                      <li>
                        <div class="left peity_bar_good"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>+20%</div>
                        <div class="right"> <strong>入住</strong> Check in </div>
                      </li>
                      <li>
                        <div class="left peity_bar_neutral"><span><span style="display: none;">12,12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>0%</div>
                        <div class="right"> <strong>空房</strong> Vacant </div>
                      </li>
                      <li>
                        <div class="left peity_bar_bad"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>-50%</div>
                        <div class="right"> <strong>脏房</strong> Dirty </div>
                      </li>
                      <li>
                        <div class="left peity_bar_little"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>-50%</div>
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
                <div class="widget-content nopadding form-horizontal">
                <%foreach key=room_mansion item=arrayMansion from=$arrayRoom%>
                    <div class="control-group">
                        <div class="controls">
                            <%foreach key=room_floor item=room from=$arrayMansion%>
                            <ul class="stat-boxes stat-boxes2">
                                <%section name=i loop=$room%>
                                  <li>
                                    <div class="left peity_bar_better"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>+70%</div>
                                    <div class="right"> <strong>预定</strong> Book </div>
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
	maruti.peity();
    //日历
	$.datetimepicker.setLocale('ch');
	var dateToDisable =  new Date('<%$thisDay%>'); 
	$('#time_begin').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false, 
        yearStart: '1980', yearEnd: '<%$nextYear%>', //yearOffset:1,maxDate:'+1970-01-02',
		beforeShowDay: function(date) {
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
	$('#time_end').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false, yearEnd: '<%$nextYear%>',
		beforeShowDay: function(date) {//new Date($('#book_check_in').val()).getDate()
			var dateToDisable = new Date($('#time_begin').val());
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
    
    var thisModuleClass = {
        instance: function() {
            var thisModule = {};
            thisModule.thisYear = '<%$thisYear%>';
            thisModule.thisMonth = '<%$thisMonth%>';
            thisModule.time_begin = '<%$thisDay%>';
            thisModule.time_end = '<%$toDay%>';
            return thisModule;
        },

    }
    var thisModule = thisModuleClass.instance();
})
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