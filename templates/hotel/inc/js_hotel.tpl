<script src="<%$__RESOURCE%>js/jquery.min.js"></script>
<script src="<%$__RESOURCE%>js/jquery.ui.custom.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap.min.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap-colorpicker.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap-datepicker.js"></script>
<script src="<%$__RESOURCE%>js/jquery.uniform.js"></script>
<script src="<%$__RESOURCE%>js/select2.min.js"></script>
<script src="<%$__RESOURCE%>js/maruti.js"></script>
<script src="<%$__RESOURCE%>js/maruti.form_common.js"></script>
<script type="text/javascript">
	$("form input,textarea,select").prop("readonly", true);
	$('#cancel_edit_company').hide();
	$('#save_company_info').hide();
	$(document).ready(function(){
		//省
		var xml_data;
		$.ajax({url:"static/area/Area.xml",
			success:function(xml){
				xml_data = xml;
				$(xml).find("province").each(function(){
					var t = $(this).attr("name");//this->
					$("#DropProvince").append("<option>"+t+"</option>");
				});
			},
			error: function(e) {
				alert(e);
			} 
		});
		//市
		$("#DropProvince").change(function(){
			$("#sCity>option").remove();
			$("#DropProvince").next().find('span').text("<%$arrayLaguage['please_select']['page_laguage_value']%>");
			$("#sArea>option").remove();
			$("#sCity").next().find('span').text("<%$arrayLaguage['please_select']['page_laguage_value']%>");
			var pname = $("#DropProvince").val();
			$(xml_data).find("province[name='"+pname+"']>city").each(function(){
				var city = $(this).attr("name");//this->
				$("#sCity").append("<option>"+city+"</option>");
			});
			///查找<city>下的所有第一级子元素(即区域)
			var cname = $("#sCity").val();
			$(xml_data).find("city[name='"+cname+"']>country").each(function(){
				var area = $(this).attr("name");//this->
				$("#sArea").append("<option>"+area+"</option>");
			});
		});
		//区
		$("#sCity").change(function(){
			$("#sArea>option").remove();
			$("#sCity").next().find('span').text("<%$arrayLaguage['please_select']['page_laguage_value']%>");
			var cname = $("#sCity").val();
			$(xml_data).find("city[name='"+cname+"']>country").each(function(){
				var area = $(this).attr("name");//this->
				$("#sArea").append("<option>"+area+"</option>");
			});
		});
		$('#edit_company').click(function(e) {
            $("form input,textarea,select").prop("readonly", false);
			$(this).hide();
			$('#cancel_edit_company').show();
			$('#save_company_info').show();
        });
		$('#cancel_edit_company').click(function(e) {
            $("form input,textarea,select").prop("readonly", true);
			$(this).hide();
			$('#edit_company').show();
			$('#save_company_info').hide();
        });
	});
	
</script>
<script type="text/javascript">
	var map = new BMap.Map("allmap");
	var point = new BMap.Point(116.331398,39.897445);
	map.centerAndZoom(point,11);

	function theLocation(){
		var city = document.getElementById("cityName").value;
		if(city != ""){
			map.centerAndZoom(city,18);      // 用城市名设置地图中心点
		}
	}
	
	function G(id) {
		return document.getElementById(id);
	}
	
	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "cityName"
		,"location" : map
	});
	
	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
	var str = "";
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
		
		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
		G("searchResultPanel").innerHTML = str;
	});
	
	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
	var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		
		setPlace();
	});

	function setPlace(){
		map.clearOverlays();    //清除地图上所有覆盖物
		function myFun(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			map.centerAndZoom(pp, 18);
			marker = new BMap.Marker(pp);
			marker.enableDragging();
			map.addOverlay(marker);    //添加标注
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: myFun
		});
		local.search(myValue);
	}	
	
</script>