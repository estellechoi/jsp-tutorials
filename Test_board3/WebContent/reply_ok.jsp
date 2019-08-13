<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*"%>
<%
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);

	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	String pwd = request.getParameter("pwd");
	String rid = request.getParameter("rid");
	// 원래 페이지로 돌아가기 위해 페이지 값을 갖고 다니자 !
	String pageNum = request.getParameter("page");

	String sql = "insert into reply(name, content, pwd, writeday, rid) ";
	sql = sql + "values('" + name + "', '" + content + "', '" + pwd
			+ "', '" + writeday + "', " + rid + ")";

	stmt.executeUpdate(sql);
	
	// content.jsp → list.jsp?page=x 로 복귀를 위한 값이 필요
	response.sendRedirect("content.jsp?id=" + rid+"&page="+pageNum);
	
	// 객체 닫기
	conn.close();
	stmt.close();
%>