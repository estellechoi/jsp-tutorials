<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	// DB 접속
	String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false"; // db명 : hotel
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement(); // 쿼리 객체

	// 사용자 입력값 가져오기 (수정 후 저장 전의 내용들을 어떻게 가져올 것인가 ?)
	String id = request.getParameter("id");
	String guestTitle = request.getParameter("title");
	String guestContent = request.getParameter("content");
	
	// 쿼리문
	// update "table" set "field"='new record', "field"='new record' where "field"='record';
	String sql = "update guest set title='"+guestTitle+"', content='"+guestContent+"' where id=" + id;

	stmt.executeUpdate(sql);

	// ★ Test_content.jsp?id=x 로 이동
	response.sendRedirect("Test_content.jsp?id="+id);
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