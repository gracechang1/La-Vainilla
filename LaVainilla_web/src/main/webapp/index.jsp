<%@page import="uuu.lav.entity.Customer_lav"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>La Vainilla | 香草屋 首頁</title>
	<link rel="stylesheet" type="text/css" href="css/lav.css">
	<script type="text/javascript" src="jquery/jquery.js"></script>
	
	<style>
		#outer {
			position: relative;
			width: 839px;
			/*image width=839 height=441*/
			overflow: hidden;
			background-color: lightgray;
			margin: auto;
		}

		#photos {
			position: relative;
			width: 3356px;
			/*image width=839x4=3356px*/
			display: flex;
		}

		#prev,#next {
			position: absolute;
			width: 20px;
			height: 40px;
			color: gray;
			cursor: pointer;
			font-size: 3em;
			top: 200px;
			opacity: 0.5;
		}

		#prev {
			left: 0px;
		}

		#next {
			right: 0px;
		}

		#prev:hover,#next:hover {
			opacity: 0.9;
		}

		#dots {
			width: 96px;
			/*(16+4x2)x4=96px*/
			margin: auto;
			display: flex;
		}

		.dot {
			width: 16px;
			height: 16px;
			background-color: gray;
			border-radius: 50%;
			margin: 5px;
			cursor: pointer;
		}

		.dot:first-child {
			background-color: white;
		}
		
		#searchForm{float: right;}
	</style>
	
	<script type="text/javascript">
		var myInterval, index = 0;
		$(document).ready(function init() {
			$(".dot,#next,#prev").click(moveHandler);//run the same function
			myInterval = setTimeout(moveHandler, 3000);//initial timer
		});
		function moveHandler(e) {
			clearInterval(myInterval);//reset timer
			myInterval = setTimeout(moveHandler, 3000);//set timeer
			$(".dot:eq(" + index + ")").css("backgroundColor", "gray");//reset dot color
			if (this == window) {
				index++;//setInterval
			} else if ($(this).attr("myIndex")) {
				index = Number($(this).attr("myIndex"));//.dot
			} else {
				index += Number($(this).attr("direction"));// $#prev / #next
			}
			if (index > 3) index = 0;//last image
			if (index < 0) index = 3;//first image
			$(".dot:eq(" + index + ")").css("backgroundColor", "white");//set dot color
			$("#photos").stop().animate({ "marginLeft": -index * 839 + "px" }, 1000);//image width=735px
		}
	</script>
	
</head>

<body>

	<jsp:include page="./subviews/header.jsp" />

	<%@include file="./subviews/nav.jsp" %>
	
	<article  style="min-height: 70hv;">
	
		<div id="outer">
			<div id="photos">
				<img src="images/slide1.png">
				<img src="images/slide2.png">
				<img src="images/slide3.png">
				<img src="images/slide4.png">
			</div>
			
			<div id="prev" direction="-1">&laquo;</div>
			<div id="next" direction="1">&raquo;</div>
			
			<div id="dots">
				<div class="dot" myIndex="0"></div>
				<div class="dot" myIndex="1"></div>
				<div class="dot" myIndex="2"></div>
				<div class="dot" myIndex="3"></div>
			</div>
		</div>
		
	</article>
	
	<%@include file="./subviews/footer.jsp" %>
	
</body>

</html>