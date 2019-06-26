<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>유진의 블로그</title>
<link rel="stylesheet" href="../style/structure.css">
<script>
	function locationProfile() {
		location = "";
	}
</script>
</head>

<body>
	<header>
		<div id="topbar">
			<div id="profileImage" onclick="locationProfile()"></div>
			<a href="">업로드하기</a> <a href="">회원가입</a> <a href="">로그인</a>
		</div>
	</header>
	<section>
		<article id="category">
			<ul>
				<li><a href="">에세이</a></li>
				<li><a href="">개발</a></li>
				<li><a href="">디자인</a></li>
				<li><a href="">커뮤니티</a></li>
			</ul>
		</article>
		<article id="feed"></article>
	</section>
	<footer></footer>

</body>

</html>