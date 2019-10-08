<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();

	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	String destination = request.getParameter("destination");
	String recipient = request.getParameter("recipient");
	String zip = request.getParameter("zip");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String cell = request.getParameter("cell");
	// 체크박스 값 넘어오나 ?
	// 	String isdefault = request.getParameter("isdefault");

	String sql = "insert into address(email, destination, recipient, zip, address1, address2, cell, writeday)";
	sql = sql + " values(?,?,?,?,?,?,?,now())";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, email);
	pstmt.setString(2, destination);
	pstmt.setString(3, recipient);
	pstmt.setString(4, zip);
	pstmt.setString(5, address1);
	pstmt.setString(6, address2);
	pstmt.setString(7, cell);
	
	pstmt.executeUpdate();

	pstmt.close();
	conn.close();

	response.sendRedirect("product_buynow_address.jsp?email=" + email);
%>