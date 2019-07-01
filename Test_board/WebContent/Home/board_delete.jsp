<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/test?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("name");
	String sql = "delete from board where id=" + id;

	stmt.executeUpdate(sql);
	
	response.sendRedirect("../Home/board_list.jsp");

	stmt.close();
	conn.close();
%>