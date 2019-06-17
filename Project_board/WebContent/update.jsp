<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3306/checkin?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	String id = request.getParameter("id");
	String sql = "select*from board where id=" + id;

	ResultSet rs = stmt.executeQuery(sql);

	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="input.css">
</head>
<body>
	<form action="update_ok.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>">
		Name <input type="text" name="name" value="<%=rs.getString("name")%>"
			disabled>
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