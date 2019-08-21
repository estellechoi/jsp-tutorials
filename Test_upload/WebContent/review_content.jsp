<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	
	String sql = "select*from review where id=" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		width: 600px;
		margin: auto;
		border: 1px solid #eeeeee;
		border-collapse: collapse;
	}
	
	table tr, td {
		border: 1px solid #eeeeee;
		text-align: center;
	}
	
	table caption {
		text-align: right;
	}
</style>
</head>
<body>
	<table>
		<caption><a href="review_list.jsp">목록</a></caption>
		<tr>
			<td>작성자</td>
			<td><%=rs.getString("user")%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=rs.getString("title")%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=rs.getString("content")%></td>
		</tr>
		<tr>
			<td>사진</td>
			<td><img src="imsi/<%=rs.getString("img")%>" alt="이미지 없음" width="400"></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%=rs.getString("writeday")%></td>
		</tr>
	</table>

</body>
</html>