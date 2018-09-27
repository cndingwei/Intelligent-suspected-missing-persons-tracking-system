<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>、
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js fixed-layout">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>用户管理</title>
  <meta name="description" content="这是一个 index 页面">
  <meta name="keywords" content="index">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="icon" type="image/png" href="<%=path %>/assets/i/favicon.png">
  <link rel="apple-touch-icon-precomposed" href="<%=path %>/assets/i/app-icon72x72@2x.png">
  <meta name="apple-mobile-web-app-title" content="Amaze UI" />
  <link rel="stylesheet" href="<%=path %>/assets/css/amazeui.min.css"/>
  <link rel="stylesheet" href="<%=path %>/assets/css/admin.css">
  <link rel="stylesheet" href="<%=path %>/Scripts/validform/css/style.css">
</head>
<c:import url="/common/header.jsp"></c:import>
 <div class="am-cf admin-main" style="padding-top:27px !important;">
  <c:import url="/common/menu.jsp"></c:import>
<!-- content start -->
 <div class="admin-content">
   <div class="admin-content-body">
    	<div class="am-cf am-padding am-padding-bottom-0">
	      <div class="am-fl am-cf">
	        <strong class="am-text-primary am-text-lg">用户管理</strong>
	      </div>
	    </div>
	
	    <hr>
    	<div class="am-tabs am-margin" data-am-tabs>
	      <ul class="am-tabs-nav am-nav am-nav-tabs">
	        <li class="am-active"><a href="#tab1">用户信息</a></li>
	      </ul>
	    	<div class="am-tabs-bd">
		        <div class="am-tab-panel am-fade am-in am-active" id="tab1">
			        <form class="registerform am-form" id="userForm" action="${user == null ? '/user/addUser' : '/user/upUser' }" method="post">
			            <input id="userId" type="hidden" name="user.id" value="${user.ID }">
			            <div class="formsub">
			            	<div class="am-g am-margin-top-sm">
				              <div class="am-u-sm-4 am-u-md-2 am-text-right">
				                <label><span class="need">*</span> 选择角色：</label>
				              </div>
				              <div class="am-u-sm-8 am-u-md-4 am-u-end">
				               <select name="ur.roleid" data-am-selected="{btnSize: 'sm'}">
				                  <c:forEach items="${roleList }" var="role">
				                  	<option value="${role.id }" <c:if test="${user.ROLEID == role.id }">selected="selected"</c:if>>${role.name }</option>
				                  </c:forEach>
					           </select>
				              </div>
				            </div>
				            <div class="am-g am-margin-top-sm">
				              <div class="am-u-sm-4 am-u-md-2 am-text-right">
				                <label><span class="need">*</span> 选择角色：</label>
				              </div>
				              <div class="am-u-sm-8 am-u-md-4 am-u-end">
				                <select name="user.type" data-am-selected="{btnSize: 'sm'}">
				                  	<option value="组织" <c:if test="${user.TYPE == '组织' }">selected="selected"</c:if>>组织</option>
				                  	<option value="个人" <c:if test="${user.TYPE == '个人' }">selected="selected"</c:if>>个人</option>
					           </select>
				              </div>
				            </div>
				            <div class="am-g am-margin-top-sm">
				              <div class="am-u-sm-4 am-u-md-2 am-text-right">
				                <label><span class="need">*</span> 身份证号：</label>
				              </div>
				              <div class="am-u-sm-8 am-u-md-4 am-u-end">
				                <input type="text" value="${user.USERCODE }" name="user.usercode" class="inputxt" 
				                datatype="n18-19" ajaxurl="<%=path %>/user/validCode/${user.ID}" errormsg="身份证号为18个数字" />
			                        <div class="Validform_checktip">身份证号为18个数字</div>
				              </div>
				            </div>
				            <div class="am-g am-margin-top-sm">
				              <div class="am-u-sm-4 am-u-md-2 am-text-right">
				                <label><span class="need">*</span> 姓名：</label>
				              </div>
				              <div class="am-u-sm-8 am-u-md-4 am-u-end">
				                <input type="text" value="${user.NAME }" name="user.name" class="inputxt" 
				                datatype="s2-18" errormsg="姓名至少2个字符,最多18个字符！" />
			                        <div class="Validform_checktip">姓名为2~18个字符</div>
				              </div>
				            </div>
				            <div class="am-g am-margin-top-sm">
				              <div class="am-u-sm-4 am-u-md-2 am-text-right">
				                <label><span class="need">*</span> 手机号：</label>
				              </div>
				              <div class="am-u-sm-8 am-u-md-4 am-u-end">
				                <input type="text" value="${user.TEL }" name="user.tel" class="inputxt"
				                datatype="m" ajaxurl="<%=path %>/user/validTel/${user.ID}" errormsg="请填写11位数字的手机号码！" />
			                        <div class="Validform_checktip">请填写11位数字的手机号码！</div>
				              </div>
				            </div>
				            <div class="am-g am-margin-top-sm">
				              <div class="am-u-sm-4 am-u-md-2 am-text-right">
				                <label><span class="need">*</span> 志愿者：</label>
				              </div>
				              <div class="am-u-sm-8 am-u-md-4 am-u-end">
				                <label class="am-btn am-btn-default am-btn-xs">
				                  <input type="radio" name="user.isvolun" value="0" <c:if test="${user.ISVOLUN == 0 }">checked="checked"</c:if>>是志愿者
				                </label>
				                <label class="am-btn am-btn-default am-btn-xs">
				                  <input type="radio" name="user.isvolun" value="1" <c:if test="${user.ISVOLUN == 1 }">checked="checked"</c:if>>非志愿者
				                </label>
				              </div>
				            </div>
				            <div class="am-g am-margin-top">
				              <div class="am-u-sm-4 am-u-md-2 am-text-right">
				                <label style=" width:120px; ">信息备注：</label>
				              </div>
				              <div class="am-u-sm-12 am-u-md-10">
				                <textarea rows="4" name="user.remark" placeholder="请使用富文本编辑插件">${user.REMARK }</textarea>
				              </div>
				            </div>
			                <div class="am-margin">
						      <button type="submit" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
						    </div>
			            </div>
			        </form>
		        </div>
	        </div>
        </div>
     </div>
         <c:import url="/common/footer.jsp"></c:import>
    </div>
</div>

<script type="text/javascript" src="<%=path %>/Scripts/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=path %>/Scripts/jquery-form/jquery.form.min.js"></script>
<script type="text/javascript" src="<%=path %>/Scripts/validform/js/Validform_v5.3.2_min.js"></script>

<script src="<%=path %>/assets/js/amazeui.min.js"></script>
<script src="<%=path %>/assets/js/app.js"></script>
<script type="text/javascript">
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
		
	$(".registerform").Validform({
		tiptype:function(msg,o,cssctl){
			//msg：提示信息;
			//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
			//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
			if(!o.obj.is("form")){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
				var objtip=o.obj.siblings(".Validform_checktip");
				cssctl(objtip,o.type);
				objtip.text(msg);
			}
		}
	});
	
	$("#userForm").ajaxForm({
		dataType: "json", 
		success: function(ret) {
			if (ret.state == "ok") {
				alert(ret.msg);
				location.href = "<%=path %>/user";
			} else {
				alert(ret.msg);
			}
		}
		, error: function(ret) {alert(ret.msg);}
		, complete: function(ret) {} 	      // 无论是 success 还是 error，最终都会被回调
	});
})
</script>

</body>
</html>
