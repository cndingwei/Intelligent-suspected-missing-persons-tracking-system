<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>无相智慧人口登记追查系统</title>
		<meta name="description" content="无相智慧人口登记追查系统">
		<meta name="keywords" content="无相智慧人口登记追查系统">
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
		<link rel="stylesheet" href="<%=path %>/css/bootstrap-datetimepicker.min.css">
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
			<!--左侧导航-->
			<c:import url="/common/menu.jsp"></c:import>
		    <main class="col py-3 bd-content" role="main">
				<div class=" mx-auto py-2">
					<h3 class="mb-3 font-weight-normal text-left">配置监控</h3>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
		          		<button class="btn btn-info btn-md mt-3 mx-3" data-toggle="modal" onclick="add();"><i class="fa fa-plus mr-1"></i>配置新监控</button>
		          		<hr />
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                	<th scope="col">序号</th>
				                  	<th scope="col">监控名称</th>
				                  	<th scope="col">地点</th>
				                  	<th scope="col">参数</th>
				                  	<th scope="col">链接</th>
				                  	<th scope="col">对外端口</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			              		 <c:forEach items="${camaList.list}" var="cama">
			                	<tr>
				                  	<td scope="row">${cama.ID }</td>
				                  	<td><span>${cama.CAMNAME }</span></td>
				                  	<td><span>${cama.ADDRESS }</span></td>
				                  	<td><p>${cama.PARAM}</p></td>
				                  	<td><span>${cama.URL }</span></td> 
				                  	<td><span>${cama.PORT }</span></td>                 	
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" onclick="func(${cama.ID})" data-toggle="modal"><i class="fa fa-pencil mr-1"></i>编辑</button>
				                  		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="del(${cama.ID})"><i class="fa fa-minus mr-1"></i>删除</button>
				                  	</td>
			                	</tr>
			                	</c:forEach>
			             	</tbody>
			            </table>
			            <!--页码 pagination-->
						<nav class="mx-3">
		                	<ul class="pagination font-12">
		                		<c:choose>  
					                <c:when test="${camaList.pageNumber>1 }"> 
					                	<li class="page-item"><a class="page-link" href="<%=path%>/cama?p=${camaList.pageNumber-1}" aria-label="Previous"><i class="fa fa-angle-left"></i></a></li>
					                </c:when>  
					                <c:otherwise>  
					                    <li class="page-item"><a class="page-link" href="#"><i class="fa fa-angle-left"></i></a></li>  
					                </c:otherwise>  
					            </c:choose>  
					            <c:forEach var="p" begin="1" end="${camaList.totalPage }">  
					           		<li <c:choose>
					            		<c:when test="${camaList.pageNumber == p}">class="page-item active"</c:when>
					            		<c:otherwise>class="page-item"</c:otherwise>
					            	</c:choose>><a class="page-link" href="<%=path%>/cama?p=${p }">${p }</a></li>
					            </c:forEach>  
					            <c:choose>  
					                <c:when test="${camaList.pageNumber<camaList.totalPage}">
					                	<li class="page-item"><a class="page-link" href="<%=path%>/cama?p=${camaList.pageNumber + 1}" aria-label="Next"><i class="fa fa-angle-right"></i></a></li> 
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

	<!--添加与更新弹出框 -->
	<div class="modal fade" id="addCamarea" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>配置监控</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="camaForm" action="" method="post">
		      	    <input type="hidden" id="camaId" name="cama.id">
		      	    <div class="modal-body text-center">
					  	<div class="form-group row">
					    	<label for="address" class="col-sm-3 col-form-label col-form-label-sm">所在地点</label>
					    	<div class="col-sm-9">
					      		<input id="address" type="text" name="cama.address" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="camName" class="col-sm-3 col-form-label col-form-label-sm">监控名称</label>
					    	<div class="col-sm-9">
					      		<input id="camName" type="text" name="cama.camname" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="param" class="col-sm-3 col-form-label col-form-label-sm">监控参数</label>
					    	<div class="col-sm-9">
					      		<input id="param" type="text" name="cama.param" class="form-control form-control-sm"  value=" ">
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="url" class="col-sm-3 col-form-label col-form-label-sm">链接</label>
					    	<div class="col-sm-9">
					      		<input id="url" type="text" name="cama.url" class="form-control form-control-sm"  value=" ">
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="port" class="col-sm-3 col-form-label col-form-label-sm">端口号</label>
					    	<div class="col-sm-9">
					      		<input id="port" type="text" name="cama.port" class="form-control form-control-sm"  value=" ">
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="remark" class="col-sm-3 col-form-label col-form-label-sm">备注</label>
					    	<div class="col-sm-9">
					      		<textarea id="remark" name="cama.remark" type="textarea" class="form-control"  value=" "></textarea>
					    	</div>
					  	</div>
				    </div>
			      	<div class="modal-footer">
			      		<button type="submit" class="btn btn-info" >确定</button>
			        	<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
			      	</div>
		      	</form>
	    	</div>
	  	</div>
	</div>
	<!--jquery js-->
	<script type="text/javascript" src="<%=path %>/Scripts/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/Scripts/jquery-form/jquery.form.min.js"></script>
	<!--Bootstrap js-->
	<script type="text/javascript" src="<%=path %>/Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=path %>/Scripts/docs.min.js"></script>
	<script type="text/javascript" src="<%=path %>/Scripts/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<!--侧导航隐藏显示-->
    <script type="text/javascript" src="<%=path %>/Scripts/app.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/theme-switcher.min.js"></script>
	<!--Custom js-->
	<script type="text/javascript">
		$(document).ready(function(){
			App.livePreview();
		});	
		$('.form_datetime').datetimepicker({
	        //language:  'fr',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
	        showMeridian: 1
	    });
	</script>
	<script type="text/javascript">
	$(function(){
		$("#camaForm").ajaxForm({
			dataType: "json", 
			success: function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/cama";
				} else {
					alert(ret.msg);
				}
			}
			, error: function(ret) {alert(ret.msg);}
			, complete: function(ret) {} 	      // 无论是 success 还是 error，最终都会被回调
		});
	})
	//添加弹出框
	function add(){
		$('#camaId').val("");
    	$('#address').val("");
    	$('#camName').val("");
    	$('#param').val("");
    	$('#url').val("");
    	$('#port').val("");
    	$('#remark').val("");
		$("#camaForm").attr('action','/cama/addCama');
		$('#addCamarea').modal('show');
	}
	//编辑弹出框
	function func(id){
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/cama/findById",
			dataType : 'json',
			success : function(data) {
				$('#camaId').val(data.ID);
		    	$('#address').val(data.ADDRESS);
		    	$('#camName').val(data.CAMNAME);
		    	$('#param').val(data.PARAM);
		    	$('#url').val(data.URL);
		    	$('#port').val(data.PORT);
		    	$('#remark').val(data.REMARK);
			}
		});
		$("#camaForm").attr('action','/cama/upCama');
		$('#addCamarea').modal('show');
	}
	//删除数据
	function del(data){
		   if(confirm("是否确认删除")){
			   $.ajax({
					async : false,
					type : "POST",
					data:{id:data},
					url : "<%=path %>/cama/delCama",
					dataType : 'json',
					success : function(ret) {
						if (ret.state == "ok") {
							location.href = "<%=path %>/cama";
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
