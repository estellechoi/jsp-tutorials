<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/hostel?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	// 사용자 입력값
	request.setCharacterEncoding("utf-8");
	String passwordCheck = request.getParameter("password");

	String sql = "select*from member where userid='"
			+ session.getAttribute("userid") + "' and password='"
			+ passwordCheck + "'";

	ResultSet rs = stmt.executeQuery(sql);
	
	// 비밀번호 일치여부 한 번 더 확인
	// ※ 문자열 비교는 .equals()
	if (rs.next() && passwordCheck.equals(rs.getString("password"))) {
		response.sendRedirect("../SignUp/editProfile.jsp");

	} else {
		response.sendRedirect("../SignUp/editProfile_check.jsp");
	}

	stmt.close();
	conn.close();
%>
