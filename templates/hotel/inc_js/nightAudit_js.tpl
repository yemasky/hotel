<script language="javascript">
$(document).ready(function(){
	// === Prepare peity charts === //
	
    //日历
	$.datetimepicker.setLocale('ch');
	$('#time_begin').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false, 
        yearStart: '1980', yearEnd: '<%$nextYear%>', //yearOffset:1,maxDate:'+1970-01-02',
		beforeShowDay: function(date) {
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
            };
            thisModule.init = function() {
                $('#begin_night_audit').click(function(e) {
                    window.location.href="<%$search_url%>?module=<%$module%>&act=night_audit"; 
                });
            };
            thisModule.checkErrorNightAudit = function() {
                $('.error_night_audit').each(function(index, element) {
                    
                });
            };
            return thisModule;
        },

    }
    var thisModule = thisModuleClass.instance();
    thisModule.initParameter();
    thisModule.init();
})//console.log();
</script>