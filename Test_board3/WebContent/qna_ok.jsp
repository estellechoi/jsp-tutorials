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
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String user = request.getParameter("user");
	String age = request.getParameter("age");
	String sex = request.getParameter("sex");
	String pwd = request.getParameter("pwd");

	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);
	
	// * 신규 질문에 대한 ref(그룹) 값 구하기
	// qna 테이블에서 가장 높은 ref 값을 num 필드에 표시하라
	// rs.getInt(null) = 0
	String sql = "select max(ref) as num from qna";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	String ref = (rs.getInt("num") + 1) + "";
	
	// * ref, depth, seq 필드 추가
	sql = "insert into qna(title, content, user, age, sex, pwd, readnum, writeday, ref, depth, seq)";
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
	
	pstmt.setString(9, ref); // ref
	pstmt.setString(10, "1"); // depth
	pstmt.setString(11, "1"); // seq

 	pstmt.executeUpdate();

	response.sendRedirect("qna_list.jsp");
	conn.close();
	stmt.close();
%>