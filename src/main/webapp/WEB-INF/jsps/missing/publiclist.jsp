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
				<div class=" mx-auto py-2 ">
					<h3 class="mb-3 font-weight-normal text-left pl-4">失踪人口信息</h3>
					<div class="row">
					<c:forEach items="${missingList.list}" var="missing">
						<div class="col-md-4">
							<div class="card mb-4 shadow">
								<div class="card-header bg-danger">
									<c:choose>
				                  			<c:when test="${missing.PICPATH != null }">
				                  				<img src="<%=path %>${missing.PICPATH}"/>
				                  			</c:when>
				                  			<c:otherwise>
				                  				<img src="/img/photo.png"/>
				                  			</c:otherwise>
				                  		</c:choose>
								</div>
								<ul class="list-group list-group-flush text-left">
								    <li class="list-group-item">失踪人姓名：<span>${missing.MIUSER }</span></li>
								    <li class="list-group-item">失踪人性别：<span>${missing.SEX }</span></li>
								    <li class="list-group-item">失踪人身份证号：<span>${missing.USERCODE }</span></li>
								    <li class="list-group-item">失踪人电话：<span>${missing.SZTEL }</span></li>
								    <li class="list-group-item">失踪时间：<span>${missing.MISDATE }</span></li>
								    <li class="list-group-item">失踪地点：<span>${missing.ADDRESS }</span></li>
								    <li class="list-group-item">描述：
								    	<p class="card-text">${missing.CONTENT }</p>
								    </li>
								 </ul>
								<div class="card-body text-white bg-success">
								    <small class="d-block">联系人：<span>${missing.REUSER }</span></small>
								    <small class="d-block">联系人电话：<span>${missing.TEL }</span></small>
								</div>
								<div class="card-footer text-white">
					  				<button type="button" class="btn btn-info btn-block py-2"  data-toggle="modal" onclick="findPer('${missing.ID}','${missing.PICPATH}');">发现疑似人员</button>
								</div>
							</div>					
						</div>
					</c:forEach>
					</div>
					<div class="card-deck  pt-2 pb-2">
					</div>		
			    </div>
		        <c:import url="/common/footer.jsp"></c:import>
		    </main>
		</div>
	</div> 
	<!--内容end-->

	<!-- 发现疑似人员拍照弹出框 -->
	<div class="modal fade" id="FindSamePer" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>发现疑似人员拍照对比上传</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body">
		        	<form>
		        		<div class="row text-center">
		        			<input type="hidden" id="misId" name="picl.misid">
		        			<input type="hidden" id="reuser" name="mis.reuser" value="${sessionScope.user.ID }">
		        			<div class="col-md-6 border-right border-info mb-4">
		        				<label class="d-block p-2 mb-2">失踪人员照片</label>
		        				<img id="szPhoto" class="img-thumbnail"  />
		        			</div>
		        			<div class="col-md-6  mb-4">
		        				<input type="file" name="imageName" id="imageFile" class="form-control-file btn float-center" onchange="loadPhoto()">
		        				<img id="photoImg" class="img-thumbnail" src="<%=path %>/img/photo.png" />
		        				<input type="hidden" name="picl.picpath" id="pictureSrc" value="">
		        			</div>
		        		</div>
		        		<div class="row">
		        			<label id="textInfo" class="col">相似度：</label>
		        		</div>
		        		<div class="form-group">
	        				<label class="form-label" for="PhoneAdress">发现地点：</label>
	        				<input class="form-control" id="PhoneAdress" name="picl.address" type="text" value="" placeholder="请输入地址...">
		        		</div>
		        	</form>
		      	</div>
		      	<div class="modal-footer">
		      		<button id="upSub" onclick="uploadSub();" type="button" disabled="disabled" class="btn btn-info" data-dismiss="modal"  data-toggle="modal">确定上传</button>
		      		<button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
		      	</div>
	    	</div>
	  	</div>
	</div>

	<!-- 拍照上传成功弹出框 -->
	<div class="modal fade" id="FindSamePerSuccess" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>提示</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-check text-info mr-1" aria-hidden="true"></i>谢谢，上传成功！
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
	<script type="text/javascript" src="<%=path %>/Scripts/theme-switcher.min.js"></script>
	<!--侧导航隐藏显示-->
    <script type="text/javascript" src="<%=path %>/Scripts/app.js"></script>
    <script type="text/javascript" src="<%=path %>/Scripts/theme-switcher.min.js"></script>
	<!--Custom js-->
	<script type="text/javascript">
		$(document).ready(function(){
			App.livePreview();
		});		
		var score = "";
		function findPer(id,path){
			$("#misId").val(id);
			$("#szPhoto").attr("src","<%=path %>"+path);
			$("#photoImg").attr('src', "<%=path %>/img/photo.png");
			$("#imageFile").val("");
			$("#textInfo").html("");
			$("#PhoneAdress").val("");
			$('#FindSamePer').modal('show');
		}
		function loadPhoto(){
			$.ajaxFileUpload({
		        url : '/missing/tempLoad',   //提交的路径
		        secureuri : false, // 是否启用安全提交，默认为false
		        fileElementId : 'imageFile', // file控件id
		        dataType : 'json',
		        data:{imageName:$("#imageFile").val()}, // 键:值，传递文件名
		        success : function(ret) {
		            if (ret.state == "ok") {
		            	var newPath = ret.src;
		            	$("#photoImg").attr('src', newPath);
		                $("#pictureSrc").val(ret.src);
		                var phoPath = $("#szPhoto").attr('src');
		                $.ajax({
		        			async : false,
		        			type : "POST",
		        			data:{phoPath:phoPath,newPath:newPath},
		        			url : "<%=path %>/missing/ansPhoto",
		        			dataType : 'json',
		        			success : function(ret) {
		        				if(ret.state == "ok"){
		        					var html = "相似度：<h5 class=\"text-info\">"+ret.score+"%</h5>"
		        					$("#textInfo").html(html);
		        					if(ret.score > 50){
		        						score = ret.score;
		        						$('#upSub').removeAttr("disabled");
		        					}else{
		        						$('#upSub').attr('disabled',"true");
		        					}
		        				}else{
		        					alert(ret.score);
		        				}
		        			}
		        		});
		            } else {
		            	alert(ret.src);
		            }
		        },
		        error : function(ret) {
		            alert("上传出错啦！");
		        }
		    });
		}
		//上报地点信息
		function uploadSub(){
			var addr = $("#PhoneAdress").val();
			if(addr == ""){
				alert("请输入发现地点信息");
				return false;
			}
			var misId = $("#misId").val();
			var newPath = $("#pictureSrc").val();
			var reuser = $("#reuser").val();
			$.ajax({
    			async : false,
    			type : "POST",
    			data:{misId:misId,addr:addr,newPath:newPath,reuser:reuser,score:score},
    			url : "<%=path %>/missing/ansSub",
    			dataType : 'json',
    			success : function(ret) {
    				if(ret.state == "ok"){
    					$('#FindSamePerSuccess').modal('show');
    				}else{
    					alert(ret.msg);
    				}
    			}
    		});
		}
	</script>
	</body>
</html>