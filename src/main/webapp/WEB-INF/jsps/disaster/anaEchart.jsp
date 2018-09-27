<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Invisible Wisdom Missing Tracing System</title>
	<meta name="description" content="无相智慧人口失踪追查系统">
	<meta name="keywords" content="无相智慧人口失踪追查系统">
	<!--视口的 meta 标签，重写了默认的视口。
	width属性设置屏幕宽度，用来告诉浏览器使用原始的分辨率。
	initial-scale 属性是视口最初的比例。当设置为 1.0 时，将呈现设备的原始宽度。-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- icon图标logo -->
	<link rel="shortcut icon" href="img/favicon.ico">		
	<!--Bootstrap css-->
	<link rel="stylesheet" href="<%=path %>/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=path %>/css/docs.min.css">
	<link rel="stylesheet" href="<%=path %>/css/font-awesome.min.css">
	<!--Custom css-->
	<link rel="stylesheet" href="<%=path %>/css/global.css">
	<link rel="stylesheet" href="<%=path %>/css/nav.css">
	</head>
	<body>
	<!--头部导航begin-->
	<c:import url="/common/header.jsp"></c:import>
	<!--内容 begin--> 
	<div class="container-fluid">
		<div class="row">
		   <c:import url="/common/menu.jsp"></c:import>
		    <!--右侧主内容-->
		    <main class="col py-3 bd-content" role="main">
				<div class=" mx-auto py-2">
					<h3 class="mb-3 font-weight-normal text-left pl-4">Analysis chart</h3>
					<button class="btn btn-info btn-sm my-1" onclick="findAll();"><i class="fa fa-pencil mr-1"></i>Details</button>
					<button class="btn btn-info btn-sm my-1" onclick="findAllByVideo();"><i class="fa fa-pencil mr-1"></i>Statistics</button>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
			            <input type="hidden" id="disId" name="disId" value="${disId}">
			            <div id="sexDiv" style="height: 400px;width:500px;display: inline-block;"></div>  
			            <div id="bloodDiv" style="height: 400px;width:500px;margin-left:200px;display:inline-block ;"></div> 
		          	</div>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
			            <input type="hidden" id="disId" name="disId" value="${disId}">
			            <div id="areaDiv" style="height: 400px;width:500px;display: inline-block;"></div>  
			            <div id="shDiv" style="height: 400px;width:500px;margin-left:200px;display:inline-block ;"></div> 
		          	</div>
			    </div>
		        <c:import url="/common/footer.jsp"></c:import>
		    </main>
		</div>
	</div> 
	<!--内容end-->
	
	<!--jquery js-->
	<script type="text/javascript" src="<%=path %>/Scripts/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/Scripts/jquery-form/jquery.form.min.js"></script>
	<!--Bootstrap js-->
	<script type="text/javascript" src="<%=path %>/Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=path %>/Scripts/docs.min.js"></script>
	<!--侧导航隐藏显示-->
    <script type="text/javascript" src="<%=path %>/Scripts/app.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/theme-switcher.min.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/echarts.common.min.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/js/macarons.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/js/shine.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/js/infographic.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/js/essos.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/js/roma.js"></script>
	<!--Custom js-->
	<script type="text/javascript">
		$(document).ready(function(){
			App.livePreview();
		});		
	</script>
	<script type="text/javascript">
	    $(function(){
	    	sexEchart();
	    	bloodEchart();
	    	areaEchart();
	    	shEchart();
	    })
	    
	    function sexEchart(){
	    	var disId = $("#disId").val();
	    	var sexdata = "";
	    	$.ajax({
				async : false,
				type : "POST",
				data:{disId:disId},
				url : "<%=path %>/disaster/statisSex",
				dataType : 'json',
				success : function(data) {
					sexData = data;
				}
			});
	    	var option = {
	    		    title : {
	    		        text: 'Gender analysis',
	    		        subtext: 'Sex ratio',
	    		        x:'center'
	    		    },
	    		    tooltip : {
	    		        trigger: 'item',
	    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    		    },
	    		    legend: {
	    		        orient: 'vertical',
	    		        left: 'left',
	    		        data: ['male','female']
	    		    },
	    		    series : [
	    		        {
	    		            name: 'Sex ratio',
	    		            type: 'pie',
	    		            radius : '55%',
	    		            center: ['50%', '60%'],
	    		            data:sexData,
	    		            itemStyle: {
	    		                emphasis: {
	    		                    shadowBlur: 10,
	    		                    shadowOffsetX: 0,
	    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	    		                }
	    		            }
	    		        }
	    		    ]
	    		};
	    	 var chartOutChar = echarts.init(document.getElementById('sexDiv'),'infographic');
	    	 chartOutChar.setOption(option);
	    }
	    
	    function bloodEchart(){
	    	var disId = $("#disId").val();
	    	var namedata = "";
	    	var valuedata = "";
	    	$.ajax({
				async : false,
				type : "POST",
				data:{disId:disId},
				url : "<%=path %>/disaster/statisBlood",
				dataType : 'json',
				success : function(ret) {
					if (ret.state == "ok") {
						namedata = ret.name;
						valuedata = ret.value;
					}
				}
			});
	    	option = {
	    			title : {
	    		        text: 'Blood analysis',
	    		        subtext: 'Blood type ratio',
	    		        x:'center'
	    		    },
	    		    xAxis: {
	    		        type: 'category',
	    		        data: namedata
	    		    },
	    		    yAxis: {
	    		        type: 'value'
	    		    },
	    		    series: [{
	    		        data: valuedata,
	    		        type: 'bar'
	    		    }]
	    		};
	    	 var chartOutChar = echarts.init(document.getElementById('bloodDiv'),'shine');
	    	 chartOutChar.setOption(option);
	    }
	    
	    function areaEchart(){
	    	var disId = $("#disId").val();
	    	var namedata = "";
	    	var valuedata = "";
	    	$.ajax({
				async : false,
				type : "POST",
				data:{disId:disId},
				url : "<%=path %>/disaster/statisArea",
				dataType : 'json',
				success : function(ret) {
					if (ret.state == "ok") {
						namedata = ret.name;
						valuedata = ret.value;
					}
				}
			});
	    	option = {
	    			title : {
	    		        text: 'Age analysis',
	    		        subtext: 'Age ratio',
	    		        x:'center'
	    		    },
	    		    xAxis: {
	    		    	type: 'category',
	    		        data: namedata
	    		    },
	    		    yAxis: {
	    		        type: 'value'
	    		    },
	    		    series: [{
	    		        data: valuedata,
	    		        type: 'bar'
	    		    }]
	    		};
	    	 var chartOutChar = echarts.init(document.getElementById('areaDiv'),'essos');
	    	 chartOutChar.setOption(option);
	    }
	    
	    function shEchart(){
	    	var disId = $("#disId").val();
	    	var shdata = "";
	    	$.ajax({
				async : false,
				type : "POST",
				data:{disId:disId},
				url : "<%=path %>/disaster/statisSh",
				dataType : 'json',
				success : function(data) {
					shdata = data;
				}
			});
	    	var option = {
	    		    title : {
	    		        text: 'Analysis of the number of injured',
	    		        subtext: 'Proportion of injured',
	    		        x:'center'
	    		    },
	    		    tooltip : {
	    		        trigger: 'item',
	    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    		    },
	    		    legend: {
	    		        orient: 'vertical',
	    		        left: 'left',
	    		        data: ['Not injured','Injured']
	    		    },
	    		    series : [
	    		        {
	    		            name: 'Proportion of injured',
	    		            type: 'pie',
	    		            radius : '55%',
	    		            center: ['50%', '60%'],
	    		            data:shdata,
	    		            itemStyle: {
	    		                emphasis: {
	    		                    shadowBlur: 10,
	    		                    shadowOffsetX: 0,
	    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	    		                }
	    		            }
	    		        }
	    		    ]
	    		};
	    	 var chartOutChar = echarts.init(document.getElementById('shDiv'),'roma');
	    	 chartOutChar.setOption(option);
	    }
	    //查看视频中的分析人物详情
	    function findAll(){
	    	var disId = $("#disId").val();
	    	location.href = "<%=path %>/disaster/findByDisId/"+disId;
	    }
	    //分析灾难中单个视频的统计信息
	    function findAllByVideo(){
	    	var disId = $("#disId").val();
	    	location.href = "<%=path %>/disaster/findAllByVideo/"+disId;
	    }
	</script>
	</body>
</html>