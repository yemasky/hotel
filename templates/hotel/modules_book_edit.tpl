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
.custom-date-style{ cursor:pointer; color:#666666 !important;}
.table-bordered th, .table-bordered td:first-child {border-left: 0px solid #ddd !important;}
.dropdown-menu {margin: 2px -40px 0 !important; min-width:110px;}
.dropdown-menu li{padding:0px !important;}
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
                    <div class="span4">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-eye-open"></i>
								</span><!--A3 单状态 -1 失效 0预定成功 1入住 2退房完成-->
								<h5>订单号：<%$arrayDataInfo[0].book_order_number%>  订单状态：<%$arrayLaguage[$orderStatus[$arrayDataInfo[0].book_order_number_status]]['page_laguage_value']%></h5>
							</div>
							<div class="widget-content nopadding">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>价格信息</th>
											<th>单位：元</th>
                                            <th><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>总价</td>
											<td><%$arrayDataInfo[0].book_total_price%></td>
                                            <td></td>
										</tr>
										<tr>
											<td>预付价</td>
											<td><%$arrayDataInfo[0].book_prepayment_price%></td>
                                            <td></td>
										</tr>
										<tr>
											<td>总房价</td>
											<td><%$arrayDataInfo[0].book_total_room_rate%></td>
                                            <td></td>
										</tr>
                                        <tr>
											<td>附加服务费</td>
											<td><%$arrayDataInfo[0].book_need_service_price%></td>
                                            <td></td>
										</tr>
                                        <tr>
											<td>服务费</td>
											<td><%$arrayDataInfo[0].book_service_charge%></td>
                                            <td></td>
										</tr>
                                        <tr>
											<td>总押金</td>
											<td><%$arrayDataInfo[0].book_total_cash_pledge%></td>
                                            <td></td>
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
								<h5>来源/折扣</h5>
							</div>
							<div class="widget-content nopadding">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>信息</th>
											<th></th>
                                            <th><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>来源</td>
											<td><%$arrayBookType[$arrayDataInfo[0].book_type_id].book_type_name%></td>
                                            <td></td>
										</tr>
										<tr>
											<td>折扣</td>
											<td><%$arrayDataInfo[0].book_discount%><input id="discount" type="hidden" value="<%$arrayDataInfo[0].book_discount%>"></td>
                                            <td></td>
										</tr>
                                        <tr>
											<td>外部订单号</td>
											<td><%$arrayDataInfo[0].book_order_number_ourter%></td>
                                            <td></td>
										</tr>
										<tr>
											<td>订单保留时间</td>
											<td><%$arrayDataInfo[0].book_order_retention_time%></td>
                                            <td></td>
										</tr>
										<tr>
											<td><%$arrayLaguage['book_man']['page_laguage_value']%>：</td>
											<td><%$arrayDataInfo[0].book_contact_name%></td>
                                            <td></td>
										</tr>
										<tr>
											<td><%$arrayLaguage['mobile']['page_laguage_value']%>：</td>
											<td><%$arrayDataInfo[0].book_contact_mobile%></td>
                                            <td></td>
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
                                            <th><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>支付状态</td>
											<td><%if $arrayDataInfo[0].book_is_pay==1%>已支付<%else%>未支付<%/if%></td>
                                            <td></td>
										</tr>
										<tr>
											<td>支付到账</td>
											<td><%if $arrayDataInfo[0].book_pay_date ==''%>未到账<%else%>到账时间:<%$arrayDataInfo[0].book_pay_date%><%/if%></td>
                                            <td></td>
										</tr>
                                        <tr>
											<td>支付方式</td>
											<td><%if $arrayDataInfo[0].payment_type_id > 0%><%$arrayPaymentType[$arrayDataInfo[0].payment_type_id].payment_type_name%><%else%>未支付<%/if%></td>
                                            <td></td>
										</tr>
										<tr>
											<td>预付状态</td>
											<td><%if $arrayDataInfo[0].book_is_prepayment==1%>已预付<%else%>未预付<%/if%></td>
                                            <td></td>
										</tr>
										<tr>
											<td>预付到账</td>
											<td><%if $arrayDataInfo[0].book_prepayment_date ==''%>未到账<%else%>到账时间: <%$arrayDataInfo[0].book_prepayment_date%><%/if%></td>
                                            <td></td>
										</tr>
										<tr>
											<td>预付方式</td>
											<td><%if $arrayDataInfo[0].prepayment_type_id > 0%><%$arrayPaymentType[$arrayDataInfo[0].prepayment_type_id].payment_type_name%><%else%>未支付<%/if%></td>
                                            <td></td>
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
                            <input id="half_price" value="<%$arrayDataInfo[0].book_half_price%>" name="half_price" type="hidden">
                            <div class="buttons">
                                <a id="add_room" class="btn btn-primary btn-mini"><i class="am-icon-plus-circle"></i> 
                                <%$arrayLaguage['add']['page_laguage_value']%></a>
                            </div>
                        </div>
                       <div class="widget-content nopadding">  
                            <table class="table table-bordered table-striped">
                              <thead>
                                <tr>
                                  <th><%$arrayLaguage['checkin']['page_laguage_value']%></th>
                                  <th><%$arrayLaguage['checkout']['page_laguage_value']%></th>
                                  <th>房型</th>
                                  <th>价格体系</th>
                                  <th>房间</th>
                                  <th>加床</th>
                                  <th></th>
                                </tr>
                              </thead>
                              <tbody>
                              <%section name=i loop=$arrayDataInfo%>
                                <tr>
                                  <td><%$arrayDataInfo[i].book_check_in%></td>
                                  <td><%$arrayDataInfo[i].book_check_out%></td>
                                  <td><%$arraySellLayout[$arrayDataInfo[i].room_sell_layout_id].room_sell_layout_name%></td>
                                  <td><%$arrayPriceSystem[$arrayDataInfo[i].room_layout_price_system_id].room_layout_price_system_name%></td>                   
                                  <td><%$arrayRoomInfo[$arrayDataInfo[i].room_id].room_name%>[<%$arrayRoomInfo[$arrayDataInfo[i].room_id].room_number%>]</td>
                                  <td><%$arrayRoomInfo[$arrayDataInfo[i].room_id].room_name%>[<%$arrayRoomInfo[$arrayDataInfo[i].room_id].room_number%>]</td>
                                  <td>
                                  <div class="fr">
                                    <div class="btn-group">
                                        <a class="btn btn-primary btn-mini" href="#"><i class="am-icon-sun-o"></i> <%$arrayLaguage['manage']['page_laguage_value']%></a>
                                        <a class="btn btn-primary btn-mini dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                        <ul class="dropdown-menu">
                                            <li><a data-target="#" href=""><i class="am-icon-pencil-square-o"></i> 换房</a></li>
                                            <li><a data-target="#" href="#"><i class="am-icon-pencil-square-o"></i> 续住</a></li>
                                            <li><a data-target="#" href="#"><i class="am-icon-pencil-square-o"></i> 退房</a></li>
                                            <li><a data-target="#" href="#"><i class="am-icon-trash-o"></i> 删除</a></li>
                                        </ul>
                                    </div>
                                </div>
                                  </td>
                                </tr>
                              <%/section%>
                                <tr id="add_room_tr" class="hide">
                                  <td><input type="text" class="input-medium" id="room_check_in" value="" ></td>
                                  <td><input type="text" class="input-medium" id="room_check_out" value="" ></td>
                                  <td><select id="sell_layout" class="input-medium">
                                        <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                    <%foreach key=room_sell_layout_id item=arrayLayout from=$arraySellLayout%>
                                        <option room_layout="<%$arrayLayout.room_layout_id%>" value="<%$room_sell_layout_id%>"><%$arrayLayout.room_sell_layout_name%></option>
                                    <%/foreach%>
                                 </select></td>
                                  <td>
                                    <select id="price_system" class="input-medium">
                                    <%foreach key=system_id item=arraySystem from=$arrayPriceSystem%>
                                        <option sell_id="<%$arraySystem.room_sell_layout_id%>" value="<%$system_id%>"><%$arraySystem.room_layout_price_system_name%></option>
                                    <%/foreach%>
                                    </select>
                                  </td>
                                  <td></td>
                                  <td></td>
                                  <td><div class="input-prepend input-append fr">
                                  <a id="cancel_add_room" class="btn btn-primary btn-mini"><i class="am-icon-edit"></i><%$arrayLaguage['cancel']['page_laguage_value']%></a>
                                  <a id="asve_add_room" class="btn btn-primary btn-mini"><i class="am-icon-save"></i><%$arrayLaguage['save']['page_laguage_value']%></a>
                                  </div></td>
                                </tr>
                                <tr id="room_layout_data" class="hide">
                                  <td colspan="7"><div class="input-prepend input-append fr"></div></td>
                                </tr>
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
                            <div class="buttons">
                                <a id="add_user" class="btn btn-primary btn-mini"><i class="am-icon-user-plus"></i> 
                                <%$arrayLaguage['add']['page_laguage_value']%></a>
                            </div>
                        </div>
                       <div class="widget-content nopadding">  
                            <table class="table table-bordered table-striped">
                              <thead>
                                <tr>
                                  <th>姓名</th>
                                  <th>性别</th>
                                  <th>身份信息</th>
                                  <th>证件号码</th>
                                  <th>入住房号</th>
                                  <th><%$arrayLaguage['checkin']['page_laguage_value']%></th>
                                  <th><%$arrayLaguage['checkout']['page_laguage_value']%></th>
                                  <th>备注</th>
                                  <th></th>
                                </tr>
                              </thead>
                              <tbody>
                              <%section name=i loop=$arrayBookUser%>
                                <tr>
                                  <td><%$arrayBookUser[i].book_user_name%></td>
                                  <td><%if $arrayBookUser[i].book_user_sex==1%>男<%else%>女<%/if%></td>
                                  <td><%if $arrayBookUser[i].book_user_id_card_type!=''%><%$arrayLaguage[$arrayBookUser[i].book_user_id_card_type]['page_laguage_value']%><%/if%></td>
                                  <td><%$arrayBookUser[i].book_user_id_card%></td>
                                  <td><%$arrayRoomInfo[$arrayBookUser[i].room_id].room_name%>[<%$arrayRoomInfo[$arrayBookUser[i].room_id].room_number%>]</td>
                                  <td><%$arrayBookUser[i].book_check_in%></td>
                                  <td><%$arrayBookUser[i].book_check_out%></td>
                                  <td><%$arrayBookUser[i].book_user_comments%></td>
                                  <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
                                </tr>
                              <%/section%>
                              <tr id="add_user_tr" class="hide">
                                  <td><input name="user_name[]" value="" type="text" class="input-small" placeholder="<%$arrayLaguage['name']['page_laguage_value']%>" /></td>
                                  <td>
                                      <select name="user_sex" class="input-small">
                                        <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                        <option value="1"><%$arrayLaguage['male']['page_laguage_value']%></option>
                                        <option value="0"><%$arrayLaguage['female']['page_laguage_value']%></option>
                                      </select>
                                  </td>
                                  <td>
                                  <select name="user_id_card_type" class="input-small">
									<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
									<%section name=card_type loop=$idCardType%>
									<option value="<%$idCardType[card_type]%>"><%$arrayLaguage[$idCardType[card_type]]['page_laguage_value']%></option>
									<%/section%>
								  </select>
                                  </td>
                                  <td><input type="text" name="user_id_card" class="input-medium" placeholder="<%$arrayLaguage['identification_number']['page_laguage_value']%>"/></td>
                                  <td></td>
                                  <td><input class="input-medium" type="text" id="user_check_in"></td>
                                  <td><input class="input-medium" type="text" id="user_check_out"></td>
                                  <td><input type="text" name="user_comments" class="input-large" placeholder="<%$arrayLaguage['user_comments']['page_laguage_value']%>"/></td>
                                  <td><div class="input-prepend input-append fr">
                                  <a id="cancel_add_user" class="btn btn-primary btn-mini"><i class="am-icon-edit"></i><%$arrayLaguage['cancel']['page_laguage_value']%></a>
                                  <a id="asve_add_user" class="btn btn-primary btn-mini"><i class="am-icon-save"></i><%$arrayLaguage['save']['page_laguage_value']%></a>
                                  </div>
                                  </td>
                                </tr>
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
                            <div class="buttons">
                                <a id="add_service" class="btn btn-primary btn-mini"><i class="am-icon-plus-circle"></i> 
                                <%$arrayLaguage['add']['page_laguage_value']%></a>
                            </div>
                        </div>
                       <div class="widget-content nopadding">  
                            <table class="table table-bordered table-striped">
                              <thead>
                                <tr>
                                  <th>项目</th>
                                  <th>单价</th>
                                  <th>数量</th>
                                  <th>折扣</th>
                                  <th></th>
                                </tr>
                              </thead>
                              <tbody>
                              <%section name=i loop=$arrayBookHotelService%>
                                <tr>
                                  <td><%$arrayHotelService[$arrayBookHotelService[i].hotel_service_id].hotel_service_name%></td>
                                  <td><%$arrayBookHotelService[i].hotel_service_price%></td>
                                  <td><%$arrayBookHotelService[i].book_hotel_service_num%></td>
                                  <td><%$arrayBookHotelService[i].book_hotel_service_discount%></td>
                                  <td><a class="btn btn-primary btn-mini fr"><i class="am-icon-edit"></i><%$arrayLaguage['edit']['page_laguage_value']%></a></td>
                                </tr>
                              <%/section%>
                                <tr id="add_service_tr" class="hide">
                                  <td><select id="serviceItem" class="input-medium">
                                        <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                    <%foreach key=service_id item=arrayService from=$arrayHotelService%>
                                        <%if $arrayService.hotel_service_price != -1%><option price="<%$arrayService.hotel_service_price%>" value="<%$service_id%>">
                                            <%$arrayService.hotel_service_name%>
                                        </option><%/if%>
                                    <%/foreach%>
                                 </select></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td><div class="input-prepend input-append fr">
                                  <a id="cancel_add_service" class="btn btn-primary btn-mini"><i class="am-icon-edit"></i><%$arrayLaguage['cancel']['page_laguage_value']%></a>
                                  <a id="asve_add_service" class="btn btn-primary btn-mini"><i class="am-icon-save"></i><%$arrayLaguage['save']['page_laguage_value']%></a>
                                  </div></td>
                                </tr>
                              </tbody>
                            </table>
                       </div>
                   </div>
                   <div class="widget-box">   
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-arrow-right"></i>
                            </span>
                            <h5>变更历史</h5>
                        </div>
                       <div class="widget-content nopadding">  
                            <table class="table table-bordered table-striped">
                              <thead>
                                <tr>
                                  <th>变更项目</th>
                                  <th>变更内容</th>
                                  <th>涉及价钱</th>
                                  <th>变更时间</th>
                                </tr>
                              </thead>
                              <tbody>
                              <%section name=i loop=$arrayBookChange%>
                                <tr>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
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