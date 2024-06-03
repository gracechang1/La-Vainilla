<%@page import="uuu.lav.entity.VIP_lav"%>
<%@page import="uuu.lav.entity.Customer_lav"%>
<%@ page pageEncoding="UTF-8"%>

<!-- 內部轉址 -->
<%-- 	<% Customer_lav c= (Customer_lav)request.getAttribute("member"); %> --%>
<!-- 外部轉址	 -->
	<% Customer_lav member=(Customer_lav)session.getAttribute("member");   %>
	
	<nav id="pageNav">
		<ul id="siteNav">
			<a href="<%= request.getContextPath() %>/aboutus.jsp">關於我們</a>
			<a href="<%= request.getContextPath() %>/product_list.jsp">產品項目</a>
			
		<%if(member==null){ %>
			<a href="<%= request.getContextPath() %>/login.jsp">登入會員</a>
			<a href="<%= request.getContextPath() %>/register.jsp">註冊會員</a>			
		<% }else {%>
			<a href="<%= request.getContextPath() %>/member/update_member.jsp">修改會員資料</a>
			<a href="<%= request.getContextPath() %>/member/orders_history.jsp">歷史訂單</a> 			
			<a href="<%= request.getContextPath() %>/logout.do">登出會員</a>
		<% } %>	
				
			<a href="<%= request.getContextPath() %>/asked_question.jsp">FAQ常見說明</a>
			
			
		<span id="welcomeSpan" style="float:right; color:#E35106 ">	
			<a href='<%= request.getContextPath() %>/member/cart.jsp'>
				<img class='cartIconImg' src='<%=request.getContextPath() %>/images/cart.png'>
				(<span class='cartQty'>${sessionScope.cart==null?"0":cart.getTotalQuantity()}</span>)
<!-- cart icorn後顯示：有多少產品數量加入購物車(EL寫法) -->
				
			</a>
			<%= member!=null? member.getName()+"會員，您好!":"歡迎光臨" %> 
			<%= (member instanceof VIP_lav)? "(VIP)":"" %> 
		</span>
		
		</ul>
		
		<hr>
	</nav>
