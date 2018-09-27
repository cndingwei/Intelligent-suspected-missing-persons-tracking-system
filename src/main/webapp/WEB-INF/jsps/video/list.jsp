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
					<h3 class="mb-3 font-weight-normal text-left">视频列表</h3>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
		          		<button class="btn btn-info btn-md mt-3 mx-3" data-toggle="modal" onclick="add();"><i class="fa fa-plus mr-1"></i>上传新视频</button>
		          		<hr />
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                	<th scope="col">序号</th>
				                  	<th scope="col">视频名称</th>
				                  	<th scope="col">地点</th>
				                  	<th scope="col">视频路径</th>
				                  	<th scope="col">开始时间</th>
				                  	<th scope="col">结束时间</th>
				                  	<th scope="col">上传时间</th>
				                 	<th scope="col">操作</th>
				                </tr>
			             	</thead>
			              	<tbody>
			              		 <c:forEach items="${videoList.list}" var="video">
			                	<tr>
				                  	<td scope="row">${video.ID }</td>
				                  	<td><span>${video.CAMNAME }</span></td>
				                  	<td><span>${video.ADDRESS }</span></td>
				                  	<td><p>${video.VIDEOPATH }</p></td>
				                  	<td><span>${video.STARTTIME }</span></td> 
				                  	<td><span>${video.ENDTIME }</span></td>    
				                  	<td><span>${video.CREATETIME }</span></td>             	
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="del(${video.ID})"><i class="fa fa-minus mr-1"></i>删除</button>
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

	<!--上传视频弹出框 -->
	<div class="modal fade" id="addVideo" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>上传视频</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="videoForm" action="" method="post">
		      	    <input type="hidden" id="videoId" name="video.id" value="">
		      	    <div class="modal-body text-center">
					  	<div class="form-group row">
					    	<label for="DisasterCode" class="col-sm-3 col-form-label col-form-label-sm">监控地点</label>
					    	<div class="col-sm-9">
					      		<select class="form-control form-control-md" id="address" name="video.camid">
							    </select>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="startTime" class="col-sm-3 col-form-label col-form-label-sm">开始时间</label>
					    	<div class="input-group date form_datetime col-md-9" data-date="" data-date-format="yyyy-mm-dd hh:ii:ss">
					      		<input id="startTime" name="video.starttime" class="form-control form-control-md" size="16" type="text" value="" readonly>
                   				<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
								<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="endTime" class="col-sm-3 col-form-label col-form-label-sm">结束时间</label>
					    	<div class="input-group date form_datetime col-md-9" data-date="" data-date-format="yyyy-mm-dd hh:ii:ss">
					      		<input id="endTime" name="video.endtime" class="form-control form-control-md" size="16" type="text" value="" readonly>
                   				<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
								<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="UserLibraryBirty" class="col-sm-3 col-form-label col-form-label-sm">视频路径</label>
					    	<div class="col-sm-9">
					    		<input type="file" name="videoName" id="imageFile" class="form-control-file btn float-center">
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
		$("#videoForm").ajaxForm({
			dataType: "json", 
			success: function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/video";
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
		$.ajax({
			async : false,
			type : "POST",
			url : "<%=path %>/cama/findAll",
			dataType : 'json',
			success : function(data) {
				var optionHtml = "";
				if(data.length > 0){
					for(var i = 0;i<data.length;i++){
						optionHtml = optionHtml + "<option value=\""+data[i].ID+"\">"+data[i].ADDR+"</option>";
					}
				}
				$("#address").append(optionHtml);
			}
		});
		$("#videoForm").attr('action','/video/addVideo');
		$('#addVideo').modal('show');
	}
	//删除数据
	function del(data){
		   if(confirm("是否确认删除")){
			   $.ajax({
					async : false,
					type : "POST",
					data:{id:data},
					url : "<%=path %>/video/delVideo",
					dataType : 'json',
					success : function(ret) {
						if (ret.state == "ok") {
							location.href = "<%=path %>/video";
						} else {
							alert(ret.msg);
						}
					}
				});
		   }else{
			   return false; 
		   }
	   }
	//分析视频，将视频截图，展示 
	function anasView(data){
		$("#misId").val(data);
		$.ajax({
			async : false,
			type : "POST",
			data:{id:data},
			url : "<%=path %>/disaster/anasView",
			dataType : 'json',
			success : function(data) {
				if(data.length > 0){
					var html = "";
					for(var i = 0;i<data.length;i++){
						html = html + "<figure class=\"figure\"><img src=\""+<%=path %>data[i]+"\" height=\"189\" width=\"129\" class=\"figure-img img-fluid rounded img-thumbnail\" ></figure>";
					}
					$("#picList").html(html);
				}
			}
		});
		$('#AnalysisVideo').modal('show');
	}
	
	//人物比对，调用接口与人口基本信息库中进行对比 
	function contrast(){
		var misId = $("#misId").val();
		$.ajax({
			async : false,
			type : "POST",
			data:{misId:misId},
			url : "<%=path %>/disaster/contrast",
			dataType : 'json',
			success : function(data) {
				$('#AnalysisVideo').modal('hide');
				alert("分析完毕，共发现"+ data.length + "个人");
				location.href = "<%=path %>/disaster/findByDisId/"+misId;
			}
		});
	}
	function findByDisId(data){
		location.href = "<%=path %>/disaster/findEchartByDisId/"+data;
	}
	</script>
	</body>
</html>
