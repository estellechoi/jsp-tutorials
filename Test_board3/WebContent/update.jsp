<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	String id = request.getParameter("id");
	String sql = "select*from testboard where id =" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="write_ok.jsp" method="post" name="form">
		제목 <input type="text" name="title" size="50" value="<%=rs.getString("title")%>">
		<p></p>
		내용
		<textarea name="content" id="content" cols="50" rows="6"><%=rs.getString("content")%></textarea>
		<p></p>
		작성자 <input type="text" name="user" size="8" value="<%=rs.getString("user")%>" readonly>
		<p></p>
		나이 
		<select name="age" id="age">
			<option value="10대">10대</option>
			<option value="20대">20대</option>
			<option value="30대">30대</option>
			<option value="40대">40대</option>
			<option value="50대">50대</option>
		</select>
		<p></p>
		성별 <input type="radio" name="sex" value="0"> 남자
		   <input type="radio" name="sex" value="1"> 여자
		<p></p>
		<a href="update.jsp?id=<%=rs.getString("id")%>">수정</a>
		<a href="del.jsp?id=<%=rs.getString("id")%>">삭제</a>
	</form>
</body>
</html>