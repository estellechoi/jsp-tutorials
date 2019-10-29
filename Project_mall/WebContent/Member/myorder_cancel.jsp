<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
// 	String order_code = request.getParameter("order_code");
	String id_order = request.getParameter("id_order");
	
	// DB 연결 
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	String sql = "update ordered set cancel='requested' where id=" + id_order + " and email='" + session.getAttribute("email") + "'";
	stmt.executeUpdate(sql);
	stmt.close();
	conn.close();
	
	// 페이지 이동
	response.sendRedirect("myorder.jsp");
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