<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
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
                        <i class="icon-th-list"></i>
                    </span>
                    <h5><%$arrayLaguage['book_info']['page_laguage_value']%> <%$today%></h5>
                    <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                    <div class="buttons">
                        <a class="btn btn-primary btn-mini" href="<%$add_book_url%>"><i class="am-icon-plus-square"></i>
                        &#12288;<%$arrayLaguage['add_book']['page_laguage_value']%></a>
                    </div>
                    <%/if%>
                </div>
                <div class="widget-content nopadding">
                    <div class="btn-group">
                        <a class="btn btn-primary" href="#"><i class="icon-user icon-white"></i> User</a>
                        <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#"><i class="icon-pencil"></i> Edit</a></li>
                            <li><a href="#"><i class="icon-trash"></i> Delete</a></li>
                            <li><a href="#"><i class="icon-ban-circle"></i> Ban</a></li>
                            <li class="divider"></li>
                            <li><a href="#"><i class="i"></i> Make admin</a></li>
                        </ul>
                    </div>
                    <form class="form-search">
                        <div class="input-append">
                            <input type="text" class="span2 search-query">
                            <button type="submit" class="btn">Search</button>
                        </div>
                        <div class="input-prepend">
                            <button type="submit" class="btn">Search</button>
                            <input type="text" class="span2 search-query">
                        </div>
                    </form>
                    <ul class="activity-list">
                    	<li>
                        	<a href="#collapseOne" data-toggle="collapse">
                            <i class="icon-user"></i>
                            <strong>Themeforest</strong>Approved My college theme <strong>1 user</strong> <span>2 hours ago</span>
                        	</a>
                            <div class="collapse" id="collapseOne">
                                    <div class="new-update clearfix"><i class="icon-ok-sign"></i>
                                      <div class="update-done"><a href="#" title=""><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</strong></a> <span>dolor sit amet, consectetur adipiscing eli</span> </div>
                                      <div class="update-date"><span class="update-day">20</span>jan</div>
                                    </div>
                            </div>
                        </li>
                        <li>
                        	<a href="#collapse2" data-toggle="collapse">
                            <i class="icon-user"></i>
                            <strong>Themeforest</strong>Approved My college theme <strong>1 user</strong> <span>2 hours ago</span>
                        	</a>
                            <div class="collapse" id="collapse2">
                            	<div class="widget-content">
                                This box is opened by default
                                </div>
                            </div>
                        </li>
                     </ul>
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
</body>
</html>