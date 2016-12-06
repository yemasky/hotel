<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<%include file="hotel/inc_js/ztree.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
<style type="text/css">
.ztree li ul.line{height:auto;}
.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
.ztree li ul.level0 {padding:0; background:none;}
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
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
             <span class="icon"><i class="icon-th"></i></span> 
            <h5><%$arrayLaguage['hotel_department_manage']['page_laguage_value']%></h5>
          </div>
          <div class="widget-title">
            <ul class="nav nav-tabs">
                <li class="active" id="hotel_department_manage"><a data-toggle="tab" href="#tab1"><%$arrayLaguage['hotel_department_manage']['page_laguage_value']%></a></li>
                <li id="department_role_setting"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['department_role_setting']['page_laguage_value']%></a></li>
                <li id="employee_manage"><a data-toggle="tab" href="#tab3"><%$arrayLaguage['employee_manage']['page_laguage_value']%></a></li>
            </ul>
        </div>
          <div class="widget-content tab-content">
           <div id="tab1" class="tab-pane active">
               <div class="btn-group pagination">
               <button id="addParent" class="btn btn-primary">添加部门</button>
               <button id="edit" class="btn btn-warning">编辑部门</button> 
               <button id="remove" class="btn btn-danger">删除部门</button>
               </div>
               <div class="content_wrap">
                <div class="zTreeDemoBackground left">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
                <div class="right">
                    <ul class="info">
                        <li class="title">
                            <ul class="list">
                            <li>利用 addNodes / editName / removeNode / removeChildNodes 方法也可以实现 增 / 删 / 改 节点的目的，这里简单演示使用方法</li>
                            <li>cancelEditName 方法仅仅是在节点进入名称编辑状态时有效，请在必要时使用，Demo 不进行此方法的演示</li>
                            <li class="highlight_red">利用 setting.data.keep.parent / leaf 属性 实现了父节点、叶子节点的状态锁定</li>
                            <li><p>对节点进行 增 / 删 / 改，试试看：<br/>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="callbackTrigger" checked /> removeNode 方法是否触发 callback<br/>
                                &nbsp;&nbsp;&nbsp;&nbsp;[ <a  href="#" title="增加父节点" onclick="return false;">增加父节点</a> ]
                                &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="addLeaf" href="#" title="增加叶子节点" onclick="return false;">增加叶子节点</a> ]
                                &nbsp;&nbsp;&nbsp;&nbsp;[ <a  href="#" title="编辑名称" onclick="return false;">编辑名称</a> ]<br/>
                                &nbsp;&nbsp;&nbsp;&nbsp;[ <a  href="#" title="删除节点" onclick="return false;">删除节点</a> ]
                                &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="clearChildren" href="#" title="清空子节点" onclick="return false;">清空子节点</a> ]<br/>
                                remove log:<br/>
                                <ul id="log" class="log"></ul></p>
                            </li>
                            <li class="highlight_red">使用 zTreeObj.addNodes / cancelEditName / editName / removeNode / removeChildNodes 方法，详细请参见 API 文档中的相关内容</li>
                            </ul>
                        </li>
                        
                    </ul>
                </div>
            </div>
           </div>
    	   <div id="tab2" class="tab-pane">
               <form action="#" method="get" class="form-horizontal">
                   <div class="control-group">
                       <label class="control-label">First Name :</label>
                       <div class="controls"><input type="text" class="span20" placeholder="First name" /></div>
                   </div>
               </form>
           </div>
           <div id="tab3" class="tab-pane">
               <form action="#" method="get" class="form-horizontal">
                   <div class="control-group">
                       <label class="control-label">First Name :</label>
                       <div class="controls"><input type="text" class="span20" placeholder="First name" /></div>
                   </div>
               </form>
           </div>
           
           </div>
          </div>
        </div>   
        </div>
					
	  </div>
    
    </div>
</div>
<div id="edit_department" class="modal hide in" aria-hidden="false">
<form action="" method="post" class="form-horizontal" enctype="multipart/form-data" name="add_attr_classes" id="add_attr_classes" novalidate>
  <div class="modal-header">
    <button data-dismiss="modal" class="close" type="button">×</button>
    <h3>添加部门</h3>
  </div>
  <div class="modal-body">
      <div class="widget-box">
        <div class="widget-content tab-content nopadding">
                <div class="control-group">
                    <label class="control-label">部门属于 :</label>
                    <div class="controls">
                        <input id="department_parent_name" name="" class="span2" readonly value="" type="text">
                        <input id="department_parent_id" name="" type="hidden" value="" >
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">部门名称 :</label>
                    <div class="controls">
                        <input id="" name="" class="span2" placeholder="" value="" type="text">
                    </div>
                </div>
         </div>
      </div>
  </div>
  <div class="modal-footer"> <button type="submit" id="save_info" class="btn btn-success pagination-centered">Save</button> <a data-dismiss="modal" class="btn" href="#">Cancel</a> </div>
