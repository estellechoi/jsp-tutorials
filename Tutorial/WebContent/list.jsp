<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<%
String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
String user = "root";
String pw = "apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

// DB 컨트롤 객체 생성
Statement stmt = conn.createStatement();

// DB 데이터 가져와서 저장하는 객체 생성 (sql select 쿼리문 결과값을 저장할 객체)
ResultSet rs;

// 쿼리문
String sql = "select*from guest";
// 쿼리문 실행메소드를 rs에 대입 (데이터 가져왔다 !)
rs = stmt.executeQuery(sql);

// rs.next(); (레코드포인터 이동 메소드)
// while(rs.next()){} → rs.next()의 결과값이 true 이면 실행하는 반복문
while(rs.next()) {
	out.println(rs.getString("name"));
	out.println(rs.getString("title"));
	out.println("<p>");
}

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