<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		width: 600px;
		margin: auto;
		border: 1px solid #eeeeee;
	}
	
	table td {
		height: 30px;
	}
</style>
</head>
<body>
<form action="booking_select.jsp" method="post" name="bookingForm">
	<table>
		<caption> 좌석 예약 </caption>
		<tr>
			<td>이름</td>
			<td><input type="text" name="name" placeholder="이름"></td>
		</tr>
		<tr>
			<td>휴대폰</td>
			<td><input type="text" name="cell" placeholder="휴대폰 번호"></td>
		</tr>
		<tr>
			<td>예약날짜</td>
			<td>
				<select name="year" id="year">
					<%
					for (int i=2019; i>= 1950; i--) {
					%>
						<option value="<%=i%>"><%=i%></option>
					<%
					}
					%>
				</select>
				<select name="month" id="month">
					<%
					for (int i=1; i<=12; i++) {
					%>
						<option value="<%=i%>"><%=i%></option>
					<%
					}
					%>
				</select>
				<select name="date" id="date">
					<%
					for (int i=1; i<=31; i++) { // 월별 일수로 수정 필요
					%>
						<option value="<%=i%>"><%=i%></option>
					<%
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>예약시간</td>
			<td>
				<select name="time" id="time">
					<option value="19:00">19:00</option>
					<option value="20:00">20:00</option>
					<option value="21:00">21:00</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>인원수</td>
			<td>
				<select name="people" id="people">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="예약하기"></td>
		</tr>
	</table>
</form>
</body>
</html>