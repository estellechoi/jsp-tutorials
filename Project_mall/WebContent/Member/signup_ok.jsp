<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();
	
	request.setCharacterEncoding("UTF-8");
	String usertype = request.getParameter("usertype");
	// userid = email
	String email = request.getParameter("email");
	String username = request.getParameter("username");
	String pwd = request.getParameter("pwd");
	String cell = request.getParameter("cell");
	String zip = request.getParameter("zip");
	String address1 = request.getParameter("address1"); 
	String address2 = request.getParameter("address2");
	String sex = request.getParameter("sex");
	String birth = request.getParameter("birth_year")+"-"+request.getParameter("birth_month")+"-"+request.getParameter("birth_date");
	String agree_SMS = request.getParameter("agree3");
	String agree_email = request.getParameter("agree4");
	
	
	String sql = "insert into member(usertype, email, username, pwd, cell, zip, address1, address2, sex, birth, agree_SMS, agree_email, writeday)";
	sql = sql + " values(?,?,?,?,?,?,?,?,?,?,?,?,now())";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, usertype);
	pstmt.setString(2, email);
	pstmt.setString(3, username);
	pstmt.setString(4, pwd);
	pstmt.setString(5, cell);
	pstmt.setString(6, zip);
	pstmt.setString(7, address1);
	pstmt.setString(8, address2);
	pstmt.setString(9, sex);
	pstmt.setString(10, birth);
	pstmt.setString(11, agree_SMS);
	pstmt.setString(12, agree_email);
	
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	response.sendRedirect("signin.jsp");	
	
	
%>