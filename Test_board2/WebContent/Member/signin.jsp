<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/signup.css">
<script>
	function check() {
		var icon = "<img src='../Image/alert.png' alt='이미지' width='25'>";
		
		if (document.sign.userid.value == "") {
			document.querySelectorAll(".xx")[0].innerHTML = icon;
			return false;
		}
		else if (document.sign.password.value == "") {
			document.querySelectorAll(".xx")[1].innerHTML = icon;
			return false;
		}
	}
</script>
</head>
<body>
<%@ include file="../Common/header.jsp" %>
<section>
	<form name="sign" action="../Member/signin_ok.jsp" method="post" onsubmit="return check()">
		<table>
			<caption>로그인</caption>
			<tr>
				<td>
					<input type="text" name="userid" placeholder="아이디">
					<span class="xx"></span>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="password" placeholder="비밀번호">
					<span class="xx"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="로그인"></td>
			</tr>
		</table>
	</form>
</section>
</body>
</html>