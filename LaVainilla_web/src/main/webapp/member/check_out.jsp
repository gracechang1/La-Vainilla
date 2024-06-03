<%@page import="uuu.lav.entity.PaymentType_lav"%>
<%@page import="uuu.lav.entity.ShippingType_lav"%>
<%@page import="uuu.lav.entity.CartItem_lav"%>
<%@page import="uuu.lav.entity.ShoppingCart_lav"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 結帳</title>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/lav.css">
	<style>
		#searchForm{float: right;}

		details{width: 90%;margin: auto;text-align: center;}
		details summary{width: 85%;margin: auto;border: lightgray 1px solid;margin-bottom: 0.35ex;}
		
		#cartTable , #dataTable{
/* 			  font-family: Arial, Helvetica, sans-serif; */
/* 			  font-size: smaller; */
			  border-collapse: collapse;
			  width: 85%;margin: auto;
			}
			
		#cartTable td, #cartTable th {
			  border: 1px solid #9B8884;
			  padding: 8px;			 
			}
			
		#cartTable tbody tr:nth-child(even){background-color: #E2D8CE;}
			
		#cartTable tr:hover {background-color: #9B8884;}
			
		#cartTable th,  #cartTable caption{
			  padding-top: 12px;
			  padding-bottom: 12px;			  
			  background-color: #BA8D6C;
			  color: black;
			}
		
		#cartTable tbody td{text-align: left;}
			
		#chooseStoreButton{display:none}			
			
		.cartPhoto{width:50px; float: left;}
		
		.listPriceDiv{color:gray;text-decoration: line-through;}
		.discountDiv{color:black;}
		.unitPriceDiv{color:#FD5308;font-size: larger;}
		
		.updateSubmitAlign  {text-align: right}	
		
		fieldset label{display: inline-block;min-width: 3.5em}
		fieldset input:not([type='button'],[type='checkbox']){width:70%}
			
	</style>

	<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>
	
	<script>
	$(init);
	
		function copyMember(){
			$("input[name=recipientName]").val('${member.getName()}');
			$("input[name=recipientEmail]").val('${member.getEmail()}');
			$("input[name=recipientPhone]").val('${member.getPhone()}');
			if($("select[name=shippingType]").val()=='HOME'){
				$("input[name=shippingAddress]").val('${member.getAddress()}');
			}
		}
		
		function init(){
			$("#copyMemberButton").click(copyMember);
			$("select[name=shippingType]").on('change',shippingAddressTwist);
			
			$("select[name=paymentType]").on('change',calculateAmount);			
			repopulateForm();
		}

		function shippingAddressTwist(){
			$("input[name=shippingAddress]").removeAttr('list');
			$("#chooseStoreButton").hide();
			
			$("select[name=paymentType] option").prop("disabled", true);
			$("select[name=paymentType] option[value='']").removeAttr("disabled");
			
			var paymentArray = $("select[name=shippingType] option:selected").attr('data-paymentArray');
			if(paymentArray && paymentArray.length>0){
				paymentArray = paymentArray.split(',');
				for(i in paymentArray){
					//alert(paymentArray[i]);
					$("select[name=paymentType] option[value="+paymentArray[i]+"]").removeAttr("disabled");
				}
				$("select[name=paymentType]").val(paymentArray[0]);
			}
			
			
			$("input[name=shippingAddress]").attr('autocomplete', 'off');
			if($("select[name=shippingType]").val()=='SHOP'){
				$("input[name=shippingAddress]").attr('list', 'shopList');
				$("input[name=shippingAddress]").val('');
			}else if($("select[name=shippingType]").val()=='STORE'){
				$("#chooseStoreButton").show();
				$("input[name=shippingAddress]").val('');
			}else {
				$("input[name=shippingAddress]").attr('autocomplete','on');
			}
			
			calculateAmount();
			//alert(1);
		}

		function calculateAmount(){
			var shFee = $("select[name=shippingType] option:selected").attr('data-fee');
			var pFee = $("select[name=paymentType] option:selected").attr('data-fee');
			var amount = Number($("#totalAmountSpan").text());
			//alert(amount + "," + isNaN(shFee) + "," + isNaN(pFee));
			if(!isNaN(shFee)) amount = amount + Number(shFee);
			if(!isNaN(pFee)) amount = amount + Number(pFee);
			$("#totalAmountWithFeeSpan").text(amount);
		}

		function repopulateForm(){
			<% if("POST".equals(request.getMethod())){%>
			$("select[name=shippingType]").val('${param.shippingType}');
// 			shippingAddressTwist();
			$( "select[name=shippingType]" ).trigger("change");
			
			$("select[name=paymentType]").val('${param.paymentType}');
			$( "select[name=paymentType]" ).trigger("change");
// 			calculateAmount();
			
			$("input[name=recipientName]").val('${param.recipientName}'.trim());
			$("input[name=recipientEmail]").val('${param.recipientEmail}'.trim());
			$("input[name=recipientPhone]").val('${param.recipientPhone}'.trim());
			$("input[name=shippingAddress]").val('${param.shippingAddress}'.trim());
			
			<%}%>
			
		}

	</script>
</head>
<body>
<!-- 寫法一 -->
	<jsp:include page="/subviews/header.jsp" />
<!-- 寫法二 -->
<%-- 		<jsp:include page="/subviews/header.jsp"> --%>
<%-- 			<jsp:param value="結帳" name="subheader"/> --%>
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
			<div style='color:darkred'>${requestScope.errors}</div>		
			<details open>			
			<summary>點擊即可檢視購物明細(共<%=cart.getCheckOutTotalAmount() %>元): </summary>
			<table id='cartTable'>
			<caption>結帳明細</caption>
			<thead>
				<tr>
					<th></th>
					<th>名稱</th>
					<th>味道/規格</th>					
					<th>價格</th>
					<th>數量</th>	
					<th>小計</th>		
				</tr>
			</thead>
			<tbody>
				<%for(CartItem_lav cartItem:cart.getCartItemSet()){ 
					if(!cartItem.isCheckOut()) continue;
				%>	
						
				<tr>
					<td><input type=checkbox checked disabled></td>				
					<td>
						<img class='cartPhoto' src='<%=cartItem.getPhotoUrl() %>'>
						<div style='font: larger;'><%=cartItem.getProductName() %></div>
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
					<td><%=cart.getQuantity(cartItem) %></td>
					<td><%=cartItem.getUnitPrice() * cart.getQuantity(cartItem) %>元</td>
				</tr>								
				<%} %>
			</tbody>	
			<tfoot>
				<tr>
					<td colspan='4'>共<%=cart.getCheckOutSize() %>項, <%=cart.getCheckOutTotalQuantity() %>件</td>
					<td colspan='2'>共<span id='totalAmountSpan'><%=cart.getCheckOutTotalAmount() %></span>元</td>
				</tr>
			</tfoot>
			</table>
			</details>
			<br>
			<form id='cartForm' method='post' action="check_out.do" autocomplete="on">	
			<table id='dataTable'>
				<tfoot>
				<tr>
					<td colspan='2'>
						<label>貨運方式:</label>
						<select name='shippingType' required>
							<option value=''>請選擇</option>
							<%
							for(ShippingType_lav shType:ShippingType_lav.values()){
							%>
							<option value='<%= shType.name()%>' data-paymentArray='<%= shType.getPaymentTypesArray()%>' 
									data-fee='<%= shType.getFee()%>'><%= shType%></option>
							<% }%>
						</select>
					</td>
					<td colspan='2'>
						<label>付款方式:</label>
						<select name='paymentType' required>
							<option value=''>請選擇</option>
							<% for(PaymentType_lav pType:PaymentType_lav.values()){ %>
							<option value='<%= pType.name()%>' 
									data-fee='<%= pType.getFee()%>'><%= pType%></option>
							<% }%>						
						</select>
					</td>
					<td colspan='1' style='text-align: right'>
						含手續費
					</td>
					<td colspan='1'>
						總共:<span id='totalAmountWithFeeSpan'><%=cart.getCheckOutTotalAmount() %></span>元
					</td>
				</tr>
				<tr>
					<td colspan='6'>
						<fieldset>
							<legend>收件人<input type='button' id='copyMemberButton' value='同訂購人'>:</legend>
							<label>姓名:</label><input type='text' name='recipientName' required><br>
							<label>email:</label><input type='text' name='recipientEmail' required><br>
							<label>手機:</label><input type='text' name='recipientPhone' required><br>
							<label>地址:</label><input type='text' name='shippingAddress' required>
							<input id='chooseStoreButton' type='button' value='選擇超商' onclick='goEZShip()'>
							<datalist id='shopList'>
								<option value='台北市信義區市府路45號'>台北總公司 台北市信義區市府路45號</option>
								<option value='高雄市大樹區學城路一段10號'>高雄門市 高雄市大樹區學城路一段10號</option>
							</datalist>						 
						</fieldset> 
					</td>
				</tr>
				<tr>
					<td colspan='6' class='updateSubmitAlign'>
						<input type=submit value="送出訂單">
					</td>					
				</tr>			

			</tfoot>
			
			</table>
			</form>
			<script>                         

			function goEZShip() {//前往EZShip選擇門市
	           	if (confirm("Go EZShip前，你的網址已經改用ip Address了嗎?")) {
		            alert("出發至EZShip[選擇超商]");
	            } else {
 		            alert("快改網址!並重新登入與購買");
	    	        return;
	            }
	 
			    //去除文字欄位資料前後的多餘空白
				$("input[name=recipientName]").val($("input[name=recipientName]").val().trim());
				$("input[name=recipientEmail]").val($("input[name=recipientEmail]").val().trim());
				$("input[name=recipientPhone]").val($("input[name=recipientPhone]").val().trim());
				$("input[name=shippingAddress]").val($("input[name=shippingAddress]").val().trim());
				
				var protocol = "https"; //之後要改成https
				var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";
				var url = protocol + "://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ezship_callback.jsp";                  
				$("#rtURL").val(url);				 
				
				//$("#webPara").val($("form[action='check_out.do']").serialize());				
				$("#webPara").val($("#cartForm").serialize());				
// 				alert('現在網址不得為[locolhost]: '+url); //測試用，測試完畢後請將此行comment				
// 				alert($("#webPara").val()) //測試用，測試完畢後請將此行comment
				
				$("#ezForm").submit();			
			}

			</script>
			
			<form id="ezForm" method="post" name="simulation_from" action="https://map.ezship.com.tw/ezship_map_web.jsp" >			
				<input type="hidden" name="suID"  value="test@lav.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->			
				<input type="hidden" name="processID" value="LAV202107050000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->			
				<input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->			
				<input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->			
				<input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->			
				<input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中cartForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->			
			</form>
		
			<% } %>
	</article>

	<%@include file="/subviews/footer.jsp" %>
	
</body>
</html>