<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	String id = request.getParameter("id");

	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	// 사용자의 모든 배송지 isdefault = 0 으로 수정
	String sql = "update address set isdefault = 0 where email='" + session.getAttribute("email") + "'";
	stmt.executeUpdate(sql);
	
	sql = "update address set isdefault = 1 where email='" + session.getAttribute("email") + "' and id =" + id;
	stmt.executeUpdate(sql);
	
	stmt.close();
	conn.close();
	
	// 페이지 복귀
	response.sendRedirect("address.jsp");
%>