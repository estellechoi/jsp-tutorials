<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%
	// * 현재년도
	Date today = new Date();
	int yy = today.getYear() + 1900;

	request.setCharacterEncoding("UTF-8");
	String movie = request.getParameter("movie");
	String name = request.getParameter("name");
	String cell = request.getParameter("cell");
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
	String day = yy + "-" + request.getParameter("mm") + "-" + request.getParameter("dd");
	String time = request.getParameter("time");
	int people = Integer.parseInt(request.getParameter("people"));
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
		padding: 20px;
	}
	
	table caption {
		padding-top: 20px;
		padding-bottom: 20px;
		font-weight: bold;
	}
	
	table td {
		width: 30px;
		height: 25px;
		margin: 3px;
		border: 2px solid #C0E0FF;
		border-radius: 5px;
		text-align: center;
		font-size: 13px;
		font-weight: bold;
		background: #4d4d4d;
		color: white;
		cursor: pointer;
	}
	
	table .space {
		border: none;
		background: none;
		cursor: default;
	}
	
	div {
		width: 400px;
		height: 100px;
		margin: auto;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	div input[type=submit] {
		border-radius: 5px;
		background: #4d4d4d;
		color: white;
		padding: 3px;
		height: 35px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var seat = "";
	function selectSeat(seatNo) {
		var seatArr = seat.split(",");
		if (seatArr.length - 1 >= <%=people%>) {
			alert("좌석 재선택 !");
			// 이전 좌석 모두 취소
			$(".selected").css("background", "#4d4d4d"); // 모든 좌석 색상 블랙으로
			seat = "";
			// 현재 선택
			seatNo.style.background = "#2080D0";
			seat = seatNo.innerText + ",";
			document.bookingBox.seat.value = seat;
		}
		else {
			// 브라우저 색상 표시
			// 클래스 selected
			seatNo.style.background = "#2080D0";
			// input 값 부여
			seat = seat + seatNo.innerText + ",";
			document.bookingBox.seat.value = seat;
		}
	}
</script>
</head>
<body>
	<form action="booking_ok.jsp" method="post" name="bookingBox">
		<input type="hidden" name="movie" value="<%=movie%>">
		<input type="hidden" name="name" value="<%=name%>">
		<input type="hidden" name="cell" value="<%=cell%>">
		<input type="hidden" name="email" value="<%=email%>">
		<input type="hidden" name="pwd" value="<%=pwd%>">
		<input type="hidden" name="day" value="<%=day%>">
		<input type="hidden" name="time" value="<%=time%>">
		<input type="hidden" name="people" value="<%=people%>">
		<input type="hidden" name="seat"> <!-- script 에서 값 부여 -->
		<table>
			<caption>좌석 선택</caption>
			<%
			char alphabet = 'A';
			for (int i =0; i<5; i++) {
				
			%>
			<tr>
				<%
				for (int j=1; j<=10; j++) {
					if (j == 3 || j == 9) {
					%>
						<td class="space"></td>
					<%
					}
				%>
					<td class="selected" onclick="selectSeat(this)"><%=(char)alphabet%><%=j%></td>
				<%
				}
				%>
			</tr>
			<%
				alphabet++;
			}
			%>
		</table>
		<div>
			<input type="submit" value="완료">
		</div>
	</form>
</body>
</html>