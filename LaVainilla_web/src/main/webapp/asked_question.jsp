<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 FAQ</title>
	<link rel="stylesheet" type="text/css" href="css/lav.css">
	<link rel="stylesheet" href="themes/pepper-grinder/jquery-ui.css" />
	<script type="text/javascript" src="jquery_jquery-ui/jquery.js"></script>
	<script type="text/javascript" src="jquery_jquery-ui/jquery-ui.js"></script>
	
	<style>
		#myTabs{
			width: 900px;
			height: fit-content;
			margin: auto;
		}
		
		p{
			display: inline-block;
			text-align: justify;
			line-height: 40px;
		}
		#searchForm{float: right;}
	</style>
	
	<script type="text/javascript">
		$(document).ready(init);
		function init(){
			$("#myTabs").tabs({
				disabled: false,
				active: 0,
				collapsible: false,
				heightStyle: "auto",
				event:"click",
				hide:{effect: "slideup", duration:500},
				show:{effect: "slideDown", duration:500},
			});
		}
	
	</script>
	
</head>
<body>

	<jsp:include page="./subviews/header.jsp" />

	<%@include file="./subviews/nav.jsp" %>

	<article  style="min-height: 70hv;">
		<div id="myTabs">
			<ul>
				<li><a href="#tabs_1">登入會員須知</a></li>
				<li><a href="#tabs_2">商品購物須知</a></li>
				<li><a href="#tabs_3">配送商品須知</a></li>
				<li><a href="#tabs_4">超商取貨須知</a></li>
				<li><a href="#tabs_5">發票開立須知</a></li>
				<li><a href="#tabs_6">付/退款須知</a></li>
			</ul>
			<div id="tabs_1">
				<p>1.我要如何成為客戶？<br>
					 您必須先在網站上加入會員，完成相關個人基本資料填寫後，才能進行相關線上訂購、付款等程序。<br>
				   2.註冊會員時卻出現卻出現『您已是香草屋的客戶』該怎麼辦？<br>
					 會員帳號為「email」無法重複註冊，出現此訊息代表您可能已是香草屋會員，您可以使用『忘記密碼』進行身分驗證，無須重新申請新帳號。
					 此外，您如果提供任何錯誤或是不實的資料進行登錄，本公司有權暫停或是終止您的帳號，並拒絕您使用本服務。
				</p> 
			</div>	
			
			<div id="tabs_2" >
				<p>1.收到商品後，我需要注意什麼事項，以確保我的購物權益呢？<br>
					 包裝出貨已全程攝影，為確保消費者權益，請您於開啟商品外箱時全程攝影，核對包裝箱內的商品內容，
					 若有不符或短少，請於24小時內於網頁「聯絡客服」中反應，由網路客服人員為您服務，我們將為您作紀錄並進行處理。<br>
				   2.如我收到商品有缺件，應該如何處理？<br>
				   	 若您發現商品有短缺的現象，請您至「客服中心」與我們聯絡。
				</p>
			</div>
			
			<div id="tabs_3">
				<p>1.我可以指定送貨地點嗎？<br>
					 您可以在填寫訂單資料時的收件人欄位，輸入您指定的送貨地址，有「速」標誌的商品皆可離島地區配送。<br>
				   2.我在網站上確認訂單後，多久可以收到商品呢？<br>
				     除特殊原因外，一般在訂單確認後五天內(不含例假日)將貨品運送到指定地點。
				</p>
			</div>
			
			<div id="tabs_4">
				<p>1.在超商取貨付款訂單完成後，我還可以更改成別種的付款方式嗎？<br>
					 由於不同的付款方式分別是採用不同的作業系統，我們目前尚未提供您直接更改付款方式的服務。<br>
				   2.請問我該如何得知已經完成超商取貨訂單？<br>
				     當您成立訂單後，網站會發送簡訊及email至您的手機及信箱，您也可以透過網站「我的帳戶」查詢。	
				</p>
			</div>	
			
			<div id="tabs_5">
				<p>1.發票可以指定日期、開立其它品名或金額嗎？<br>
					 本公司發票採用自動化系統開立，因此發票上商品名稱將依訂購當時品名和金額開立，請恕無法指定開立其它品名、金額，或指定開立日期。<br>
				   2.收到發票後，可否改開立為多張發票？<br>
				     為配合電子請款結帳，故一次出貨對應一張發票，恕無法分別開立多張。
				</p>
			</div>
			
			<div id="tabs_6">
				<p>1.請問除了信用卡,還有別的付款方式嗎?<br>
					 各項商品除了信用卡付款外，可選擇貨到付款。<br>
				   2.請問至門市取貨時可以使用信用卡刷卡消費嗎？<br>
				     目前超商取貨付款方式時僅能支付現金。 
				</p>
			</div>
			
		</div>
		
		
		
	</article>

	<%@include file="./subviews/footer.jsp" %>

</body>
</html>