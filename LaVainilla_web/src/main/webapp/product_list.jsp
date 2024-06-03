<%@page import="uuu.lav.entity.SpecialOffer_lav"%>
<%@page import="uuu.lav.entity.Product_lav"%>
<%@page import="java.util.List"%>
<%@page import="uuu.lav.service.ProductService_lav"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 產品項目</title>
	<link rel="stylesheet" type="text/css" href="css/lav.css">
	<link rel='stylesheet' type='text/css' href='./fancybox/jquery.fancybox.css'>
	<style>
		.fancybox-is-open .fancybox-bg{ 
 	  		  opacity: 0.79; 
 			}
		
		#searchForm{float: right;} 
		
		.productList{width:80%;margin: auto;}
		.productItem{display: inline-block;width:18em;height:19em;box-shadow: #338EB8 0 0 5px;
						 vertical-align: top;text-align: center;margin:0.5ex;}
		.productItem h4{padding-bottom: 0px;}
		.productPhoto{width:150px;}	
		
	</style>
	
	<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>
			
	<script src='./fancybox/jquery.fancybox.js'></script>
	
	<script>
		function getProductData(pid){
// 				alert(pid);				
				$.ajax({
					url:"product_data.jsp?productId=" + pid
				}).done(getProductDataDoneHandler);
			}
			
		function getProductDataDoneHandler(result){
// 				alert(result);
				$('#productData').html(result);
				
				$.fancybox.open({
					'width':1000,
                    'height':500,
				    src  : '#productData',
				    type : 'inline',
				    opts : {
				      afterShow : function( instance, current ) {
				        console.info('done!');
			          }
			        }
			    });	  
			
			}
	</script>
</head>

<body>
	<div style="display:none" id="productData"></div>		
<!-- 寫法一 -->
	<jsp:include page="./subviews/header.jsp" />
<!-- 寫法二 -->
<%-- 		<jsp:include page="./subviews/header.jsp"> --%>
<%-- 			<jsp:param value="逛商店" name="subheader"/> --%>
<%-- 		</jsp:include> --%>

	<%@include file="./subviews/nav.jsp" %>
	
	<article style="min-height: 70hv;">
	
	<aside>
		<a href="?category=EXP">有效日期</a>
		<a href="?category=原料">原料</a>
		<a href="?category=甜品">甜品</a>
		<a href="?">全部</a>
	</aside>
	
<!-- 帶入DB產品資訊至前端	 -->
	<%	 
// 	1.取得request的查詢條件 
		String search= request.getParameter("search");
		String category= request.getParameter("category");
		
		ProductService_lav pService= new ProductService_lav();
		List<Product_lav> list;
			
//	2.呼叫商業邏輯
		if(search!=null && (search=search.trim()).length()>0){
			list= pService.getProductsByKeyword(search);
		}else if(category!=null){
			if("EXP".equals(category)){
				list= pService.getProductsByExpirationDate();
			}else{
				list= pService.getProductsByCategory(category);
			}
		}else{
			list= pService.getAllProducts();
		}
	%>	
		
		<% if(list==null || list.size()==0) {%>
			<p>目前查無此資料，請重新查詢</p>
		<%}else{ %>
			<div class="productList"><label><%= category!=null? ("分類> "+category):"" %></label>
				<% 
//	寫法一(for迴圈)				
// 				for(int i=0; i<list.size(); i++) {
// 						Product_lav p= list.get(i);
//	寫法二(for each語法)
				for(Product_lav p:list){
				%>
					<div class="productItem">
						<a href="javascript:getProductData(<%= p.getId() %>)">
							<img class="productPhoto" src="<%= p.getPhotoUrl() %>">
						</a>	
						<h4><a href="product_detail.jsp?productId=<%= p.getId() %>"><%= p.getName() %></a></h4>
						<div>定價: <%= p instanceof SpecialOffer_lav? ((SpecialOffer_lav)p).getListPrice():p.getUnitPrice() %>元</div>
						<div>優惠價: <%= p.getUnitPrice() %>元 / <%= p instanceof SpecialOffer_lav? ((SpecialOffer_lav)p).getDiscountString():"無折扣" %></div>
						<small>庫存: <%= p.getStock() %></small>
					</div>
					<%} %>
			</div>
		<% }%>
		
	</article>

	<%@include file="./subviews/footer.jsp" %>	
</body>

</html>