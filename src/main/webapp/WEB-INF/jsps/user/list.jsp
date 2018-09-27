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
					<h3 class="mb-3 font-weight-normal text-left">用户管理列表</h3>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
		          		<button class="btn btn-info btn-md mt-3 mx-3" data-toggle="modal" onclick="add();"><i class="fa fa-plus mr-1"></i>新增用户</button>
		          		<hr />
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                  	<th scope="col">角色名称</th>
				                  	<th scope="col">用户姓名</th>
				                  	<th scope="col">身份证号</th>
				                  	<th scope="col">手机号码</th>
				                  	<th scope="col">类型</th>
				                  	<th scope="col">审核状态</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			              		 <c:forEach items="${userList.list}" var="user">
			                	<tr>
				                  	<td scope="row">${user.ROLENAME }</td>
				                  	<td><span>${user.NAME }</span></td>
				                  	<td><span>${user.USERCODE }</span></td>
				                  	<td><span>${user.TEL }</span></td>                  	
				                  	<td><span>${user.TYPE }</span></td>
				                  	<td><span>${user.STATUS }</span></td>
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" onclick="func(${user.ID})" data-toggle="modal"><i class="fa fa-pencil mr-1"></i>编辑</button>
				                		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="status(${user.ID})"><i class="fa fa-gears mr-1"></i>用户审核</button>
				                		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="toRole(${user.ID})"><i class="fa fa-gears mr-1"></i>分配角色</button>
				                  		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="del(${user.ID})"><i class="fa fa-minus mr-1"></i>删除</button>
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

	

	<!--新增用户弹出框 -->
	<div class="modal fade" id="AddUsers" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>用户表单</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="userForm" action="" method="post">
		      	    <input type="hidden" id="userId" name="user.id">
		      	    <div class="modal-body text-center">
					  	<div class="form-group row">
					    	<label for="UserName" class="col-sm-3 col-form-label col-form-label-sm">姓名</label>
					    	<div class="col-sm-9">
					      		<input id="UserName" type="text" name="user.name" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserUsercode" class="col-sm-3 col-form-label col-form-label-sm">身份证号</label>
					    	<div class="col-sm-9">
					      		<input id="UserUsercode" type="text" name="user.usercode" class="form-control form-control-sm"  value=" " required >
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserTel" class="col-sm-3 col-form-label col-form-label-sm">联系方式</label>
					    	<div class="col-sm-9">
					      		<input id="UserTel" type="text" name="user.tel" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserTel" class="col-sm-3 col-form-label col-form-label-sm">用户类型</label>
					    	<div class="col-sm-9">
					      		 <input id="org" type="radio" name="user.type" value="组织">
				                 <label for="org" class="custom-control-label">组织</label>
				                 <input id="per" type="radio" name="user.type" value="个人" >
				                 <label for="per" class="custom-control-label">个人</label>
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
	
	<!--用户审核弹出框 -->
	<div class="modal fade" id="AllotPower" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-gears mr-1"></i>用户审核</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="statusForm" action="/user/status" method="post">
		      		<input type="hidden" id="stUserId" name="user.id">
		      		<div class="modal-body">
						<div class="d-block my-3">
							<label class="form-check-label">审核状态：</label>
							<hr />
							<div class="custom-control custom-checkbox custom-control-inline">
				               <input id="roleMenuManage" type="radio" name="user.status" value="1" class="custom-control-input" >
				               <label for="roleMenuManage" class="custom-control-label">通过审核</label>
				            </div>
				            <div class="custom-control custom-checkbox custom-control-inline">
				               <input id="roleRoleManage" type="radio" name="user.status" value="2" class="custom-control-input">
				               <label for="roleRoleManage" class="custom-control-label" >审核不通过</label>
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
	
	<!--用户角色分配 -->
	<div class="modal fade" id="rolePower" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-gears mr-1"></i>角色分配</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="statusForm" action="/user/status" method="post">
		      		<input type="hidden" id="roUserId" name="user.id">
		      		<div class="modal-body">
						<div id="roleList" class="d-block my-3">

						</div>	
						<div class="modal-footer">
				      		<button onclick="saveRole();" class="btn btn-info" data-dismiss="modal">确定</button>
				        	<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
				      	</div>				  	
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
		$("#userForm").ajaxForm({
			dataType: "json", 
			success: function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/user";
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
		$('#userId').val("");
    	$('#UserName').val("");
    	$('#UserUsercode').val("");
    	$('#UserUsercode').removeAttr("readonly");
    	$('#UserTel').val("");
		$("#userForm").attr('action','/user/addUser');
		$('#AddUsers').modal('show');
	}
	//编辑弹出框
	function func(id){
		var userId = "";
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/user/findById",
			dataType : 'json',
			success : function(data) {
				userId = data.ID;
				$('#userId').val(data.ID);
		    	$('#UserName').val(data.NAME);
		    	$('#UserUsercode').val(data.USERCODE);
		    	$('#UserUsercode').attr("readonly","readonly");
		    	$('#UserTel').val(data.TEL);
		    	if(data.TYPE == "组织"){
		    		$("#org").attr("checked","checked");
		    	}else{
		    		$("#per").attr("checked","checked");
		    	}
			}
		});
		$("#userForm").attr('action','/user/upUser/'+ userId );
		$('#AddUsers').modal('show');
	}
	//删除数据
	function del(data){
		   if(confirm("是否确认删除")){
			   $.ajax({
					async : false,
					type : "POST",
					data:{id:data},
					url : "<%=path %>/user/delUser",
					dataType : 'json',
					success : function(ret) {
						if (ret.state == "ok") {
							$('#DeleteSuccess').modal('show');
							location.href = "<%=path %>/user";
						} else {
							alert(ret.msg);
						}
					}
				});
		   }else{
			   return false; 
		   }
	   }
	//审核用户 
	function status(id){
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/user/findById",
			dataType : 'json',
			success : function(data) {
				$('#stUserId').val(data.ID);
				if(data.STATUS == 2){
					$("#roleRoleManage").attr("checked","checked");
				}else{
					$("#roleMenuManage").attr("checked","checked");
				}
			}
		});
		$('#AllotPower').modal('show');
	}
	//审核用户提交
	function upStatus(){
		var userId = $("#stUserId").val();
		var status = $('input:radio[name="user.status"]:checked').val();
		$.ajax({
			async : false,
			type : "POST",
			data:{userId:userId,status:status},
			url : "<%=path %>/user/status",
			dataType : 'json',
			success : function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/user";
				} else {
					alert(ret.msg);
				}
			}
		});
	}
	//分配角色弹出框
	function toRole(id){
		$('#roUserId').val(id);
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/user/findRoleById",
			dataType : 'json',
			success : function(data) {
				var html = "<label class=\"form-check-label\">角色名称：</label><hr />";
				if(data.length == 0)
					return false;
				for(var i = 0;i<data.length;i++){
					html = html + "<div class=\"custom-control custom-checkbox custom-control-inline\">";
		            html = html + "<input id= \""+data[i].ID + data[i].NAME+"\" type=\"radio\" name=\"userole\" value=\""+data[i].ID+"\" class=\"custom-control-input\" ";
		            if(data[i].STATUS == 1){
		            	html = html + "checked=\"checked\"";
		            }
		            html = html + "><label for=\""+data[i].ID + data[i].NAME+"\" class=\"custom-control-label\">"+data[i].NAME+"</label></div>";
				}
				$("#roleList").html(html);
			}
		});
		$('#rolePower').modal('show');
	}
	//对分配的角色进行保存
	function saveRole(){
		var userId = $("#roUserId").val();
		var roleId = $('input:radio[name="userole"]:checked').val();
		if(roleId == ""){
			alert("请选择相应的角色");
			return false;
		}
		$.ajax({
			async : false,
			type : "POST",
			data:{userId:userId,roleId:roleId},
			url : "<%=path %>/user/saveRole",
			dataType : 'json',
			success : function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/user";
				} else {
					alert(ret.msg);
				}
			}
		});
	}
	</script>
	</body>
</html>
