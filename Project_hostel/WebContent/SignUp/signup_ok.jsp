<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
String db="jdbc:mysql://localhost:3307/hostel?useSSL=false";
String user="root";
String pw="1234";
Connection conn = DriverManager.getConnection(db,user,pw);
Statement stmt = conn.createStatement();

// 한글패치 필수
request.setCharacterEncoding("utf-8");
String userid = request.getParameter("userid");
String name = request.getParameter("name");
String password = request.getParameter("password");
String email = request.getParameter("email");

String sql="insert into member(userid, name, password, email) values('"+userid+"', '"+name+"', '"+password+"', '"+email+"')";
stmt.executeUpdate(sql);

// 어디로 보내지
response.sendRedirect("../Home/home.jsp");
%>


