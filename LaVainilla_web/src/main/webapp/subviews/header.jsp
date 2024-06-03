<%@ page pageEncoding="UTF-8"%>

<header id="pageHeader">
		
		<a href="<%= request.getContextPath()%>">
			<img src="<%= request.getContextPath() %>/images/trademark.PNG" alt="Logo" border="0" class="logo">
		</a>
		
	<form id="searchForm" action="<%= request.getContextPath() %>/product_list.jsp" method="GET">
		<input type="search" name="search" placeholder="請輸入關鍵字或產品名稱">
		<input type="submit" value="查詢">
	</form>
	<hr>
	
</header>

<!-- 若有下標題 -->
<!-- 		<sub> -->
<%-- 			<%= request.getParameter("subheader")==null?"首頁":request.getParameter("subheader") %> --%>
<!-- 		</sub> -->
