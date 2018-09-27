<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
					<h3 class="mb-3 font-weight-normal text-left">分析列表</h3>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                 	<th scope="col">灾难监控发生地</th>
				                 	<th scope="col">视频总人数</th>
				                 	<th scope="col">男性人数</th>
				                 	<th scope="col">女性人数</th>
				                 	<th scope="col">血型A人数</th>
				                 	<th scope="col">血型B人数</th>
				                 	<th scope="col">血型AB人数</th>
				                 	<th scope="col">血型O人数</th>
				                 	<th scope="col">受伤总人数</th>
				                 	<th scope="col">轻伤人数</th>
				                 	<th scope="col">重伤人数</th>
				                 	<th scope="col">已救援人数</th>
				                 	<th scope="col">死亡人数</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			                	 <c:forEach items="${resultList.list}" var="user">
			                	<tr>
				                  	<td><span>${user.VIDEONAME }</span></td>
				                  	<td><span>${user.COUNT }</span></td>
				                  	<td><span>${user.MCOUNT }</span></td>
				                  	<td><span>${user.WMCOUNT }</span></td>
				                  	<td><span>${user.ACOUNT }</span></td>
				                  	<td><span>${user.BCOUNT }</span></td>
				                  	<td><span>${user.ABCOUNT }</span></td>
				                  	<td><span>${user.OCOUNT }</span></td>
				                  	<td><span>${user.SHCOUNT }</span></td>
				                  	<td><span>${user.QSCOUNT }</span></td>
				                  	<td><span>${user.ZSCOUNT }</span></td>
				                  	<td><span>${user.ALRCOUNT }</span></td>
				                  	<td><span>${user.DIECOUNT }</span></td>
				                  	<td>
				                  		<a class="btn btn-info btn-sm my-1" href="#"><i class="fa fa-pencil mr-1"></i>查看详情</a>
				                  	</td>
			                	</tr>
			                	</c:forEach>
			              	</tbody>
			            </table>
			            
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                 	<th scope="col">灾难名称</th>
				                 	<th scope="col">总人数</th>
				                 	<th scope="col">男性人数</th>
				                 	<th scope="col">女性人数</th>
				                 	<th scope="col">血型A人数</th>
				                 	<th scope="col">血型B人数</th>
				                 	<th scope="col">血型AB人数</th>
				                 	<th scope="col">血型O人数</th>
				                 	<th scope="col">受伤总人数</th>
				                 	<th scope="col">轻伤人数</th>
				                 	<th scope="col">重伤人数</th>
				                 	<th scope="col">已救援人数</th>
				                 	<th scope="col">死亡人数</th>
				                 	<th scope="col">救援团队</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			                	<tr>
				                  	<td><span>${record.DNAME }</span></td>
				                  	<td><span>${record.COUNT }</span></td>
				                  	<td><span>${record.MCOUNT }</span></td>
				                  	<td><span>${record.WMCOUNT }</span></td>
				                  	<td><span>${record.ACOUNT }</span></td>
				                  	<td><span>${record.BCOUNT }</span></td>
				                  	<td><span>${record.ABCOUNT }</span></td>
				                  	<td><span>${record.OCOUNT }</span></td>
				                  	<td><span>${record.SHCOUNT }</span></td>
				                  	<td><span>${record.QSCOUNT }</span></td>
				                  	<td><span>${record.ZSCOUNT }</span></td>
				                  	<td><span>${user.ALRCOUNT }</span></td>
				                  	<td><span>${user.DIECOUNT }</span></td>
				                  	<td><span>${user.RECUNAME }</span></td>
				                  	<td>
				                  		<a class="btn btn-info btn-sm my-1" href="<%=path %>/disaster/findEchartByDisId/${record.ID }"><i class="fa fa-pencil mr-1"></i>查看分析详情</a>
				                  	</td>
			                	</tr>
			              	</tbody>
			            </table>
			             <!--页码 pagination-->
						<nav class="mx-3">
		                	<ul class="pagination font-12">
		                		<c:choose>  
					                <c:when test="${resultList.pageNumber>1 }"> 
					                	<li class="page-item"><a class="page-link" href="<%=path%>/disaster/findAllByVideo?p=${resultList.pageNumber-1}" aria-label="Previous"><i class="fa fa-angle-left"></i></a></li>
					                </c:when>  
					                <c:otherwise>  
					                    <li class="page-item"><a class="page-link" href="#"><i class="fa fa-angle-left"></i></a></li>  
					                </c:otherwise>  
					            </c:choose>  
					            <c:forEach var="p" begin="1" end="${resultList.totalPage }">  
					           		<li <c:choose>
					            		<c:when test="${resultList.pageNumber == p}">class="page-item active"</c:when>
					            		<c:otherwise>class="page-item"</c:otherwise>
					            	</c:choose>><a class="page-link" href="<%=path%>/disaster/findAllByVideo?p=${p }">${p }</a></li>
					            </c:forEach>  
					            <c:choose>  
					                <c:when test="${resultList.pageNumber<resultList.totalPage}">
					                	<li class="page-item"><a class="page-link" href="<%=path%>/disaster/findAllByVideo?p=${resultList.pageNumber + 1}" aria-label="Next"><i class="fa fa-angle-right"></i></a></li> 
					                </c:when>  
					                <c:otherwise>  
					                    <li class="page-item"><a class="page-link" href="#"><i class="fa fa-angle-right"></i></a></li>
					                </c:otherwise>  
					            </c:choose>
		                	</ul>
		                </nav>
		          	</div>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
			            
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
	<!--Custom js-->
	<script type="text/javascript">
		$(document).ready(function(){
			App.livePreview();
		});		
	</script>
	<script type="text/javascript">
		function anaByUserCode(code,disId){
			$.ajax({
				async : false,
				type : "POST",
				data:{code:code,disId:disId},
				url : "<%=path %>/disaster/anaByUserCode",
				dataType : 'json',
				success : function(data) {
					if(data.length > 0){
						var picHtml = "";
						for(var i = 0;i<data.length;i++){
							picHtml = picHtml + "<figure class=\"figure\"><img src=\""+<%=path %>data[i].PICTURE+"\" height=\"189\" width=\"129\" class=\"figure-img img-fluid rounded img-thumbnail\" >"+
							   "<figcaption class=\"figure-caption\"> 分数："+data[i].SCORE+"</figcaption></figure>"
						}
						$("#picList").html(picHtml);
					}
				}
			});
			$("#photoModal").modal("show");
		}
	</script>
	</body>
</html>