<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/checkin?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	//한글 인식하기
	request.setCharacterEncoding("utf-8");
	// 사용자 form 입력값 가져오기
	String id = request.getParameter("id");
	String city = request.getParameter("city");
	String comment = request.getParameter("comment");

	String sql = "update board set city='" + city + "', comment='"
			+ comment + "' where id=" + id;

	stmt.executeUpdate(sql);

	// content 화면으로 가기
	response.sendRedirect("content.jsp?id=" + id);
	
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