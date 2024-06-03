<%@page import="uuu.lav.entity.OrderStatusLog_lav"%>
<%@page import="java.util.List"%>
<%@page import="uuu.lav.entity.PaymentType_lav"%>
<%@page import="uuu.lav.entity.OrderItem_lav"%>
<%@page import="uuu.lav.entity.Order_lav"%>
<%@page import="uuu.lav.service.OrderService_lav"%>
<%@page import="uuu.lav.entity.CartItem_lav"%>
<%@page import="uuu.lav.entity.ShoppingCart_lav"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 訂單明細</title>
	<link rel="stylesheet" type="text/css" href="/lav/css/lav.css">
	<style>
		#searchForm{float: right;}

		#dataTable{width: 85%;}
		#dataTable thead td{font-size: large}
		#totalAmountWithFeeSpan{color: #FD5308}

		.statusList{margin: auto;width:22em}				
		.statusDiv{background-color: lightgray;display: inline-block;color:white;font-size:smaller;
					width:4em;height:3.75ex;padding: 1ex 0.15ex 0.5ex;text-align: center}							
		.theStatusDiv{background-color:  #FD5308;}			
		.statusDiv,.theStatusDiv{border-radius: 5px} 

		#orderTable{width: 75%;font-size: smaller;}
			
		#orderTable, #dataTable {
			  border-collapse: collapse;
			  margin: auto;
			  margin-bottom: 1ex;
			}
			
		#orderTable td, #orderTable th{
			  border: 1px solid #ddd;
			  padding: 8px;			 
			}
			
		#orderTable tbody tr:nth-child(even){background-color: #E2D8CE;}
			
		#orderTable tr:hover {background-color: #9B8884;}
			
		#orderTable th,  #orderTable caption{
			  padding-top: 12px;
			  padding-bottom: 12px;			  
			  background-color: #BA8D6C;
			  color: black;
			}
			
		#orderTable tbody td{text-align: left;}		
			
		.cartPhoto{width:50px; float: left;}
		.listPriceDiv{color: gray; text-decoration: line-through;}
		.discountDiv{color: darkred;}
		.unitPriceDiv{color: #FD5308;font-size: larger;}
			
		fieldset label{display: inline-block; min-width: 3.5em}
		fieldset input:not([type='button'],[type='checkbox']){width:70%}

		#dataTable label{color:gray}
	</style>
	
<!-- 	<script src="https://code.jquery.com/jquery-3.0.0.js"  -->
<!-- 			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo="  -->
<!-- 			crossorigin="anonymous"></script> -->
			
	<script>
//		$(init);		

//		function init(){			
//		}

	</script>
</head>
<body>
<!-- 寫法一 -->
	<jsp:include page="/subviews/header.jsp" />
<!-- 寫法二 -->
<%-- 		<jsp:include page="/subviews/header.jsp"> --%>
<%-- 			<jsp:param value="檢視訂單明細" name="subheader"/> --%>
<%-- 		</jsp:include> --%>

		<%@include file="/subviews/nav.jsp" %>

		<%
		String orderId = request.getParameter("orderId");
			OrderService_lav oService = new OrderService_lav();
			Order_lav order = null;
			List<OrderStatusLog_lav> statusLogList = null;
			int lastStatus= 1;
			if(member!=null && orderId!=null){
				order = oService.getOrderById(member, orderId);
				if(order!=null){
			            	statusLogList = oService.getOrderStatusLog(orderId);
			            }
			}
		%>	

	<article>
			<%
			if(order==null){
			%>
				<h2>查無該筆訂單</h2>		
			<%
					}else{
					%>
			<table id='dataTable'>
			<thead>
				<tr>
					<td colspan='1'><label>訂單:</label> <%=order.getIdString()%>
									<label>狀態:</label> <%=order.getStatusString()%></td>
					<td colspan='1'><%=order.getOrderDate()%> <%=order.getOrderTime()%></td>
					<td rowspan='4' colspan='4' style='width:50%;'>
						<div class='statusList'>
							<div class='statusDiv theStatusDiv' id='statusNEW'>新訂單</div> > 
						<%if(statusLogList!=null && statusLogList.size()>0){%>
							<%for(OrderStatusLog_lav statusLog:statusLogList) { lastStatus=statusLog.getStatus(); %>
							<div class='statusDiv theStatusDiv' title= '<%= statusLog.getLogTime() %>'>
								<%= Order_lav.getStatusString(statusLog.getStatus()) %>
								</div> <%= statusLog.getStatus()<6? ">":"" %>
							<% } %>
						<% } %>
						<% for(int i=lastStatus+1 ;i<=6 ; i++){
							switch(i) {case 1: case 4: continue;} %>
							<div class='statusDiv'> <%= Order_lav.getStatusString(i) %></div> <%=i<6? ">":"" %>
						<% } %>
						</div>
						
					</td>
				</tr>				
				<tr>
					<td colspan='1'>
						<label>貨運/付款:</label>							
						<span><%= order.getShippingType().getDescription() %>,
						 	  <%= order.getShippingFee()>0? order.getShippingFee():"" %></span>/
						<span><%= order.getPaymentType().getDescription() %></span>
							  <%= order.getPaymentFee()>0? order.getPaymentFee():"" %></span>
							  
						<% if(order.getStatus()==0 && order.getPaymentType()==PaymentType_lav.ATM){%>
							<a href='atm_transfered.jsp?orderId=<%= order.getId()%>'>通知已轉帳</a>
						<% }%>
						
					</td>
					<td colspan='1' style='text-align: right'>
						含手續費總共:<span id='totalAmountWithFeeSpan'><%= order.getTotalAmountWithFee() %></span>元
					</td>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan='6'>
						<fieldset>
							<legend>收件人</legend>
							<label>姓名:</label><input type='text' value='<%= order.getRecipientName()%>' readonly><br>
							<label>email:</label><input type='text' value='<%= order.getRecipientEmail()%>' readonly><br>
							<label>手機:</label><input type='text' value='<%= order.getRecipientPhone()%>' readonly><br>
							<label>地址:</label><input type='text' value='<%= order.getShippingAddress()%>' readonly>	
						</fieldset> 
					</td>
				</tr>
			</tfoot>
			</table>
			
			<table id='orderTable' >
				<caption>訂單明細</caption>
				<thead>
					<tr>						
						<th>名稱</th>
						<th>味道/規格</th>					
						<th>價格</th>
						<th>數量</th>	
						<th>小計</th>
					</tr>
				</thead>
				<tbody>
					<% for(OrderItem_lav orderItem:order.getOrderItemSet()){%>
					<tr>
						<td>
							<img class='cartPhoto' src='<%= orderItem.getPhotoUrl()%>'>
							<div style='font: larger;'><%= orderItem.getProductName() %></div>
						</td>
						<td><%= orderItem.getFlavorName() %> <%= orderItem.getSpecName() %></td>					
						<td>
							<div class='unitPriceDiv'><%= orderItem.getPrice() %>元</div>
						</td>
						<td><%= orderItem.getQuantity() %></td>		
						<td><%=orderItem.getPrice() * orderItem.getQuantity() %>元</td>
					</tr>
					<% } %>
				</tbody>
				<tfoot>
					<tr>
						<td colspan='4'>共<%= order.size()%>項, <%= order.getTotalQuantity() %>件</td>
						<td colspan='2'>共<span id='totalAmountSpan'><%= order.getTotalAmount() %></span>元</td>
					</tr>
				</tfoot>
			</table>
			<% } %>	
	</article>

	<%@include file="/subviews/footer.jsp" %>
	
</body>
</html>