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
.stat-boxes{text-align:left !important;}
.stat-boxes .right {padding: 2px 2px 2px 0;}
.stat-boxes .right strong {font-size: 14px;margin-bottom: 3px; margin-top: 6px;}
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
            <h5><%$selfNavigation.hotel_modules_name%></h5>
          </div>
          <div class="widget-title">
            <ul class="nav nav-tabs">
                <li class="active" id="hotel_department_manage"><a data-toggle="tab" href="#tab1">员工管理</a></li>
                <li id="position_manage"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['position_manage']['page_laguage_value']%></a></li>
                <li id="department_role_setting"><a data-toggle="tab" href="#tab3">权限管理</a></li>
            </ul>
        </div>
          <div class="widget-content tab-content">
           <div id="tab1" class="tab-pane active">
                <div class="btn-group pagination">
                   <button id="" class="btn btn-primary addTree"><i class="am-icon-plus-circle"></i> 添加员工</button>
                   <button id="" class="btn btn-warning editTree"><i class="am-icon-edit"></i> 编辑员工</button> 
                   <button id="" class="btn btn-danger removeTree"><i class="am-icon-minus-circle"></i> 删除员工</button>
                </div>
                <div class="widget-content nopadding form-horizontal">
                   <div class="content_wrap control-group">
                        <div class="control-label">
                            <ul id="zTree" class="ztree"></ul>
                        </div>
                        <div class="controls">
                            <ul id="employee" class="stat-boxes stat-boxes2">
                            <%section name=i loop=$arrayPageEmployee['list_data']%>
                              <li>
                                <div class="left peity_bar_good"><span><span style="display: none;">2,4,9,7,12,10,12</span><img alt="User" src="<%$__RESOURCE%>img/demo/av1.jpg" width="40" height="40"></span><%if $arrayPageEmployee['list_data'][i].employee_sex==1%>男<%else%>女<%/if%></div>
                                <div class="right"> <strong><%$arrayPageEmployee['list_data'][i].employee_name%></strong><%$arrayDepartment[$arrayPageEmployee['list_data'][i].department_id].department_name%>-<%$arrayPosition[$arrayPageEmployee['list_data'][i].department_position_id].department_position_name%>                                
                                </div>
                              </li>
                            <%/section%>
                            </ul>
                            <%include file="hotel/inc/page.tpl"%>
                        </div>
                   </div>
                </div>
           </div>
    	   <div id="tab2" class="tab-pane">
               <div class="btn-group pagination">
               <button id="" class="btn btn-primary addTree"><i class="am-icon-plus-circle"></i> 添加职位</button>
               <button id="" class="btn btn-warning editTree"><i class="am-icon-edit"></i> 编辑职位</button> 
               <button id="" class="btn btn-danger removeTree"><i class="am-icon-minus-circle"></i> 删除职位</button>
               </div>
               <div class="content_wrap">
                <div>
                    
                </div>
                <div class="right">
                    <ul id="log" class="log"></ul>
                </div>
                </div>
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
<%include file="hotel/inc_js/employee_js.tpl"%>
</body>
</html>