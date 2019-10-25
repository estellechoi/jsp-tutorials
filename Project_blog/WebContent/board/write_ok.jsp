<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="blog.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="blog.Dto.Board"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="dto" class="blog.Dto.Board">
	<jsp:setProperty name="dto" property="*" />
</jsp:useBean>

<%
	// DB 연결
	Connection conn = Connect.connection();

	// DTO 객체
	Board dto = new Board();

	String sql = "insert into board(board, email, username, title, content, writeday)";
	sql = " values(?,?,?,?,?,now())";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, dto.getBoard());
	pstmt.setString(2, dto.getEmail());
	
%>