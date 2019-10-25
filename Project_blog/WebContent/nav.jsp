<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	margin: 0;
}

nav {
	width: 200px;
	height: 100%;
}

nav li {
	list-style-type: none;
}

nav li a {
	text-decoration: none;
}

nav li a:hover {
	text-decoration: underline;
	font-weight: bold;
	font-size: 15px;
	color: #0A246A;
}
</style>
</head>
<body>
	<nav>
		<div id="logo"><a href="../home/home.jsp">home</a></div>
		<ul>
			<li><a href="../board/write.jsp?board=qna">Q&A</a></li>
			<li><a href="../board/write.jsp?board=qna">테스트2</a></li>
		</ul>
	</nav>
</body>
</html>