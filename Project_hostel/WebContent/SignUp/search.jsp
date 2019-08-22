<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css?ver=1">
<style>
	table {
		width: 400px;
		height: 150px;
		margin: auto;
		border: 1px solid #eeeeee;
		border-radius: 10px;
	}
</style>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article>
			<form action="search_id.jsp" method="post">
				<table>
					<caption>아이디 찾기</caption>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="email"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="아이디 찾기"></td>
					</tr>
				</table>
			</form>
			<form action="search_pwd.jsp" method="post">
				<table>
					<caption>비밀번호 찾기</caption>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="userid"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="email"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="비밀번호 찾기"></td>
					</tr>
				</table>
			</form>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>