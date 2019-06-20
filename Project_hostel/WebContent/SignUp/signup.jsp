<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/signupStyle.css">
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<form action="signup_ok.jsp">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="userid" placeholder="anthony"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" placeholder="안토니"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="password"
						placeholder="숫자/영문 혼합"></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="confirmPassword"
						placeholder="숫자/영문 혼합"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email"
						placeholder="anthony@gmail.com"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="가입하기"></td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>