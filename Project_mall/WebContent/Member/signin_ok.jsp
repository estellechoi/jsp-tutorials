<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");

	String sql = "select * from member where email='" + email + "'";
	sql = sql + " and pwd='" + pwd + "'";
	ResultSet rs = stmt.executeQuery(sql);

	if (rs.next()) {
		session.setAttribute("email", rs.getString("email"));
		session.setAttribute("username", rs.getString("username"));
		response.sendRedirect("../Index/home.jsp");
	}

	else {
%>
<script>
	alert("회원정보가 일치하지 않거나 회원이 아닙니다.");
	history.back();
</script>
<%
	}
%>