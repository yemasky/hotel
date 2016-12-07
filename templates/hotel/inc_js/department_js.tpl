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
                         var zTree = DepartmentClass.ZTreeObj['ztree'];
                         var treeNode = DepartmentClass.ZTreeObj['treeNode'];
                         var newCount = DepartmentClass.ZTreeObj['newCount'];
                         var isParent = ($('#department_position').val() - 0) == 1 ? false : true;
                         //var isParent = DepartmentClass.ZTreeObj['isParent'];
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
    
    var DepartmentClass = {
		setting: {},
        zNodes: [],
        className: 'dark',
        newCount: 1,
        ZTreeObj: {},
        instance: function() {
            var department = {};
            department.initParameter = function() {
                //var setting = DepartmentClass.setting;
                DepartmentClass.setting = {
                    view: {//addHoverDom: addHoverDom,//removeHoverDom: removeHoverDom,
                        selectedMulti: false
                    },
                    edit: {enable: true,showRemoveBtn: false,showRenameBtn: false
                    },
                    data: {keep: {
                            parent:true,
                            leaf:true
                        },
                        simpleData: {
                            enable: true
                        }
                    },
                    callback: {
                        beforeDrag: department.beforeDrag,
                        beforeRemove: department.beforeRemove,
                        beforeRename: department.beforeRename,
                        onRemove: department.onRemove
                    }
                };
                DepartmentClass.ZTreeObj['id'] = 'department_tree';
                //var zNodes = DepartmentClass.zNodes;
                DepartmentClass.zNodes['department_tree'] = [
                    { id:0, pId:0, name:"<%$arrayLoginEmployeeInfo.hotel_name%>", open:true, isParent:true},
                    <%section name=i loop=$arrayDepartment%>
                    {id:'<%$arrayDepartment[i].department_id%>',pId:'<%$arrayDepartment[i].department_father_id%>', name:"<%$arrayDepartment[i].department_name%>", open:true,isParent:true},
                    <%/section%>
                ];
                DepartmentClass.zNodes['position_tree'] = [];
            };
            department.init = function() {
                $.fn.zTree.init($("#department_tree"), DepartmentClass.setting, DepartmentClass.zNodes['department_tree']);
                $(".addParentTree").bind("click", {isParent:true}, department.add);
                $("#addLeaf").bind("click", {isParent:false}, department.add);
                $(".editTree").bind("click", department.edit);
                $(".removeTree").bind("click", department.remove);
                $("#clearChildren").bind("click", department.clearChildren);
                $('#hotel_department_manage').click(function(e) {
                    DepartmentClass.ZTreeObj['id'] = 'department_tree';
                    $('#department_position').val(0);
                });
                $('#position_manage').click(function(e) {
                    $('#department_position').val(1);
                    DepartmentClass.ZTreeObj['id'] = 'position_tree';
                    if(DepartmentClass.zNodes['position_tree'] != '') return;
                    $.getJSON('<%$view_url%>&act=getPosition', function(result){
                        data = result;
                        if(data.success == 1) {
                            var treeObj = $.fn.zTree.getZTreeObj("department_tree");
                            var nodes = treeObj.getNodes();
                            var nodesArray = treeObj.transformToArray(treeObj.getNodes());
                            var position = [];
                            var j = 0;
                            itemData = data.itemData;
                            for(i in itemData) {
                                position[j] = {};
                                position[j]['id'] = 'P' + itemData[i]['department_position_id'];
                                position[j]['pId'] = itemData[i]['department_id'];
                                position[j]['name'] = itemData[i]['department_position_name'];
                                position[j]['open'] = true;  
                                position[j]['isParent'] = false;
                                j++;
                                //open:true,isParent:true                                
                            }
                            for(i in nodesArray) {
                               position[j] = {};
                               position[j]['id'] = nodesArray[i]['id'];
                               position[j]['pId'] = nodesArray[i]['pId'];
                               position[j]['name'] = nodesArray[i]['name'];       
                               position[j]['open'] = true;  
                               position[j]['isParent'] = true;    
                               j++;                      
                            }
                            DepartmentClass.zNodes['position_tree'] = position;
                            //
                            $.fn.zTree.init($("#position_tree"), DepartmentClass.setting, position);
                        } else {
                            $('#modal_fail').modal('show');
                            $('#modal_fail_message').html(data.message);
                        }
                    });
                    
                });
                $('#department_role_setting').click(function(e) {
                    DepartmentClass.ZTreeObj['id'] = 'role_tree';
                });
            };
            
       		//var log, className = "dark";
            department.beforeDrag = function (treeId, treeNodes) {
                return false;
            };
		    department.beforeRemove = function (treeId, treeNode) {
                var className = DepartmentClass.className;
                className = (className === "dark" ? "":"dark");
                department.showLog("[ "+department.getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
                $('#modal_delete').modal('show');
				return;
                //return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
            };
            department.onRemove = function(e, treeId, treeNode) {
                department.showLog("[ "+department.getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
            };
            department.beforeRename = function(treeId, treeNode, newName) {
                if (newName.length == 0) {
                    alert("节点名称不能为空.");
                    var zTree = $.fn.zTree.getZTreeObj("department_tree");
                    setTimeout(function(){zTree.editName(treeNode)}, 10);
                    return false;
                }
                return true;
            };
            department.showLog = function (str) {
                var className = DepartmentClass.className;
                log = $("#log");
                log.append("<li class='"+className+"'>"+str+"</li>");
                if(log.children("li").length > 8) {
                    log.get(0).removeChild(log.children("li")[0]);
                }
            };
            department.getTime = function() {
                var now= new Date(),
                h=now.getHours(),
                m=now.getMinutes(),
                s=now.getSeconds(),
                ms=now.getMilliseconds();
                return (h+":"+m+":"+s+ " " +ms);
            };

            //var newCount = 1;
            department.add = function(e) {
                var newCount = DepartmentClass.newCount;
                var zTree = $.fn.zTree.getZTreeObj(DepartmentClass.ZTreeObj['id']);
                isParent = e.data.isParent;
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (treeNode) {
                    //treeNode = zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, isParent:isParent, name:"new node" + (newCount++)});
                } else {
                    $('#modal_info_message').html('请选择节点');
                    $('#modal_info').modal('show');
                    //alert('请选择节点');
                    return;
                    //treeNode = zTree.addNodes(null, {id:(100 + newCount), pId:0, isParent:isParent, name:"new node" + (newCount++)});
                }
                $('#edit_department').find('h3').text('添加/编辑部门');
                if(DepartmentClass.ZTreeObj['id'] == 'position_tree') {
                    $('#edit_department').find('h3').text('添加/编辑职位');
                    parentNode = treeNode.getParentNode();
                    if(parentNode == null || isNaN(treeNode.id)) {
                        $('#modal_info_message').html('无法在此节点添加职位！');
                        $('#modal_info').modal('show');
                        return;
                    }
                } 
                $('#department_parent_name').val(treeNode.name);
                $('#department_parent_id').val(treeNode.id);
                $('#department_self_name').val('');
                $('#department_self_id').val('');
                $('#edit_department').modal('show');
                DepartmentClass.ZTreeObj['ztree'] = zTree;
                DepartmentClass.ZTreeObj['treeNode'] = treeNode;
                DepartmentClass.ZTreeObj['newCount'] = newCount;
                DepartmentClass.ZTreeObj['isParent'] = isParent;
                if (treeNode) {
                    zTree.editName(treeNode[0]);
                } else {
                    alert("叶子节点被锁定，无法增加子节点");
                }
            };
            department.edit = function() {
                var zTree = $.fn.zTree.getZTreeObj(DepartmentClass.ZTreeObj['id']),
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (nodes.length == 0) {
                    //alert("请先选择一个节点");
                    $('#modal_info_message').html('请先选择一个节点');
                    $('#modal_info').modal('show');
                    return;
                }
				parentNode = treeNode.getParentNode();
				if(parentNode == null) {
                    $('#modal_info_message').html('无法编辑此节点！');
                    $('#modal_info').modal('show');
                    return;
                }
                if(DepartmentClass.ZTreeObj['id'] == 'position_tree' && !isNaN(treeNode.id)) {
                    $('#modal_info_message').html('无法编辑此节点！此节点不是职位');
                    $('#modal_info').modal('show');
                    return;
                }
				$('#department_parent_name').val(parentNode.name);
				$('#department_parent_id').val('');
				$('#department_self_id').val(treeNode.id);
				$('#department_self_name').val(treeNode.name);
				$('#edit_department').modal('show');
                DepartmentClass.ZTreeObj['ztree'] = zTree;
                DepartmentClass.ZTreeObj['treeNode'] = treeNode;
                DepartmentClass.ZTreeObj['newCount'] = '';
                DepartmentClass.ZTreeObj['isParent'] = '';
                //zTree.editName(treeNode);
            };
            department.remove = function(e) {
                var zTree = $.fn.zTree.getZTreeObj(DepartmentClass.ZTreeObj['id']),
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (nodes.length == 0) {
                    $('#modal_info_message').html('请先选择一个节点');
                    $('#modal_info').modal('show');
                    return;
                }
                $('#modal_delete').modal('show');
                var callbackFlag = $("#callbackTrigger").attr("checked");
                DepartmentClass.ZTreeObj['ztree'] = zTree;
                DepartmentClass.ZTreeObj['treeNode'] = treeNode;
                DepartmentClass.ZTreeObj['newCount'] = '';
                DepartmentClass.ZTreeObj['isParent'] = callbackFlag;
                //zTree.removeNode(treeNode, callbackFlag);
            };
            department.clearChildren = function(e) {
                var zTree = $.fn.zTree.getZTreeObj(DepartmentClass.ZTreeObj['id']),
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (nodes.length == 0 || !nodes[0].isParent) {
                    alert("请先选择一个父节点");
                    return;
                }
                zTree.removeChildNodes(treeNode);
            };
            department.updateDepartment = function() {
                
            }
            return department;		
        }
    }
    var department = DepartmentClass.instance();
    department.initParameter();
    department.init();
});//console.log($('#add_user_tr'));
//-->
</script>