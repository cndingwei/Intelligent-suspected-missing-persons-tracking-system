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
					<h3 class="mb-3 font-weight-normal text-left">人员信息库管理</h3>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
		          		<button class="btn btn-info btn-md mt-3 mx-3" data-toggle="modal" onclick="add();"><i class="fa fa-plus mr-1"></i>新增人员信息</button>
		          		<hr />
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                  	<th scope="col">序号</th>
				                  	<th scope="col">姓名</th>
				                  	<th scope="col">身份证号</th>
				                  	<th scope="col">性别</th>
				                  	<th scope="col">家庭住址</th>
				                  	<th scope="col">联系方式</th>
				                  	<th scope="col">照片</th>
				                  	<th scope="col">生日</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			              		 <c:forEach items="${userLibraryList.list}" var="userLibrary">
			                	<tr>
				                  	<td scope="row">${userLibrary.ID }</td>
				                  	<td><span>${userLibrary.NAME }</span></td>
				                  	<td><span>${userLibrary.USERCODE }</span></td>
				                  	<td><span>${userLibrary.SEX }</span></td>
				                  	<td><span>${userLibrary.ADDR }</span></td>
				                  	<td><span>${userLibrary.TEL }</span></td>
				                  	<td><span>${userLibrary.PICPATH }</span></td>
				                  	<td><span>${userLibrary.BIRTY }</span></td>
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" onclick="func(${userLibrary.ID})" data-toggle="modal"><i class="fa fa-pencil mr-1"></i>编辑</button>
				                  		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="del(${userLibrary.ID})"><i class="fa fa-minus mr-1"></i>删除</button>
				                  	</td>
			                	</tr>
			                	</c:forEach>
			             	</tbody>
			            </table>
			            <!--页码 pagination-->
						<nav class="mx-3">
		                	<ul class="pagination font-12">
		                		<c:choose>  
					                <c:when test="${userLibraryList.pageNumber>1 }"> 
					                	<li class="page-item"><a class="page-link" href="<%=path%>/userLibrary?p=${userLibraryList.pageNumber-1}" aria-label="Previous"><i class="fa fa-angle-left"></i></a></li>
					                </c:when>  
					                <c:otherwise>  
					                    <li class="page-item"><a class="page-link" href="#"><i class="fa fa-angle-left"></i></a></li>  
					                </c:otherwise>  
					            </c:choose>  
					            <c:forEach var="p" begin="1" end="${userLibraryList.totalPage }">  
					           		<li <c:choose>
					            		<c:when test="${userLibraryList.pageNumber == p}">class="page-item active"</c:when>
					            		<c:otherwise>class="page-item"</c:otherwise>
					            	</c:choose>><a class="page-link" href="<%=path%>/userLibrary?p=${p }">${p }</a></li>
					            </c:forEach>  
					            <c:choose>  
					                <c:when test="${userLibraryList.pageNumber<userLibraryList.totalPage}">
					                	<li class="page-item"><a class="page-link" href="<%=path%>/userLibrary?p=${userLibraryList.pageNumber + 1}" aria-label="Next"><i class="fa fa-angle-right"></i></a></li> 
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
	
	<!--新增人口信息库弹出框 -->
	<div class="modal fade" id="AddUserLibrarys" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>人口信息库表单</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="userLibraryForm" action="" method="post" enctype="multipart/form-data">
		      	    <input type="hidden" id="UserLibraryId" name="userLibrary.id" value="">
		      	    <div class="modal-body text-center">
					  	<div class="form-group row">
					    	<label for="UserLibraryName" class="col-sm-3 col-form-label col-form-label-sm">姓名</label>
					    	<div class="col-sm-9">
					      		<input id="UserLibraryName" type="text" name="userLibrary.name" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserLibraryUserCode" class="col-sm-3 col-form-label col-form-label-sm">身份证号</label>
					    	<div class="col-sm-9">
					      		<input id="UserLibraryUserCode" type="text" name="userLibrary.usercode" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserLibrarySex" class="col-sm-3 col-form-label col-form-label-sm">性别</label>
					    	<div class="col-sm-9" id="UserSex">
								<div class="custom-control custom-radio custom-control-inline">
									<input id="UserLibrarySex01" class="custom-control-input" type="radio" name="userLibrary.sex" value="男" checked />
									<label for="UserLibrarySex01" class="custom-control-label">男</label>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input id="UserLibrarySex02" class="custom-control-input" type="radio" name="userLibrary.sex" value="女"  />
									<label for="UserLibrarySex02" class="custom-control-label"> 女</label>
								</div>					    	
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserLibraryAddr" class="col-sm-3 col-form-label col-form-label-sm">家庭住址</label>
					    	<div class="col-sm-9">
					      		<input id="UserLibraryAddr" type="text" name="userLibrary.addr" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserLibraryTel" class="col-sm-3 col-form-label col-form-label-sm">联系方式</label>
					    	<div class="col-sm-9">
					      		<input id="UserLibraryTel" type="text" name="userLibrary.tel" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserLibraryBirty" class="col-sm-3 col-form-label col-form-label-sm">出生日期</label>
					    	<div class="col-sm-9">
					      		<input id="UserLibraryBirty" name="userLibrary.birty" type="date" class="form-control form-control-md" >
					    	</div>
					  	</div>
						<div class="form-group row">
					    	<label for="UserLibraryBirty" class="col-sm-3 col-form-label col-form-label-sm">照片信息</label>
					    	<div class="col-sm-9">
					    		<input type="file" name="imageName" id="imageFile" class="form-control-file btn float-center">
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserLibraryRemark" class="col-sm-3 col-form-label col-form-label-sm">备注</label>
					    	<div class="col-sm-9">
					      		<textarea id="UserLibraryRemark" name="userLibrary.remark" type="textarea" class="form-control"  value=" "></textarea>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserLibraryAddr" class="col-sm-3 col-form-label col-form-label-sm">关系人证件号</label>
					    	<div class="col-sm-4">
					    		<input type="hidden" id="fartherId" name="userLibrary.fartherid">
					      		<input id="userReal" type="text" name="userRral" class="form-control form-control-sm"  value=" " onblur="findUserLibr();">
					      		<span id="realName"></span>
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

	<!-- 删除成功弹出框 -->
	<div class="modal fade" id="DeleteSuccess" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>提示</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-check text-info mr-1" aria-hidden="true"></i>删除成功！
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
	$(function(){
		$("#userLibraryForm").ajaxForm({
			dataType: "json", 
			success: function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/userLibrary";
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
		$("#userLibraryForm").attr('action','/userLibrary/addUserLibrary');
		$('#AddUserLibrarys').modal('show');
	}
	//编辑弹出框
	function func(id){
		$("#userReal").val("");
		$("#realName").html();
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/userLibrary/findById",
			dataType : 'json',
			success : function(data) {
				$('#UserLibraryId').val(data.ID);
		    	$('#UserLibraryName').val(data.NAME);
		    	$('#UserLibraryUserCode').val(data.USERCODE);
		    	$('#UserLibrarySex').val(data.SEX);
		    	$('#UserLibraryAddr').val(data.ADDR);
		    	$('#UserLibraryTel').val(data.TEL);
		    	$('#UserLibraryPicPath').val(data.PICPATH);
		    	$('#UserLibraryBirty').val(data.BIRTY);
		    	$('#UserLibraryFartherId').val(data.FARTHER_ID);
		    	$('#UserLibraryMotherId').val(data.MOTHER_ID);
		    	$('#UserLibraryRemark').val(data.REMARK);
		    	$('#UserLibraryCreateTime').val(data.CREATETIME);
			}
		});
		$("#userLibraryForm").attr('action','/userLibrary/upUserLibrary');
		$('#AddUserLibrarys').modal('show');
	}
	//删除数据
	function del(data){
		   if(confirm("是否确认删除")){
			   $.ajax({
					async : false,
					type : "POST",
					data:{id:data},
					url : "<%=path %>/userLibrary/delRole",
					dataType : 'json',
					success : function(ret) {
						if (ret.state == "ok") {
							$('#DeleteSuccess').modal('show');
							location.href = "<%=path %>/userLibrary";
						} else {
							alert(ret.msg);
						}
					}
				});
		   }else{
			   return false; 
		   }
	   }
	//查询联系人信息
	function findUserLibr(){
		var userReal = $("#userReal").val();
		if(userReal == ""){
			return false;
		}
		$.ajax({
			async : false,
			type : "POST",
			data:{code:userReal},
			url : "<%=path %>/userLibrary/relation",
			dataType : 'json',
			success : function(ret) {
				if(ret == null){
					$("#realName").html("没有该人员信息");
				}else{
					$("#fartherId").val(ret.ID);
					$("#realName").html(ret.NAME);
				}
			}
		});
	}
	</script>
	</body>
</html>
