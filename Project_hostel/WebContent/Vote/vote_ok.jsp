<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/hostel?useSSL=false";
	Connection conn = DriverManager.getConnection(db, "root", "1234");
	Statement stmt = conn.createStatement();
	String sql =null;

	request.setCharacterEncoding("UTF-8");
	String menu = request.getParameter("menu");

	switch (menu) {
		case "1" :
			sql = "update vote set a1=a1+1 where id=1";
			break;
		case "2" :
			sql = "update vote set a2=a2+1 where id=1";
			break;
		case "3" :
			sql = "update vote set a3=a3+1 where id=1";
			break;
		case "4" :
			sql = "update vote set a4=a4+1 where id=1";
			break;
		case "5" :
			sql = "update vote set a5=a5+1 where id=1";
			break;
		case "6" :
			sql = "update vote set a6=a6+1 where id=1";
			break;
		case "7" :
			sql = "update vote set a7=a7+1 where id=1";
			break;
	}
	stmt.executeUpdate(sql);

	response.sendRedirect("../Vote/vote_view.jsp");
%>