<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);
	
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/test?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String sex = request.getParameter("sex");
	String address = request.getParameter("address");

	String f[] = request.getParameterValues("food");
	String food = "";
	for (int i = 0; i < f.length; i++) {
		food = food + f[i] + ",";
	}

	String sql = "insert into test set name='" + name + "', email='"
			+ email + "', title='" + title + "'";
	sql = sql + ", content='" + content + "', sex=" + sex
			+ ", address='" + address + "', food='" + food + "'";
	sql = sql + ", readnum=0, writeday='" + writeday + "'";
	stmt.executeUpdate(sql);

	response.sendRedirect("../Board/list.jsp");

	stmt.close();
	conn.close();
%>