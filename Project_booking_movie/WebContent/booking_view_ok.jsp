<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");

	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String cell = request.getParameter("cell");
	String pwd = request.getParameter("pwd");
	
	String sql = "select*from movie where name='"+name+"' and cell="+cell;
	ResultSet rs = stmt.executeQuery(sql);
	
	if (rs.next()) {
		if (pwd.equals(rs.getString("pwd"))) {
			response.sendRedirect("booking_view_checked.jsp?cell="+cell);
		}
		else {
			%>
			<script>
				alert("비밀번호가 틀립니다 !");
				history.back();
			</script>
			<%
		}
	}
	else {
		%>
		<script>
			alert("예약정보가 없습니다 !");
			history.back();
		</script>
		<%
	}
	
	stmt.close();
	conn.close();
%>