<%@page pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<header class="navbar navbar-expand navbar-dark bg-info bd-navbar"> 
		<div class="navLogo">
			<a class="navbar-brand float-left" href="#">无相智慧人口失踪追查系统</a>
		</div>
		<div class="navRight">
			<ul class="navbar-nav mr-1 float-right">
			    <li class="nav-item dropdown">
				    <a class="nav-link dropdown-toggle text-white" data-toggle="dropdown" href="#" role="button" id="user-dropdownMenu"  aria-haspopup="true" aria-expanded="false">${sessionScope.user.NAME}</a>
				    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="user-dropdownMenu">
				       <a class="dropdown-item" href="#"><i class="fa fa-fw fa-user-circle mr-1"></i>个人中心</a>
				       <a class="dropdown-item" href="#"><i class="fa fa-fw fa-lock mr-1"></i>修改密码</a>
				       <div class="dropdown-divider"></div>
				       <a class="dropdown-item" href="/logout"><i class="fa fa-fw fa-sign-out mr-1"></i>退出</a>
				    </div>
			    </li>
			</ul>		
			<span class="text-white float-right mt-2 mr-1">
			 	<a href="/send/abc" class="text-light"><i class="fa fa-commenting-o fa-lg"></i><span id="msg" class="badge"></span></a>
			</span>	
		</div>
	</header>
	<!--jquery js-->
	<script type="text/javascript" src="<%=path %>/Scripts/jquery-1.10.2.min.js"></script>
	<script type="text/javascript">
		$(function(){  
			$.ajax({
				async : false,
				type : "POST",
				url : "<%=path %>/getMsg",
				dataType : 'json',
				success : function(ret) {
					if(ret.state == "ok"){
						$("#msg").html(ret.msg);
					}
				}
			});
		});  
	</script>