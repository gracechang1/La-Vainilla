<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 註冊</title>
	<link rel="stylesheet" type="text/css" href="css/lav.css">
	<style>
		.memberForm {
	  		width: 40%; max-width: 50em; min-width:350px; margin:auto;
		}
		.memberForm label{
			display: inline-block;min-width:5em;
		}
		.memberForm input,select{
			background-color: lightgray;
		}
		
		#searchForm{float: right;}
	</style>
	
<!-- 載入jQuery	 -->
	<script src="https://code.jquery.com/jquery-3.0.0.js" 
		integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
		crossorigin="anonymous"></script>

	<script>
// 註冊錯誤，重新填寫時，資料會帶回至表格
		$(init);
		
		function init() {
			repopulateForm();
		}
	
		function repopulateForm() {
			<% if("POST".equals(request.getMethod())){%>
				$("input[name=name]").val('<%= request.getParameter("name")%>');
				$("input[name=birthday]").val('<%= request.getParameter("birthday")%>');
				$("select[name=gender][value=<%= request.getParameter("gender")%>]").prop("checked", true);
				$("input[name=email]").val('<%= request.getParameter("email")%>');
				$("input[name=phone]").val('<%= request.getParameter("phone")%>');
				$("textarea[name=address]").val('<%= request.getParameter("address")%>');
				$("input[name=subscribedAgree]").prop(<%= request.getParameter("subscribedAgree")!=null%>);
				$("input[name=subscribedMsg]").prop(<%= request.getParameter("subscribedMsg")!=null%>);

			<% } %> 
			
		}
		
		function displayPwdHandler(theCheckbox){
			pwd1.type=(theCheckbox.checked)?"text":"password";
			pwd2.type=pwd1.type;
		}
		
		function refreshCaptcha(){
			captchaImg.src="images/captcha_register.png?refresh="+new Date();
		}
		
	</script>
</head>

<body>

	<jsp:include page="/subviews/header.jsp" />

	<%@include file="/subviews/nav.jsp" %>

	<article style="min-height: 70hv;">
		<form autocomplete="off" class="memberForm" action="register.do" method="POST">
			
<!-- 登入失敗	 -->			
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
				<legend>會員註冊</legend>
				<label>姓名:</label>
				<input type="text" name="name" placeholder="請填寫真實中文姓名" required 
					   title="請填寫2~20個字" pattern="[\u0020A-Za-z\u4e00-\u9fa5]{2,20}" minlength="2" maxlength="20"><br><br>
				<label>生日:</label>
				<input type="date" name="birthday" placeholder="請填寫生日" required><br><br>
				<label>性別:</label>
				<select name="gender"  required>
					<option value="">請選擇性別</option>
					<option value="M">男生</option>
					<option value="F">女生</option>
					<option value="O">其他</option>
				</select>
				<br><br>
				<label>帳號:</label>
				<input type="text" name="email" placeholder="請填寫email" required><br><br>
				<label>設定密碼:</label>
				<input class= "pwd" type="password" id="pwd1" name="pwd1" placeholder="請填寫密碼" required minlength="6" maxlength="20"><br>
				<label>密碼確認:</label>
				<input class= "pwd" type="password" id="pwd2" name="pwd2" placeholder="請再次輸入密碼" required minlength="6" maxlength="20">
				<input type="checkbox" onchange="displayPwdHandler(this)"><label>顯示密碼</label><br><br>
				<label>手機號碼:</label>
				<input type="tel" name="phone" placeholder="請填寫手機號碼" required pattern="\d{10}"><br><br>
				<label>地址:</label>
				<input type="text" name="address" placeholder="請填寫地址" required><br>
				<p>
					<label>驗證碼:</label>
					<input type="text" name="captcha" placeholder="請依圖片輸入驗證碼" required><br><br>
					<img id="captchaImg" src="images/captcha_register.png" style="vertical-align: middle;">
					<input type="button" value="更新驗證碼" onclick="refreshCaptcha()">
				</p>
				<input type="checkbox" name="subscribedAgree"><label>我同意貴公司客戶隱私權政策與客戶服務條款</label><br>
				<input type="checkbox" name="subscribedMsg"><label>我願意收到貴公司商品及會員折扣訊息</label><br><br>
				<input type="submit" value="立即註冊">
			</fieldset>
		</form>
	</article>

	<%@include file="/subviews/footer.jsp" %>	

</body>

</html>