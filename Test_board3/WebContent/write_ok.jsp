<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!-- java sql 패키지를 import -->
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String user = request.getParameter("user");
	String age = request.getParameter("age");
	String sex = request.getParameter("sex");
	String pwd = request.getParameter("pwd");

	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);

	String sql = "insert into testboard(title, content, user, age, sex, pwd, readnum, writeday) ";
	sql = sql + " values('" + title + "', '" + content + "', '" + user
			+ "', '" + age + "', '" + sex + "', '" + pwd + "', 0, '"
			+ writeday + "')";
	stmt.executeUpdate(sql);

	response.sendRedirect("list.jsp");
	conn.close();
	stmt.close();
%>