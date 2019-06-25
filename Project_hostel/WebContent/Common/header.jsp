<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header>
	<div id="signin">
	<%
		if (session.getAttribute("userid") == null) {
	%>	
		<a href="../SignUp/signup.jsp">회원가입</a>
		<a href="../SignUp/signin.jsp">로그인</a>
		<a href="">찾아오시는길</a>
	<%
		}
		else {
	%>
		<a href=""><%=session.getAttribute("name")%> 님, 안녕하세요 !</a>
		<a href="../SignUp/editProfile_check.jsp">정보수정</a>
		<a href="../SignUp/signout.jsp">로그아웃</a>
		<a href="">찾아오시는길</a>	
	<%
		}
	%>
	</div>
	<div id="topbar">
		<div id="logo">
			<a href="../Home/home.jsp"> <img src="../Image/logo.png"
				height="50px" alt="로고이미지">
			</a>
		</div>
		<div id="menu">
			<ul>
				<li><a href="">소개</a></li>
				<li><a href="">객실</a></li>
				<li><a href="">부대시설</a></li>
				<li><a href="../Board/announce_list.jsp">게시판</a></li>
				<li><a href="">예약</a></li>
			</ul>
		</div>
	</div>
</header>