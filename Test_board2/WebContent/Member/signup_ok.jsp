<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/test?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String sex = request.getParameter("sex");
	String birthYear = request.getParameter("birthYear");
	String birthMonth = request.getParameter("birthMonth");
	String birthDate = request.getParameter("birthDate");
	
	String sql = "insert into member(userid, password, name, email, sex, birthYear, birthMonth, birthDate)";
	sql = sql + " values('"+userid+"', '"+password+"', '"+name+"', '"+email+"', "+sex+", "+birthYear+", "+birthMonth+", "+birthDate+")";
	stmt.executeUpdate(sql);
	
	response.sendRedirect("../Member/signin.jsp");
	
	stmt.close();
	conn.close();
%>