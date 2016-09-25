<!DOCTYPE html>
<html lang="en">

<head>
<%include file="hotel/inc/head.tpl"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<%$__RESOURCE%>css/fullcalendar.css" />
</head>
<body>
<%include file="hotel/inc/top_menu.tpl"%>

<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a></div>
  </div>
  <div  class="quick-actions_homepage">
    <ul class="quick-actions">
          <li> <a href="#"> <i class="icon-dashboard"></i> My Dashboard </a> </li>
          <li> <a href="#"> <i class="icon-shopping-bag"></i> Shopping Cart</a> </li>
          <li> <a href="#"> <i class="icon-web"></i> Web Marketing </a> </li>
          <li> <a href="#"> <i class="icon-people"></i> Manage Users </a> </li>
          <li> <a href="#"> <i class="icon-calendar"></i> Manage Events </a> </li>
        </ul>
  </div>
  <div class="container-fluid">    
    <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-hand-right"></i> </span>
            <h5>Notifications</h5>
          </div>
          <div class="widget-content">
            <div class="alert alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
              <h4 class="alert-heading">Warning!</h4>
             You're not looking too good. Nulla vitae elit libero, a pharetra augue. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. 
            </div>
            <div class="alert alert-info alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
              <h4 class="alert-heading">Info!</h4>
              Tou're not looking too good. Nulla vitae elit libero, a pharetra augue. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. 
            </div>
          </div>
        </div>    
  </div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<script src="<%$__RESOURCE%>js/excanvas.min.js"></script> 
<script src="<%$__RESOURCE%>js/jquery.min.js"></script> 
<script src="<%$__RESOURCE%>js/jquery.ui.custom.js"></script> 
<script src="<%$__RESOURCE%>js/bootstrap.min.js"></script> 
<script src="<%$__RESOURCE%>js/jquery.flot.min.js"></script> 
<script src="<%$__RESOURCE%>js/jquery.flot.resize.min.js"></script> 
<script src="<%$__RESOURCE%>js/jquery.peity.min.js"></script> 
<script src="<%$__RESOURCE%>js/fullcalendar.min.js"></script> 
<script src="<%$__RESOURCE%>js/maruti.js"></script> 
<script src="<%$__RESOURCE%>js/maruti.dashboard.js"></script> 
<script src="<%$__RESOURCE%>js/maruti.chat.js"></script> 
<script type="text/javascript">
  // This function is called from the pop-up menus to transfer to
  // a different page. Ignore if the value returned is a null string:
  function goPage (newURL) {

      // if url is empty, skip the menu dividers and reset the menu selection to default
      if (newURL != "") {
      
          // if url is "-", it is this page -- reset the menu:
          if (newURL == "-" ) {
              resetMenu();            
          } 
          // else, send page to designated URL            
          else {  
            document.location.href = newURL;
          }
      }
  }

// resets the menu selection upon entry to this page:
function resetMenu() {
   document.gomenu.selector.selectedIndex = 2;
}
</script>
</body>

</html>
