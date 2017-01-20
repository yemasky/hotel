<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">

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
                    <span class="icon"><i class="am-icon-briefcase am-blue-2F93FF"></i></span>
                    <h5><%$selfNavigation.hotel_modules_name%></h5>
                </div>
                <div class="widget-content">
                   <div class="btn-group">
                   <button id="" class="btn btn-primary add"><i class="am-icon-plus-circle"></i> 添加价格种类</button>
                   <button id="" class="btn btn-warning edit"><i class="am-icon-edit"></i> 编辑价格种类</button> 
                   <button id="" class="btn btn-danger remove"><i class="am-icon-minus-circle"></i> 删除价格种类</button>
                   </div>
                   <div class="row-fluid">
                        <div class="span2 fl">
                            <ul id="role_tree" class="ztree">
                            <p>sss</p>
                            <p>sss</p><p>sss</p>
                            <p>sss</p>
                            <p>sss</p>
                            <p>sss</p>
                            <p>sss</p>
                            <p>sss</p>
                            <p>sss</p>
                            <p>sss</p>
                            <p>sss</p>
                            <p>sss</p>
                            </ul>
                        </div>
                        <div class="span10 fl">
                            <div class="widget-box">
                                <div class="widget-title">
                                    <span class="icon"><i class="icon-th-list"></i></span><h5>权限</h5>
                                </div>
                                <div class="widget-content nopadding form-horizontal">
                                    <div class="control-group">
                                        <label class="control-label">菜单</label>
                                        <div class="controls"></div>
                                    </div>
                                </div>
                                <div class="widget-content nopadding form-horizontal" id="role_power">
                                
                                </div>
                            </div>
                        </div>
                    </div>
                   
                </div>
            </div>   
        </div>
					
	  </div>
    
    </div>
</div>
<%include file="hotel/inc/footer.tpl"%>
</body>
</html>