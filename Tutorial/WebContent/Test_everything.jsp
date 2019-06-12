<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	
	// 데이터베이스 접속 객체
	Connection conn = DriverManager.getConnection(db, user, pw);

	// 쿼리문 사용하게 해주는 객체
	Statement stmt = conn.createStatement();
	
	// 데이터 수령 객체
	ResultSet rs;

	// 쿼리문
	String sql = "select*from guest";
	
	// 쿼리실행 메소드(쿼리문) 리턴값 ⇒  데이터 수령 객체
	rs = stmt.executeQuery(sql);
	
	// 레코드포인터 컨트롤
	rs.next();
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