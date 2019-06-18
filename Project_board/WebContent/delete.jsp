<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/checkin?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	// 한글 인식하기
	request.setCharacterEncoding("utf-8");
	//
	String id = request.getParameter("id");
	String sql = "delete from board where id=" + id;
	stmt.executeUpdate(sql);

	// 홈화면으로 이동
	response.sendRedirect("home.jsp");
	
	stmt.close();
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>