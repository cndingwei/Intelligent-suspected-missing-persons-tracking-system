<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>、
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js fixed-layout">
<head>
  <head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
	<link rel="stylesheet" href="<%=path %>/css/font-awesome.min.css">
	<!--Custom css-->
	<link rel="stylesheet" href="<%=path %>/css/global.css">
	<link rel="stylesheet" href="<%=path %>/css/signin.css">
	</head>
	<body class="centerbody">
	<!--内容main begin-->
	<div class="main container-fluid">
	    <form class="form-signin needs-validation" method="post" action="/login" novalidate>
			<h1 class="h2 mb-4 text-info">无相智慧人口失踪追查系统</h1>
			<h2 class="h3 mb-3 font-weight-normal">登录</h2>
            <div class="d-block my-3">
				<label class="form-check-label">用户类型：</label>
				<div class="custom-control custom-radio custom-control-inline">
					<input id="personuser" class="custom-control-input" type="radio" name="userCategory" value="个人" checked />
					<label for="personuser" class="custom-control-label">个人</label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input id="orguser" class="custom-control-input" type="radio" name="userCategory" value="组织"  />
					<label for="orguser" class="custom-control-label"> 组织</label>
				</div>
			</div>			
			
			<div id="card" class="col-12">
				<label for="cardID" class="sr-only">身份证</label>
				<input type="text" name="cardId" id="cardID" class="form-control" placeholder="请输入身份证号码" required autofocus >
				<div class="invalid-tooltip">请输入有效的身份证号!</div>
	        </div>
	        
			<div id="org" class="col-12" style="display:none;">
				<label for="orgID" class="sr-only">统一社会信用代码</label>
				<input type="text" name="orgId" id="orgID" class="form-control" placeholder="请输入统一社会信用代码" required autofocus disabled="disabled">
	        	<div class="invalid-tooltip">请输入有效的统一社会信用代码!</div>
			</div>
	        
	        <div class="col-12">
	        	<label for="Password" class="sr-only">密码</label>
	        	<input type="password" name="pwd" id="Password" class="form-control" placeholder="请输入密码" required>
	        	<div class="invalid-tooltip">请输入有效的密码!</div>
	        </div>

           <div class="custom-control custom-checkbox mb-3  custom-control-inline">
             	<input type="checkbox" class="custom-control-input" id="remberpwd" value="记住密码">
             	<label class="custom-control-label" for="remberpwd">记住密码</label>
            </div>

			<div class="col-12 mb-2">
             	<a href="<%=path %>/register" class="text-info" href="register.html">注册账号</a>
            </div>
            
			<button id="login" class="btn btn-lg btn-info btn-block" type="submit">登录</button>
			<c:import url="/common/footer.jsp"></c:import>
	    </form>
	</div>
	<!-- 急救信息弹出框 -->
	<div class="modal fade" id="CryHelpNews" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-danger text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-exclamation mr-1"></i>急救信息</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<form>
					  	<div class="form-group row">
					    	<label for="dangerPerName" class="col-sm-3 col-form-label col-form-label-sm">姓名</label>
					    	<div class="col-sm-9">
					      		<input id="dangerPerName" type="text" class="form-control form-control-sm"  value=" ">
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="dangerPerCardID" class="col-sm-3 col-form-label col-form-label-sm">身份证号</label>
					    	<div class="col-sm-9">
					      		<input id="dangerPerCardID" type="text" class="form-control form-control-sm"  value=" ">
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="dangerPerPhoneNum" class="col-sm-3 col-form-label col-form-label-sm">手机号</label>
					    	<div class="col-sm-9">
					      		<input id="dangerPerPhoneNum" type="number" class="form-control form-control-sm"  value=" ">
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="dangerPerAdderss" class="col-sm-3 col-form-label col-form-label-sm">地点</label>
					    	<div class="col-sm-9">
					      		<input id="dangerPerAdderss" type="text" class="form-control form-control-sm"  value=" ">
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="dangerPerDescribe" class="col-sm-3 col-form-label col-form-label-sm">描述</label>
					    	<div class="col-sm-9">
					      		<textarea id="dangerPerDescribe" type="textarea" class="form-control"  value=" "></textarea>
					    	</div>
					  	</div>
					</form>
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" class="btn btn-danger">发送急救消息</button>
		        	<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div>

	<!--jquery js-->
	<script type="text/javascript" src="<%=path %>/Scripts/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=path %>/Scripts/jquery-form/jquery.form.min.js"></script>
	<!--Bootstrap js-->
	<script type="text/javascript" src="<%=path %>/Scripts/bootstrap.min.js"></script>
	<!--Custom js-->
	<script type="text/javascript">
	$(document).ready(function() {
		//选择个人或组织显示对应文本框
	    $('input[type=radio][name=userCategory]').change(function() {
	        if (this.value == '个人') {
	            $('#card').css('display','block');
	            $('#cardID').attr("disabled",false);
	            $('#org').css('display','none');
	            $('#orgID').attr("disabled",true);
	        }
	        else if (this.value == '组织') {
	            $('#card').css('display','none');
	            $('#cardID').attr("disabled",true);
	            $('#org').css('display','block');
	            $('#orgID').attr("disabled",false);		            
	        }
	    });	 
	    
	    $("#login").click(function() {
			$('.form-signin').ajaxSubmit(function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/desktop";
				}												
				else {
					alert(ret.msg);
					$("#Password").val("");
					return false;
				}
			});
			return false;
		});
	});	
	</script>
	</body>
</html>
