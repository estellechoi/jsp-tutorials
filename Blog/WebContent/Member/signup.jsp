<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/commonStyle.css">
<link rel="stylesheet" href="../Style/signupStyle.css">
<script src="../Script/signupCheck.js"></script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<%@ include file="../Common/sidebar.jsp"%>
		<article>
			<form action="../Member/signup_ok.jsp" method="post"
				onsubmit="return check()">
				<table>
					<caption>회원가입</caption>

					<tr>
						<td><input type="text" name="userid" placeholder="아이디"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="password" name="password" placeholder="비밀번호"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="password" name="passwordCon"
							placeholder="비밀번호 확인"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="text" name="name" placeholder="이름"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="text" name="email" placeholder="이메일"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="radio" name="sex" value="남"> 남 <input
							type="radio" name="sex" value="여"> 여</td>
						<td class="x"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="가입하기"></td>
					</tr>
				</table>
			</form>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>

</body>
</html>