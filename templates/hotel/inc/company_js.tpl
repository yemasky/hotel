<!--<script src="<%$__RESOURCE%>js/jquery.ui.custom.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap.min.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap-colorpicker.js"></script>
<script src="<%$__RESOURCE%>js/bootstrap-datepicker.js"></script>
<script src="<%$__RESOURCE%>js/jquery.uniform.js"></script>
<script src="<%$__RESOURCE%>js/select2.min.js"></script>
<script src="<%$__RESOURCE%>js/maruti.js"></script>
<script src="<%$__RESOURCE%>js/maruti.form_common.js"></script>-->
<script src="<%$__RESOURCE%>js/jquery.validate.js"></script>
<script src="<%$__RESOURCE%>js.model/company.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//省
		var xml_data;
		$.ajax({url:"static/area/Area.xml",
			success:function(xml){
				xml_data = xml;
				$(xml).find("province").each(function(){
					var t = $(this).attr("name");//this->
					$("#company_province").append("<option value='"+t+"'>"+t+"</option>");
				});
			},
			error: function(e) {
				alert(e);
			} 
		});
		//市
		$("#company_province").change(function(){
			$("#company_city>option").remove();
			$("#company_province").next().find('span').text("<%$arrayLaguage['please_select']['page_laguage_value']%>");
			$("#company_town>option").remove();
			$("#company_city").next().find('span').text("<%$arrayLaguage['please_select']['page_laguage_value']%>");
			var pname = $("#company_province").val();
			$(xml_data).find("province[name='"+pname+"']>city").each(function(){
				var city = $(this).attr("name");//this->
				$("#company_city").append("<option value='"+city+"'>"+city+"</option>");
			});
			///查找<city>下的所有第一级子元素(即区域)
			var cname = $("#company_city").val();
			$(xml_data).find("city[name='"+cname+"']>country").each(function(){
				var area = $(this).attr("name");//this->
				$("#company_town").append("<option value='"+area+"'>"+area+"</option>");
			});
		});
		//区
		$("#company_city").change(function(){
			$("#company_town>option").remove();
			$("#company_city").next().find('span').text("<%$arrayLaguage['please_select']['page_laguage_value']%>");
			var cname = $("#company_city").val();
			$(xml_data).find("city[name='"+cname+"']>country").each(function(){
				var area = $(this).attr("name");//this->
				$("#company_town").append("<option value='"+area+"'>"+area+"</option>");
			});
		});
	});
	
</script>
<script type="text/javascript">
	var map = new BMap.Map("allmap");
	var point = new BMap.Point(121.480174,31.236428);
	map.centerAndZoom(point,11);
	function myLocation(result){
		var cityName = result.name;
		map.setCenter(cityName);
		//alert("当前定位城市:"+cityName);
	}
	var myCity = new BMap.LocalCity();
	myCity.get(myLocation);
	
	function theLocation(){
		var city = document.getElementById("company_address").value;
		if(city != ""){
			map.centerAndZoom(city,18);      // 用城市名设置地图中心点
		}
	}
	
	function G(id) {
		return document.getElementById(id);
	}
	
	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "company_address"
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
		function mySetMap(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			map.centerAndZoom(pp, 18);
			marker = new BMap.Marker(pp);
			marker.enableDragging();
			map.addOverlay(marker);    //添加标注
			alert(pp.lng);
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: mySetMap
		});
		local.search(myValue);
	}	

</script>