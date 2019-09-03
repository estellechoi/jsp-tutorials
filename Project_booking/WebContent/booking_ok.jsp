<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	
	request.setCharacterEncoding("UTF-8");
	String seat = request.getParameter("seat");
	String name = request.getParameter("name");
	String cell = request.getParameter("cell");
	String day = request.getParameter("day");
	String time = request.getParameter("time");
	String people = request.getParameter("people");
	
	String sql = "insert into booking(seat, name, cell, day, time, people)";
	sql = sql + " values(?,?,?,?,?,?)";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, seat);
	pstmt.setString(2, name);
	pstmt.setString(3, cell);
	pstmt.setString(4, day);
	pstmt.setString(5, time);
	pstmt.setString(6, people);
	
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	response.sendRedirect("booking_list.jsp");
	
%>