<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">
.new-update i{margin-top:0px;}
.roomLayoutPrice td{width:37px;}
@media (max-width: 480px) {
    .roomLayoutPrice td{width:37px;}
}
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
              <div class="widget-content nopadding">
                    <form action="<%$search_url%>" method="post" class="form-horizontal ui-formwizard" enctype="multipart/form-data">
                        <div class="control-group" id="form-wizard-1">
                            <label class="control-label"><%$arrayLaguage['please_select']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <select name="year" id="year" class="span1">
                                    <option value="<%$thisYear%>" ><%$thisYear%></option>
                                    <option value="<%$thisYear + 1%>" ><%$thisYear + 1%></option>
                                </select>
                                
                                <select name="month" id="month" class="span1">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            <button class="btn btn-primary"><i class="am-icon-search"></i> <%$arrayLaguage['search']['page_laguage_value']%></button >
                            
                            </div>
                        </div>
                    </form>
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
                                <li><i class="am-icon-rmb am-red-EA5555"></i>
                                <%if $arrayRoomLayoutPriceList[layout].price_system[system].price != ''%>
                                <code><%$year%>-<%$month%> <%$arrayLaguage['sell_price']['page_laguage_value']%></code>
                                <table class="roomLayoutPrice">
                                <tr>
                                    <%section name=price loop=$monthT%>
                                        <td>
                                        <code><%$smarty.section.price.iteration%></code>
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
                                <code><%$year%>-<%$month%> <%$arrayLaguage['no_price']['page_laguage_value']%></code>
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
<script language="javascript">
$(document).ready(function(){
    var RoomLayoutClass = {
        instance: function() {
            var roomLayout = {};
            roomLayout.thisYear = '<%$thisYear%>';
            roomLayout.year = '<%$year%>';
            roomLayout.nextYear = '<%$nextYear%>';
            roomLayout.thisMonth = '<%$thisMonth%>';
            roomLayout.month = '<%$month%>';
            roomLayout.monthT = '<%$monthT%>';
            return roomLayout;
        },
        setSelectYear: function(year) {
            $('#year').val(year);
        },
        setSelectMonth: function(month) {
            $('#month').val(month);
        }
    }
    var roomLayout = RoomLayoutClass.instance();
    RoomLayoutClass.setSelectYear(roomLayout.year);
    RoomLayoutClass.setSelectMonth(roomLayout.month);
})
</script>
</body>
</html>