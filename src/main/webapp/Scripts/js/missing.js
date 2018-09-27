	var localObj = window.location;
	var contextPath = localObj.pathname.split("/")[1];
	var basePath = localObj.protocol+"//"+localObj.host;
	//编辑弹出框
	function func(id){
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : basePath+"/missing/findById",
			dataType : 'json',
			success : function(data) {
				var src = basePath;
				if(data.PICPATH == null){
					src =  src + "/img/photo.png";
				}else{
					src = src + data.PICPATH;
				}
				$('#picpath').attr("src",src);
		    	$('#misname').html(data.MIUSER);
		    	$('#sex').html(data.SEX);
		    	$('#usercode').html(data.USERCODE);
		    	$("#mistell").html(data.SZTEL);
		    	$('#misdate').html(data.MISDATE);
		    	$('#address').html(data.ADDRESS);
		    	$("#content").html(data.CONTENT);
		    	$('#reuser').html(data.REUSER);
		    	$('#tel').html(data.TEL);
			}
		});
		$('#detailsSuccuss').modal('show');
	}
	//审核失踪信息
	function status(id){
		$.ajax({
			async : false,
			type : "POST",
			data:{id:id},
			url : basePath + "/missing/findMisById",
			dataType : 'json',
			success : function(data) {
				$('#stMisId').val(data.ID);
				if(data.STATUS == "审核不通过"){
					$("#unstatusManage").attr("checked","checked");
				}else{
					$("#statusManage").attr("checked","checked");
				}
			}
		});
		$('#AllotPower').modal('show');
	}
	//审核失踪信息提交
	function upStatus(){
		var misId = $("#stMisId").val();
		var status = $('input:radio[name="mis.status"]:checked').val();
		$.ajax({
			async : false,
			type : "POST",
			data:{misId:misId,status:status},
			url : basePath + "/missing/finfs",
			dataType : 'json',
			success : function(ret) {
				if (ret.state == "ok") {
					location.href = basePath + "/missing";
				} else {
					alert(ret.msg);
				}
			}
		});
	}
	//删除失踪信息
	function del(id){
		if(confirm("是否删除失踪信息")){
			   $.ajax({
					async : false,
					type : "POST",
					data:{id:id},
					url : basePath + "/missing/delMis",
					dataType : 'json',
					success : function(ret) {
						if (ret.state == "ok") {
							$('#DeleteSuccess').modal('show');
							location.href = basePath + "/missing";
						} else {
							alert(ret.msg);
						}
					}
				});
		   }else{
			   return false; 
		   }
	}
	//警方首先对获得的地点信息列表进行选择，查看相应的监控信息
	function ans(id){
		$("#videoMisId").val(id);
		$.ajax({
			async : false,
			type : "POST",
			url : basePath + "/cama/findAddress",
			dataType : 'json',
			success : function(data) {
				if(data.length > 0){
					var html = "";
					for(var i = 0;i<data.length;i++){
						if(i % 2 ==0){
							html = html + "<div class=\"form-group mb-1\">";
						}
						html = html +"<div class=\"custom-control custom-checkbox custom-control-inline mr-2\"><input class=\"custom-control-input\" name=\"address\" type=\"radio\"  id=\""+data[i].ADDRESS+"\" ";
						html = html + "value=\""+data[i].ADDRESS+"\"><label class=\"custom-control-label\" for=\""+data[i].ADDRESS+"\">"+data[i].ADDRESS+"</label></div>";
						if(i%2!=0){
							html = html + "</div>";
						}
					}
					$("#areasForm").html(html);
					$("#areasModal").modal("show");
				}
			}
		});
   }
	//获得所选地点的监控信息列表 
	function findView(){
		var misId = $("#videoMisId").val();
		$("#areaVideoMisId").val(misId);
		var addr = $('input[name="address"]:checked').val();
		if(addr == undefined){
			alert("请选择地点信息。");
			return false;
		}
		$.ajax({
			async : false,
			type : "POST",
			data:{addr:addr},
			url : basePath + "/disaster/findVideo",
			dataType : 'json',
			success : function(ret) {
				$("#areasModal").modal("hide");
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
					$("#StartWastonAnalysisNone").modal("show");
				}
			}
		})
	}
	//分析视频，将视频截图，展示 
	function anasView(){
		var disId = $("#areaVideoMisId").val();
		$("#picMisId").val(disId);
		var values = []; 
		$('input[name="videoPath"]:checked').each(function(){ 
			values.push($(this).val()); 
	    }); 
		if(values.length == 0){
			alert("你还没选中任何视频。");
			return false;
		}
		if(values.length > 2){
			alert("选择的视频应小于两个。");
			return false;
		}
		$.ajax({
			async : false,
			type : "POST",
			data:{id:disId,path:values},
			url : basePath + "/missing/anasView",
			dataType : 'json',
			success : function(ret) {
				$("#videosModal").modal("hide");
				if(ret.state == "ok"){
					var msg = ret.msg;
					var html = "";
					for(var i = 0;i<msg.length;i++){
						html = html + "<div class=\"mb-3\"><span class=\"text-info h6 d-block address\">"+msg[i].address +'>'+"</span>";
						var data = msg[i].paths;
						for(var j = 0;j<data.length;j++){
							html = html + "<figure class=\"figure\"><img src=\""+basePath +data[j]+"\" height=\"109\" width=\"89\" class=\"figure-img img-fluid rounded img-thumbnail\" ></figure>";
						}
						html = html +"</div>";
					}
					$("#picList").html(html);
				}
			}        
		});
		$('#AnalysisVideo').modal('show');
	}
	//人物比对，调用接口与人口基本信息库中进行对比 
	function contrast(){
		var misId = $("#picMisId").val();
		var addrs = $(".address").text();
		$.ajax({
			async : false,
			type : "POST",
			data:{misId:misId,addrs:addrs},
			url : basePath + "/missing/contrast",
			dataType : 'json',
			success : function(data) {
				$('#AnalysisVideo').modal('hide');
				if(data.length > 1){
					$("#misId").val(misId);
					$("#videoArea").text(data[0].addr);
					var picHtml = "";
					for(var i = 1;i<data.length;i++){
						picHtml = picHtml + "<figure class=\"figure\"><img src=\""+ basePath +data[i].PICPATH+"\" height=\"189\" width=\"129\" class=\"figure-img img-fluid rounded img-thumbnail\" >"+
						   "<figcaption class=\"figure-caption\"> 分数："+data[i].SCORE+"</figcaption></figure>"
					}
					$("#videopicList").html(picHtml);
					$("#send").attr("style","display:block;");
					$("#seState").attr("style","display:none;");
					$('#StartWastonAnalysisHave').modal('show');
				}else{
					$("#noMisId").val(misId);
					$('#StartWastonAnalysisNone').modal('show');
				}
			}
		});
	}
	//上传公视平台
	function upTopub(){
		var misId = $("#noMisId").val();
		$.ajax({
			async : false,
			type : "POST",
			data:{misId:misId},
			url : basePath + "/missing/upTopub",
			dataType : 'json',
			success : function(ret) {
				if (ret.state == "ok") {
					location.href = basePath + "/missing/publicindex";
				} else {
					alert(ret.msg);
				}
			}
		});
	}
	//分析找到后，推送联系人消息
	function toRePer(){
		var misId = $("#misId").val();
		var addr = $("#videoArea").text();
		$.ajax({
			async : false,
			type : "POST",
			data:{misId:misId,addr:addr},
			url : basePath + "/missing/toRePer",
			dataType : 'json',
			success : function(ret) {
				if (ret.state == "ok") {
					location.href = basePath + "/missing";
				} else {
					alert(ret.msg);
				}
			}
		});
	}
	//失踪者轨迹信息
	function route(id){
		$("#area").html("");
		$("#picList").html("");
		$.ajax({
			async : false,
			type : "POST",
			data:{misId:id},
			url : basePath + "/missing/route",
			dataType : 'json',
			success : function(data) {
				var areaHtml = "";
				var picHtml = "";
				if(data.length > 0){
					$("#misId").val(data[0].MISID);
					for(var i = 0;i<data.length;i++){
						areaHtml = areaHtml + "<span>"+data[i].ADDRESS+"</span>--";
						picHtml = picHtml + "<figure class=\"figure\"><img src=\""+basePath + data[i].PICPATH+"\" height=\"189\" width=\"129\" class=\"figure-img img-fluid rounded img-thumbnail\" >"+
						   "<figcaption class=\"figure-caption\">"+data[i].ADDRESS+"</figcaption></figure>"
					}
					$("#videoArea").html(areaHtml);
					$("#videopicList").html(picHtml);
					$('#StartWastonAnalysisHave').modal('show');
					$("#send").attr("style","display:none;");
					$("#seState").attr("style","display:block;");
				}else{
					alert("没有找到失踪者的轨迹信息。");
				}
				
			}
		});
	}
	//变更失踪状态
	function toseState(){
		var misId = $("#misId").val();
		$.ajax({
			async : false,
			type : "POST",
			data:{misId:misId},
			url : basePath + "/missing/toseState",
			dataType : 'json',
			success : function(ret) {
				if (ret.state == "ok") {
					location.href = basePath + "/missing/doneindex";
				} else {
					alert(ret.msg);
				}
			}
		});
	}
	//重新开始地点选择
	function reFind(){
		var misId = $("#noMisId").val();
		ans(misId);
	}