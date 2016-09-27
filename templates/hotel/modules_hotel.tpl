<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<link rel="stylesheet" href="<%$__RESOURCE%>css/colorpicker.css" />
<link rel="stylesheet" href="<%$__RESOURCE%>css/datepicker.css" />
<link rel="stylesheet" href="<%$__RESOURCE%>css/uniform.css" />
<link rel="stylesheet" href="<%$__RESOURCE%>css/select2.css" />
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
                    <h5><%$arrayLaguage['list_of_hotel']['page_laguage_value']%></h5>
                    <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                    <div class="buttons">
                        <a class="btn btn-primary btn-mini" href="#" id="add_company"><i class="am-icon-plus-square"></i> <%$arrayLaguage['hotel_add']['page_laguage_value']%></a>
                    </div>
                    <%/if%>
                </div>
                <div class="widget-content nopadding">
                    <ul class="recent-posts">
                      <%section name=hotel loop=$arrayHotel%>
                      <li>
                        <div class="user-thumb"> <img width="50" height="50" alt="User" src="<%$__RESOURCE%>img/icons/50/hotel.jpg"> </div>
                        <div class="article-post">
                          <div class="fr">
                            <%if $arrayRoleModulesEmployee['role_modules_action_permissions'] > 1%>
                          	<a href="<%$arrayHotel[hotel].edit_url%>" class="btn btn-primary btn-mini"><i class="am-icon-edit"></i> Edit</a> 
                            <%/if%>
                            <%if $arrayRoleModulesEmployee['role_modules_action_permissions'] > 2%>
                            <a href="#delete" class="btn btn-danger btn-mini" data-toggle="modal" url="<%$arrayHotel[hotel].delete_url%>"><i class="am-icon-trash-o"></i> Delete</a>
                            <%/if%>
                          </div>
                          <h5><%$arrayHotel[hotel].hotel_name%></h5>
                          <p>
                          	<span class="icon-time" title="添加时间"></span> <%$arrayHotel[hotel].hotel_add_date%> 　
                          	<%if $arrayHotel[hotel].hotel_phone!=''%><span class="am-icon-phone"></span> <%$arrayHotel[hotel].hotel_phone%><%/if%> 　
                          	<%if $arrayHotel[hotel].hotel_mobile!=''%><span class="am-icon-mobile"></span> <%$arrayHotel[hotel].hotel_mobile%><%/if%> 　
                          </p>
                          
                        </div>
                      </li>
                      <%/section%>
                      
                      <li></li>
                    </ul> 
  					<div class="pagination  pagination-centered">
                      <ul>
                      <%section name=pn loop=$page%>
                      	<%if $smarty.section.pn.first%>
                      		<li<%if $page[pn].pn==''%> class="active"<%/if%>><a href="<%$page[pn].url%>">Prev</a></li>
                        <%elseif $smarty.section.pn.last%>
                            <li<%if $page[pn].pn==''%> class="active"<%/if%>><a href="<%$page[pn].url%>">Next</a></li>
                         <%else%>
                         	<li<%if $page[pn].pn==$pn%> class="active"<%/if%>><a href="<%$page[pn].url%>"><%$page[pn].pn%></a></li>
                        <%/if%>
                      <%/section%>
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
<div id="delete" class="modal hide">
  <div class="modal-header">
    <button data-dismiss="modal" class="close" type="button">×</button>
    <h3>Alert modal</h3>
  </div>
  <div class="modal-body">
    <p>Lorem ipsum dolor sit amet...</p>
  </div>
  <div class="modal-footer"> <a data-dismiss="modal" class="btn btn-primary" href="#">Confirm</a> <a data-dismiss="modal" class="btn" href="#">Cancel</a> </div>
</div>
<script src="<%$__RESOURCE%>js/jquery.min.js"></script>
<script src="<%$__RESOURCE%>js/jquery.ui.custom.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap.min.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap-colorpicker.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap-datepicker.js"></script>
<script src="<%$__RESOURCE%>js/jquery.uniform.js"></script>
<script src="<%$__RESOURCE%>js/select2.min.js"></script>
<script src="<%$__RESOURCE%>js/maruti.js"></script>
<script src="<%$__RESOURCE%>js/maruti.form_common.js"></script>
</body>
</html>