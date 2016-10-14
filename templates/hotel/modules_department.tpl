<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<%include file="hotel/inc/ztree.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
    <style type="text/css">
        .ztree li ul.line{height:auto;}
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
               <!--<div class="widget-title"></div>-->
               <div class="content_wrap">
                   <div class="zTreeDemoBackground left">
                       <ul id="treeDemo" class="ztree"></ul>
                   </div>
                   <div class="right">
                       <ul class="info">
                           <li class="title">
                               <ul class="list">
                                   <li>自定义图标不需要对 setting 进行特殊配置</li>
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
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<SCRIPT type="text/javascript">
    <!--
    var setting = {
        edit: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeDrag: beforeDrag,
            beforeDrop: beforeDrop
        }
    };

    var zNodes =[
        { id:1, pId:0, name:"展开、折叠 自定义图标不同", open:true},
        { id:11, pId:1, name:"叶子节点1"},
        { id:12, pId:1, name:"叶子节点2"},
        { id:13, pId:1, name:"叶子节点3"},
        { id:2, pId:0, name:"展开、折叠 自定义图标相同", open:true},
        { id:21, pId:2, name:"叶子节点1"},
        { id:22, pId:2, name:"叶子节点2"},
        { id:23, pId:2, name:"叶子节点3"},
        { id:3, pId:0, name:"不使用自定义图标", open:true },
        { id:31, pId:3, name:"叶子节点1"},
        { id:32, pId:3, name:"叶子节点2"},
        { id:33, pId:3, name:"叶子节点3"}

    ];

    function beforeDrag(treeId, treeNodes) {
        for (var i=0,l=treeNodes.length; i<l; i++) {
            if (treeNodes[i].drag === false) {
                return false;
            }
        }
        return true;
    }
    function beforeDrop(treeId, treeNodes, targetNode, moveType) {
        return targetNode ? targetNode.drop !== false : true;
    }

    function setEdit() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                remove = $("#remove").attr("checked"),
                rename = $("#rename").attr("checked"),
                removeTitle = $.trim($("#removeTitle").get(0).value),
                renameTitle = $.trim($("#renameTitle").get(0).value);
        zTree.setting.edit.showRemoveBtn = remove;
        zTree.setting.edit.showRenameBtn = rename;
        zTree.setting.edit.removeTitle = removeTitle;
        zTree.setting.edit.renameTitle = renameTitle;
        showCode(['setting.edit.showRemoveBtn = ' + remove, 'setting.edit.showRenameBtn = ' + rename,
            'setting.edit.removeTitle = "' + removeTitle +'"', 'setting.edit.renameTitle = "' + renameTitle + '"']);
    }
    function showCode(str) {
        var code = $("#code");
        code.empty();
        for (var i=0, l=str.length; i<l; i++) {
            code.append("<li>"+str[i]+"</li>");
        }
    }

    $(document).ready(function(){
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        setEdit();
        $("#remove").bind("change", setEdit);
        $("#rename").bind("change", setEdit);
        $("#removeTitle").bind("propertychange", setEdit)
                .bind("input", setEdit);
        $("#renameTitle").bind("propertychange", setEdit)
                .bind("input", setEdit);
    });
    //-->
</SCRIPT>
</body>
</html>