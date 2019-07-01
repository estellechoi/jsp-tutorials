<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/test?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();
	ResultSet rs;

	String id = request.getParameter("id");
	String sql = "select*from board where id=" + id;
	rs = stmt.executeQuery(sql);
	
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/listStructure.css">
</head>
<body>
	<table>
		<caption>게시판</caption>
		<caption>
			<a href="../Home/board_delete.jsp?id=<%=id%>">삭제</a>
			<a href="../Home/board_list.jsp">목록</a>
		</caption>
		<tr id="fieldName">
			<td>제목</td>
			<td>이름</td>
			<td>조회수</td>
		</tr>
		<tr>
			<td><%=rs.getString("title")%></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getString("readnum")%></td>
		</tr>
		<tr>
			<td colspan="3" id="contentField"><%=rs.getString("content")%></td>
		</tr>
	</table>
</body>
</html>

<%
stmt.close();
conn.close();
%>