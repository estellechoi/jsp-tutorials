<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String db = "jdbc:mysql://localhost:3307/java?useSSL=false";
String user = "root";
String pw = "1234";
Connection conn = DriverManager.getConnection(db, user, pw);
Statement stmt = conn.createStatement();

request.setCharacterEncoding("UTF-8");
String username = request.getParameter("username");
String title = request.getParameter("title");
String birth = request.getParameter("birth");
String sex = request.getParameter("sex");
String smoker = request.getParameter("smoker");
String address = request.getParameter("address");
String password = request.getParameter("password");


String sql = "insert into signup(username, title, birth, sex, smoker, address, password) ";
sql = sql + " values('"+username+"', '"+title+"', "+birth+", "+sex+", '"+smoker+"', '"+address+"', '"+password+"')";

stmt.executeUpdate(sql);

conn.close();
stmt.close();
%>
