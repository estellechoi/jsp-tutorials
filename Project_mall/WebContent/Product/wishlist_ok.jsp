<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	String product_code = request.getParameter("id");
	String userid = request.getParameter("userid");

	String sql = "insert into cart(product_code, userid)";
	sql = sql + "values('" + product_code + "', '" + userid + "')";
	
	stmt.executeUpdate(sql);
	
	stmt.close();
	conn.close();
	out.print("ok");
%>