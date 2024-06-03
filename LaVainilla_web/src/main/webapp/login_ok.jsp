<%@ page import="uuu.lav.entity.Customer_lav"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%
	String prevURI = (String)session.getAttribute("prevURI");
	String redirectURI = prevURI!=null?prevURI:"./"; 
	session.removeAttribute("prevURI");
%>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="refresh" content="8; url=<%= redirectURI%>"/>
	<title>La Vainilla | 香草屋 登入成功</title>
	<link rel="stylesheet" type="text/css" href="css/lav.css">
	<link rel="stylesheet" href="themes/pepper-grinder/jquery-ui.css" />
	<script type="text/javascript" src="jquery_jquery-ui/jquery.js"></script>
	<script type="text/javascript" src="jquery_jquery-ui/jquery-ui.js"></script>
	<style>
		.ui-progressbar{
			margin:auto;
			width:50%;
			position: relative;
			text-align: center;
 			background: #E2D8CE;
		}
		.ui-progressbar-value{
 			background: #AF5C4A
		}
		
		#searchForm{float: right;}
	</style>
	
	<script type="text/javascript">
	$(document).ready(init);
	function init() {
		$("#myProgressbar").progressbar({
			value:false,
			max: 200,
		});
	}
	
	</script>
</head>
<body>

	<jsp:include page="./subviews/header.jsp" />

	<article>
	
<!-- 內部轉址	 -->
<%-- 		<% Customer_lav c= (Customer_lav)request.getAttribute("member"); %> --%>
<!-- 外部轉址	 -->
		<% Customer_lav c= (Customer_lav)session.getAttribute("member"); %>
	
		<h1 style="width:50%; margin:auto; line-height: 40px;">
			<p>歡迎光臨 香草屋<br> 
			<%= c!=null? c.getName()+"會員，您好!":"您尚未登入會員，請選擇登入或註冊會員" %><br>
			</p>
		</h1>
		
		<p style="width:50%; margin:auto; line-height: 30px;" >
		稍後將自動為您跳轉至<a href="<%= redirectURI%>">首頁</a><br>
		或請點選左上方圖片或首頁連結，將直接進入首頁<br><br>
		<div id="myProgressbar">跳轉中...</div>
		</p>
		
	</article>

	<%@include file="./subviews/footer.jsp" %>

</body>

</html>