<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
// DB 접속
String db="jdbc:mysql://localhost:3306/checkin?useSSL=false";
String user="root";
String pw="apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);
// 쿼리 조정 객체
Statement stmt = conn.createStatement();

// 사용자 입력값 수령
String username = request.getParameter("name");
String usercity = request.getParameter("city");
String usercomment = request.getParameter("comment");

// 쿼리문
// insert into "table"("field", "field") values("문자", 숫자); 레코드 추가
String sql = "insert into board(name, city, comment) values('"+username+"','"+usercity+"','"+usercomment+"')";

stmt.executeUpdate(sql);

// back to home.jsp
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