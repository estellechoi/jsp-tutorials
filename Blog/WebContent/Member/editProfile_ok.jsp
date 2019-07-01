<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/blog?useSSL=false";
	Connection conn = DriverManager.getConnection(db, "root", "1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String sex = request.getParameter("sex");

	String sql = "update member set name='" + name + "', password='"
			+ password + "', email='" + email + "', sex='" + sex
			+ "' where userid='" + session.getAttribute("userid") + "'";

	stmt.executeUpdate(sql);
	response.sendRedirect("../Home/home.jsp");

	stmt.close();
	conn.close();
%>