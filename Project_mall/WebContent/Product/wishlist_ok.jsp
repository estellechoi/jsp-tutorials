<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	String product_code = request.getParameter("product_code");
	String email = request.getParameter("email");

	String sql = "select*from wishlist where product_code='"+product_code+"'";
	sql = sql + " and email='"+email+"'";
	ResultSet rs = stmt.executeQuery(sql);
	
	if (rs.next()) {
		out.print("no");
	}
	else {		
		sql = "insert into wishlist(product_code, email)";
		sql = sql + " values('" + product_code + "', '" + email + "')";	
		stmt.executeUpdate(sql);
		rs.close();
		stmt.close();
		conn.close();
		out.print("ok");		
	}
%>