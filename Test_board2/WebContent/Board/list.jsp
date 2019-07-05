<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/test?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	String sql = "select*from test order by id desc";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/list.css">
</head>
<body>
<%@ include file="../Common/header.jsp" %>
<section>
	<table>
		<caption>테스트 게시판</caption>
		<caption>
			<a href="../Board/write.jsp">글쓰기</a>
		</caption>
		<tr id="field">
			<td>순</td>
			<td class="title">제목</td>
			<td>작성자</td>
			<td>조회수</td>
			<td>최근수정일</td>
		</tr>
		<%
			int n = 0;
			while (rs.next()) {
				n = n + 1;
		%>
		<tr>
			<td><%=n%></td>
			<td class="title"><a href="../Board/readnum.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("title")%></a></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getString("readnum")%></td>
			<td><%=rs.getString("writeday")%></td>
		</tr>
		<%
			}
		%>
	</table>
</section>
</body>
</html>

<%
stmt.close();
conn.close();
%>