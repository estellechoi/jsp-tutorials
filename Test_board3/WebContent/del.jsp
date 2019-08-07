<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	String id = request.getParameter("id");
	String sql = "delete from testboard where id = " + id;

	stmt.executeUpdate(sql);

	response.sendRedirect("list.jsp");

	conn.close();
	stmt.close();
%>