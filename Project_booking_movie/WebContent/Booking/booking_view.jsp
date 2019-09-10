<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		width: 400px;
		margin: auto;
		border: 1px solid #eeeeee;
		border-radius: 10px;
		box-shadow: 3px 3px 5px 3px grey;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	
	table caption {
		padding-top: 20px;
		padding-bottom: 20px;
		font-weight: bold;
	}
	
	table td {
		text-align: center;
		font-size: 13px;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	
	table td input[type=submit],[type=button] {
		border-radius: 5px;
		background: #4d4d4d;
		color: white;
		padding: 3px;
	}
</style>
</head>
<body>
	<form action="booking_view_ok.jsp" method="post">
		<table>
			<caption>예약 조회</caption>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="cell"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pwd"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="예약 조회"></td>
			</tr>
		</table>
	</form>
</body>
</html>