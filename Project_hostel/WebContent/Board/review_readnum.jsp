<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/hostel?useSSL=false", "root",
			"1324");
	Statement stmt = conn.createStatement();

	String id = request.getParameter("id");

	String sql = "update review set readnum=readnum+1 where id=" + id;
	
	stmt.executeUpdate(sql);
	
	response.sendRedirect("review_content.jsp?id="+id);
	
	stmt.close();
	conn.close();
%>