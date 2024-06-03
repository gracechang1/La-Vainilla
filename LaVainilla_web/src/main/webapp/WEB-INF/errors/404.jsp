<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 404</title>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/lav.css">
	<style>
		#searchForm{float: right;}
		article img{display: block; margin: auto; width:50%}
	</style>
	<script>
	
	</script>
</head>
<body>
<!-- 寫法一 -->
	<jsp:include page="/subviews/header.jsp" />
<!-- 寫法二	 -->
<%-- 	<jsp:include page="/subviews/header.jsp"> --%>
<%-- 		<jsp:param value="找不到檔案" name="subheader"/> --%>
<%-- 	</jsp:include> --%>

	<%@include file="/subviews/nav.jsp" %>

	<article>
		<img src="<%= request.getContextPath() %>/images/404.png">
	</article>

	<%@include file="/subviews/footer.jsp" %>

</body>
</html>