<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	ResultSet rs;

	String sql = "select*from signup";
	rs = stmt.executeQuery(sql);
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
		color: orange;
	}
	
	td {
		text-align: center;	
		height: 30px;
		font-size: 13px;
	}
	
	tr {
		border: 1px solid #eeeeee;
	}
	
	#field {
		font-weight: bold;
	}
</style>
</head>
<body>

	<table>
		<caption>사람들</caption>
		<tr id="field">
			<td>번호</td>
			<td>코멘트</td>
			<td>이름</td>
			<td>흡연여부</td>
			<td>주소</td>
			<td>☆</td>
			<td>수정/삭제</td>
		</tr>
		<%
			int n = 0;
			while (rs.next()) {
				n++;
		%>
		<tr>
			<td><%=n%></td>
			<td><%=rs.getString("title")%></td>
			<td><%=rs.getString("username")%></td>
			<td><%=rs.getString("smoker")%></td>
			<td><%=rs.getString("address")%></td>
			<td>☆</td>
			<td><a href="">수정</a> | <a href="">삭제</a></td>
		</tr>
		<%
			}
		%>
	</table>

</body>
</html>