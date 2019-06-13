<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	// id 값 받기
	// request.getParameter("x"); html <input name="x"> 사용자 입력값(value) 호출 
	String id = request.getParameter("id");

	// 쿼리문
	String sql = "select*from guest where id=" + id;

	// 쿼리실행
	ResultSet rs = stmt.executeQuery(sql);

	// 데이터 접근 (포인터 이동)
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="Test_update_ok.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>"> <!-- 나타나지 않고, 값만 담아 넘기기 위한 input 속성-->
		<input type="submit" value="Click">
		<p></p>
		User name
		<p></p>
		<input type="text" name="name" value="<%=rs.getString("name")%>" disabled>
		<p></p>
		Title
		<p></p>
		<input type="text" name="title" value="<%=rs.getString("title")%>">
		<p></p>
		Content
		<p></p>
		<textarea name="content" cols="40" rows="5"><%=rs.getString("content")%></textarea>
		<p></p>

	</form>

</body>
</html>