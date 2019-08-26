<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/hostel?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String id_reply = request.getParameter("id_reply");

	String sql = "delete from announce_reply where id="+id_reply;
	stmt.executeUpdate(sql);
	out.println("ok");
%>