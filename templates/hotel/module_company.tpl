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
						<a class="btn btn-primary btn-mini" href="#"><i class="icon-pencil"></i><%$arrayLaguage['company_edit']['page_laguage_value']%></a>		
					</div>
                    <%/if%>
                </div>
                <div class="widget-content nopadding">
                    <form action="#" method="get" class="form-horizontal">
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_name']['page_laguage_value']%> :</label>
                            <div class="controls"><input type="text" class="span3" placeholder="<%$arrayLaguage['company_name']['page_laguage_value']%>" /> </div>
                        </div>
                        <div class="control-group">
							<label class="control-label"><%$arrayLaguage['contact_information']['page_laguage_value']%> :</label>
							<div class="controls">
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_mobile']['page_laguage_value']%>"/> 
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_phone']['page_laguage_value']%>"/> 
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_fax']['page_laguage_value']%>"/>
                                <input type="text" class="span3" placeholder="<%$arrayLaguage['company_email']['page_laguage_value']%>" /> 
                            </div>
						</div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_location']['page_laguage_value']%></label>
                            <div class="controls ">
                                <select>
                                    <option>First option</option>
                                    <option>Second option</option>
                                    <option>Third option</option>
                                    <option>Fourth option</option>
                                    <option>Fifth option</option>
                                    <option>Sixth option</option>
                                    <option>Seventh option</option>
                                    <option>Eighth option</option>
                                </select>
                                <select>
                                    <option>First option</option>
                                    <option>Second option</option>
                                    <option>Third option</option>
                                    <option>Fourth option</option>
                                    <option>Fifth option</option>
                                    <option>Sixth option</option>
                                    <option>Seventh option</option>
                                    <option>Eighth option</option>
                                </select>
                                <select>
                                    <option>First option</option>
                                    <option>Second option</option>
                                    <option>Third option</option>
                                    <option>Fourth option</option>
                                    <option>Fifth option</option>
                                    <option>Sixth option</option>
                                    <option>Seventh option</option>
                                    <option>Eighth option</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_address']['page_laguage_value']%> :</label>
                            <div class="controls">
                                <input type="text"  class="span6" placeholder="<%$arrayLaguage['company_address']['page_laguage_value']%>"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><%$arrayLaguage['company_introduction']['page_laguage_value']%></label>
                            <div class="controls">
                                <textarea class="span20"  placeholder="textarea (span20)" ></textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Description field:</label>
                            <div class="controls">
                                <span class="help-block">Description field</span>
                            </div>
                        </div>
                        
 
                        
                        <div class="form-actions">
                        	
                            <button type="submit" class="btn btn-success">Save</button>
                        </div>
                    </form>
                </div>
            </div>						
        </div>
    </div>
    
    </div>
</div>
