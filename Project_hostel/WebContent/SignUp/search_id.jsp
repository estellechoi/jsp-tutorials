<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/hostel?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String email = request.getParameter("email");

	String sql = "select*from member where email=" + email + " and name=" + name;
	ResultSet rs = stmt.executeQuery(sql);

	if (rs.next()) {
		response.sendRedirect("searchResult_id.jsp?userid="+rs.getString("userid")); // id 보여주는 페이지로 이동
		
	} else {
		%>
		<script>
			alert("일치하는 회원정보가 없습니다");
			history.back(); // 이전 페이지로 이동
		</script>
		<% 
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>