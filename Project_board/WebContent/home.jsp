<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	// DB 접속
	String db = "jdbc:mysql://localhost:3307/checkin?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	// 쿼리 조정 객체
	Statement stmt = conn.createStatement();
	// 쿼리문
	String sql = "select*from board order by id desc"; // 최신순 (id 내림차순)
	// 데이터 수령 객체
	ResultSet rs;
	// 쿼리 실행
	rs = stmt.executeQuery(sql);

	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="bodyColor.css">
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
			<td id="colId">no</td>
			<td id="colName">name</td>
			<td id="colCity">city</td>
			<td id="colComment">comment</td>
		</tr>
		<%
		int n =0;
			while (rs.next()) {
			// database table row 만큼 반복
			n = n+1;
		%>
		<tr>
			<td><%=n%></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getString("city")%></td>
			<td><a href="content.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("comment")%></a></td>
		</tr>
		<%
			// <a href="content.jsp?id=13&name=estelle">
			}
		stmt.close();
		conn.close();
		%>
	</table>

</body>
</html>