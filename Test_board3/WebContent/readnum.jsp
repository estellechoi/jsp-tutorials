<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	String id = request.getParameter("id");
	String pageNum = request.getParameter("page");
	String sql = "update testboard set readnum=readnum+1 where id=" + id;
	stmt.executeUpdate(sql);

	response.sendRedirect("content.jsp?id=" + id + "&page="+pageNum);
	conn.close();
	stmt.close();
%>