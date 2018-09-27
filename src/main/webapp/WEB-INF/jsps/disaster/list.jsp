<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Invisible Wisdom Missing Tracing System</title>
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
					<h3 class="mb-3 font-weight-normal text-left pl-4">Disaster information list</h3>
		          	<div class="table-responsive-sm  bg-white border border-light shadow">
		          		<button class="btn btn-info btn-md mt-3 mx-3" data-toggle="modal" onclick="add();"><i class="fa fa-plus mr-1"></i>Registration disaster</button>
		          		<hr />
			            <table class="table table-striped table-hover MymissPerList">
			              	<thead class="bg-info text-white">
				                <tr>
				                  	<th scope="col">Name</th>
				                  	<th scope="col">Code</th>
				                  	<th scope="col">Address</th>
				                  	<th scope="col">Description</th>
				                  	<th scope="col">Time of occurrence</th>
				                 	<th scope="col">Action</th>
				                </tr>
			             	</thead>
			              	<tbody>
			              		 <c:forEach items="${disasterList.list}" var="disaster">
			                	<tr>
				                  	<td><span>${disaster.DNAME }</span></td>
				                  	<td><span>${disaster.CODE }</span></td>
				                  	<td><span>${disaster.ADDRESS }</span></td>
				                  	<td><p>${disaster.CONTENT }</p></td>
				                  	<td><span>${disaster.OPENTIME }</span></td>                  	
				                  	<td>
				                  		<button class="btn btn-info btn-sm my-1" onclick="findVideo('${disaster.ID}','${disaster.ADDRESS}')"><i class="fa fa-pencil mr-1"></i>View monitoring</button>
				                  		<button class="btn btn-info btn-sm my-1" onclick="uploadView(${disaster.ID})"><i class="fa fa-pencil mr-1"></i>Upload video</button>
				                  		<button class="btn btn-info btn-sm my-1" onclick="findByDisId(${disaster.ID})" data-toggle="modal"><i class="fa fa-pencil mr-1"></i>Analysis</button>
				                  		<button class="btn btn-info btn-sm my-1" data-toggle="modal"  onclick="del(${disaster.ID})"><i class="fa fa-minus mr-1"></i>Delete</button>
				                  	</td>
			                	</tr>
			                	</c:forEach>
			             	</tbody>
			            </table>
			            <!--页码 pagination-->
						<nav class="mx-3">
		                	<ul class="pagination font-12">
		                		<c:choose>  
					                <c:when test="${disasterList.pageNumber>1 }"> 
					                	<li class="page-item"><a class="page-link" href="<%=path%>/disaster?p=${disasterList.pageNumber-1}" aria-label="Previous"><i class="fa fa-angle-left"></i></a></li>
					                </c:when>  
					                <c:otherwise>  
					                    <li class="page-item"><a class="page-link" href="#"><i class="fa fa-angle-left"></i></a></li>  
					                </c:otherwise>  
					            </c:choose>  
					            <c:forEach var="p" begin="1" end="${disasterList.totalPage }">  
					           		<li <c:choose>
					            		<c:when test="${disasterList.pageNumber == p}">class="page-item active"</c:when>
					            		<c:otherwise>class="page-item"</c:otherwise>
					            	</c:choose>><a class="page-link" href="<%=path%>/disaster?p=${p }">${p }</a></li>
					            </c:forEach>  
					            <c:choose>  
					                <c:when test="${disasterList.pageNumber<disasterList.totalPage}">
					                	<li class="page-item"><a class="page-link" href="<%=path%>/disaster?p=${disasterList.pageNumber + 1}" aria-label="Next"><i class="fa fa-angle-right"></i></a></li> 
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

	<!--登记灾难弹出框 -->
	<div class="modal fade" id="AddDisasters" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>Registration disaster</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="registerform am-form" id="disasterForm" action="" method="post">
		      	    <input type="hidden" id="disasterId" name="disaster.id" value="">
		      	    <div class="modal-body text-center">
					  	<div class="form-group row">
					    	<label for="DisasterName" class="col-sm-3 col-form-label col-form-label-sm">Name</label>
					    	<div class="col-sm-9">
					      		<input id="DisasterDname" type="text" name="disaster.dname" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row" id="seAddr">
					    	<label for="address" class="col-sm-3 col-form-label col-form-label-sm">Address</label>
					    	<div class="col-sm-9">
					      		<select class="form-control form-control-md" id="address" name="seleAddr">
							    </select>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="DisasterName" class="col-sm-3 col-form-label col-form-label-sm">Is exist</label>
					    	<div class="col-sm-9">
					      		<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="opFlag" id="opHas" value="0" checked="checked">
								  <label class="form-check-label" for="opHas">Yes</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="opFlag" id="opNo" value="1">
								  <label class="form-check-label" for="opNo">No</label>
								</div>
					    	</div>
					  	</div>
					  	<div class="form-group row" id="addr" style="display: none">
					    	<label for="DisasterName" class="col-sm-3 col-form-label col-form-label-sm">Add address</label>
					    	<div class="col-sm-9">
					      		<input id="DisasterDname" type="text" name="address" class="form-control form-control-sm"  value=" " required>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="opentime" class="col-sm-3 col-form-label col-form-label-sm">Time</label>
					    	<div class="input-group date form_datetime col-md-9" data-date="" data-date-format="yyyy-mm-dd hh:ii:ss">
					      		<input id="opentime" name="disaster.opentime" class="form-control form-control-md" size="16" type="text" value="" readonly>
                   				<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
								<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
					    	</div>
					  	</div>
					  	<div class="form-group row">
					    	<label for="DisasterContent" class="col-sm-3 col-form-label col-form-label-sm">Description</label>
					    	<div class="col-sm-9">
					      		<textarea id="DisasterContent" name="disaster.content" type="textarea" class="form-control"  value=" "></textarea>
					    	</div>
					  	</div>
				    </div>
			      	<div class="modal-footer">
			      		<button type="submit" class="btn btn-info" >Submit</button>
			        	<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancle</button>
			      	</div>
		      	</form>
	    	</div>
	  	</div>
	</div>
	
	<!-- 开始Waston分析未找到结果页弹出框 -->
	<div class="modal fade  bd-example-modal-lg" id="picAnas" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	    		<input type="hidden" id="noMisId">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>Waston Analysis</h5>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-spinner fa-spin text-info mr-1" aria-hidden="true"></i>Please wait for analysis！
		      	</div>
	    	</div>
	  	</div>
	</div>
	
	<!-- 开始视频截图 -->
	<div class="modal fade  bd-example-modal-lg" id="videoAnasModal" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>Video Analysis</h5>
			     </div>
		      	<div class="modal-body text-center">
		        	<i class="fa fa-spinner fa-spin text-info mr-1" aria-hidden="true"></i>Please analyze the video, please wait！
		      	</div>
	    	</div>
	  	</div>
	</div>
	
	<!--监控视频信息弹出框 -->
	<div class="modal fade" id="videosModal" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>Video List</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>	
		      	<div class="modal-body text-center font-12">
		      		<input type="hidden" id="videoDisId" name="videoDisId" value="">
					<form id="videosForm" action="" method="post">
					
		      		</form>		      	
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" onclick="anasViewByPath();" class="btn btn-info" >Analytical monitoring</button>
				    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancle</button>
		      	</div>
	    	</div>
	  	</div>
	</div> 
	
	<!-- 对视频中的截图进行展示 -->
	<div class="modal fade bd-example-modal-lg" id="AnalysisVideo" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	    	<div class="modal-content">
	    		<input type="hidden" id="misId">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-lightbulb-o mr-1"></i>Video picture</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
		      	<div class="modal-body text-center">
		      		<input type="hidden" id="anasFlag">
		        	<div id="picList" class="col">
		        		
		        	</div>
		      	</div>
		      	<div class="modal-footer">
		      		<button type="button" onclick="contrast();" class="btn btn-info" data-dismiss="modal"  data-toggle="modal">Compare Model</button>
		      		<button type="button" class="btn btn-info" data-dismiss="modal">Cancel</button>
		      	</div>
	    	</div>
	  	</div>
	</div>

	<!--上传视频弹出框 -->
	<div class="modal fade" id="uploadVideo" tabindex="-1" role="dialog" aria-labelledby="ModalCenterTitle" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header bg-info text-white">
			        <h5 class="modal-title" id="exampleModalLongTitle"><i class="fa fa-plus mr-1"></i>Upload Video</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			         	<span aria-hidden="true">&times;</span>
			        </button>
			     </div>
			     <form class="am-form" id="uploadViewForm" action="" method="post">
		      	    <div class="modal-body text-center">
						<div class="form-group row">
					    	<label for="UserLibraryBirty" class="col-sm-3 col-form-label col-form-label-sm">upload</label>
					    	<div class="col-sm-9">
					    		<input type="file" name="videoName" id="videoName" class="form-control-file btn float-center">
					    	</div>
					  	</div>
				    </div>
			      	<div class="modal-footer">
			      		<button type="submit" class="btn btn-info" >Submit</button>
			        	<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
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
		$(":radio").click(function(){
			  var val = $(this).val();
			  if(val == 1){
				  $("#addr").show();
				  $("#seAddr").hide();
			  }else{
				  $("#seAddr").show();
				  $("#addr").hide();
			  }
		});
		$("#disasterForm").ajaxForm({
			dataType: "json", 
			success: function(ret) {
				if (ret.state == "ok") {
					location.href = "<%=path %>/disaster";
				} else {
					alert(ret.msg);
				}
			}
			, error: function(ret) {alert(ret.msg);}
			, complete: function(ret) {} 	      // 无论是 success 还是 error，最终都会被回调
		});
		$("#uploadViewForm").ajaxForm({
			dataType: "json", 
			success: function(ret) {
				if (ret.state == "ok") {
					$('#uploadVideo').modal('hide');
					alert("Successful, and the analysis of the character image begins.");
					$("#videoAnasModal").modal('show');
					var values = []; 
					values.push(ret.msg); 
					var id = ret.misId;
					$("#misId").val(id);
					$.ajax({
						async : false,
						type : "POST",
						data:{id:id,path:values},
						url : "<%=path %>/disaster/anasView",
						dataType : 'json',
						success : function(data) {
							if(data.length > 0){
								$("#anasFlag").val(0);//0表示上传视频
								var html = "";
								for(var i = 0;i<data.length;i++){
									html = html + "<figure class=\"figure\"><img src=\""+<%=path %>data[i]+"\" height=\"189\" width=\"129\" class=\"figure-img img-fluid rounded img-thumbnail\" ></figure>";
								}
								$("#picList").html(html);
							}
						}
					});
					$('#AnalysisVideo').modal('show');
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
			url : "<%=path %>/cama/findAddress",
			dataType : 'json',
			success : function(data) {
				var optionHtml = "";
				if(data.length > 0){
					for(var i = 0;i<data.length;i++){
						optionHtml = optionHtml + "<option value=\""+data[i].ADDRESS+"\">"+data[i].ADDRESS+"</option>";
					}
				}
				$("#address").append(optionHtml);
			}
		});
		$("#disasterForm").attr('action','/disaster/addDisaster');
		$('#AddDisasters').modal('show');
	}
	//编辑弹出框
	function func(id){
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : "<%=path %>/disaster/findById",
			dataType : 'json',
			success : function(data) {
				$('#disasterId').val(data.ID);
		    	$('#DisasterDname').val(data.DNAME);
		    	$('#DisasterCode').val(data.CODE);
		    	$('#DisasterContent').val(data.CONTENT);
			}
		});
		$("#disasterForm").attr('action','/disaster/upDisaster');
		$('#AddDisasters').modal('show');
	}
	//删除数据
	function del(data){
		   if(confirm("是否确认删除")){
			   $.ajax({
					async : false,
					type : "POST",
					data:{id:data},
					url : "<%=path %>/disaster/delDisaster",
					dataType : 'json',
					success : function(ret) {
						if (ret.state == "ok") {
							$('#DeleteSuccess').modal('show');
							location.href = "<%=path %>/disaster";
						} else {
							alert(ret.msg);
						}
					}
				});
		   }else{
			   return false; 
		   }
	   }
	//根据发生地点获得视频信息列表
	function findVideo(id,addr){
		$("#videoDisId").val(id);
		$.ajax({
			async : false,
			type : "POST",
			data:{addr:addr},
			url : "<%=path %>/disaster/findVideo",
			dataType : 'json',
			success : function(ret) {
				if(ret.state == "ok"){
					var data = ret.msg;
					var html = "";
					for(var i = 0 ;i < data.length;i++){
						html = html + "<div id=\"videoList\" class=\"mb-3\"><div class=\"form-group mb-1\"><div class=\"custom-control\"><span class=\"text-info h6 d-block\">"+data[i].CAMNAME+"</span></div></div>";
						var videos = data[i].VIDEOS;
						for(var j = 0;j<videos.length;j++){
							var path = videos[j].VIDEOPATH;
							var videoName = path.replace("/upload/video/", "");
							if(j % 2 ==0){
								html = html + "<div class=\"form-group mb-1\">";
							}
							html = html +"<div class=\"custom-control custom-checkbox custom-control-inline mr-2\"><input class=\"custom-control-input\" name=\"videoPath\" type=\"checkbox\"  id=\""+videos[j].ID+"\" ";
							html = html + "value=\""+videos[j].ID+"\"><label class=\"custom-control-label\" for=\""+videos[j].ID+"\">"+videoName+"</label></div>";
							if(j%2!=0){
								html = html + "</div>";
							}
						}
			        	html = html + "</div>";
					}
					$("#videosForm").html(html);
					$("#videosModal").modal("show");
				}else{
					alert(ret.msg);
				}
			}
		});
	}
	//分析视频，将视频截图，展示 
	function anasViewByPath(){
		var disId = $("#videoDisId").val();
		$("#misId").val(disId);
		var values = []; 
		$('input[name="videoPath"]:checked').each(function(){ 
			values.push($(this).val()); 
	    }); 
		if(values.length == 0){
			alert("你还没选中任何视频。");
			return false;
		}
		if(values.length > 1){
			alert("请选择一个视频进行分析。");
			return false;
		}
		$("#videosModal").modal("hide");
		$("#videoAnasModal").modal('show');
		$.ajax({
			async : false,
			type : "POST",
			data:{id:disId,path:values[0]},
			url : "<%=path %>/disaster/anasViewByPath",
			dataType : 'json',
			success : function(data) {
				if(data.length > 0){
					$("#anasFlag").val(1);//1表示对选择的视频进行分析
					var html = "";
					for(var i = 0;i<data.length;i++){
						html = html + "<figure class=\"figure\"><img src=\""+<%=path %>data[i]+"\" height=\"189\" width=\"129\" class=\"figure-img img-fluid rounded img-thumbnail\" ></figure>";
					}
					$("#picList").html(html);
					$('#AnalysisVideo').modal('show');
				}else{
					alert("没有发现人物信息");
				}
			}
		});
	}
	
	//人物比对，调用接口与人口基本信息库中进行对比 
	function contrast(){
		var misId = $("#misId").val();
		var flag = $("#anasFlag").val();
		$("#videoAnasModal").modal('hide');
		$('#AnalysisVideo').modal('hide');
		$('#picAnas').modal('show');
		$.ajax({
			async : false,
			type : "POST",
			data:{misId:misId,flag:flag},
			url : "<%=path %>/disaster/contrast",
			dataType : 'json',
			success : function(data) {
				$('#picAnas').modal('hide');
				alert("After the analysis, "+ data.length + "people were found");
				location.href = "<%=path %>/disaster/findEchartByDisId/"+misId;
			}
		});
	}
	//上传视频
	function uploadView(data){
		$("#uploadViewForm").attr('action','/disaster/upload/'+ data);
		$('#uploadVideo').modal('show');
	}
	function findByDisId(data){
		location.href = "<%=path %>/disaster/findEchartByDisId/"+data;
	}
	</script>
	</body>
</html>
