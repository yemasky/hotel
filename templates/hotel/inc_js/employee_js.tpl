<script type="text/javascript">
$(document).ready(function(){
    <!--
    var department_edit_validate = $("#add_employee_form").validate({
		rules: {
			employee_name: {required: true},
            employee_sex: {required: true},
            employee_mobile: {required: true},
            upload_images_url: {required: true},
		},
		messages: {
			employee_name:"请填写姓名",
            employee_sex:"",
            employee_mobile:"",
            upload_images_url:"",
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
            var param = $("#add_employee_form").serialize();
            $('#modal_save').show('fast');
            $.ajax({
                url : url,type : "post",dataType : "json",data: param,
                success : function(result) {
                    data = result;
                    $('#modal_save').hide('fast');
                    if(data.success == 1) {
                        
                    } else {
                        $('#modal_fail').modal('show');
                        $('#modal_fail_message').html(data.message);
                    }
                }
            });
		}
	});
    //日历
	$.datetimepicker.setLocale('ch');
	$('#employee_birthday').datetimepicker({theme:'dark', format: 'Y-m-d', formatDate:'Y-m-d',timepicker:false, 
        yearStart: '1930', yearEnd: '<%$yearEnd%>', //yearOffset:1,maxDate:'+1970-01-02',
		beforeShowDay: function(date) {
            if (date.getFullYear() > '<%$yearEnd%>') {
				return [false];
			}
            return [true];
		},
        onGenerate:function( ct ){
            $(this).find('.xdsoft_other_month').removeClass('xdsoft_other_month').addClass('custom-date-style');
        },
       
	});
    var EmployeeClass = {
		setting: {},
        ZTreeObj: {},
        zNodes:{},
        instance: function() {
            var employee = {};
            employee.initParameter = function() {
                //var setting = EmployeeClass.setting;
                EmployeeClass.setting = {
                    data: {keep: {
                            parent:true,
                            leaf:true
                        },
                        simpleData: {
                            enable: true
                        }
                    },
                    callback: {beforeClick: employee.beforeClick,onClick: employee.onClick}
                };
                EmployeeClass.ZTreeObj['id'] = 'zTree';
                //var zNodes = EmployeeClass.zNodes;
                EmployeeClass.zNodes['zTree'] = [
                    { id:0, pId:0, name:"<%$arrayLoginEmployeeInfo.hotel_name%>", open:true, isParent:true},
                    <%foreach key=position_id item=position from=$arrayPosition%>
                    {id:'P<%$position_id%>',pId:'<%$position.department_id%>', name:"<%$position.department_position_name%>", isParent:false},
                    <%/foreach%>
                    <%foreach key=department_id item=department from=$arrayDepartment%>
                    {id:'<%$department_id%>',pId:'<%$department.department_father_id%>', name:"<%$department.department_name%>", open:true,isParent:true},
                    <%/foreach%>
                ];
            };
            employee.init = function() {
                $.fn.zTree.init($("#zTree"), EmployeeClass.setting, EmployeeClass.zNodes['zTree']);
                $(".addTree").bind("click", employee.addEmployee);
            };
            
            employee.addEmployee = function() {
                var zTree = $.fn.zTree.getZTreeObj(EmployeeClass.ZTreeObj['id']),
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (nodes.length == 0) {
                    //alert("请先选择一个节点");
                    $('#modal_info_message').html('请先选择要添加员工的职位！');
                    $('#modal_info').modal('show');
                    return;
                }
				parentNode = treeNode.getParentNode();
				if(parentNode == null) {
                    $('#modal_info_message').html('无法在此添加员工');
                    $('#modal_info').modal('show');
                    return;
                }
                if(!isNaN(treeNode.id)) {
                    $('#modal_info_message').html('无法在此添加员工！此节点不是职位');
                    $('#modal_info').modal('show');
                    return;
                }
                $('#employee_page').hide('fast');
                $('#employee_add').show('fast');
				
            };
            employee.beforeClick = function(treeId, treeNode, clickFlag) {
                return (treeNode.click != false);
            };
            onClick: employee.onClick = function(event, treeId, treeNode, clickFlag) {
                //alert(treeNode.id);
            };
            return employee;		
        }
    }
    var employee = EmployeeClass.instance();
    employee.initParameter();
    employee.init();
});//console.log($('#add_user_tr'));
//-->
</script>