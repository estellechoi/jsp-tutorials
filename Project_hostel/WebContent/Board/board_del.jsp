<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/hostel?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	// post 전송값
	String id = request.getParameter("id");
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	
	String sql = "select*from member where userid='"+userid+"'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();

	if(password.equals(rs.getString("password"))) {
		sql = "delete from board where id=" + id;
		stmt.executeUpdate(sql);
		response.sendRedirect("../Board/board_list.jsp");
	} else {
		response.sendRedirect("../Board/board_content.jps?id="+id+"");
	}

	stmt.close();
	conn.close();
%>