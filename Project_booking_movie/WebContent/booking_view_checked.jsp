<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");

	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String cell = request.getParameter("cell");

	String sql = "select*from movie where cell=" + cell;
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	width: 1000px;
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
	margin: auto;
	text-align: center;
	font-size: 13px;
	padding-top: 20px;
	padding-bottom: 20px;
	color: blue;
}

table tr {
	border: 1px solid #eeeeee;
	border-radius: 5px;
}

table td input[type=submit], [type=button] {
	border-radius: 5px;
	background: #4d4d4d;
	color: white;
	padding: 3px;
}

.field {
	font-weight: bold;
	color: black;
}
</style>
<script>
	function escapePage() {
		location = "booking_view.jsp";
	}
</script>
</head>
<body>
	<table>
		<caption>예약 조회</caption>
		<%
		while (rs.next()) {
		%>
		<tr>
			<td class="field">영화</td>
			<td><%=rs.getString("movie")%></td>
			<td class="field">날짜</td>
			<td><%=rs.getString("day")%></td>
			<td class="field">시간</td>
			<td><%=rs.getString("time")%></td>
			<td class="field">좌석</td>
			<td>
				<%
				// 좌석 배열 만들기
				// Java 에서는 배열에 공백 미포함
				String seat[] = rs.getString("seat").split(",");
				
				for (int i=0; i<seat.length; i++) {
				%>
				<%=seat[i]%>
				<%
				}
				%>
			</td>
			<td class="field">결제일</td>
			<td><%=rs.getString("writetime")%></td>
		</tr>
		<%
		}
		%>
		<tr>
			<td colspan="10"><input type="button" value="돌아가기" onclick="escapePage()"></td>
		</tr>
	</table>

</body>
</html>