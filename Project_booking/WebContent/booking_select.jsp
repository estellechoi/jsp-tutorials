<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// * 이름, 휴대폰, 예약날짜, 시간, 인원
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String cell = request.getParameter("cell");
	String day = request.getParameter("year") + "-"
			+ request.getParameter("month") + "-"
			+ request.getParameter("date");
	String time = request.getParameter("time");
	String people = request.getParameter("people");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script>
		function seatSel(n) {
			var seatNo = document.getElementsByClassName("seatNo");
			var seat = document.selectForm.seat.value; // input hidden 값
			
			// * 선택한 인원수보다 많이 선택하면 ?
			// 이미 붉은 표시된 요소가 있는지 검사  (이미 주어진 input hidden 값)→ 있다면  색상 원상태
			if(seat != "") {
				var i = parseInt(seat) - 1;
				seatNo[i].style.borderColor = "black";
			}
			
			// 새로 선택한 요소 값 부여 및 색상 변경
			document.selectForm.seat.value = n; // input 값 부여 // n 문자열로 안바꿔줘도 상관 없나 ?
			seatNo[n-1].style.borderColor = "red"; // 선택된 좌석 색 변경
		}
	</script>
</head>
<body>
	<form action="booking_ok.jsp" method="post" name="selectForm">
		<input type="hidden" name="seat"> <!-- script 에서 값 전달 -->
		<input type="hidden" name="name" value="<%=name%>">
		<input type="hidden" name="cell" value="<%=cell%>">
		<input type="hidden" name="day" value="<%=day%>">
		<input type="hidden" name="time" value="<%=time%>">
		<input type="hidden" name="people" value="<%=people%>">
		<table border="1px" cellspacing="30px">
			<caption>예약날짜 : <%=day%> 예약시간 : <%=time%></caption>
			<tr>
				<td onclick="seatSel(1)" class="seatNo">1</td>
				<td onclick="seatSel(2)" class="seatNo">2</td>
				<td onclick="seatSel(3)" class="seatNo">3</td>
				<td onclick="seatSel(4)" class="seatNo">4</td>
			</tr>
			<tr>
				<td onclick="seatSel(5)" class="seatNo">5</td>
				<td onclick="seatSel(6)" class="seatNo">6</td>
				<td onclick="seatSel(7)" class="seatNo">7</td>
				<td onclick="seatSel(8)" class="seatNo">8</td>
			</tr>
			<tr>
				<td onclick="seatSel(9)" class="seatNo">9</td>
				<td onclick="seatSel(10)" class="seatNo">10</td>
				<td onclick="seatSel(11)" class="seatNo">11</td>
				<td onclick="seatSel(12)" class="seatNo">12</td>
			</tr>
		</table>
		<div><input type="submit" value="좌석 선택"></div>
	</form>
</body>
</html>