<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");

	request.setCharacterEncoding("UTF-8");
	String movie = request.getParameter("movie");
	String name = request.getParameter("name");
	String cell = request.getParameter("cell");
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
	String day = request.getParameter("day");
	String time = request.getParameter("time");
	String people = request.getParameter("people");
	String seat = request.getParameter("seat");
	
	// 접수 날짜
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);
	
	String sql = "insert into movie(movie, name, cell, email, pwd, day, time, people, seat, writeday)";
	sql = sql + " values(?,?,?,?,?,?,?,?,?,?)";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, movie);
	pstmt.setString(2, name);
	pstmt.setString(3, cell);
	pstmt.setString(4, email);
	pstmt.setString(5, pwd);
	pstmt.setString(6, day);
	pstmt.setString(7, time);
	pstmt.setString(8, people);
	pstmt.setString(9, seat);
	pstmt.setString(10, writeday);
	
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	response.sendRedirect("booking_view.jsp");
%>