<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	String product_code = request.getParameter("product_code");
	String size = request.getParameter("size");
	String qty = request.getParameter("qty");
	String email = request.getParameter("email");

	// writeday timestamp
	// → 쿼리 필요없이 데이터 입력시 timestamp 필드값으로 현재시각이 자동생성됨
	// → 데이터 수정시 timestamp 값은 최종수정시각으로 변경됨
	String sql = "insert into cart(product_code, size, qty, email)";
	sql = sql + " values('" + product_code + "', " + size + ", " + qty + ", '" + email + "')";
	
	stmt.executeUpdate(sql);
	
	stmt.close();
	conn.close();
	out.print("ok");
%>