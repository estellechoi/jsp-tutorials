<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/hostel?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("userid");

	String sql = "select*from member where userid='" + userid + "'";
	ResultSet rs = stmt.executeQuery(sql);
	
	// 아이디 존재
	if(rs.next()) {
		out.print("yes"); // 출력값 "yes"를 Javascript에서 responseText로 호출한다
	}
	
	// 아이디 존재 X
	else {
		out.print("no");
	}
%>