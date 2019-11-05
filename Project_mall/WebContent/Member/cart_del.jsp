<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 마지막 , 제외한 product_code 연결 문자열
	String id[] = request.getParameter("id").split(",");
	String sql_code = "";
	for (int i=0; i<id.length; i++) {
		sql_code = sql_code + id[i] + ", ";
	}
	int e = sql_code.lastIndexOf(",");
	sql_code = sql_code.substring(0, e);
	
	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	String sql = "delete from cart where email='" + session.getAttribute("email") + "' and id=";
	sql = sql + sql_code;
	stmt.executeUpdate(sql);
	
	stmt.close();
	conn.close();
	
	response.sendRedirect("cart.jsp");
%>