<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3306/checkin?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();
	
	String id = request.getParameter("id");
	String sql = "delete from board where id="+id;
	stmt.executeUpdate(sql);
	
	// 홈화면으로 이동
	response.sendRedirect("home.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>