</form>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<script type="text/javascript">
$(document).ready(function(){
    <!--
    var DepartmentClass = {
		setting: {},
        zNodes: [],
        className: 'dark',
        newCount: 1,
        ZTreeObj: $.fn.zTree.getZTreeObj("treeDemo"),
        instance: function() {
            var department = {};
            department.initParameter = function() {
                //var zNodes = DepartmentClass.zNodes;
                DepartmentClass.zNodes = [
                    { id:0, pId:0, name:"<%$arrayLoginEmployeeInfo.hotel_name%>", open:true},
                    <%section name=i loop=$arrayDepartment%>
                    {id:'<%$arrayDepartment[i].department_id%>',pId:'<%$arrayDepartment[i].department_father_id%>', name:"<%$arrayDepartment[i].department_name%>", open:true,isParent:true},
                    <%/section%>
                ];
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
            };
            department.init = function() {
                $.fn.zTree.init($("#treeDemo"), DepartmentClass.setting, DepartmentClass.zNodes);
                $("#addParent").bind("click", {isParent:true}, department.add);
                $("#addLeaf").bind("click", {isParent:false}, department.add);
                $("#edit").bind("click", department.edit);
                $("#remove").bind("click", department.remove);
                $("#clearChildren").bind("click", department.clearChildren);
            };
            
       		//var log, className = "dark";
            department.beforeDrag = function (treeId, treeNodes) {
                return false;
            };
		    department.beforeRemove = function (treeId, treeNode) {
                var className = DepartmentClass.className;
                className = (className === "dark" ? "":"dark");
                department.showLog("[ "+department.getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
                return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
            };
            department.onRemove = function(e, treeId, treeNode) {
                department.showLog("[ "+department.getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
            };
            department.beforeRename = function(treeId, treeNode, newName) {
                if (newName.length == 0) {
                    alert("节点名称不能为空.");
                    var zTree = $.fn.zTree.getZTreeObj("treeDemo");
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
                var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                isParent = e.data.isParent,
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (treeNode) {
                    $('#department_parent_name').val(treeNode.name);
                    $('#department_parent_id').val(treeNode.id);
                    $('#edit_department').modal('show');
                    //treeNode = zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, isParent:isParent, name:"new node" + (newCount++)});
                } else {
                    $('#modal_info_message').html('请选择节点');
                    $('#modal_info').modal('show');
                    //alert('请选择节点');
                    return;
                    //treeNode = zTree.addNodes(null, {id:(100 + newCount), pId:0, isParent:isParent, name:"new node" + (newCount++)});
                }
                if (treeNode) {
                    zTree.editName(treeNode[0]);
                } else {
                    alert("叶子节点被锁定，无法增加子节点");
                }
                console.log(nodes);
            };
            department.edit = function() {
                var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (nodes.length == 0) {
                    //alert("请先选择一个节点");
                    $('#modal_info_message').html('请先选择一个节点');
                    $('#modal_info').modal('show');
                    return;
                }
                zTree.editName(treeNode);
            };
            department.remove = function(e) {
                var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (nodes.length == 0) {
                    //alert("请先选择一个节点");
                    $('#modal_info_message').html('请先选择一个节点');
                    $('#modal_info').modal('show');
                    return;
                }
                var callbackFlag = $("#callbackTrigger").attr("checked");
                zTree.removeNode(treeNode, callbackFlag);
            };
            department.clearChildren = function(e) {
                var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                nodes = zTree.getSelectedNodes(),
                treeNode = nodes[0];
                if (nodes.length == 0 || !nodes[0].isParent) {
                    alert("请先选择一个父节点");
                    return;
                }
                zTree.removeChildNodes(treeNode);
            };
            return department;		
        }
    }
    var department = DepartmentClass.instance();
    department.initParameter();
    department.init();
});//console.log($('#add_user_tr'));
//-->
</script>
</body>
</html>