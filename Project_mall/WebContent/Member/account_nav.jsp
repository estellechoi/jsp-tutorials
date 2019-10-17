<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/* ACCOUNT 본문 grid display */
	.account_grid_container {
		display: grid;
		grid-template-columns: 8fr 2fr;
	}

	.account_nav li {
		list-style-type: none;
		margin: 20px;
	}
	.account_nav li a {
		text-decoration: none;
		color: #0A246A;
		font-weight: bold;
		font-size: 13px;
		letter-spacing: 2px;
	}
	
	.account_nav li a:hover {
		font-size: 14px;
	}
</style>
</head>
<body>
	<ul class="account_nav">
		<li><a href="account.jsp">내 프로필</a></li>
		<li><a href="account_edit.jsp">정보 수정</a></li>
		<li><a href="account_edit_pwd.jsp">비밀번호 변경</a></li>
		<li><a href="myorder.jsp">마이 오더</a></li>
	</ul>
</body>
</html>