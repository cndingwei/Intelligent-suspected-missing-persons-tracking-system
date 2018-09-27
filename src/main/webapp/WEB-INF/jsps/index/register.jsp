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
	<div class="main container-fluid" >
	    <form method="post" action="<%=path %>/regSub" class="form-signin needs-validation" novalidate>
			<h1 class="h2 mb-4 text-info">无相智慧人口失踪追查系统</h1>
			<h2 class="h3 mb-3 font-weight-normal">注册</h2>
            <div class="d-block my-3">
				<label class="form-check-label">用户类型：</label>
				<div class="custom-control custom-radio custom-control-inline">
					<input id="personuser" class="custom-control-input" type="radio" name="user.type" value="个人" checked />
					<label for="personuser" class="custom-control-label">个人</label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input id="orguser" class="custom-control-input" type="radio" name="user.type" value="组织"  />
					<label for="orguser" class="custom-control-label"> 组织</label>
				</div>
			</div>			

			<div id="personRegister">
				<div id="personName" class="col-12">
					<label for="perNameText" class="sr-only">姓名</label>
					<input type="text" id="perNameText" class="form-control" name="pername" placeholder="请输入姓名" required autofocus >
					<div class="invalid-tooltip">请输入有效的姓名!</div>
		       </div>		        
				
				<div id="card" class="col-12">
					<label for="cardID" class="sr-only">身份证</label>
					<input type="text" id="cardID" class="form-control" name="percode" placeholder="请输入身份证号码" required>
					<div class="invalid-tooltip">请输入有效的身份证号!</div>
		        </div>
				
				<div id="personPhone" class="col-12">
					<label for="perPhoneNum" class="sr-only">手机号</label>
					<input type="text" id="perPhoneNum" class="form-control" name="pertel" placeholder="请输入手机号码" required>
					<div class="invalid-tooltip">请输入有效的手机号码!</div>
		       </div>		        
			</div>
			
			<div id="orgRegister" style="display:none;">
				<div id="orgName" class="col-12">
					<label for="orgNameText" class="sr-only">组织名称</label>
					<input type="text" id="orgNameText" class="form-control" name="zzname" placeholder="请输入组织名称" required autofocus >
					<div class="invalid-tooltip">请输入有效的组织名称!</div>
		       </div>		        
								
				<div id="org" class="col-12" >
					<label for="orgID" class="sr-only">统一社会信用代码</label>
					<input type="text" id="orgID" class="form-control" name="zzcode" placeholder="请输入统一社会信用代码" required >
		        	<div class="invalid-tooltip">请输入有效的统一社会信用代码!</div>
				</div>
		        
				<div id="orgPhone" class="col-12">
					<label for="orgPhoneNum" class="sr-only">联系电话</label>
					<input type="text" id="orgPhoneNum" class="form-control" name="zztel" placeholder="请输入联系电话" required>
					<div class="invalid-tooltip">请输入有效的联系电话!</div>
		       </div>		        
			</div>
			
            <div class="d-block my-3">
				<label class="form-check-label">是否成为志愿者：</label>
				<div class="custom-control custom-radio custom-control-inline">
					<input id="volunteerYes" class="custom-control-input" type="radio" name="user.isvolun" value="0" checked />
					<label for="volunteerYes" class="custom-control-label">是</label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input id="volunteerNo" class="custom-control-input" type="radio" name="user.isvolun" value="1"  />
					<label for="volunteerNo" class="custom-control-label"> 否</label>
				</div>
				<p class="mt-2 text-info " data-toggle="modal" data-target="#ViewVolunteerAgreement"><i class="fa fa-book mr-1"></i>查看志愿者协议</p>
			</div>	
			
			<div class="col-12 mb-2">`
             	<a class="text-info" href="/" >已有账号，直接登录</a>
            </div>		

			<button id="register" class="btn btn-lg btn-info btn-block" type="submit" data-toggle="modal" data-target="#RegisterSuccuss">注册</button>
			
			<c:import url="/common/footer.jsp"></c:import>
	    </form>
		
	</div>
	<!--内容main  end-->

	<!-- 注册成功弹出框 -->
	<div class="modal fade" id="RegisterSuccuss" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>提示</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-check text-info mr-1" aria-hidden="true"></i>注册成功！
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" class="btn btn-info">直接登录</button>
		        	<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div>
	<!-- 查看志愿者协议弹出框 -->
	<div class="modal fade" id="ViewVolunteerAgreement" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-book mr-1"></i>志愿者协议</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	志愿者协议内容
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
	<!--Custom js-->
	<script type="text/javascript">
	$(document).ready(function() {
		//选择个人或组织显示对应文本框
	    $('input[type=radio][name=userCategory]').change(function() {
	        if (this.value == '个人') {
	            $('#personRegister').css('display','block');
	            $('#perNameText').attr("disabled",false);
	            $('#cardID').attr("disabled",false);
	            $('#perPhoneNum').attr("disabled",false);
	            $('#orgRegister').css('display','none');
	            $('#orgNameText').attr("disabled",true);		            
	            $('#orgID').attr("disabled",true);		            
	            $('#orgPhoneNum').attr("disabled",true);		            
	        }
	        else if (this.value == '组织') {
	            $('#personRegister').css('display','none');
	            $('#perNameText').attr("disabled",true);
	            $('#cardID').attr("disabled",true);
	            $('#perPhoneNum').attr("disabled",true);
	            $('#orgRegister').css('display','block');
	            $('#orgNameText').attr("disabled",false);		            
	            $('#orgID').attr("disabled",false);		            
	            $('#orgPhoneNum').attr("disabled",false);		            
	        }
	    });	 
		
	    $("#register").click(function() {
			$('.form-signin').ajaxSubmit(function(ret) {
				if (ret.state == "ok") {
					alert(ret.msg);
					location.href = "<%=path %>/";
				}												
				else {
					alert(ret.msg);
					location.href = "<%=path %>/register";
				}
			});
			return false;
		});
	}); 
	</script>

	</body>
</html>
