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
				                 	<th scope="col">类别状态</th>
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
				                  	<td><p>${missing.TYPE }</p></td>
				                  	<td><p>${missing.REUSER }</p></td>
				                  	<td><span>${missing.USERSTATE }</span></td>
				                  	<td><span>${missing.INFSTATE }</span></td>
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" onclick="func(${missing.ID})" data-toggle="modal" ><i class="fa fa-eye mr-1"></i>查看</button>
				                  		<c:choose>
				                  			<c:when test="${sessionScope.user.ROLECODE == 'admin'}">
				                  				<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="del(${missing.ID})"><i class="fa fa-minus mr-1"></i>删除</button>
				                  			</c:when>
				                  			<c:otherwise>
				                  				<c:choose>
						                  			<c:when test="${missing.INFSTATE == '待审核' || missing.INFSTATE ==  '待审核未通过'}">
							                  			<button class="btn btn-info btn-sm my-1" onclick="status(${missing.ID})" data-toggle="modal"><i class="fa fa-check mr-1"></i>审核</button>
							                  		</c:when>
							                  		<c:otherwise>	
							                  			<button class="btn btn-info btn-sm my-1" type="button" onclick="ans(${missing.ID})" data-toggle="modal" ><i class="fa fa-gears mr-1"></i>分析</button>
							                  			<button class="btn btn-info btn-sm my-1" type="button" onclick="route(${missing.ID})" data-toggle="modal" ><i class="fa fa-gears mr-1"></i>轨迹</button>
							                  		</c:otherwise>
						                  		</c:choose>
				                  			</c:otherwise>
				                  		</c:choose>
				                  	</td>
			                	</tr>
			                	</c:forEach>
			              	</tbody>
			            </table>
			            <!--页码 pagination-->
						<nav class="mx-3">
		                	<ul class="pagination font-12">
		                		<c:choose>  
					                <c:when test="${missingList.pageNumber>1 }"> 
					                	<li class="page-item"><a class="page-link" href="<%=path%>/missing?p=${missingList.pageNumber-1}" aria-label="Previous"><i class="fa fa-angle-left"></i></a></li>
					                </c:when>  
					                <c:otherwise>  
					                    <li class="page-item"><a class="page-link" href="#"><i class="fa fa-angle-left"></i></a></li>  
					                </c:otherwise>  
					            </c:choose>  
					            <c:forEach var="p" begin="1" end="${missingList.totalPage }">  
					           		<li <c:choose>
					            		<c:when test="${missingList.pageNumber == p}">class="page-item active"</c:when>
					            		<c:otherwise>class="page-item"</c:otherwise>
					            	</c:choose>><a class="page-link" href="<%=path%>/missing?p=${p }">${p }</a></li>
					            </c:forEach>  
					            <c:choose>  
					                <c:when test="${missingList.pageNumber<missingList.totalPage}">
					                	<li class="page-item"><a class="page-link" href="<%=path%>/missing?p=${missingList.pageNumber + 1}" aria-label="Next"><i class="fa fa-angle-right"></i></a></li> 
					                </c:when>  
					                <c:otherwise>  
					                    <li class="page-item"><a class="page-link" href="#"><i class="fa fa-angle-right"></i></a></li>
					                </c:otherwise>  
					            </c:choose>
		                	</ul>
		                </nav> 
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
	<!--失踪者审核弹出框 -->
	<div class="modal fade" id="AllotPower" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-gears mr-1"></i>用户审核</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="misForm" action="/missing/status" method="post">
		      		<input type="hidden" id="stMisId" name="mis.id">
		      		<div class="modal-body">
						<div class="d-block my-3">
							<label class="form-check-label">审核状态：</label>
							<hr />
							<div class="custom-control custom-checkbox custom-control-inline">
				               <input id="statusManage" type="radio" name="mis.status" value="审核通过" class="custom-control-input" >
				               <label for="statusManage" class="custom-control-label">审核通过</label>
				            </div>
				            <div class="custom-control custom-checkbox custom-control-inline">
				               <input id="unstatusManage" type="radio" name="mis.status" value="审核不通过" class="custom-control-input">
				               <label for="unstatusManage" class="custom-control-label" >审核不通过</label>
				            </div>
						</div>	
						<div class="modal-footer">
				      		<button onclick="upStatus();" class="btn btn-info" data-dismiss="modal">确定</button>
				        	<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
				      	</div>				  	
		      		</div>
		      	</form>
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
	
	<!--选择地点信息弹出框 -->
	<div class="modal fade" id="areasModal" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>地点监控列表</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>	
		      	<div class="modal-body text-center font-12">
		      		<input type="hidden" id="videoMisId" name="videoMisId" value="">
					<form id="areasForm" action="" method="post">
					
		      		</form>		      	
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" onclick="findView();" class="btn btn-info" >确定</button>
				    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div> 
	
	<!--监控视频信息弹出框 -->
	<div class="modal fade" id="videosModal" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>视频列表</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>	
		      	<div class="modal-body text-center font-12">
		      		<input type="hidden" id="areaVideoMisId" name="areaVideoMisId" value="">
					<form id="videosForm" action="" method="post">
					
		      		</form>		      	
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" onclick="anasView();" class="btn btn-info" >分析监控</button>
				    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div> 
	
	<!-- 对视频中的截图进行展示 -->
	<div class="modal fade bd-example-modal-lg" id="AnalysisVideo" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	    		<input type="hidden" id="picMisId">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>视频图片</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<div id="picList" class="col">
		        		
		        	</div>
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" onclick="contrast();" class="btn btn-info" data-dismiss="modal"  data-toggle="modal">人物比对</button>
		      		<button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div>
	
	<!-- 开始Waston分析未找到结果页弹出框 -->
	<div class="modal fade  bd-example-modal-lg" id="StartWastonAnalysisNone" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	    		<input type="hidden" id="noMisId">
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
		      		<button type="button" class="btn btn-info" onclick="reFind();" data-dismiss="modal"  data-toggle="modal">重新查找</button>
		      		<button type="button" onclick="upTopub()" class="btn btn-info" >上传公视平台</button>
		      		<button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div>

	<!-- 开始Waston分析已找到结果页弹出框 -->
	<div class="modal fade bd-example-modal-lg" id="StartWastonAnalysisHave" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	    		<input type="hidden" id="misId">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>Waston分析</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<h5 class="text-info">发现地点：</h5>
		        	<p id="videoArea"></p>
		        	<h5 class="text-info">照片对比：</h5>
		        	<div id="videopicList" class="col">
		        		
		        	</div>
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" id="seState"  onclick="toseState();" class="btn btn-info" data-dismiss="modal"  data-toggle="modal">变更状态</button>
		      		<button type="button" id="send"  onclick="toRePer();" class="btn btn-info" data-dismiss="modal"  data-toggle="modal">推送到登记人</button>
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
	<script type="text/javascript" src="<%=path %>/Scripts/js/missing.js"></script>
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

	</body>
</html>