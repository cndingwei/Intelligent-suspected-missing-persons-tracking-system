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
		   <c:import url="/common/menu.jsp"></c:import>
		    <!--右侧主内容-->
		    <main class="col py-3 bd-content" role="main">
				<div class=" mx-auto py-2">
					<h3 class="mb-3 font-weight-normal text-left">失踪人口列表</h3>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                  	<th scope="col">失踪人照片</th>
				                  	<th scope="col">失踪人姓名</th>
				                 	<th scope="col">失踪人身份证</th>
				                 	<th scope="col">失踪人电话</th>
				                 	<th scope="col">失踪时间</th>
				                 	<th scope="col">失踪地点</th>
				                 	<th scope="col">登记人</th>
				                 	<th scope="col">失踪状态</th>
				                 	<th scope="col">信息状态</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			                	 <c:forEach items="${missingList.list}" var="missing">
			                	<tr>
				                  	<td>
				                  		<c:choose>
				                  			<c:when test="${missing.PICPATH != null }">
				                  				<img src="<%=path %>${missing.PICPATH}"/>
				                  			</c:when>
				                  			<c:otherwise>
				                  				<img src="/img/photo.png"/>
				                  			</c:otherwise>
				                  		</c:choose>
				                  	</td>
				                  	<td><span>${missing.MIUSER }</span></td>
				                  	<td><span>${missing.USERCODE }</span></td>
				                  	<td><span>${missing.SZTEL }</span></td>
				                  	<td><span>${missing.MISDATE }</span></td>
				                  	<td><p>${missing.ADDRESS }</p></td>
				                  	<td><p>${missing.REUSER }</p></td>
				                  	<td><span>${missing.USERSTATE }</span></td>
				                  	<td><span>${missing.INFSTATE }</span></td>
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" onclick="func(${missing.ID})" data-toggle="modal" ><i class="fa fa-eye mr-1"></i>查看</button>
				                  		<c:choose>
				                  			<c:when test="${missing.INFSTATE == '审核通过' }">
				                  				<button class="btn btn-info btn-sm my-1" type="submit" data-toggle="modal" data-target="#StartWastonAnalysisHave"><i class="fa fa-check mr-1"></i>轨迹</button>
				                  				<button class="btn btn-info btn-sm my-1" onclick="fstatus(${missing.ID})" data-toggle="modal"><i class="fa fa-pencil mr-1"></i>状态</button>
				                  			</c:when>
				                  			<c:otherwise>
				                  				<button class="btn btn-info btn-sm my-1" onclick="finfs(${missing.ID})" data-toggle="modal"><i class="fa fa-check mr-1"></i>审核</button>
				                  			</c:otherwise>
				                  		</c:choose>
				                  		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="del(${missing.ID})"><i class="fa fa-minus mr-1"></i>删除</button>
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

	<!-- 查看详情弹出框 -->
	<div class="modal fade" id="detailsSuccuss" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-newspaper-o mr-1"></i>详细信息</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
					<div class="card mb-4 shadow">
						<div class="card-header bg-danger">
							<img class="card-img-top rounded" id="picpath" src="img/photo1.jpg" alt="Card image cap"   >
						</div>
						<ul class="list-group list-group-flush text-left">
						    <li class="list-group-item">失踪人姓名：<span id="misname"></span></li>
						    <li class="list-group-item">失踪人性别：<span id="sex"></span></li>
						    <li class="list-group-item">失踪人身份证号：<span id="usercode"></span></li>
						    <li class="list-group-item">失踪人电话：<span id="mistell"></span></li>
						    <li class="list-group-item">失踪时间：<span id="misdate"></span></li>
						    <li class="list-group-item">失踪地点：<span id="address"></span></li>
						    <li class="list-group-item">描述：
						    	<p class="card-text" id="content"></p>
						    </li>
						 </ul>
						<div class="card-footer text-white bg-success">
						    <small class="d-block">联系人：<span id="reuser"></span></small>
						    <small class="d-block">联系人电话：<span id="tel"></span></small>
						</div>
					</div>
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" class="btn btn-info" data-dismiss="modal">确定</button>
		      	</div>
	    	</div>
	  	</div>
	</div>
	<!-- 审核通过弹出框 -->
	<div class="modal fade" id="confirmSuccuss" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>提示</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-check text-info mr-1" aria-hidden="true"></i>审核成功！
		      	</div>
		      	<div class="modal-footer">
		        	<button type="button" class="btn btn-info" data-dismiss="modal"   data-toggle="modal" data-target="#StartWastonAnalysisNone">开始Waston分析</button>
		        	<button type="button" class="btn btn-info" data-dismiss="modal">确定</button>
		      	</div>
	    	</div>
	  	</div>
	</div>
	<!-- 开始Waston分析未找到结果页弹出框 -->
	<div class="modal fade  bd-example-modal-lg" id="StartWastonAnalysisNone" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>Waston分析</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-spinner fa-spin text-info mr-1" aria-hidden="true"></i>正在分析请稍等！
		      	</div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-close text-info mr-1" aria-hidden="true"></i>未找到！
		      	</div>
		      	<div class="modal-footer">
		      		<button type="submit" class="btn btn-info" data-dismiss="modal"  data-toggle="modal" data-target="#SendNewsSuccess">推送到登记人</button>
		      		<button type="submit" class="btn btn-info" >继续上传Waston并分析</button>
		      		<button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div>

	<!-- 开始Waston分析已找到结果页弹出框 -->
	<div class="modal fade bd-example-modal-lg" id="StartWastonAnalysisHave" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>Waston分析</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<h5 class="text-info">路线轨迹：</h5>
		        	<p><span>市政府</span>--<span>世纪广场</span>--<span>沁园丹尼斯</span>--<span>交通银行</span>--<span>南蟒河</span></p>
		        	<h5 class="text-info">照片轨迹：</h5>
		        	<div class="col">
		        		<figure class="figure">
						   <img src="img/photo1.jpg" class="figure-img img-fluid rounded img-thumbnail" >
						   <figcaption class="figure-caption">市政府</figcaption>
						</figure>
		        		<figure class="figure">
						   <img src="img/photo1.jpg" class="figure-img img-fluid rounded img-thumbnail" >
						   <figcaption class="figure-caption">世纪广场</figcaption>
						</figure>
		        		<figure class="figure">
						   <img src="img/photo1.jpg" class="figure-img img-fluid rounded img-thumbnail" >
						   <figcaption class="figure-caption">沁园丹尼斯</figcaption>
						</figure>
		        		<figure class="figure">
						   <img src="img/photo1.jpg" class="figure-img img-fluid rounded img-thumbnail" >
						   <figcaption class="figure-caption">交通银行</figcaption>
						</figure>
		        		<figure class="figure">
						   <img src="img/photo1.jpg" class="figure-img img-fluid rounded img-thumbnail" >
						   <figcaption class="figure-caption">南蟒河</figcaption>
						</figure>
		        	</div>
		      	</div>
		      	<div class="modal-footer">
		      		<button type="submit" class="btn btn-info" data-dismiss="modal"  data-toggle="modal" data-target="#SendNewsSuccess">推送到登记人</button>
		      		<button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div>
	<!-- 推送消息成功弹出框 -->
	<div class="modal fade" id="SendNewsSuccess" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>提示</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-check text-info mr-1" aria-hidden="true"></i>推送成功！
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" class="btn btn-info" data-dismiss="modal">确定</button>
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
	<script type="text/javascript" src="<%=path %>/Scripts/theme-switcher.min.js"></script>
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
	//编辑弹出框
	function func(id){
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/missing/findById",
			dataType : 'json',
			success : function(data) {
				var src = "<%=path %>";
				if(data.PICPATH == null){
					src =  src + "/img/photo.png";
				}else{
					src = src + data.PICPATH;
				}
				$('#picpath').attr("src",src);
		    	$('#misname').html(data.MIUSER);
		    	$('#sex').html(data.SEX);
		    	$('#usercode').html(data.USERCODE);
		    	$("#mistell").html(data.SZTEL);
		    	$('#misdate').html(data.MISDATE);
		    	$('#address').html(data.ADDRESS);
		    	$("#content").html(data.CONTENT);
		    	$('#reuser').html(data.REUSER);
		    	$('#tel').html(data.TEL);
			}
		});
		$('#detailsSuccuss').modal('show');
	}
	    
	//审核状态
	function finfs(id){
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/missing/finfs",
			dataType : 'json',
			success : function(ret) {
				if (ret.state == "ok") {
					$('#confirmSuccuss').modal('show');
					location.href = "<%=path %>/missing";
				} else {
					alert(ret.msg);
				}
			}
		});
	}
	
	//删除失踪信息
	function del(id){
		if(confirm("是否删除失踪信息")){
			   $.ajax({
					async : false,
					type : "POST",
					data:{id:id},
					url : "<%=path %>/missing/delMis",
					dataType : 'json',
					success : function(ret) {
						if (ret.state == "ok") {
							$('#DeleteSuccess').modal('show');
							location.href = "<%=path %>/missing";
						} else {
							alert(ret.msg);
						}
					}
				});
		   }else{
			   return false; 
		   }
	}
	</script>
	</body>
</html>