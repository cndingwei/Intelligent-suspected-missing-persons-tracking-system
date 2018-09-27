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
					<h3 class="mb-3 font-weight-normal text-left">信息列表</h3>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
		          		<!-- <button class="btn btn-info btn-md mt-3 mx-3" data-toggle="modal" onclick="add();"><i class="fa fa-plus mr-1"></i>新增角色</button>
		          		<hr /> -->
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                  	<th scope="col">失踪人姓名</th>
				                  	<th scope="col">回复主题</th>
				                  	<th scope="col">内容</th>
				                  	<th scope="col">接收人</th>
				                  	<th scope="col">接收时间</th>
				                  	<th scope="col">消息状态</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			              		 <c:forEach items="${messageList.list}" var="message">
			                	<tr>
				                  	<td scope="row"><span>${message.MIUSER }</span></td>
				                  	<td><span>${message.TITLE }</span></td>
				                  	<td><p>${message.CONTENT }</p></td>
				                  	<td><span>${message.REUSER }</span></td>
				                  	<td><span>${message.SENDTIME }</span></td>
				                  	<td><span>${message.ISREAD }</span></td>
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="del(${message.ID})"><i class="fa fa-minus mr-1"></i>删除</button>
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
	
	<!--新增角色弹出框 -->
	<div class="modal fade" id="AddRoles" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>角色表单</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="roleForm" action="" method="post">
		      	    <input type="hidden" id="roleId" name="role.id" value="">
		      	    <div class="modal-body text-center">
					  	<div class="form-group row">
					    	<label for="RoleName" class="col-sm-3 col-form-label col-form-label-sm">角色名称</label>
					    	<div class="col-sm-9">
					      		<input id="RoleName" type="text" name="role.name" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="RoleCode" class="col-sm-3 col-form-label col-form-label-sm">角色编号</label>
					    	<div class="col-sm-9">
					      		<input id="RoleCode" type="text" name="role.code" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="RoleRemark" class="col-sm-3 col-form-label col-form-label-sm">描述</label>
					    	<div class="col-sm-9">
					      		<textarea id="RoleRemark" name="role.remark" type="textarea" class="form-control"  value=" "></textarea>
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
	
	<!--分配权限弹出框 -->
	<div class="modal fade" id="AllotPower" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-gears mr-1"></i>分配权限</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body">
		        	<form>
						<div class="d-block my-3">
							<label class="form-check-label">系统管理：</label>
							<hr />
							<div class="custom-control custom-checkbox custom-control-inline">
				               <input id="roleMenuManage" type="checkbox" class="custom-control-input" >
				               <label for="roleMenuManage" class="custom-control-label">菜单管理</label>
				            </div>
				            <div class="custom-control custom-checkbox custom-control-inline">
				               <input id="roleRoleManage" type="checkbox" class="custom-control-input">
				               <label for="roleRoleManage" class="custom-control-label" >角色管理</label>
				            </div>
				            <div class="custom-control custom-checkbox custom-control-inline">
				               <input id="roleAccountManage" type="checkbox" class="custom-control-input">
				               <label for="roleAccountManage" class="custom-control-label" >账号管理</label>
				            </div>
				            <div class="custom-control custom-checkbox custom-control-inline">
				               <input id="rolePersonNews" type="checkbox" class="custom-control-input">
				               <label for="rolePersonNews" class="custom-control-label" >人员基础信息</label>
				            </div>
						</div>					  	
					</form>
		      	</div>
		      	<div class="modal-footer">
		      		<button type="submit" class="btn btn-info" data-dismiss="modal">确定</button>
		        	<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		      	</div>
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
		$("#roleForm").ajaxForm({
			dataType: "json", 
			success: function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/role";
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
		$("#roleForm").attr('action','/role/addRole');
		$('#AddRoles').modal('show');
	}
	//编辑弹出框
	function func(id){
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/role/findById",
			dataType : 'json',
			success : function(data) {
				$('#roleId').val(data.ID);
		    	$('#RoleName').val(data.NAME);
		    	$('#RoleCode').val(data.CODE);
		    	$('#RoleRemark').val(data.REMARK);
			}
		});
		$("#roleForm").attr('action','/role/upRole');
		$('#AddRoles').modal('show');
	}
	//删除数据
	function del(data){
		   if(confirm("是否确认删除")){
			   $.ajax({
					async : false,
					type : "POST",
					data:{id:data},
					url : "<%=path %>/role/delRole",
					dataType : 'json',
					success : function(ret) {
						if (ret.state == "ok") {
							$('#DeleteSuccess').modal('show');
							location.href = "<%=path %>/role";
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
