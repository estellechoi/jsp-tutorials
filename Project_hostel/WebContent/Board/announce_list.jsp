<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	sql = "select*from announce order by id desc";
	rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/listStructure.css">
<!-- <script>
 	function readNumIncre() {
 	int id = rs.getInt("id");
 	sql = "update announce set readnum=readnum+1 where id="+id;
 	stmt.executeUpdate(sql);
 	}
</script> -->
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
						// session 값이 있을 때만 (로그인 상태에서만) 아래 if문 작동
						if (session.getAttribute("userid") != null) {
							if (session.getAttribute("userid").equals("admin")) {
					%>
					<a href="../Board/announce_write.jsp">글쓰기</a>
					<%
						}
						}
					%>
				</caption>
				<tr id="fields">
					<td>순</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
				<%
					int n = 0;
					while (rs.next()) {
						n = n + 1;
				%>
				<tr>
					<td><%=n%></td>
					<td><a
						href="../Board/announce_content.jsp?id=<%=rs.getInt("id")%>"><%=rs.getString("title")%></a></td>
					<td><%=rs.getString("userid")%></td>
					<td><%=rs.getString("writeday")%></td>
					<td><%=rs.getString("readnum")%></td>
				</tr>
				<%
					}
				%>

			</table>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>