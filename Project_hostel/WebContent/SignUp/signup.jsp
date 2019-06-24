<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/signupStyle.css">
<script>
	function check() {
		var email = document.all.email.value;

		if (document.all.userid.value == "") {
			useridx.innerText = "아이디를 입력하세요.";
			return false;
		} else if (document.all.name.value == "") {
			namex.innerText = "이름을 입력하세요.";
			return false;
		} else if (document.all.password.value == "") {
			passwordx.innerText = "비밀번호를 입력하세요.";
			return false;
		} else if (document.all.password.value != document.all.confirmPassword.value) {
			confirmPasswordx.innerText = "비밀번호 불일치";
			return false;
		} else if (email.indexOf("@") <= 0) {
			emailx.innerText = "올바르지 않은 이메일 주소";
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
		<article></article>
		<article>
			<form action="signup_ok.jsp" onsubmit="return check()">
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="userid" placeholder="anthony"></td>
						<td id="useridx"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name" placeholder="안토니"></td>
						<td id="namex"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="password"
							placeholder="숫자/영문 혼합"></td>
						<td id="passwordx"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" name="confirmPassword"
							placeholder="숫자/영문 혼합"></td>
						<td id="confirmPasswordx"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="email"
							placeholder="anthony@gmail.com"></td>
						<td id="emailx"></td>
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