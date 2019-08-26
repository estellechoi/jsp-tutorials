<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/hostel?useSSL=false", "root", "1234");

	// ○ 댓글 수정
	request.setCharacterEncoding("UTF-8");
	String id_reply = request.getParameter("rid");
// 	String userid = request.getParameter("userid");
// 	String name = request.getParameter("name");
	String content = request.getParameter("content");
	
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);
	
	// 쿼리
	String sql = "update announce_reply set content=?, writeday=? where id=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, content);
	pstmt.setString(2, writeday);
	pstmt.setString(3, id_reply);
	pstmt.executeUpdate(); // 쿼리실행
	
	// ○ content 페이지 복귀
	// * 댓글 수정 후 페이지 복귀를 위한 rid 값 가져오기 (rid : 댓글이 등록되는 게시글의 id)
	// * id_reply 값 전송을 위해 getParameter("rid") 값 사용 불가하므로 select문을 가져오자
	
	sql="select * from announce_reply where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id_reply);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	response.sendRedirect("announce_content.jsp?id="+rs.getString("rid"));
	
	pstmt.close();
	conn.close();
%>