<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<script>
	function locationProfile() {
		location = "../Home/home.jsp";
	}
</script>
<link rel="stylesheet" href="../Style/headerStyle.css">
</head>

<header>
	<div id="topbar">
		<div id="profileImage" onclick="locationProfile()"></div>
		<%
			if (session.getAttribute("userid") == null) {
		%>
		<a href="">업로드하기</a>
		<a href="../Member/signup.jsp">회원가입</a>
		<a href="../Member/signin.jsp">로그인</a>
		<%
			} else {
		%>
		<a href="">업로드하기</a>
		<a href="">정보수정</a>
		<a href="../Member/signout.jsp">로그아웃</a>
		<%
			}
		%>
	</div>
</header>
