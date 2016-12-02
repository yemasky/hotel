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
.table-bordered th, .table-bordered td {border-left: 1px solid #ddd !important;}
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
                    <div class="span4">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-eye-open"></i>
								</span>
								<h5>订单号：<%$arrayDataInfo[0].book_order_number%>  订单状态：<%$arrayDataInfo[0].book_order_number_status%></h5>
							</div>
							<div class="widget-content nopadding">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>价格信息</th>
											<th>单位：元</th>
                                            <th></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>总价：</td>
											<td><%$arrayDataInfo[0].book_total_price%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
										<tr>
											<td>预付价：</td>
											<td><%$arrayDataInfo[0].book_prepayment_price%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
										<tr>
											<td>总房价：</td>
											<td><%$arrayDataInfo[0].book_total_room_rate%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
                                        <tr>
											<td>附加服务费：</td>
											<td><%$arrayDataInfo[0].book_total_room_rate%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
                                        <tr>
											<td>服务费：</td>
											<td><%$arrayDataInfo[0].book_total_room_rate%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
                                        <tr>
											<td>总押金：</td>
											<td><%$arrayDataInfo[0].book_total_room_rate%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                    <div class="span4">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-arrow-right"></i>
								</span>
								<h5>支付信息</h5>
							</div>
							<div class="widget-content nopadding">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>支付方式</th>
											<th>状态</th>
                                            <th></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>支付状态：</td>
											<td><%$arrayDataInfo[0].book_is_pay%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
										<tr>
											<td>支付到账：</td>
											<td><%$arrayDataInfo[0].book_pay_date%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
                                        <tr>
											<td>支付方式：</td>
											<td><%$arrayDataInfo[0].payment_type_id%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
										<tr>
											<td>预付状态：</td>
											<td><%$arrayDataInfo[0].book_is_prepayment%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
										<tr>
											<td>预付到账：</td>
											<td><%$arrayDataInfo[0].book_prepayment_date%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
										<tr>
											<td>预付方式：</td>
											<td><%$arrayDataInfo[0].prepayment_type_id%></td>
                                            <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                      
                   <div class="widget-box">   
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-arrow-right"></i>
                            </span>
                            <h5>客房信息</h5>
                        </div>
                       <div class="widget-content nopadding">  
                            <table class="table table-bordered table-striped">
                              <thead>
                                <tr>
                                  <th>房型</th>
                                  <th>房间</th>
                                  <th>服务</th>
                                  <th><%$arrayLaguage['checkin']['page_laguage_value']%> ~ <%$arrayLaguage['checkout']['page_laguage_value']%></th>
                                  <th></th>
                                </tr>
                              </thead>
                              <tbody>
                              <%section name=i loop=$arrayDataInfo%>
                                <tr>
                                  <td><%$arraySellLayout[$arrayDataInfo[i].room_sell_layout_id].room_sell_layout_name%></td>
                                  <td><%$arrayRoomInfo[$arrayDataInfo[i].room_id].room_name%>[<%$arrayRoomInfo[$arrayDataInfo[i].room_id].room_number%>]</td>
                                  <td><%$arrayPriceSystem[$arrayDataInfo[i].room_layout_price_system_id].room_layout_price_system_name%></td>
                                  <td><%$arrayDataInfo[i].book_check_in%> ~ <%$arrayDataInfo[i].book_check_out%></td>
                                  <td><a class="btn btn-primary btn-mini"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
                                </tr>
                              <%/section%>
                              </tbody>
                            </table>
                       </div>
                   </div>
                   <div class="widget-box">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-arrow-right"></i>
                            </span>
                            <h5>入住信息</h5>
                        </div>
                       <div class="widget-content nopadding">  
                            <table class="table table-bordered table-striped">
                              <thead>
                                <tr>
                                  <th>姓名</th>
                                  <th>性别</th>
                                  <th>身份信息</th>
                                  <th>入住房号</th>
                                  <th><%$arrayLaguage['checkin']['page_laguage_value']%> ~ <%$arrayLaguage['checkout']['page_laguage_value']%></th>
                                  <th></th>
                                </tr>
                              </thead>
                              <tbody>
                              <%section name=i loop=$arrarBookUser%>
                                <tr>
                                  <td><%$arrarBookUser[i].book_user_name%></td>
                                  <td><%$arrarBookUser[i].book_user_sex%></td>
                                  <td><%$arrarBookUser[i].book_user_id_card_type%> <%$arrarBookUser[i].book_user_id_card%></td>
                                  <td><%$arrayRoomInfo[$arrarBookUser[i].room_id].room_name%>[<%$arrayRoomInfo[$arrarBookUser[i].room_id].room_number%>]</td>
                                  <td><%$arrarBookUser[i].book_check_in%> ~ <%$arrarBookUser[i].book_check_out%></td>
                                  <td><a class="btn btn-primary btn-mini"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
                                </tr>
                              <%/section%>
                              </tbody>
                            </table>
                       </div>
                   </div>
                   <div class="widget-box">   
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-arrow-right"></i>
                            </span>
                            <h5>附加服务</h5>
                        </div>
                       <div class="widget-content nopadding">  
                            <table class="table table-bordered table-striped">
                              <thead>
                                <tr>
                                  <th>项目</th>
                                  <th>价格</th>
                                  <th>数量</th>
                                  <th>折扣</th>
                                </tr>
                              </thead>
                              <tbody>
                              <%section name=i loop=$arrarBookHotelService%>
                                <tr>
                                  <td><%$arrayHotelService[$arrarBookHotelService[i].hotel_service_id].hotel_service_name%></td>
                                  <td><%$arrarBookHotelService[i].hotel_service_price%></td>
                                  <td><%$arrarBookHotelService[i].book_hotel_service_num%></td>
                                  <td><%$arrarBookHotelService[i].book_hotel_service_discount%></td>
                                </tr>
                              <%/section%>
                              </tbody>
                            </table>
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
<%include file="hotel/inc_js/book_edit_js.tpl"%>
</body>
</html>