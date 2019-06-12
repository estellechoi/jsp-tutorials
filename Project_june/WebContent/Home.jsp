<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	// 1. DB 접속 객체
	String db = "jdbc:mysql://localhost:3306/member?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);

	// 2. 쿼리문 컨트롤 객체
	Statement stmt = conn.createStatement();

	// 3. 데이터 수령 객체
	ResultSet rs;

	// 4. 쿼리문
	String sql = "";

	// 5. 쿼리문 실행 메소드
	stmt.executeQuery(sql);
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