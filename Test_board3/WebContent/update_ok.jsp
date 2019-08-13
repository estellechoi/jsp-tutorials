<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbd:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("page");
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String age = request.getParameter("age");
	String sex = request.getParameter("sex");
	String pwd = request.getParameter("pwd");

	String sql = "select pwd from testboard where id=" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();

	if (pwd.equals(rs.getString("pwd"))) {
		sql = "update testboard set title = '" + title + "', content ='"
				+ content + "', age = '" + age + "', sex =" + sex + "";
		stmt.executeUpdate(sql);
		response.sendRedirect("content.jsp?id=" + id + "&page=" + pageNum);
	} else {
		%>
		<script>
			alert("비밀번호가 틀립니다.");
			history.back();
		</script>
		
		<%
// 		response.sendRedirect("update.jsp?id=" + id);
	}

	conn.close();
	stmt.close();
%>
