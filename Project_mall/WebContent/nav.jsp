<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- JQuery 로 메뉴바 토글 구현하기 --> 
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function() {
		// hover is shorthand for mouseenter/mouseleave (mouseover/out과 다르게 자식요소까지 포함)
		$("li").click(function() {
			var sub = $(this).children(".sub");
			if (sub.is(":visible"))
				sub.slideUp(500);
			else
				sub.slideDown(500);
		});
		
		// 문서 로드시 첫번째 메뉴를 펼쳐진 상태로 두기
		// 해당 요소에 click() 이벤트를 발생시킨다 !
		$("li").eq(0).click();
	});
	
	// 상품 카테고리별 페이지 이동
	function Product_list(code, category) {
		location = "../Product/product_list.jsp?code=" + code + "&category=" + category;
	}
</script>
<link rel="stylesheet" href="../Etc/nav.css?ver=2">
</head>
<body>
<nav>
	<div id="top">
		<a href="../Index/home.jsp">LOGO IMAGE</a>
<!-- 		<!-- 크롬은 webm 만 지원 -->
<!-- 		<video preload="auto" autoplay="true" loop="loop" volume="0"> -->
<!-- 			<source src = "../Etc/bling.mp4" type ="video/mp4"> -->
<!-- 			Sorry, your browser does not support HTML5 video. -->
<!-- 		</video> -->
	</div>
	<div id="middle">
		<ul>
			<li>
				bestseller
				<ul class="sub">
					<li><a href="javascript:Product_list(0, 'bestseller');">best 24</a></li>
				</ul>
			</li>
			<li>
				top
				<ul class="sub">
					<li><a href="javascript:Product_list(101, 'top');">sleeveless</a></li>
					<li><a href="javascript:Product_list(102, 'top');">knit</a></li>
					<li><a href="javascript:Product_list(103, 'top');">blouse/shirt</a></li>
					<li><a href="javascript:Product_list(104, 'top');">tee</a></li>
				</ul>
			</li>
			<li>
				bottom
				<ul class="sub">
					<li><a href="javascript:Product_list(201, 'bottom');">skirts</a></li>
					<li><a href="javascript:Product_list(202, 'bottom');">pants</a></li>
				</ul>
			</li>
			<li>
				dress
				<ul class="sub">
					<li><a href="javascript:Product_list(301, 'dress');">short</a></li>
					<li><a href="javascript:Product_list(302, 'dress');">long</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<div id="bottom">
		<div id="search_button">
			<ul>
				<li><a href="#"><img src="../Etc/search.png" alt="no image" width="20px"></a></li>
			</ul>
		</div>
		<div>
			<ul>
				<%
				if (session.getAttribute("email") != null) {
				%>
				<li><a href="../Member/signout.jsp">SIGN OUT</a></li>
				<li><a href="../Member/account.jsp">MY ACCOUNT</a></li>
				<li><a href="../Member/cart.jsp">CART</a></li>
				<%
				} else {
				%>
				<li><a href="../Member/signin.jsp">SIGN IN</a></li>		
				<%
				}
				%>	
				<li><a href="">Q&A / REVIEW</a></li>
			</ul>
		</div>
	</div>
</nav>

</body>
</html>