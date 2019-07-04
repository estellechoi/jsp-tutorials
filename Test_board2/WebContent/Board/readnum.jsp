<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/test?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	
	String id = request.getParameter("id");
	String sql = "update test set readnum=readnum+1 where id="+id;
	stmt.executeUpdate(sql);
	
	response.sendRedirect("../Board/content.jsp?id="+id);
	
	stmt.close();
	conn.close();
%>