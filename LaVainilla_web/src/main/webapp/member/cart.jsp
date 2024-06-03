<%@page import="uuu.lav.service.ProductService_lav"%>
<%@page import="uuu.lav.entity.CartItem_lav"%>
<%@page import="uuu.lav.entity.ShoppingCart_lav"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 購物車明細</title>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/lav.css">
	<style>
		#searchForm{float: right;}
		
		#cartTable {
/* 			  font-family: Arial, Helvetica, sans-serif; */
/* 			  font-size: smaller; */
			  border-collapse: collapse;
			  width: 85%;margin: auto;
			}
			
		#cartTable td, #cartTable th {
			  border: 1px solid #9B8884;
			  padding: 8px;			 
			}
			
		#cartTable tobody tr:nth-child(even){background-color: #E2D8CE;}
		
		#cartTable tbody input[type=number]{width: 3em}
		
		#cartTable tbody tr:hover {background-color: #9B8884;}
			
		#cartTable th,  #cartTable caption{
			  padding-top: 12px;
			  padding-bottom: 12px;			  
			  background-color: #BA8D6C;
			  color: black;
			}
			
			.cartPhoto{width:50px;float: left;}
			.listPriceDiv{color:gray;text-decoration: line-through;font-size: smaller;}
			.discountDiv{color:black;}
			.unitPriceDiv{color:#FD5308;}
			.amountTd{font-size: smaller;}
			
			.updateSubmitAlign  {text-align: right}
	</style>
	
	<script>
// 		function checkout(){
// 			location.href="check_out.jsp";
// 		}	

	</script>
</head>
<body>
<!-- 寫法一 -->
	<jsp:include page="/subviews/header.jsp" />
<!-- 寫法二 -->
<%-- 		<jsp:include page="/subviews/header.jsp"> --%>
<%-- 			<jsp:param value="Cart" name="subheader"/> --%>
<%-- 		</jsp:include> --%>

		<%@include file="/subviews/nav.jsp" %>

	<article>
<%-- 			<div>${cart}</div> --%>
			<% 
				ShoppingCart_lav cart = (ShoppingCart_lav)session.getAttribute("cart");			
				if(cart!=null && member!=null){
					cart.setMember(member);
				}
			%>
			<%
				if(cart==null || cart.isEmpty()){
			%>
			<h2>您尚未購買任何商品，請先至<a href='../product_list.jsp'>賣場選購商品</a>!</h2>
			<%}else{ %>
			<form id='cartForm' method='post' action="update_cart.do">
			<table id='cartTable'>
			<caption>購物車明細</caption>
			<thead>
				<tr>
					<th>是否購買</th>
<!-- 					<th>產品編號</th> -->
					<th>名稱</th>
					<th>味道/規格</th>					
					<th>價格</th>
					<th>數量</th>	
					<th>小計</th>		
					<th>刪除</th>				
				</tr>
			</thead>
			<tbody>
				<% ProductService_lav pService = new ProductService_lav();
				   for(CartItem_lav cartItem:cart.getCartItemSet()){	
					 int stk = pService.getStockByProductIdFlavorNameSpecName(cartItem.getProduct().getId(), cartItem.getFlavorName(), cartItem.getSpecName());
					 cartItem.setStock(stk);
				 %>		
				<tr>
					<td><input type=checkbox name='checkout<%=cartItem.hashCode() %>' <%=cartItem.isCheckOut()?"checked":"" %>></td>			
<%-- 					<td><%= cartItem.getProductId() %></td> --%>
					<td>
						<img class='cartPhoto' src='<%=cartItem.getPhotoUrl() %>'>
						<div><a href='../product_detail.jsp?productId=<%=cartItem.getProductId() %>'><%=cartItem.getProductName() %></a></div>
						<small style='color: #FD5308'>庫存: 
							<%=cartItem.getStock() %>
						</small>
					</td>
					<td><%=cartItem.getFlavorSpecName() %></td>					
					<td>
						<div class='listPriceDiv'><%=cartItem.getListPrice() %>元</div>
						<div class='discountDiv'><%=cartItem.getDiscountString() %></div>
						<div class='unitPriceDiv'><%=cartItem.getUnitPrice() %>元</div>
					</td>
					<td><input type='number' min='1' max='<%=cartItem.getStock() %>' required 
									name="quantity<%=cartItem.hashCode() %>"
									value='<%=cart.getQuantity(cartItem) %>'></td>		

					<td class='amountTd'><%=cartItem.getUnitPrice() * cart.getQuantity(cartItem) %>元</td>
					<td><input type=checkbox name='delete<%=cartItem.hashCode() %>'></td>
				</tr>								
				<%} %>
			</tbody>	
			<tfoot>
				<tr>
					<td colspan='4'>共<%=cart.size() %>項, <%=cart.getTotalQuantity() %>件</td>
					<td colspan='3'><%=cart.getTotalAmount() %>元 </td>
				</tr>
				<tr>
					<td colspan='4'>要結帳:<%=cart.getCheckOutSize() %>項, <%=cart.getCheckOutTotalQuantity() %>件</td>
					<td colspan='3'>共<%=cart.getCheckOutTotalAmount() %>元 </td>
				</tr>				
				<tr>
					<td colspan="4" class='updateSubmitAlign'>
						<input type=submit value="修改購物明細">
					</td>
					<td colspan="3">
						<button type="submit" name="submit" value="checkOut">我要結帳</button>
					</td>
				</tr>			
				
			</tfoot>
			
			</table>
			</form>
		
			<% } %>
	</article>

	<%@include file="/subviews/footer.jsp" %>
	
</body>
</html>