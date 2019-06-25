<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	String id = request.getParameter("id");
	sql = "select*from announce where id=" + id;
	rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/writeStructure.css">
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article>
			<table>
				<caption>공지사항</caption>
				<caption>
					<%
						if (session.getAttribute("userid") != null) {
							if (session.getAttribute("userid").equals("admin")) {
					%>
					<a href="../Board/announce_delete.jsp?id=<%=rs.getInt("id")%>">삭제</a>
					<a href="">수정</a>
					<%
						}
						}
					%>
					<a href="../Board/announce_list.jsp">목록</a>
				</caption>
				<tr id="fields">
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
				</tr>
				<tr id="contentInfo">
					<td><%=rs.getString("title")%></td>
					<td><%=rs.getString("userid")%></td>
					<td><%=rs.getString("writeday")%></td>
				</tr>
				<tr id="fields">
					<td colspan="3">내용</td>
				</tr>
				<tr id="content">
					<td colspan="3"><%=rs.getString("content")%></td>
				</tr>
			</table>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>