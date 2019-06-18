<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/checkin?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();
	ResultSet rs;

	// 한글 인식하기
	request.setCharacterEncoding("utf-8");

	// 사용자가 선택한 링크의 parameter("id") 값 가져오기
	String id = request.getParameter("id");

	String sql = "select*from board where id=" + id;
	rs = stmt.executeQuery(sql);

	rs.next();
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="bodyColor.css">
<link rel="stylesheet" href="content.css">
</head>
<body>
	<a href="update.jsp?id=<%=rs.getString("id")%>"> Amend </a>
	<a href="delete.jsp?id=<%=rs.getString("id")%>"> Delete </a>
	<a href="home.jsp"> To Home </a>
	<p></p>
	<div>
		Name <span> <%=rs.getString("name")%>
		</span>
		<p></p>
		City &nbsp; <span> <%=rs.getString("city")%>
		</span>
		<p></p>
		Comment <span> <%=rs.getString("comment")%>
		</span>
	</div>
</body>
</html>

<%
stmt.close();
conn.close();
%>