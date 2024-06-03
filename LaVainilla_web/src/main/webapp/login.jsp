<%@page pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 登入</title>
	<link rel="stylesheet" type="text/css" href="css/lav.css">
	<style>
		.memberForm {
	  		width: 40%; max-width: 50em; min-width:350px; margin:auto;
		}
		.memberForm label{
			display: inline-block;min-width:3.5em;
		}
		.memberForm input{
			background-color: lightgray;
		}
		
		#searchForm{float: right;}
	</style>
	<script>
		function displayPwdHandler(theCheckbox){
			pwd.type=(theCheckbox.checked)?"text":password;
		}
		
		function refreshCaptcha(){
			//alert(1);
			captchaImg.src="images/captcha_login.png?refresh="+new Date();
		}
	</script>
</head>

<body>

	<jsp:include page="./subviews/header.jsp" />

	<%@include file="./subviews/nav.jsp" %>
	
	<article style="min-height: 70hv;">
		<form autocomplete="off" class="memberForm" action="login.do" method="POST">
		
<!-- 登入失敗	 -->			
<%-- 			<% errors!=null? errors:"" %> --%>
		<% List<String> errors= (List<String>)request.getAttribute("errors");
				if(errors!=null && errors.size()>0) {
		%>		
				<div style="color: red;">
					<% for(int i=0; i<errors.size(); i++) {%>
						<div><%= i+1 %>.<%= errors.get(i) %></div>
					<% }%>
				</div>
			<% }%>
			
			<fieldset>
				
				<legend>會員登入</legend>
				<label>帳號:</label>
				<input type="text" name="email" placeholder="請輸入email" required>
				<input type="checkbox" name="auto" value="on" ${cookie.auto.value} />記住帳號密碼<br><br>
				<label>密碼:</label>
				<input type="password" id="pwd" name="password" placeholder="請輸入密碼"required>
				<input type="checkbox" onchange="displayPwdHandler(this)"><label>顯示密碼</label>
				<br>
				<p>
					<label>驗證碼:</label>
					<input type="text" name="captcha" placeholder="請依圖片輸入驗證碼" required><br><br>
					<img id="captchaImg" src="images/captcha_login.png" style="vertical-align: middle;">
					<input type="button" value="更新驗證碼" onclick="refreshCaptcha()">
				</p>
				<input type="submit" value="登入 Login">
			</fieldset>
		</form>
	</article>

	<%@include file="./subviews/footer.jsp" %>	
		
</body>

</html>