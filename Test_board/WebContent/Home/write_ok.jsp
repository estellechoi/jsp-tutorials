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
	String name = request.getParameter("name");
	String title = request.getParameter("title");
 	String sex = request.getParameter("sex");
	String content = request.getParameter("content");

	String sql = "insert into board(readnum, name, title, content, sex)";
	sql = sql + " values(0, '"+name+"', '"+title+"', '"+content+"', '"+sex+"')";
	stmt.executeUpdate(sql);

	response.sendRedirect("../Home/board_list.jsp");

	stmt.close();
	conn.close();
%>