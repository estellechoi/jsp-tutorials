<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	String sql = "select*from testboard order by id desc";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		margin: auto;
		width: 1000px;
		border: 1px solid #eeeeee;
		border-collapse: collapse;
	}
	
	caption {
		padding-top: 20px;
		padding-bottom: 20px;
		font-weight: bold;
	}
	
	tr {
		border: 1px solid #eeeeee;
		font-size: 13px;
	}
	
	td {
		height: 30px;
		text-align: center;
	}
	
	#field {
		font-weight: bold;
	}
	
	#fieldTitle {
		width: 500px;
	}
</style>
</head>
<body>
	<table>
		<caption>게시판</caption>
		<tr id="field">
			<td>순</td>
			<td id="fieldTitle">제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		<%
			int n = 0;
			while (rs.next()) {
				n++;
		%>
		<tr>
			<td><%=n%></td>
			<td><a href="readnum.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("title")%></a></td>
			<td><%=rs.getString("user")%></td>
			<td><%=rs.getString("writeday")%></td>
			<td><%=rs.getInt("readnum")%></td>
		</tr>

		<%
			}
		%>
	</table>

</body>
</html>

<%
	conn.close();
	stmt.close();
%>