<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 마지막 , 제외한 product_code 연결 문자열
	String code[] = request.getParameter("code").split(",");
	
	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	// cart 테이블에 담기
	String sql = "insert into cart(email, size, qty, product_code) values('"+session.getAttribute("email")+"', 1, 1, '";
	String sql_del = "delete from wishlist where email='"+session.getAttribute("email")+"' and product_code=";

	for (int i=0; i<code.length; i++) {
		sql = sql + code[i] + "')";
		stmt.executeUpdate(sql);
	}
	
	for (int i=0; i<code.length; i++) {
		sql_del = sql_del + "'" +code[i] +"'";
		stmt.executeUpdate(sql_del);
	}

	stmt.close();
	conn.close();
	
	response.sendRedirect("cart.jsp");
%>