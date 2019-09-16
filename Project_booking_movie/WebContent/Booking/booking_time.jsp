<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String movie = request.getParameter("movie");
	String name = request.getParameter("name");
	String cell = request.getParameter("cell");
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
%>
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
	
	.numberController {
		border-radius: 50px;
		width: 30px;
		height: 30px;
		border: 2px solid #C0E0FF;
		cursor: pointer;
	}
</style>
<script>
	function removePeople() {
		var number = parseInt(document.getElementById("countPeople").innerText);
		if (number - 1 < 0) {
			alert("선택 불가");
		}
		else {
			document.getElementById("countPeople").innerText = (number - 1) + "";
			document.bookingBox.people.value = number - 1;
		}
	}
	
	function addPeople() {
		var number = parseInt(document.getElementById("countPeople").innerText);
		if (number + 1 > 6) {
			alert("인원수는 6명까지 가능합니다.");
		}
		else {
			document.getElementById("countPeople").innerText = (number + 1) + "";
			document.bookingBox.people.value = number + 1;
		}
	}
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<form action="booking_seat.jsp" method="post" name="bookingBox">
			<input type="hidden" name="movie" value="<%=movie%>">
			<input type="hidden" name="name" value="<%=name%>">
			<input type="hidden" name="cell" value="<%=cell%>">
			<input type="hidden" name="email" value="<%=email%>">
			<input type="hidden" name="pwd" value="<%=pwd%>">
			<input type="hidden" name="people"> <!-- script 에서 값 부여 -->
			<table>
				<caption>날짜 및 시간 선택</caption>
				<tr>
					<td>
						<select name="mm" id="mm">
							<%
							for (int i=1; i<=12; i++) {
							%>
							<option value="<%=i%>"><%=i%> 월</option>
							<%
							}
							%>
						</select>
						<select name="dd" id="dd">
							<%
							for (int i=1; i<=31; i++) {
							%>
							<option value="<%=i%>"><%=i%> 일</option>
							<%
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<select name="time" id="time">
							<option value="0">시간 선택</option>
							<option value="19:00">19:00</option>
							<option value="20:00">20:00</option>
							<option value="21:00">21:00</option>
							<option value="22:00">22:00</option>
							<option value="23:00">23:00</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						인원 <span id="countPeople">0</span>
						<input class="numberController" type="button" value="-" onclick="removePeople()">
						<input class="numberController" type="button" value="+" onclick="addPeople()">
					</td>
				</tr>
				<tr>
					<td><input type="submit" value="다음"></td>
				</tr>
			</table>
		</form>
	</section>
</body>
</html>