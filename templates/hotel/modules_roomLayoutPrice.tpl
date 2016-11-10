<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">
.new-update i{margin-top:0px;}
.roomLayoutPrice td{width:37px;}
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
              <div class="widget-title"> <span class="icon"> <i class="icon-refresh"></i> </span>
                <h5><%$arrayLaguage['manager_room_layout_price']['page_laguage_value']%></h5>
                <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                <div class="buttons" id="btn_room_layout">
                    <a class="btn btn-primary btn-mini" href="<%$add_roomLayoutPriceSystem_url%>" id="add_room_layout"><i class="am-icon-plus-square"></i> 
                    &#12288;<%$arrayLaguage['manager_room_layout_price']['page_laguage_value']%></a>
                </div>
                <%/if%>
              </div>
              <div class="widget-content">
                    
              </div>
              <div class="widget-content nopadding updates">
                <!--<div class="new-update clearfix"><i class="am-icon-caret-right"></i>
                  <div class="update-done"><a href="#" title=""><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</strong></a> <span>dolor sit amet, consectetur adipiscing eli</span> </div>
                  <div class="update-done">ssss</div>
                  <div class="update-date"><span class="update-day">20</span>jan</div>
                </div>-->
                
                <%section name=layout loop=$arrayRoomLayoutPriceList%>
                <div class="new-update clearfix"> 
                    <i class="am-icon-bed am-icon-sm"></i> 
                    <span class="update-notice"> 
                        <a href="#" title=""><strong><%$arrayRoomLayoutPriceList[layout].room_layout_name%> </strong></a> 
                        <span>
                        <div class="span12 btn-icon-pg">
                            <ul>
                                <%section name=system loop=$arrayRoomLayoutPriceList[layout].price_system%>
                                <li><i class="am-icon-glass am-blue-2F93FF"></i><%$arrayRoomLayoutPriceList[layout].price_system[system].room_layout_price_system_name%> 
                                </li>
                                <li><i class="am-icon-rmb am-red-EA5555"></i><%$year%>-<%$month%>&#12288;
                                <%if $arrayRoomLayoutPriceList[layout].price_system[system].price != ''%>
                                售卖价格
                                <table class="roomLayoutPrice">
                                <tr>
                                    <%section name=price loop=$monthT%>
                                        <td>
                                        <%$smarty.section.price.iteration%>
                                        </td>
                                    <%/section%>
                                </tr>
                                <tr>
                                    <%section name=price loop=$monthT%>
                                        <td>
                                        <%if $smarty.section.price.iteration<10%>
                                        <%$day=0|cat:$smarty.section.price.iteration|cat:'_day'%>
                                        <%else%>
                                        <%$day=$smarty.section.price.iteration|cat:'_day'%>
                                        <%/if%>
                                        <%$arrayRoomLayoutPriceList[layout].price_system[system].price.$day%>
                                        </td>
                                    <%/section%>
                                </tr>
                                </table>
                                <%else%>
                                没有设置房价
                                <%/if%>
                                </li>
                                <br>
                                <%/section%>
                            </ul>
                        </div>
                        </span> 
                    </span> 
                    <span class="update-date">
                        <span class="update-day"><%$month%></span><%$year%>
                    </span> 
                </div>
                <%/section%>
                
                <!--<div class="new-update clearfix"> <i class="am-icon-caret-right"></i> <span class="update-alert"> <a href="#" title=""><strong>Maruti is a Responsive Admin theme</strong></a> <span>But already everything was solved. It will ...</span> </span> <span class="update-date"><span class="update-day">07</span>Jan</span> </div>
                <div class="new-update clearfix"> <i class="am-icon-caret-right"></i> <span class="update-done"> <a href="#" title=""><strong>Envato approved Maruti Admin template</strong></a> <span>i am very happy to approved by TF</span> </span> <span class="update-date"><span class="update-day">05</span>jan</span> </div>
                <div class="new-update clearfix"> <i class="am-icon-caret-right"></i> <span class="update-notice"> <a href="#" title=""><strong>I am alwayse here if you have any question</strong></a> <span>we glad that you choose our template</span> </span> <span class="update-date"><span class="update-day">01</span>jan</span> </div>-->
              </div>
              <div class="widget-content">
                    
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