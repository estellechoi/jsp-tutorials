<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/blog?useSSL=false";
	Connection conn = DriverManager.getConnection(db, "root", "1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("userid");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String sex = request.getParameter("sex");

	String sql = "insert into member(userid, name, password, email, sex)";
	sql = sql + " values('" + userid + "', '" + name + "', '" + password
			+ "', '" + email + "', '" + sex + "')";
	stmt.executeUpdate(sql);
	
	response.sendRedirect("../Home/home.jsp");
	
	stmt.close();
	conn.close();
%>