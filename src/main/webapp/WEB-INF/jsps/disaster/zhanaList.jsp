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
				                  	<th scope="col">人员照片</th>
				                  	<th scope="col">姓名</th>
				                 	<th scope="col">身份证</th>
				                 	<th scope="col">性别</th>
				                 	<th scope="col">电话</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			                	 <c:forEach items="${resultList.list}" var="user">
			                	<tr>
				                  	<td>
				                  		<c:choose>
				                  			<c:when test="${user.PICPATH != null }">
				                  				<img src="<%=path %>${user.PICPATH}"/>
				                  			</c:when>
				                  			<c:otherwise>
				                  				<img src="/img/photo.png"/>
				                  			</c:otherwise>
				                  		</c:choose>
				                  	</td>
				                  	<td><span>${user.NAME}</span></td>
				                  	<td><span>${user.USERCODE }</span></td>
				                  	<td><span>${user.SEX }</span></td>
				                  	<td><span>${user.TEL }</span></td>
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" onclick="anaByUserCode('${user.USERCODE}','${user.DISID}')"><i class="fa fa-pencil mr-1"></i>查看对比</button>
				                  	</td>
			                	</tr>
			                	</c:forEach>
			              	</tbody>
			            </table>
		          	</div>
			    </div>
		        <c:import url="/common/footer.jsp"></c:import>
		    </main>
		</div>
	</div> 
	<!--内容end-->

	<!-- 查询照片比对弹出框 -->
	<div class="modal fade bd-example-modal-lg" id="photoModal" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	    		<input type="hidden" id="misId">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>查看比对信息</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<h5 class="text-info">比对信息：</h5>
		        	<div id="picList" class="col">
		        		
		        	</div>
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div>
	
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