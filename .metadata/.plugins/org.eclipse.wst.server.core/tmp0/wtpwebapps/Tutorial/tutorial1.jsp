<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "java.sql.*" %>

<%
// DB 연결
String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false"; // db명 : hotel
String user = "root";
String pw = "apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

// form input value 가져오기, 출력하기
String a = request.getParameter("xx"); // <input name="xx">
String b = request.getParameter("yy"); // <input name="xx">

//DB 컨트롤 객체 생성
Statement stmt = conn.createStatement();

//쿼리문
String sql = "insert into guest(field name,field name)";
sql=sql+"values('"+a+"','"+b+"')";

// 쿼리 실행
// stmt.executeUpdate(sql);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
Tutorial.
</body>
</html>