<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
<link rel="stylesheet" href="<%$__RESOURCE%>css/tree.style.min.css" />
<script src="<%$__RESOURCE%>js/jstree.min.js"></script>
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
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
             <span class="icon"><i class="icon-th"></i></span> 
            <h5><%$arrayLaguage['hotel_department_manage']['page_laguage_value']%></h5>
          </div>
          <div class="widget-title">
            <ul class="nav nav-tabs">
                <li class="active" id="rooms_layout_setting"><a data-toggle="tab" href="#tab1"><%$arrayLaguage['hotel_department_manage']['page_laguage_value']%></a></li>
                <li id="room_layout_attr"><a data-toggle="tab" href="#tab2"><%$arrayLaguage['department_role_setting']['page_laguage_value']%></a></li>
            </ul>
        </div>
          <div class="widget-content tab-content">
           <div id="tab1" class="tab-pane active">
            <h1>HTML demo</h1>
                <div id="html" class="demo">
                    <ul>
                        <li data-jstree='{ "opened" : true }'>Root node
                            <ul>
                                <li data-jstree='{ "selected" : true }'>Child node 1</li>
                                <li>Child node 2</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            
                <h1>Inline data demo</h1>
                <div id="data" class="demo"></div>
            
                <h1>Data format demo</h1>
                <div id="frmt" class="demo"></div>
           </div>
    	   <div id="tab2" class="tab-pane">
              
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
<script>
	// html demo
	$('#html').jstree();

	// inline data demo
	$('#data').jstree({
		'core' : {
			'data' : [
				  { "text" : "Root node", 
				    "state" : { "opened" : true },
				    "children" : [
						{ "text" : "Child node 1" },
						{ "text" : "Child node 2" }
				   ]
				  }
			    ],
			'themes' : {
							'responsive' : false,
							'variant' : 'small',
							'stripes' : true
						}
		}
	});

	// data format demo
	$('#frmt').jstree({
		'core' : {
			'data' : [
				{
					"text" : "Root node",
					"state" : { "opened" : true },
					"children" : [
						{
							"text" : "Child node 1",
							"state" : { "selected" : true },
							"icon" : "jstree-file"
						},
						{ "text" : "Child node 2", "state" : { "disabled" : true } }
					]
				}
			]
		}
	});
</script>
</body>
</html>