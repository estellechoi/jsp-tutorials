<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String cell = request.getParameter("cell");
	
	String sql = "select*from movie_member where cell="+cell+" and birth="+birth+" and name='"+name+"'";
	ResultSet rs = stmt.executeQuery(sql);
	
	if (rs.next()) {
// 		response.sendRedirect("signup_form.jsp");
		%>
		<script>
			alert("이미 가입된 회원입니다 !");
			history.back();
		</script>
		<%
	}
	else {
		response.sendRedirect("signup_form_checked_form.jsp");
	}
	
	stmt.close();
	conn.close();
%>