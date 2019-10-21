<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String product_code[] = request.getParameterValues("product_code");
	
	String sql_code = "";
	
	for(int i=0; i<product_code.length; i++) {
		sql_code = sql_code + "'" + product_code[i] + "',";
	}
	
	int e = sql_code.lastIndexOf(",");
	sql_code = sql_code.substring(0, e);
	
	String sql = "delete from wishlist where email='" + session.getAttribute("email") + "'";
	sql = sql + " and product_code=" + sql_code;
	stmt.executeUpdate(sql);
	stmt.close();
	conn.close();
	
	response.sendRedirect("wishlist.jsp");
	
%>