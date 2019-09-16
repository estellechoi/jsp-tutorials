<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	
	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("userid");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String birth = request.getParameter("birth");
	String cell = request.getParameter("cell");
	String sex = request.getParameter("sex");
	
	// 접수 날짜
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String signupday = sdf.format(today);
	
	String sql = "insert into movie_member(userid, name, pwd, email, birth, cell, sex, signupday)";
	sql = sql + " values(?,?,?,?,?,?,?,?)";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, userid);
	pstmt.setString(2, name);
	pstmt.setString(3, pwd);
	pstmt.setString(4, email);
	pstmt.setString(5, birth);
	pstmt.setString(6, cell);
	pstmt.setString(7, sex);
	pstmt.setString(8, signupday);
	
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	response.sendRedirect("signup.jsp");

%>