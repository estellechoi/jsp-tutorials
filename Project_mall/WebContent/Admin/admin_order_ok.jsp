<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="mall.Util.Util"%>
 
 <%
 	request.setCharacterEncoding("UTF-8");
 	String id = request.getParameter("id");
 	String status = request.getParameter("status");
 	
 	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	String sql = "update ordered set status='" + status + "' where id=" + id;
	stmt.executeUpdate(sql);
	
	stmt.close();
	conn.close();
	
	// 페이지 복귀
	response.sendRedirect("admin_order.jsp");
%>