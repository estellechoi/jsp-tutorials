<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// db 접속
	String db = "jdbc:mysql://localhost:3307/hostel?useSSL=false";
	Connection conn = DriverManager.getConnection(db, "root", "1234");
	Statement stmt = conn.createStatement();

	// 사용자입력값 가져오기
	request.setCharacterEncoding("utf-8");
	String password = request.getParameter("password");
	String newPassword = request.getParameter("newPassword");
	String email = request.getParameter("email");

	// ※ 기존 비밀번호 일치여부 검토
	String sqlSelect = "select*from member where userid='" + session.getAttribute("userid") + "'";
	ResultSet rs = stmt.executeQuery(sqlSelect);
	rs.next();

	// ※ 문자열비교 (== 자료형 같을때만 비교 → String a; a.equals() String의 값비교 메소드)
	if (password.equals(rs.getString("password"))) {
		// 수정할 쿼리 작성
		String sql = "update member set email='" + email + "', password='" + newPassword + "' where userid='"
				+ session.getAttribute("userid") + "'";
		// 수정 쿼리 실행
		stmt.executeUpdate(sql);
		// 수정 후 editProfile.jsp로 이동
		response.sendRedirect("editProfile_check.jsp");

	} else {
%>
<script>
	alert("비밀번호가 틀립니다.");
	location = "editProfile.jsp";
</script>
<%
	}
%>
