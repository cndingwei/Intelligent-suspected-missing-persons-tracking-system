<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>、
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js fixed-layout">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>关系列表</title>
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
</head>
<body>
 <c:import url="/common/header.jsp"></c:import>
<div class="am-cf admin-main" style="padding-top:27px !important;">
  <c:import url="/common/menu.jsp"></c:import>
  <!-- content start -->
  <div class="admin-content">
    <div class="admin-content-body">
      <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">关系列表</strong></div>
      </div>

      <hr>

      <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
          <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
              <a href="<%=path %>/rela/form" type="button" class="am-btn am-btn-default"><span class="am-icon-plus"></span> 新增角色</a>
            </div>
          </div>
        </div>
      </div>

      <div class="am-g">
        <div class="am-u-sm-12">
          <form class="am-form">
            <table class="am-table am-table-striped am-table-hover table-main">
              <thead>
              <tr>
                <th class="table-check"><input type="checkbox" /></th>
                <th class="table-title">关系名称</th>
                <th class="table-type">备注</th>
                <th class="table-set">操作</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${relaList.list}" var="rela">
                   <tr>
		                <td><input type="checkbox" /></td>
		                <td class="am-hide-sm-only">${rela.name }</td>
		                <td class="am-hide-sm-only">${rela.remark }</td>
		                <td>
		                  <div class="am-btn-toolbar">
		                    <div class="am-btn-group am-btn-group-xs">
		                      <a href="<%=path %>/rela/form/${rela.ID }" class="am-btn am-btn-default am-btn-xs am-text-secondary">
		                           <span class="am-icon-pencil-square-o"></span> 编辑</a>
		                      <a href="#" onclick="del(${rela.ID })" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only">
		                           <span class="am-icon-trash-o"></span> 删除</a>
		                    </div>
		                  </div>
		                </td>
		              </tr>
		    	</c:forEach>
              </tbody>
            </table>
            <div class="am-cf">
              共${relaList.totalRow}条记录
              <div class="am-fr">
                <ul class="am-pagination">
                   <c:choose>  
		                <c:when test="${relaList.pageNumber>1 }"> 
		                	<li><a href="<%=path%>/rela?p=${relaList.pageNumber>1?relaList.pageNumber-1:1}">«</a></li> 
		                </c:when>  
		                <c:otherwise>  
		                    <li class="am-disabled"><a href="#">«</a></li>  
		                </c:otherwise>  
		            </c:choose>  
		            <c:forEach var="p" begin="1" end="${relaList.totalPage }">  
		                <li <c:if test="${relaList.pageNumber == p}">class="am-active"</c:if>><a href="<%=path%>/rela?p=${p }">${p }</a>  </li>
		            </c:forEach>  
		            <c:choose>  
		                <c:when test="${relaList.pageNumber<relaList.totalPage}">
		                    <li><a href="<%=path%>/rela?p=<c:choose>
		                    	<c:when test="${relaList.pageNumber<relaList.totalPage }">${relaList.pageNumber+1}</c:when>
		                    	<c:otherwise>${relaList.totalPage}</c:otherwise>
		                    </c:choose>">»</a></li>  
		                </c:when>  
		                <c:otherwise>  
		                    <li class="am-disabled"><a href="#">»</a></li>
		                </c:otherwise>  
		            </c:choose>   
                </ul>
              </div>
            </div>
          </form>
        </div>

      </div>
    </div>
    <c:import url="/common/footer.jsp"></c:import>
  </div>
  <!-- content end -->
</div>

<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<%=path %>/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<%=path %>/Scripts/jquery-1.10.2.min.js"></script>
<!--<![endif]-->
<script src="<%=path %>/assets/js/amazeui.min.js"></script>
<script src="<%=path %>/assets/js/app.js"></script>
<script type="text/javascript">
   function del(data){
	   if(confirm("是否确认删除")){
		   $.ajax({
				async : false,
				type : "POST",
				data:{id:data},
				url : "<%=path %>/rela/delRela",
				dataType : 'json',
				success : function(ret) {
					if (ret.state == "ok") {
						location.href = "<%=path %>/rela";
					} else {
						alert(ret.msg);
					}
				}
			});
	   }else{
		   return false; 
	   }
   }
</script>
</body>
</html>
