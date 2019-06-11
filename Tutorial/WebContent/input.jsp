<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
// DB 연결
String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false"; // db명 : hotel
String user = "root";
String pw = "apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

// form input value 가져오기, 출력하기
String guestName = request.getParameter("name"); // name="name"
String guestTitle = request.getParameter("title"); // name="title"
String guestContent = request.getParameter("content"); // name="content"

//DB 컨트롤 객체 생성
Statement stmt = conn.createStatement();

//쿼리문
String sql = "insert into guest(name, title, content)";
sql=sql+"values('"+guestName+"','"+guestTitle+"','"+guestContent+"')";

// 쿼리 실행
out.println(sql);
//stmt.executeUpdate(sql);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
input page

</body>
</html>