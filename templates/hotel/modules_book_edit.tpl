<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%$__RESOURCE%>js/jquery.datetimepicker.full.min.js"></script>
<script src="<%$__RESOURCE%>js/jquery.dataTables.min.1.10.12.js"></script>
<!--<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>-->
<link rel="stylesheet" href="<%$__RESOURCE%>css/jquery.dataTables.min.1.10.12.css" />
<style type="text/css">
@media (max-width: 480px){
.stat-boxes2 {margin:auto;}
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
                <div class="widget-title">
                    <span class="icon">
                        <i class="icon-th-list"></i>
                    </span>
                    <h5><%$arrayLaguage['book_info']['page_laguage_value']%> <%$today%></h5>
                    <div class="buttons" id="btn_room_layout">
                        <a class="btn btn-primary btn-mini" href="<%$back_lis_url%>" id="add_room_layout"><i class="am-icon-arrow-circle-left"></i> 
                        &#12288;<%$arrayLaguage['back_list']['page_laguage_value']%></a>
                    </div>
                </div>
                <div class="widget-content">
                    订单号：<%$arrayBookInfo[0].book_order_number%>
                   <hr>
                   <table class="table table-bordered table-striped">
                      <thead>
                        <tr>
                          <th>Name</th>
                          <th>Example</th>
                          <th>Markup</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td> Default </td>
                          <td><span class="badge">1</span></td>
                          <td><code>&lt;span class="badge"&gt;</code></td>
                        </tr>
                        <tr>
                          <td> Success </td>
                          <td><span class="badge badge-success">2</span></td>
                          <td><code>&lt;span class="badge badge-success"&gt;</code></td>
                        </tr>
                        <tr>
                          <td> Warning </td>
                          <td><span class="badge badge-warning">4</span></td>
                          <td><code>&lt;span class="badge badge-warning"&gt;</code></td>
                        </tr>
                        <tr>
                          <td> Important </td>
                          <td><span class="badge badge-important">6</span></td>
                          <td><code>&lt;span class="badge badge-important"&gt;</code></td>
                        </tr>
                        <tr>
                          <td> Info </td>
                          <td><span class="badge badge-info">8</span></td>
                          <td><code>&lt;span class="badge badge-info"&gt;</code></td>
                        </tr>
                        <tr>
                          <td> Inverse </td>
                          <td><span class="badge badge-inverse">10</span></td>
                          <td><code>&lt;span class="badge badge-inverse"&gt;</code></td>
                        </tr>
                      </tbody>
                    </table>
					
                </div>
            </div>   
        </div>
					
	  </div>
    
    </div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<%include file="hotel/inc_js/book_edit_js.tpl"%>
</body>
</html>