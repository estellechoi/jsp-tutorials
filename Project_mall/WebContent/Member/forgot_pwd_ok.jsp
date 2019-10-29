<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	String username = request.getParameter("username");

	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	String sql = "select*from member where email='" + email + "' and username='" + username + "'";
	ResultSet rs = stmt.executeQuery(sql);
	
	if (rs.next()) {
		response.sendRedirect("forgot_pwd_view.jsp?email="+rs.getString("email"));
	}
	else {
		%>
		<script>
			history.back();
			alert("일치하는 회원 정보가 없습니다.");
		</script>
		<%
	}
	
	stmt.close();
	conn.close();
%>