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
			    <div class="mx-auto py-2">
			    	<h3 class="mb-3 font-weight-normal text-left">登记失踪人口信息</h3>
					<form class="MyRegmissPer needs-validation bg-white shadow rounded py-3" id="missForm" action="/missing/missSub" novalidate>
				    	<div class="row">
				    		<div class="col-md-8">
				    			  <div class="row ">
									    <div class="col p-2">
									    	<input type="hidden" id="miUserId" name="mis.miuser">
									    	<label for="missPerCardID" >失踪人身份证</label>
									      	<input id="missPerCardID" name="missPerCardID" type="text" class="form-control form-control-md" onblur="findUser();" required>
									      	<div class="invalid-tooltip">请输入有效的身份证号!</div>
									    </div>
									</div>
									<div class="row ">
									    <div class="col-md-6  p-2">
									    	<label for="missPerName" class="text-left">失踪人姓名</label>
									      	<input id="missPerName" name="missPerName" type="text" class="form-control form-control-md"  readonly="readonly">
									      	<div class="invalid-tooltip">请输入有效的姓名!</div>
									    </div>
									    <div class="col-md-6  p-2">
									    	<label class="form-label form-label-md ">失踪人性别</label>
									      	<div class="form-check ">
												<input id="missPerSexNv" class="form-check-input" type="radio" name="sex" value="0" readonly="readonly"/>
												<label for="missPerSexNv" class="form-check-label">女</label>
											</div>
											<div class="form-check ">
												<input id="missPerSexNan" class="form-check-input" type="radio" name="sex" value="1" readonly="readonly"/>
												<label for="missPerSexNan" class="form-check-label"> 男</label>
											</div>
									    </div>
									</div>    
									<div class="row ">    
									    <div class="col-md-6 p-2">
									    	<label for="missPerType" >失踪类别</label>
											<select class="form-control" name="mis.type" id="exampleFormControlSelect1">
											    <option value="疑似失踪">疑似失踪</option>
											    <option value="疑似遇难">疑似遇难</option>
										    </select>			    	
									    </div>
									    <div class="col-md-6 p-2">
									    	<label for="missPerTime"  class="form-label form-label-md ">失踪时间</label>
									    	<input id="missPerAdress" name="misdate" type="datetime-local" class="form-control form-control-md" >
									    	<div class="invalid-tooltip">请输入有效的时间!</div>
									    </div>
									</div>    
									<div class="row ">    
									    <div class="col p-2">
									    	<label for="missPerAdress" >失踪地点</label>
									    	<input id="missPerAdress" type="text" name="mis.address" class="form-control form-control-md" required>
									    	<div class="invalid-tooltip">请输入有效的地点!</div>
									    </div>
									</div>
									<div class="row ">
										<div class="col p-2">
											<label for="missPerPhoneNum" >失踪人电话</label>
											<input type="text" id="missPerPhoneNum" class="form-control" readonly="readonly">
											<div class="invalid-tooltip">请输入有效的手机号码!</div>					
										</div>
									</div>    
									<div class="row "> 	
										<div class="col p-2">
											<label for="missPerDescribe" >详细描述</label>
											<textarea class="form-control" name="mis.content" id="missPerDescribe" rows="5" required></textarea>
											<div class="invalid-tooltip">请输入有效的描述!</div>
										</div>
									</div>
									<div class="row ">
										<div class="col-md-6 p-2">
											<input type="hidden" name="mis.reuser" value="${sessionScope.user.ID }">
											<label for="registerPerName" >登记人姓名</label>
									      	<input id="registerPerName" type="text" class="form-control form-control-md"  value="${sessionScope.user.NAME }" readonly="readonly">
									      	<div class="invalid-tooltip">请输入有效的姓名!</div>					
										</div>
										<div class="col-md-6 p-2">
											<label for="registerPerPhoneNum" >登记人电话</label>
											<input type="text" id="registerPerPhoneNum" class="form-control" value="${sessionScope.user.TEL }" readonly="readonly">
											<div class="invalid-tooltip">请输入有效的手机号码!</div>
										</div>
									</div>
				    		</div>
				    		<div class="col-md-4">
								<label for="missPerPhoto" >失踪人照片</label>
								<div id="missPerPhoto">
									<img id="missPerPhotoImg" class="shadow-sm bg-white img-thumbnail" src="<%=path %>/img/photo.png">
									<div id="missPerPhotoBtn" >
									    <input type="file" name="imageName" id="imageFile" class="form-control-file btn float-center" onchange="loadPhoto()">
									    <input type="hidden" name="mis.picpath" id="pictureSrc" value="">
									</div>
								</div>   
				    		</div>
				    	</div>
				    	<div class="row">
						    <div class="col p-4">
					  			<button type="submit" class="btn btn-info mr-3 px-5 my-1 btn-md"  data-toggle="modal">提交</button>
							    <button type="button" class="btn btn-secondary px-5 my-1 btn-md" data-dismiss="modal">取消</button>
						    </div>
						</div>
					</form>
				</div>
		        <c:import url="/common/footer.jsp"></c:import>
		    </main>
		</div>
	</div> 
	<!--内容end-->

	<!-- 登记成功弹出框 -->
	<div class="modal fade" id="RegisterSubmitSuccuss" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>提示</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-check text-info mr-1" aria-hidden="true"></i>登记成功！
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
	<script type="text/javascript" src="<%=path %>/Scripts/ajaxfileupload.js"></script>
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
		$("#missForm").ajaxForm({
			dataType: "json", 
			success: function(ret) {
				if (ret.state == "ok") {
					$('#RegisterSubmitSuccuss').modal('show');
				} else {
					alert(ret.msg);
				}
			}
			, error: function(ret) {alert(ret.msg);}
			, complete: function(ret) {} 	      // 无论是 success 还是 error，最终都会被回调
		});
	})
	//获取上传照片
	function loadPhoto(){
		 $.ajaxFileUpload({
		        url : '/missing/imageUpload',   //提交的路径
		        secureuri : false, // 是否启用安全提交，默认为false
		        fileElementId : 'imageFile', // file控件id
		        dataType : 'json',
		        data:{imageName:$("#imageFile").val()}, // 键:值，传递文件名
		        success : function(ret) {
		            if (ret.state == "ok") {
		            	$("#missPerPhotoImg").attr('src', ret.src);
		                $("#pictureSrc").val(ret.src);
		            } else {
		            	alert(ret.src);
		            }
		        },
		        error : function(ret) {
		            alert("上传出错啦！");
		        }
		    });
	} 
	
	function findUser(){
		var cardId = $("#missPerCardID").val();
		if(cardId == ''){
			alert("身份证号为必填项！");
			return false;
		}
		$.ajax({
			async : false,
			type : "POST",
			data:{cardId:cardId},
			url : "<%=path %>/missing/findBycardId",
			dataType : 'json',
			success : function(data) {
				if(data == null){
					alert("请填写正确的身份证号！");
					$("#missPerCardID").val("");
				}else{
					$("#missPerName").val(data.NAME);
					$("#miUserId").val(data.ID);
					if(data.SEX == '女'){
						$("#missPerSexNv").attr("checked","checked");
					}else{
						$("#missPerSexNan").attr("checked","checked");
					}
					$("#missPerPhoneNum").val(data.TEL);
				}
			}
		});
	}
	</script>
	</body>
</html>