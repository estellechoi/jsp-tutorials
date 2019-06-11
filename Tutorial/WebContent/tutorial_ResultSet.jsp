<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
//DB 접속을 위한 변수들
String db="jdbc:mysql://localhost:3306/hotel?useSSL=false";
String user="root";
String pw="apmsetup";

// DB 접속
Connection conn = DriverManager.getConnection(db,user,pw);

// DB 쿼리 컨트롤 객체 생성
Statement stmt = conn.createStatement();

// DB 데이터 가져오는 객체 생성 (sql select 쿼리문 결과값을 저장할 객체)
ResultSet rs;

// 쿼리문 실행
String sql = "select*from guest";
rs = stmt.executeQuery(sql);

// rs.getString(); rs에 저장된 값 문자열로 출력
// rs.getInt(); 정수로 출력

// * 레코드포인터 (default position → table field row)
// rs.next(); to move record pointer (row by row)
// * if points a row without records, it values "false"(boolean).
// while statement : 조건이 true일 때 반복 실행
while(rs.next()) {
	out.println(rs.getString("name"));
	out.println(rs.getString("title"));
	out.println("<p>");	
}

//rs.next();
//out.println(rs.getString("name"));
//out.println(rs.getString("title"));
//out.println("<p>");
//rs.next();
//out.println(rs.getString("name"));
//out.println(rs.getString("title"));
//out.println("<p>");

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