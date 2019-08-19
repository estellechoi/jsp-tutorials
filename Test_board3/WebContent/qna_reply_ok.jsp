<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pageNum = request.getParameter("page");

	// 데이터
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String user = request.getParameter("user");
	String age = request.getParameter("age");
	String sex = request.getParameter("sex");
	String pwd = request.getParameter("pwd");

	String ref = request.getParameter("ref"); // 그룹 동일
	String depth = Integer.parseInt(request.getParameter("depth")) + 1 + ""; // 1층 추가
	String seq = Integer.parseInt(request.getParameter("seq")) + 1 + ""; // 순서 1 단계 내려감

	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);

	// * ref, depth, seq 필드 추가
	String sql = "insert into qna(title, content, user, age, sex, pwd, readnum, writeday, ref, depth, seq)";
	sql = sql + " values(?,?,?,?,?,?,?,?,?,?,?)";

	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, title);
	pstmt.setString(2, content);
	pstmt.setString(3, user);
	pstmt.setString(4, age);
	pstmt.setString(5, sex);
	pstmt.setString(6, pwd);
	pstmt.setString(7, "0");
	pstmt.setString(8, writeday);

	pstmt.setString(9, ref);
	pstmt.setString(10, depth);
	pstmt.setString(11, seq);

	pstmt.executeUpdate();

	response.sendRedirect("qna_content.jsp?id=" + id + "&page=" + pageNum);
	conn.close();
	stmt.close();
%>