<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/hostel?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
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
<link rel="stylesheet" href="../Image/structure.css?ver=1">
<link rel="stylesheet" href="../Image/categoriesStyle.css">
<style>
	table {
		margin: auto;
		width: 1000px;
		border: 1px solid #eeeeee;
		
	}
</style>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article id="grid-container">
			<%@ include file="../Board/board_structure.jsp"%>
			<div>
				<table>
					<tr>
						<td>제목</td>
						<td colspan="3"><%=rs.getString("title")%></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><%=rs.getString("name")%></td>
						<td>조회수</td>
						<td><%=rs.getString("readnum")%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3"><%=rs.getString("content")%></td>
					</tr>
					<tr>
						<td>작성일</td>
						<td colspan="3"><%=rs.getString("writeday")%></td>
					</tr>
					<tr>
						<td colspan="4">
							<a href="review_list.jsp">목록</a>
							<a href="review_update.jsp?id=<%=id%>">수정</a>
							<a href="review_del.jsp?id=<%=id%>">삭제</a>
						</td>
					</tr>
				</table>
			</div>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>

</body>
</html>