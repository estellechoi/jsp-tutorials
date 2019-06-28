<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/blog?useSSL=false";
	Connection conn = DriverManager.getConnection(db, "root", "1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");

	String sql = "select*from member where userid='" + userid
			+ "' and password='" + password + "'";
	ResultSet rs = stmt.executeQuery(sql);

	if (rs.next()) {
		session.setAttribute("userid", rs.getString("userid"));
		session.setAttribute("name", rs.getString("name"));
		response.sendRedirect("../Home/home.jsp");
	} else {
		// 오류 메세지를 위한 err
		response.sendRedirect("../Member/signin.jsp?err=1");
	}
	
	stmt.close();
	conn.close();
%>
