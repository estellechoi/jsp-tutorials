<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/header.css">
</head>

<header>
		<div class="grid1">Test Blog</div>
		<div class="grid2">
			<ul>
				<li><a href="../Board/list.jsp">게시판</a></li>
				<li><a href="#" disabled>Disabled</a></li>
			</ul>
		</div>
		<div class="grid3">
			<%
				if(session.getAttribute("userid") != null) {
			%>
			<a href="#"><%=session.getAttribute("name")%> 님</a>
			<a href="../Member/signout.jsp">로그아웃</a>
			<a href="../Member/edit.jsp">프로필 수정</a>
			<%
				} else {
			%>
			<a href="../Member/signin.jsp">로그인</a>
			<a href="../Member/signup.jsp">회원가입</a>
			<%
				}
			%>
		</div>
</header>