<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/test?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	
	String sql="select*from member where userid='"+userid+"' and password='"+password+"'";
	ResultSet rs = stmt.executeQuery(sql);
	
	if(rs.next()) {
		session.setAttribute("userid", rs.getString("userid"));
		session.setAttribute("name", rs.getString("name"));
		response.sendRedirect("../Board/list.jsp");
	}
	else {
		response.sendRedirect("../Member/signin.jsp");
	}
	
	stmt.close();
	conn.close();
%>