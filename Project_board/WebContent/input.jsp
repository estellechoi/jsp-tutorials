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

	//한글 인식하기
	request.setCharacterEncoding("utf-8");
	// 사용자 입력값 수령
	String username = request.getParameter("name");
	String usercity = request.getParameter("city");
	String usercomment = request.getParameter("comment");

	// 쿼리문
	// insert into "table"("field", "field") values("문자", 숫자); 레코드 추가
	String sql = "insert into board(name, city, comment) values('"
			+ username + "','" + usercity + "','" + usercomment + "')";

	stmt.executeUpdate(sql);

	// back to home.jsp
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