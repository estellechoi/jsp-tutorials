<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	
	String sql = "select distinct site from movie where title='"+title+"'";
	ResultSet rs = stmt.executeQuery(sql);
	
	String site = "";
	while (rs.next()) {
		out.print("<li><a href='javascript:getDate(\""+title+"\",\""+rs.getString("site")+"\")'>" + rs.getString("site") + "</a></li>");
	}
	
	stmt.close();
	conn.close();
%>