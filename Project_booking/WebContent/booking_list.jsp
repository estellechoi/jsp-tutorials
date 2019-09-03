<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%
	// 현재날짜
	Date today = new Date();
	int yy = today.getYear() + 1900;
	int mm = today.getMonth() + 1;
	int dd = today.getDate();
	String nowday = yy + "-" + mm + "-" + dd;

	// DB 연결
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	String sql = "select*from booking where day='" + nowday + "'";
	ResultSet rs = stmt.executeQuery(sql);

	// 해당 날짜에 예약된 데이터 조회
	String seat = "";
	while (rs.next()) {
		seat = seat + rs.getString("seat") + ",";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function check() {
		var seat = "<%=seat%>";
		// ex) var seat = "9,4,";
		var seatArr = seat.split(",");
		// javascript 에서는 배열의 길이에 빈칸 포함
		var seatNo = document.getElementsByClassName("seatNo");
		for (var i = 0; i < seatArr.length - 1; i++) {
			seatNo[seatArr[i]-1].style.background = "#dddddd";
			seatNo[seatArr[i]-1].style.borderColor = "red";
		}
	}
</script>
</head>
<body onload="check()">
	<table border="1px" cellspacing="30px">
		<caption>
			예약날짜 : <%=yy%> 년 <%=mm%> 월 <%=dd%> 일
		</caption>
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
</body>
</html>