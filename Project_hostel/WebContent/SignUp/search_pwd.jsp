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
	String name = request.getParameter("name");
	String email = request.getParameter("email");

	String sql = "select*from member where userid='" + userid + "' and email='" + email + "' and name='" + name + "'";
	ResultSet rs = stmt.executeQuery(sql);

	if (rs.next()) {
		out.print("<b style='color:red'>"+rs.getString("password")+"</b>"); // AJAX 처리로 변경 예정
		
	} else {
		out.println("<b style='color:red'>일치하는 회원정보가 없습니다.</b>");
	}
	
	stmt.close();
	conn.close();
%>