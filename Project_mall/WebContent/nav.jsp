<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../Etc/nav.js?ver=1"></script>
<link rel="stylesheet" href="../Etc/nav.css">
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
			<li onclick="toggle(0, 'best')">
				bestseller
				<ul class="sub">
					<li>best 30</li>
				</ul>
			</li>
			<li onclick="toggle(1, 'top')">
				top
				<ul class="sub">
					<li>sleeveless</li>
					<li>knit</li>
					<li>blouse/shirt</li>
					<li>tee</li>
				</ul>
			</li>
			<li onclick="toggle(2, 'bottom')">
				bottom
				<ul class="sub">
					<li>skirts</li>
					<li>pants</li>
				</ul>
			</li>
			<li onclick="toggle(3, 'dress')">
				dress
				<ul class="sub">
					<li>short</li>
					<li>long</li>
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
				<li><a href="../Member/signin.jsp">LOGIN</a></li>
				<li><a href="">MY ACCOUNT</a></li>
				<li><a href="">CART</a></li>
				<li><a href="">Q&A / REVIEW</a></li>
			</ul>
		</div>
	</div>
</nav>

</body>
</html>