<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	// DB 접속
	String db = "jdbc:mysql://localhost:3306/checkin?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);
	// 쿼리 조정 객체
	Statement stmt = conn.createStatement();
	// 쿼리문
	String sql = "select*from board";
	// 데이터 수령 객체
	ResultSet rs;
	// 쿼리 실행
	rs = stmt.executeQuery(sql);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="home.css">
</head>
<body>
	<table>
		<caption>
			<h3>Checkin Board</h3>
			<a href="input.html" id="checkinButton"> Checkin </a>
			<p></p>
		</caption>
		<tr id="field">
			<td id="colId">id</td>
			<td id="colName">name</td>
			<td id="colCity">city</td>
			<td id="colComment">comment</td>
		</tr>
		<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("id")%></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getString("city")%></td>
			<td><a href="content.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("comment")%></a></td>
		</tr>
		<%
			}
		%>
	</table>

</body>
</html>