<%@page import="uuu.lav.entity.Order_lav"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>La Vainilla | 香草屋 結帳成功</title>
		<link rel="stylesheet" type="text/css" href="/lav/css/lav.css">
		<style>
			#searchForm{float: right;}
			
			#checkOutOk {width:75%;text-align: center;margin: auto}
			#checkOutOk img{vertical-align: text-top;}
			h1,h2,h3{width:75%;text-align:center;margin:auto}	
		</style>
		
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
				integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
				crossorigin="anonymous"></script>
		
		<script>
		
		$(init);		

		function init(){
			
		}

		</script>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" />

		<%@include file="/subviews/nav.jsp" %>	
		<article>
			<%
				Order_lav order = (Order_lav)request.getAttribute("order");
			
			%>		
			<h1 id='checkOutOk'>
				<img src='../images/checkOutOk.png'>
				<br><br>
				<% if(order!=null) {%>
				訂單<a href='order.jsp?orderId=<%= order.getId() %>'><%= order.getIdString() %></a>已完成，感謝您的訂購!
				<%}else{ %>
				<h2>剛才訂單尚未完成</h2>
				<% }%>
			</h1>
			<br><br>
			<h3><a href="../">回首頁</a> <a href='orders_history.jsp'>訂單查詢</a></h3>
		
		</article>
		<%@include file="/subviews/footer.jsp" %>

	</body>

</html>