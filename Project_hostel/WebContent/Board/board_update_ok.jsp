<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/hostel?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String password = request.getParameter("password");
	String blood = request.getParameter("blood");
	String birth = request.getParameter("birthYear");

	// checkbox 는 값이 여러 개 (배열)
	String h[] = request.getParameterValues("hobby");
	String hobby = "";
	for (int i = 0; i < h.length; i++) {
		hobby = hobby + h[i] + ",";
	}

	// 비밀번호 확인
	String sql = "select*from board where id=" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();

		sql = "update board set title='"+title+"', content='"+content+"'";
		sql = sql + ", blood="+blood+", birth='"+birth+"', hobby='"+hobby+"'";
		sql = sql + " where id="+id;
		stmt.executeUpdate(sql);
		response.sendRedirect("../Board/board_content.jsp?id="+id);

	stmt.close();
	conn.close();
%>