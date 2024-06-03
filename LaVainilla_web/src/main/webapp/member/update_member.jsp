<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 會員修改</title>
	<link rel="stylesheet" type="text/css" href="../css/lav.css">
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
	
	<script src="https://code.jquery.com/jquery-3.0.0.js" 
		integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
		crossorigin="anonymous"></script>		
	
	<script>
		$(init);
		function init() {
			<% if("GET".equals(request.getMethod())){ %>
//	一開始先帶入session的會員資料			
				populateForm();
			<% }else if("POST".equals(request.getMethod())) {%>
//	修改失敗帶入request中form的會員資料			
				repopulateForm();
			<% } %>
		}
	
		function repopulateForm() {
			<% if("POST".equals(request.getMethod())){%>
				$("input[name=name]").val('<%= request.getParameter("name")%>');
				$("input[name=birthday]").val('<%= request.getParameter("birthday")%>');
				$("select[name=gender]").val('<%= request.getParameter("gender")%>');
				$("input[name=email]").val('<%= request.getParameter("email")%>');
				$("input[name=phone]").val('<%= request.getParameter("phone")%>');
				$("textarea[name=address]").val('<%= request.getParameter("address")%>');
				$("input[name=subscribedAgree]").prop("checked", <%= request.getParameter("subscribedAgree")!=null %>);
				$("input[name=subscribedMsg]").prop("checked", <%= request.getParameter("subscribedMsg")!=null %>);
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
<!-- 寫法一 -->
	<jsp:include page="/subviews/header.jsp" />
<!-- 寫法二 -->
<%-- 		<jsp:include page="/subviews/header.jsp"> --%>
<%-- 			<jsp:param value="Update Member" name="subheader"/> --%>
<%-- 		</jsp:include> --%>

	<%@include file="/subviews/nav.jsp" %>

	<article style="min-height: 70hv;">
		<form autocomplete="off" class="memberForm" action="update_member.do" method="POST">
			
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
				<legend>會員修改</legend>
				<label>姓名:</label>
				<input type="text" name="name" placeholder="請填寫真實中文姓名" required 
					   title="請填寫2~20個字" pattern="[\u0020A-Za-z\u4e00-\u9fa5]{2,20}" minlength="2" maxlength="20"><br><br>
				<label>生日:</label>
				<input type="date" name="birthday" placeholder="請填寫生日" required ><br><br>
				<label>性別:</label>
				<select name="gender"  required>
					<option value="">請選擇性別</option>
					<option value="M">男生</option>
					<option value="F">女生</option>
					<option value="O">其他</option>
				</select>
				<br><br>
				<label>帳號:</label>
				<input type="text" name="email" readonly>
					<% if(member instanceof VIP_lav) {%>
						<input type="checkbox" checked readonly > <%= ((VIP_lav)member).getDiscountString() %>
					<% } %><br><br>
				<label>設定密碼:</label>
				<input class= "pwd" type="password" id="pwd" name="pwd" placeholder="請填寫密碼" required minlength="6" maxlength="20"><br><br>
				<fieldset>
				<legend><input type='checkbox' id='changPwdBox' name='changePwdBox'>我要修改</legend>
				<label>修改密碼:</label>
				<input class= "pwd" type="password" id="pwd1" name="pwd1" placeholder="請填寫密碼" required disabled minlength="6" maxlength="20"><br>
				<label>密碼確認:</label>
				<input class= "pwd" type="password" id="pwd2" name="pwd2" placeholder="請再次輸入密碼" required disabled minlength="6" maxlength="20">
				<input type="checkbox" onchange="displayPwdHandler(this)"><label>顯示密碼</label><br>
				</fieldset><br>
				<label>手機號碼:</label>
				<input type="tel" name="phone" placeholder="請填寫手機號碼" required pattern="\d{10}"><br><br>
				<label>地址:</label>
				<textarea name="address" placeholder="請填寫地址"></textarea><br>
				<p>
					<label>驗證碼:</label>
					<input type="text" name="captcha" placeholder="請依圖片輸入驗證碼" required><br><br>
					<img id="captchaImg" src="../images/captcha_register.png" style="vertical-align: middle;">
					<input type="button" value="更新驗證碼" onclick="refreshCaptcha()">
				</p>
				<input type="checkbox" name="subscribedAgree"><label>我同意貴公司客戶隱私權政策與客戶服務條款</label><br>
				<input type="checkbox" name="subscribedMsg"><label>我願意收到貴公司商品及會員折扣訊息</label><br><br>
				<input type="submit" value="確定修改">
			</fieldset>
		</form>
	</article>

	<%@include file="/subviews/footer.jsp" %>	
	
<script>
	function populateForm(){
// 	EL寫法:從session中取得會員email(帳號)	
			$("input[name=email]").val('${sessionScope.member.getEmail()}');
			$("input[name=name]").val('${member.getName()}');
			$("input[name=birthday]").val('<%= member.getBirthday()%>');
			$("select[name=gender]").val('<%= member.getGender()%>');
			$("input[name=phone]").val('<%= member.getPhone()%>');
			$("textarea[name=address]").val('<%= member.getAddress()%>');
			$("input[name=subscribedAgre]").prop("checked", <%= member.isSubscribed()%>);
			$("input[name=subscribedMsg]").prop("checked", <%= member.isSubscribed()%>);
		}

</script>

</body>

</html>