<script type="text/javascript">
$(document).ready(function(){
    <!--
    var department_edit_validate = $("#edit_department_form").validate({
		rules: {
			department_self_name: {required: true},
            //contact_email: {email: true},
		},
		messages: {
			department_self_name:"请填写部门名称",
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
            var add_url = '<%$add_url%>'; var edit_url = '<%$edit_url%>'
            var url = ($('#department_parent_id').val() - 0) > 0 ? add_url : edit_url;
            var param = $("#edit_department_form").serialize();
            $('#edit_department').modal('hide');
            $('#modal_save').show('fast');
            $.ajax({
                url : url,type : "post",dataType : "json",data: param,
                success : function(result) {
                    data = result;
                    $('#modal_save').hide('fast');
                    if(data.success == 1) {
                        room_layout_id = data.itemData.room_layout_id;
                         $('#modal_success').modal('show');
                         $('#modal_success_message').html(data.message);
                         var zTree = EmployeeClass.ZTreeObj['ztree'];
                         var treeNode = EmployeeClass.ZTreeObj['treeNode'];
                         var newCount = EmployeeClass.ZTreeObj['newCount'];
                         var isParent = ($('#department_position').val() - 0) == 1 ? false : true;
                         //var isParent = EmployeeClass.ZTreeObj['isParent'];
                         if(newCount == '') {
                             treeNode.name = $('#department_self_name').val();
                             zTree.editName(treeNode);
                         } else {
                            zTree.addNodes(treeNode, {id:data.itemData.id, pId:treeNode.id, isParent:isParent, name:$('#department_self_name').val()});
                         }
                    } else {
                        $('#modal_fail').modal('show');
                        $('#modal_fail_message').html(data.message);
                    }
                }
            });
		}
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