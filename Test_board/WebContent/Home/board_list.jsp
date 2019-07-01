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
	
	String sql = "select*from board order by id desc";
	rs = stmt.executeQuery(sql);
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
		<caption><a href="../Home/write.jsp">글쓰기</a></caption>
		<tr id="fieldName">
			<td>순</td>
			<td>제목</td>
			<td>이름</td>
			<td>조회수</td>
		</tr>
		<%
		int n=0;
			while (rs.next()) {
				n=n+1;
		%>
		<tr>
			<td><%=n%></td>
			<td><a href="../Home/content.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("title")%></a></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getInt("readnum")%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>

<%
stmt.close();
conn.close();
%>