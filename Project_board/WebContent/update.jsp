<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/checkin?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	// 한글 인식하기
	request.setCharacterEncoding("utf-8");
	// response.setCharacterEncoding("utf-8");
	//
	String id = request.getParameter("id");
	String sql = "select*from board where id=" + id;

	ResultSet rs = stmt.executeQuery(sql);

	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="bodyColor.css">
<link rel="stylesheet" href="input.css">
</head>
<body>
	<form action="update_ok.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>"> Name <input
			type="text" name="name" value="<%=rs.getString("name")%>" disabled>
		<p></p>
		City &nbsp; <input type="text" name="city"
			value="<%=rs.getString("city")%>">
		<p></p>
		Comment
		<p>
			<textarea name="comment" id="" cols="40" rows="10">
			<%=rs.getString("comment")%>
			</textarea>
		</p>
		<input id="submitButton" type="submit" value="Update">
	</form>

</body>
</html>

<%
	stmt.close();
	conn.close();
%>