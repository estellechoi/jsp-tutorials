<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String site = request.getParameter("site");
	String date = request.getParameter("date");
	
	String sql = "select distinct date from movie where title='"+title+"' and site='"+site+"' and date='"+date+"'";
	ResultSet rs = stmt.executeQuery(sql);
	
	String time = "";
	while (rs.next()) {
		out.print("<li><a href='javascript:getAll('" + title + "','" + site + "','" + rs.getString("date") + "')'>" + rs.getString("date") + "</a></li>");
	}
	
	stmt.close();
	conn.close();
%>