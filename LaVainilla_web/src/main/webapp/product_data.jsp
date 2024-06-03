<%@page import="uuu.lav.entity.Flavor_lav"%>
<%@page import="uuu.lav.entity.Product_lav"%>
<%@page import="uuu.lav.entity.SpecialOffer_lav"%>
<%@page import="uuu.lav.service.ProductService_lav"%>
<%@page pageEncoding="UTF-8"%>

	<style>
		#photoImg{width:350px;vertical-align: top;}
		.listPrice{text-decoration: line-through;}
		.price{font-size: larger;color: #E25D66}
		.specDiv{display:none} 
		.specDivShow{display:inline-block}
	</style>
	
	<script>
		$(init);
		function init() {
//			$("input[name='flavor']").on("change", changeOptionData);
			$("select[name='flavor']").on("change", changeFlavorOptionData);
// 			$("input[name='spec']").on("change", changeSpecOptionData);		//因為spec選項尚未用ajax帶入，所以改在ajax doneHandler註冊事件
		}
		
		function changeFlavorOptionData() {
// 			console.log($(this).attr("value"));
// 			console.log($(this).attr("data-stock"));
// 			console.log($(this).attr("data-photo"));
			
			var flavorName = $("select[name='flavor'] option:selected").attr("value");
			var stock = $("select[name='flavor'] option:selected").attr("data-stock");
			var photo = $("select[name='flavor'] option:selected").attr("data-photo");

			$("#flavorStockSpan").text("("+flavorName+ ":" + stock + "件)");
			$("input[name=quantity]").attr("max", stock);
			$("#photoImg").attr("src", photo);
// 			$(".specDiv").hide()
// 			$(".specDiv[data-flavor="+flavorName+"]").css("display", "inline-block");
			getSpecListByAjax(flavorName);	
		}
		
		function getSpecListByAjax(flavorName) {
			var pId = $("input[name=productId]").val();
			$.ajax({
				url: 'get_spec_list.jsp?productId=' + pId +'&flavorName='+ flavorName,
				method: 'GET'		
			}).done(getSpecListByAjaxDoneHandler);
// 			alert('send Ajax already!...');
		}
		
//	將規格的result帶至畫面
		function getSpecListByAjaxDoneHandler(result) {
			$(".specDiv").replaceWith(result);
			$("input[name='spec']").on("change", changeSpecOptionData);
		}

		function changeSpecOptionData() {
			console.log($(this).attr("value"));
			console.log($(this).attr("data-stock"));
			console.log($(this).attr("data-photo"));
			console.log($(this).attr("data-listPrice"));
			console.log($(this).attr("data-price"));
		
	

			var flavorName = $(".specDivShow").attr("data-flavor");
			if(flavorName.length>0) flavorName+="/";
			var specName= $(this).attr("value");
			var listPrice= $(this).attr("data-listPrice"); 
			var price= $(this).attr("data-price");
			var stock= $(this).attr("data-stock");
			var photo= $(this).attr("data-photo");

			$(".listPrice").text(listPrice);
			$(".price").text(price);
			$("#flavorStockSpan").text("("+flavorName +specName + ": " + stock + "件)");
			if(photo!=null && photo.length>0){ 					
 				$("#photoImg").attr("src", photo);
 			}
			$("input [name=quantity]").attr("max", stock);
		}

		function addCartAjax(){
// 			alert("即將加入購物車!");
// 			alert($("#submitForm").serialize()); 
			$.ajax({
				url: $("#submitForm").attr("action") + "?ajax=",
				method: $("#submitForm").attr("method"),
				data: $("#submitForm").serialize()
			}).done(addCartAjaxDoneHandler);
			return false; //取消submit				
		}
		
		function addCartAjaxDoneHandler(result){
			alert("加入購物車成功!");
			$(".cartQty").text(result.totalQty);
		}
		
		
	</script>

<body>

	<%@include file="./subviews/nav.jsp" %>

	<%
		String productId= request.getParameter("productId");
		Product_lav p= null;
		
		if(productId!=null){
			ProductService_lav pService= new ProductService_lav();
			p= pService.getProductById(productId);
		}
	%>
	
	<div>
		<% if(p==null){ %>
			<h2>查無產品代號: <%= productId %> 之產品</h2>
		<% }else{ %>
		<div>
			<img id="photoImg" src="<%= p.getPhotoUrl() %>">
			<li style="display: inline-block;">
				<ul style="list-style-type: square;">
					<h2><%= p.getName() %></h2>	
					<li>產地: <%= p.getOrigin() %></li>
					<li>有效日期: <%= p.getExpirationDate() %></li>
					<li>定價: <span class="listPrice"><%= p instanceof SpecialOffer_lav? ((SpecialOffer_lav)p).getListPrice():p.getUnitPrice() %></span>元</li>
					<li>優惠價: <span class="price"><%= p.getUnitPrice() %></span>元 / <%= p instanceof SpecialOffer_lav? ((SpecialOffer_lav)p).getDiscountString():"無折扣" %></li>
					<li>庫存: 共<%= p.getStock() %>件 <span id='flavorStockSpan'></span></li>
					<li>分類: <a href='product_list.jsp?category=<%= p.getCategory() %>'><%= p.getCategory() %></a></li>
					<li>
						<form id='submitForm' action='add_cart.do' method='POST' onsubmit="return addCartAjax()">
							<input type="hidden" value="<%= p.getId() %>" name="productId">
							<% if(p.getFlavorMapSize()>0) {%>
							<div>
							<label>味道: </label>	
<!-- input寫法 -->
<%-- 								<% for(Flavor_lav flavor: p.getFlavorList()){ %>																												 --%>
<%-- 									<input type='radio' name='flavor' value='<%= flavor.getFlavorName() %>' required data-stock='<%= flavor.getStock() %>'  --%>
<%-- 										data-photo='<%= flavor.getPhotoUrl() %>'><label><%= flavor.getFlavorName() %></label> --%>
<%-- 								<% } %> --%>
<!-- select寫法 -->
							<select name='flavor' required >
								<option value=''>請選擇</option>
								<% for(Flavor_lav flavor: p.getFlavorList()){ %>																												
									<option value='<%= flavor.getFlavorName() %>' data-stock='<%= flavor.getStock() %>' 
											data-photo="<%= flavor.getPhotoUrl() %>"><%= flavor.getFlavorName() %></option>
								<% } %>
							</select>
							</div>
							<% } %>
							<% if(p.getSpecCount()>0){%>
							<div>
								<label>規格: </label>
								<div class='specDiv specDivShow' data-flavor=''>
									請先挑選味道
								</div>
							</div>
							<% } %> 
							<div>
								<label>數量:</label>
								<input type="number" name="quantity" min="1"  max="<%= p.getStock()%>" required>
								<input type="submit" value="放入購物車">
							</div>
						</form>
					</li>
					
				</ul>	
			</div>
			<% } %>
		</div>
	<script>
	
	<% if(p!=null && p.getFlavorMapSize()==0 && p.getSpecCount()>0){%>
		getSpecListByAjax('');
	<% } %>
	
	</script>
	
</body>
</html>