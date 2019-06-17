<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
String db="jdbc:mysql://localhost:3306/checkin?useSSL=false";
String user="root";
String pw="apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);
Statement stmt = conn.createStatement();

// 사용자 form 입력값 가져오기
String id = request.getParameter("id");
String city = request.getParameter("city");
String comment = request.getParameter("comment");

String sql="update board set city='"+city+"', comment='"+comment+"' where id="+id;

stmt.executeUpdate(sql);

// content 화면으로 가기
response.sendRedirect("content.jsp?id="+id);

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