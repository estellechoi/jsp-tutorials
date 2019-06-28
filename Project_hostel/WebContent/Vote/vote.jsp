<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="../Vote/vote_ok.jsp" method="post">
		<table>
			<caption>
				<h3>당신이 좋아하는 안주는 ?</h3>
			</caption>
			<tr>
				<td><input type="radio" name="menu" value="1">생선회</td>
				<td><input type="radio" name="menu" value="2">소곱창</td>
				<td><input type="radio" name="menu" value="3">두부김치</td>
				<td><input type="radio" name="menu" value="4">양꼬치</td>
				<td><input type="radio" name="menu" value="5">초밥</td>
				<td><input type="radio" name="menu" value="6">감자탕</td>
				<td><input type="radio" name="menu" value="7">족발</td>
			</tr>
			<tr>
				<td colspan="7"><input type="submit" value="선택 완료"></td>
			</tr>
		</table>
	</form>
</body>
</html>