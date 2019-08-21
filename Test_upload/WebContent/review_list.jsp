<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();	
	String sql = "select*from review order by id desc";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		width: 1000px;
		margin: auto;
		border: 1px solid #eeeeee;
		border-collapse: collapse;
	}
	
	table tr {
		border: 1px solid #eeeeee;
	}
</style>
</head>
<body>
	<table>
		<tr>
			<td>작성자</td>
			<td>제목</td>
			<td>조회수</td>
			<td>작성일</td>
		</tr>
		<%
		while(rs.next()) {
		%>
			<tr>
				<td><%=rs.getString("user")%></td>
				<td><a href="review_content.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("title")%></a></td>
				<td><%=rs.getString("readnum")%></td>
				<td><%=rs.getString("writeday")%></td>
			</tr>
		<%
		}
		%>
	</table>

</body>
</html>