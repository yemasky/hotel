<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<style type="text/css">
.bookEdit {color: #bbbbbb;float: right;margin: 4px 10px 0 0;text-align: center;}
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
                    <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                    <div class="buttons">
                        <a class="btn btn-primary btn-mini" href="<%$add_book_url%>"><i class="am-icon-plus-square"></i>
                        &#12288;<%$arrayLaguage['add_book']['page_laguage_value']%></a>
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
                <div class="widget-content nopadding">
                    <ul class="recent-posts">
                      <li>
                        <div class="article-post"> 
                        <i class="icon-user"></i>
                        	<div class="fr">
                                <div class="btn-group">
                                    <a class="btn btn-primary" href="#"><i class="icon-user icon-white"></i> User</a>
                                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="#"><i class="icon-pencil"></i> Edit</a></li>
                                        <li><a href="#"><i class="icon-trash"></i> Delete</a></li>
                                        <li class="divider"></li>
                                        <li><a href="#"><i class="i"></i> Make admin</a></li>
                                    </ul>
                                </div>
                            </div>
                          <a href="#collapseOne" data-toggle="collapse">
                            <strong>Themeforest</strong>Approved My college theme <strong>1 user</strong> <span>2 hours ago</span>
                            <span class="user-info"> By: john Deo / Date: 2 Aug 2012 / Time:09:27 AM </span>
                          </a>
                          <p><a href="#">This is a much longer one that will go on for a few lines.It has multiple paragraphs and is full of waffle to pad out the comment.</a> </p>
                          
                          </div>
                          <div class="collapse" id="collapseOne">
                                    <div class="new-update clearfix"><i class="icon-ok-sign"></i>
                                      <div class="update-done"><a href="#" title=""><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</strong></a> <span>dolor sit amet, consectetur adipiscing eli</span> </div>
                                      <div class="update-date"><span class="update-day">20</span>jan</div>
                                    </div>
                            </div>
                      </li>
                      <li>
                        <div class="article-post"> 
                        <i class="icon-user"></i>
                        	<div class="fr">
                                <div class="btn-group">
                                    <a class="btn btn-primary" href="#"><i class="icon-user icon-white"></i> User</a>
                                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="#"><i class="icon-pencil"></i> Edit</a></li>
                                        <li><a href="#"><i class="icon-trash"></i> Delete</a></li>
                                        <li class="divider"></li>
                                        <li><a href="#"><i class="i"></i> Make admin</a></li>
                                    </ul>
                                </div>
                            </div>
                          <a href="#collapse2" data-toggle="collapse">
                            <strong>Themeforest</strong>Approved My college theme <strong>1 user</strong> <span>2 hours ago</span>
                            <span class="user-info"> By: john Deo / Date: 2 Aug 2012 / Time:09:27 AM </span>
                          </a>
                          <p><a href="#">This is a much longer one that will go on for a few lines.It has multiple paragraphs and is full of waffle to pad out the comment.</a> </p>
                          
                          </div>
                          <div class="collapse" id="collapse2">
                                    <div class="new-update clearfix"><i class="icon-ok-sign"></i>
                                      <div class="update-done"><a href="#" title=""><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</strong></a> <span>dolor sit amet, consectetur adipiscing eli</span> </div>
                                      <div class="update-date"><span class="update-day">20</span>jan</div>
                                    </div>
                            </div>
                      </li>
                    </ul>
                    
                    
                    <ul class="activity-list">
                    	<li>
                           
                        	<a href="#collapseOne" data-toggle="collapse">
                            <i class="icon-user"></i>
                            <strong>Themeforest</strong>Approved My college theme <strong>1 user</strong> <span>2 hours ago</span>
                        	</a>
                            
                            
                        </li>
                        <li>
                        	<a href="#collapse2" data-toggle="collapse">
                            <i class="icon-user"></i>
                            <strong>Themeforest</strong>Approved My college theme <strong>1 user</strong> <span>2 hours ago</span>
                        	</a>
                            <div class="collapse" id="collapse2">
                            	<div class="widget-content">
                                This box is opened by default
                                </div>
                            </div>
                        </li>
                     </ul>
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
<script language="javascript">
$(document).ready(function(){
    var BookClass = {
        instance: function() {
            var book = {};
            book.thisYear = '<%$thisYear%>';
            book.year = '<%$year%>';
            book.nextYear = '<%$nextYear%>';
            book.thisMonth = '<%$thisMonth%>';
            book.month = '<%$month%>';
            book.monthT = '<%$monthT%>';
            return book;
        },
        setSelectYear: function(year) {
            $('#year').val(year);
        },
        setSelectMonth: function(month) {
            $('#month').val(month);
        }
    }
    var book = BookClass.instance();
    BookClass.setSelectYear(book.year);
    BookClass.setSelectMonth(book.month);
})
</script>
</body>
</html>