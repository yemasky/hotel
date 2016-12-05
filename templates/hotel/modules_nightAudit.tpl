<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.peity.min.js"></script>
<script src="<%$__RESOURCE%>js/maruti.dashboard.js"></script>
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
                        <i class="am-icon-server am-yellow-EBC012"></i>
                    </span>
                    <h5><%$selfNavigation['hotel_modules_name']%></h5>
                </div>
                <div class="widget-content">
                    <ul class="stat-boxes stat-boxes2">
                      <li>
                        <div class="left peity_bar_good"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>+20%</div>
                        <div class="right"> <strong>已审</strong> check in </div>
                      </li>
                      <li>
                        <div class="left peity_bar_neutral"><span><span style="display: none;">12,12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>0%</div>
                        <div class="right"> <strong>未审</strong> vacant </div>
                      </li>
                      <li>
                        <div class="left peity_bar_bad"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>-50%</div>
                        <div class="right"> <strong>已结</strong> Dirty </div>
                      </li>
                      <li>
                        <div class="left peity_line_good"><span><span style="display: none;">12,12,12,12,12,12,12</span><canvas width="50" height="24"></canvas></span>+70%</div>
                        <div class="right"> <strong>未结</strong> book </div>
                      </li>
                    </ul>
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