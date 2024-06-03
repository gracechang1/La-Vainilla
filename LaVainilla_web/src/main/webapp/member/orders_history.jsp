<%@page import="java.util.List"%>
<%@page import="uuu.lav.entity.Order_lav"%>
<%@page import="uuu.lav.service.OrderService_lav"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 歷史訂單</title>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/lav.css">
	<style>
		#searchForm{float: right;}
		
		#ordersTable th{background-color:  #BA8D6C; color:black; border-bottom: gray 1px solid; padding: 1ex }
		#ordersTable th, #ordersTable td{text-align: center}
		
	</style>
	
	<script>
	
	</script>
</head>
<body>
<!-- 寫法一 -->
	<jsp:include page="/subviews/header.jsp" />
<!-- 寫法二 -->
<%-- 		<jsp:include page="/subviews/header.jsp"> --%>
<%-- 			<jsp:param value="Orders History" name="subheader"/> --%>
<%-- 		</jsp:include> --%>

		<%@include file="/subviews/nav.jsp" %>

		<%
			int r=1;
			String range = request.getParameter("range");
			if(range!=null && range.matches("\\d{1,2}")){
				r = Integer.parseInt(range);
				if(r!=1 && r!=6 && r!=24) r=1;
			}		
		%>


	<article>
		<form style='margin: 1em auto; width:50%; text-align: center;'>
			<input type='radio' value='1' name=range required checked><label>最近1個月</label>
			<input type='radio' value='6' name=range required <%= r==6? "checked":"" %>><label>最近半年</label>
			<input type='radio' value='' checked name=range required <%= r==24?"checked":"" %>><label>全部訂單(只能查到最近2年)</label>
			<input type="submit" value='查詢指定區間的訂單'>
		</form>

			<%
				OrderService_lav oService = new OrderService_lav();
				List<Order_lav> list = null;
				if(member!=null){
					switch(r){
					case 24: list=oService.getOrdersHistory2YearsAgo(member);break;
					case 6: list=oService.getOrdersHistory6MonthsAgo(member);break;						
					default:list=oService.getOrdersHistory1MonthAgo(member);
					}
				}
			%>
<%-- 			<%=list %> --%>
			<% if(list==null || list.isEmpty()) {%>
				<h2>查無<%=r%>個月內的訂單</h2>
			<% }else{%>
		
		<table id='ordersTable' style='width:80%;margin: auto;'>
			<caption>歷史訂單</caption>
			<thead>
				<tr><th>訂單編號</th><th>訂購日期時間</th><th>處理狀態</th><th>總金額</th><th>取貨/付款方式</th></tr>
			</thead>
			<tbody>
				<% for(Order_lav order:list){%>
				<tr>
					<td><a href='order.jsp?orderId=<%= order.getId()%>'><%= order.getIdString() %></a></td>
					<td><%= order.getOrderDate() %> <%= order.getOrderTime() %></td>
					<td><%= order.getStatusString() %></td>
					<td><%= order.getTotalAmountWithFee() %>元</td>
					<td><%= order.getShippingType().getDescription() %>/<%= order.getPaymentType().getDescription() %></td>
				</tr>
				<% }%>
			</tbody>
		</table>
		<% } %>	
	</article>

	<%@include file="/subviews/footer.jsp" %>
	
</body>
</html>