<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/hostel?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	
	String rid = request.getParameter("rid");
	String userid = request.getParameter("userid");
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);
	
	// 쿼리
	String sql = "insert into announce_reply(rid, userid, name, content, writeday)";
	sql = sql + " values("+rid+", '"+userid+"', '"+name+"', '"+content+"', '"+writeday+"')";
	
	stmt.executeUpdate(sql);
	
	response.sendRedirect("announce_content.jsp?id="+rid);
	
	stmt.close();
	conn.close();
%>