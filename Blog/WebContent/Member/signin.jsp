<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/commonStyle.css">
<link rel="stylesheet" href="../Style/signupStyle.css?ver=1">
<script>
	function check() {
		var x = document.querySelectorAll('.x');
		if (document.all.userid.value == "") {
			x[0].innerText = "!!!";
			return false;
		} else if (document.all.password.value == "") {
			x[1].innerText = "!!!";
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<%@ include file="../Common/sidebar.jsp"%>
		<article>
			<form action="../Member/signin_ok.jsp" method="post"
				onsubmit="return check()">
				<table>
					<caption>로그인</caption>

					<tr>
						<td><input type="text" name="userid" placeholder="아이디"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="password" name="password" placeholder="비밀번호"></td>
						<td class="x"></td>
					</tr>

					<%
						if (request.getParameter("err") != null) {
					%>
					<tr>
						<td colspan="2" style="color: red">아이디 혹은 비밀번호가 틀립니다.</td>
					</tr>
					<%
						}
					%>

					<tr>
						<td colspan="2"><input type="button" value="아이디/비밀번호 찾기">
							<input type="submit" value="로그인"></td>
					</tr>
				</table>
			</form>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>

</body>
</html>