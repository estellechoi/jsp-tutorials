<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.time.LocalDate"%>
<%
	String db = "jdbc:mysql://localhost:3307/hostel?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("userid");
	String room = request.getParameter("room");
	int yy = Integer.parseInt(request.getParameter("checkinYY"));
	int mm = Integer.parseInt(request.getParameter("checkinMM"));
	int dd = Integer.parseInt(request.getParameter("checkinDD"));
	int nights = Integer.parseInt(request.getParameter("nights"));

	// 작성일
	Date xday = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(xday);

	// ※ yy, mm, dd have to be in integer.
	LocalDate checkinDate = LocalDate.of(yy, mm, dd);
	
	// 날짜계산 메소드 (type to LocalDate)
	LocalDate checkoutDate = checkinDate.plusDays(nights);
	
	String sql="insert into booking(userid, room, checkinDate, checkoutDate, nights, writeday)";
	sql = sql + " values('"+userid+"', '"+room+"', '"+checkinDate+"', '"+checkoutDate+"', "+nights+", '"+writeday+"')";
	stmt.executeUpdate(sql);
	
	response.sendRedirect("../Booking/callendar_now.jsp");
	
	stmt.close();
	conn.close();
	
%>