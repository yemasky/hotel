<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div class="widget-box">
                <div class="widget-title">
                    <span class="icon">
                        <i class="icon-align-justify"></i>									
                    </span>
                    <h5><%$arrayLaguage['company_information']['page_laguage_value']%></h5>
                    <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                    <div class="buttons">
						<a class="btn btn-primary btn-mini" href="#" id="edit_company"><i class="icon-pencil"></i><%$arrayLaguage['company_edit']['page_laguage_value']%></a>	
                        <a class="btn btn-primary btn-mini" href="#" id="cancel_edit_company"><i class="icon-pencil"></i><%$arrayLaguage['company_cancel_edit']['page_laguage_value']%></a>
					</div>
                    <%/if%>
                </div>
                <div class="widget-content nopadding">
                    <form id="company" action="#" method="get" class="form-horizontal">
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_name']['page_laguage_value']%> :</label>
                            <div class="controls"><input type="text" class="span3" placeholder="<%$arrayLaguage['company_name']['page_laguage_value']%>" name="company_name" value="<%$arrayCompany['company_name']%>" /> </div>
                        </div>
                        <div class="control-group">
							<label class="control-label"><%$arrayLaguage['contact_information']['page_laguage_value']%> :</label>
							<div class="controls">
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_mobile']['page_laguage_value']%>"/>
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_phone']['page_laguage_value']%>"/> 
                            </div>
						</div>
                        <div class="control-group">
							<label class="control-label"><%$arrayLaguage['company_fax']['page_laguage_value']%> :</label>
							<div class="controls">
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_fax']['page_laguage_value']%>"/> 
                            </div>
						</div>
                        <div class="control-group">
							<label class="control-label"><%$arrayLaguage['company_email']['page_laguage_value']%> :</label>
							<div class="controls">
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_email']['page_laguage_value']%>"/> 
                            </div>
						</div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_location']['page_laguage_value']%></label>
                            <div class="controls ">
                                <select id="DropProvince" style="width:120px;">
                                    <option><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                </select>
                                <select id="sCity" style="width:120px;">
                                    <option><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                </select>
                                <select id="sArea" style="width:120px;">
                                    <option><%$arrayLaguage['please_select']['page_laguage_value']%></option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_address']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <input type="text"  class="span6" id="cityName" placeholder="<%$arrayLaguage['company_address']['page_laguage_value']%>"  /> 
                                <button class="btn btn-primary" type="button" onclick="theLocation()"><%$arrayLaguage['search_map']['page_laguage_value']%></button>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_map']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
                                <div id="allmap"></div>
                                </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_introduction']['page_laguage_value']%></label>
                            <div class="controls">
                                <textarea class="span20"  placeholder="<%$arrayLaguage['company_introduction']['page_laguage_value']%>" ></textarea>
                            </div>
                        </div>
                       
 
                        
                        <div class="form-actions pagination-centered">
                        	
                            <button type="submit" id="save_company_info" class="btn btn-success pagination-centered">Save</button>
                        </div>
                    </form>
                </div>
            </div>						
        </div>
    </div>
    
    </div>
</div>
