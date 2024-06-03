<%@page import="java.time.LocalDate"%>
<%@page import="uuu.lav.service.OrderService_lav"%>
<%@page import="uuu.lav.entity.Order_lav"%>
<%@page import="uuu.lav.entity.PaymentType_lav"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 通知已轉帳</title>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/lav.css">
	<style>
		#searchForm{float: right;}
      	.darkredErrors {color:darkred}
		form p label:first-child {display: inline-block;min-width: 5em}  
	</style>
	
	<script>

	</script>
</head>
<body>
<!-- 寫法一 -->
	<jsp:include page="/subviews/header.jsp" />
<!-- 寫法二 -->
<%-- 		<jsp:include page="/subviews/header.jsp"> --%>
<%-- 			<jsp:param value="通知已轉帳" name="subheader"/> --%>
<%-- 		</jsp:include> --%>

		<%@include file="/subviews/nav.jsp" %>

  <%        
          String orderId = request.getParameter("orderId");
          Order_lav order = null;
          OrderService_lav oService = new OrderService_lav();
          if(member!=null && orderId!=null){
              order = oService.getOrderById(member, orderId);            
          }      
      %>

	<article>
	
     <% if(order==null || !(PaymentType_lav.ATM==order.getPaymentType() && order.getStatus()==0)){%>
          <p>查無需通知轉帳的訂單資料，請選擇<a href='orders_history.jsp'>歷史訂單</a>查詢</p>
      <% }else{%>
     	<div class='darkredErrors'>${errors}</div>
       <form action='atm_transfered.do' method='POST' style='width: 20em; margin: auto;'>
          <p>
              <label>訂單編號:</label>
              <input type='hidden' name='orderId' value='<%= orderId%>' readonly>
              <input value='<%= order.getIdString()%>' readonly>
          </p>
           <p>
              <label>轉帳銀行:</label>
              <input name='bank' required placeholder='請輸入轉帳銀行名稱'>
          </p>
          <p>
              <label>帳號後5碼:</label>
              <input name='last5Code' required placeholder='請輸入轉帳帳號後5碼'>
          </p>
           <p>
              <label>轉帳金額:</label>
              <input name='amount' name='amount' required value='<%= order.getTotalAmountWithFee() %>' >
          </p>
           <p>
              <label>轉帳時間:</label>
              <input type='date' name='transDate' required min='<%= order.getOrderDate()%>' max='<%= LocalDate.now()%>'>
              <input type='time' name='transTime' required>
          </p>
          <p style='text-align:right'>
              <input type="reset" value='重置'>
              <input type="submit" value='確定'>
          </p>
      </form>
      <% } %>
 	
	
	</article>

	<%@include file="/subviews/footer.jsp" %>
	
</body>
</html>