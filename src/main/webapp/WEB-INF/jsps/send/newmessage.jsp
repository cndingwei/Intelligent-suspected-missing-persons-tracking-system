<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>无相智慧人口失踪追查系统</title>
	<meta name="description" content="无相智慧人口失踪追查系统">
	<meta name="keywords" content="无相智慧人口失踪追查系统">
	<!--视口的 meta 标签，重写了默认的视口。
	width属性设置屏幕宽度，用来告诉浏览器使用原始的分辨率。
	initial-scale 属性是视口最初的比例。当设置为 1.0 时，将呈现设备的原始宽度。-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- icon图标logo -->
	<link rel="shortcut icon" href="<%=path %>/img/favicon.ico">		
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
			<!--左侧悬浮导航-->
			<c:import url="/common/menu.jsp"></c:import>
		    <!--右侧主内容-->
		    <main class="col py-3 bd-content" role="main">
			    <div class="mx-auto  py-2"> 
			    	<h3 class="mb-3 font-weight-normal text-left pl-4">收到新消息</h3>
					<div class="col alert alert-info" role="alert">
						<h4 class="alert-heading">你好！请查看失踪人员路线轨迹</h4>
						<hr />
						<div class="modal-body">
				        	<h5 class="text-info">路线轨迹：</h5>
				        	<p>
				        		<c:forEach items="${areaList }" var="area">
				        			<span>${area.ADDRESS }</span>--
				        		</c:forEach>
				        	</p>
				        	<h5 class="text-info">照片轨迹：</h5>
				        	<div class="col">
				        		<c:forEach items="${areaList }" var="area">
				        			<figure class="figure">
									   <img src="<%=path %>${area.PICPATH }" height="189" width="129" class="figure-img img-fluid rounded img-thumbnail" >
									   <figcaption class="figure-caption">${area.ADDRESS }</figcaption>
									</figure>
				        		</c:forEach>
				        	</div>
			        	</div>
			        	<hr>
					</div>	
					<c:forEach items="${sendList.list}" var="send">				
					<div class="col alert alert-info" role="alert">
						<h4 class="alert-heading">${send.NAME }你好！${send.TITLE }</h4>
						<hr />
						<div class="modal-body">
				        	<p>${send.CONTENT }</p>
				        	<p>${send.RECTIME }</p>
			        	</div>
			        	<hr>
					</div>	
					</c:forEach>							
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
	<!--Custom js-->
	<script type="text/javascript">
		$(document).ready(function(){
			App.livePreview();
		});		
	</script>
	<script type="text/javascript">
		$(function (){
		
		})
	</script>
	</body>
</html>