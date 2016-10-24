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
.modal-body{ padding:1px;}
.widget-box{margin-bottom:1px; margin-top:1px;}
#room_layout_paginate a{border:1px solid #BFBDBD;}
.dataTables_wrapper .dataTables_paginate .paginate_button {border-radius: 0;margin-left: 0;min-width: 0;padding: 0.1em 0.5em;}
.details-control{cursor:pointer;}
#noBodyLeft{}
#noBodyLeft th,#noBodyLeft td{padding:5px;}
#noBodyLeft input,#noBodyLeft select{margin-bottom:0px;}
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
                <div class="widget-content nopadding">
                    <form action="#" method="post" class="form-horizontal ui-formwizard" enctype="multipart/form-data" name="contact_form" id="contact_form">
                    	<div class="control-group" id="form-wizard-1">
                            <label class="control-label"><%$arrayLaguage['contact_information']['page_laguage_value']%> :</label>
                            <div class="controls">
                            <input type="text" id="contact_name" name="contact_name" class="span2" placeholder="<%$arrayLaguage['contacts']['page_laguage_value']%>"  />
                            <%$arrayLaguage['mobile']['page_laguage_value']%> : 
                            <input type="text" id="contact_mobile" name="contact_mobile" class="span2" placeholder="<%$arrayLaguage['mobile']['page_laguage_value']%>"  />
                            </div>
                        </div>
					</form>
					<form action="#" method="post" class="form-horizontal ui-formwizard" enctype="multipart/form-data" name="book_form" id="book_form">
						<input type="hidden" value="" name="book_contact_name" id="book_contact_name">
						<input type="hidden" value="" name="book_contact_mobile" id="book_contact_mobile">
						<div class="control-group book_form_step1">
							<label class="control-label"><%$arrayLaguage['book_type']['page_laguage_value']%> :</label>
							<div class="controls">
								 <select name="book_type_id" id="book_type_id" class="span2">
								 <option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
								 <%section name=type loop=$arrayBookType%>
									<%if $arrayBookType[type].book_type_father_id!=$arrayBookType[type].book_type_id%>
									<option value="<%$arrayBookType[type].book_type_id%>"><%$arrayBookType[type].book_type_name%></option>
									<%/if%>
								 <%/section%>
								</select>
							</div>
						</div>
						<div class="control-group book_form_step1">
							<label class="control-label"><%$arrayLaguage['discount']['page_laguage_value']%> :</label>
							<div class="controls">
								 <input type="text" id="discount" name="book_discount" class="span1 book_price" placeholder="<%$arrayLaguage['discount']['page_laguage_value']%>" value="100"  />
								 <%$arrayLaguage['discount_describe']['page_laguage_value']%> :
								 <input type="text" id="book_discount_describe" name="book_discount_describe" class="span2" placeholder="<%$arrayLaguage['discount_describe']['page_laguage_value']%>"  />
							</div>
						</div>
						<div class="control-group book_form_step1">
							<label class="control-label"><%$arrayLaguage['checkin']['page_laguage_value']%> :</label>
							<div class="controls">
								<input type="text" class="span2" id="book_check_int" name="book_check_int" value="<%$book_check_int%>"/>
								<%$arrayLaguage['checkout']['page_laguage_value']%> :
								<input type="text" class="span2" id="book_check_out" name="book_check_out" value="<%$book_check_out%>"/>
								<!--<%$arrayLaguage['number_of_people']['page_laguage_value']%> :
								<input type="text" class="span1" id="room_layout_max_people" name="room_layout_max_people" placeholder="<%$arrayLaguage['number_of_people']['page_laguage_value']%>"  />-->
                                <%$arrayLaguage['book_order_retention_time']['page_laguage_value']%> :
                                <input value="18:00" type="text" class="span1" id="book_order_retention_time" name="book_order_retention_time" />
								<a href="#searchRoom" id="search_room_layout" class="btn btn-primary btn-mini"><i class="am-icon-search"></i> <%$arrayLaguage['find_room']['page_laguage_value']%></a>
							</div>
						</div>
						 <div class="control-group" id="room_layout_table">
							<div class="controls">
							 <table class="table table-bordered data-table" id="room_layout">
							  <thead>
								<tr>
								  <th><%$arrayLaguage['room_layout_name']['page_laguage_value']%><%$arrayLaguage['book']['page_laguage_value']%></th>
								  <th><%$arrayLaguage['price']['page_laguage_value']%></th>
								  <th><%$arrayLaguage['extra_bed']['page_laguage_value']%></th>
								</tr>
							  </thead>
							  <tbody id='room_layout_data'>
								<tr class="gradeX">
								  <td></td>
								  <td></td>
								  <td></td>
								</tr>
							  </tbody>
							</table>
                            <div id="room_layout_html"></div>
                            <div id="room_data"></div>
                            <div id="room_name_data"></div>
                            <div id="addBed_data"></div>
						  </div>
						</div>
						<div class="control-group">
							<label class="control-label"><%$arrayLaguage['total_price']['page_laguage_value']%> :</label>
							<div class="controls">
							 <input value="" type="text" class="span1" id="total_price" name="book_total_price" />
							 <%$arrayLaguage['prepayment_price']['page_laguage_value']%> :
							 <input value="" type="text" class="span1" id="prepayment" name="book_prepayment_price" />
						  </div>
						</div>
						<div class="control-group">
							<label class="control-label"><%$arrayLaguage['pay']['page_laguage_value']%> :</label>
							<div class="controls">
							 <select name="payment" id="payment" class="span1">
								<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
								<option value="1"><%$arrayLaguage['prepayment']['page_laguage_value']%></option>
								<option value="2"><%$arrayLaguage['remaining_sum']['page_laguage_value']%></option>
								<option value="3"><%$arrayLaguage['full-payout']['page_laguage_value']%></option>
							 </select>
							 <%$arrayLaguage['payment_type']['page_laguage_value']%> :
							 <select name="payment_type" id="payment_type" class="span1">
								<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
								<%section name=type loop=$arrayPaymentType%>
								<option value="<%$arrayPaymentType[type].payment_type_id%>"><%$arrayPaymentType[type].payment_type_name%></option>
								<%/section%>
							 </select>
							 <%$arrayLaguage['money_has_to_account']['page_laguage_value']%> :
							 <select name="is_pay" id="is_pay" class="span1">
								<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
								<option value="1"><%$arrayLaguage['already_collection']['page_laguage_value']%></option>
								<option value="2"><%$arrayLaguage['not_receivable']['page_laguage_value']%></option>
							 </select>
							 <%$arrayLaguage['payment_voucher']['page_laguage_value']%> :
							 <input value="" type="text" class="span2" id="book_payment_voucher" name="book_payment_voucher" />
						  </div>
						</div>
						<div class="control-group">
							<label class="control-label"><%$arrayLaguage['check_in_information']['page_laguage_value']%> :</label>
							<div class="controls" id="book_user_info">
								<input name="book_user_name" value="" type="text" class="span2" placeholder="<%$arrayLaguage['name']['page_laguage_value']%>" />
								<%$arrayLaguage['sex']['page_laguage_value']%> :
								<select name="book_user_sex" class="span1">
									<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
									<option value="1"><%$arrayLaguage['male']['page_laguage_value']%></option>
									<option value="0"><%$arrayLaguage['female']['page_laguage_value']%></option>
								</select>
								<%$arrayLaguage['identity_information']['page_laguage_value']%> :
								<select name="book_user_id_card_type" class="span1">
									<option value=""><%$arrayLaguage['please_select']['page_laguage_value']%></option>
									<%section name=card_type loop=$idCardType%>
									<option value="<%$idCardType[card_type]%>"><%$arrayLaguage[$idCardType[card_type]]['page_laguage_value']%></option>
									<%/section%>
								</select>
								<input type="text" class="span3" placeholder="<%$arrayLaguage['identification_number']['page_laguage_value']%>"/>
							</div>
							<div class="controls">
							<a href="#addBookUser" id="addBookUser" class="btn btn-primary btn-mini"><i class="am-icon-plus-circle"></i> <%$arrayLaguage['add_number_of_people']['page_laguage_value']%></a>
							<a href="#reduceBookUser" id="reduceBookUser" class="btn btn-warning btn-mini"><i class="am-icon-minus-circle"></i> <%$arrayLaguage['reduce_number_of_people']['page_laguage_value']%></a>
							</div>
						</div>
                        <div class="form-actions pagination-centered">
                            <button type="submit" class="btn btn-primary pagination-centered save_info"><%$arrayLaguage['save_next']['page_laguage_value']%></button>
                        </div>
                    </form>
                </div>
            </div>   
        </div>
					
	  </div>
    
    </div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<%include file="hotel/inc/book_edit_js.tpl"%>
</body>
</html>