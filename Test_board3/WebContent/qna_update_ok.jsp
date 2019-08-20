<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pageNum = request.getParameter("page");
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String user = request.getParameter("user");
	String age = request.getParameter("age");
	String sex = request.getParameter("sex");
// 	String pwd = request.getParameter("pwd");

	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);
	
	String sql = "update qna set title='"+title+"', content='"+content+"', user='"+user+"', age='"+age+"', sex="+sex+", writeday='"+writeday+"'";
	sql = sql + " where id="+id;

	stmt.executeUpdate(sql);

	response.sendRedirect("qna_content.jsp?id="+id+"&page="+pageNum);
	conn.close();
	stmt.close();
%>