<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	sql = "select*from board order by id desc"; // 내림차순 정렬
	rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/listStyle.css">
<link rel="stylesheet" href="../Image/categoriesStyle.css">
</head>
<body>
	<%@ include file="../Common/header.jsp"%>

	<section>
		<article></article>
		<article id="grid-container">
			<%@ include file="../Board/board_structure.jsp"%>
			<div>
				<table>
					<caption>게시판</caption>
					<caption>
						<a href="../Board/board_write.jsp">글쓰기</a>
					</caption>
					<tr id="fields">
						<td>순</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
						<td>비고</td>
					</tr>
					<%
						int n = 0;
						while (rs.next()) {
							n = n + 1;
					%>
					<tr>
						<td><%=n%></td>
						<td><a href="../Board/board_readnum.jsp?id=<%=rs.getString("id")%>"> <%=rs.getString("title")%>
						</a></td>
						<td><%=rs.getString("name")%></td>
						<td><%=rs.getString("writeday")%></td>
						<td><%=rs.getString("readnum")%></td>
						<td>
							<%
								if (session.getAttribute("name") != null) {
										if (session.getAttribute("name").equals("관리자")) {
							%>
							<a href="../Board/board_delete.jsp?id=<%=rs.getString("id")%>">삭제</a>
							<%
									}
								}
							%>
						</td>
					</tr>
					<%
						}
					%>

				</table>
			</div>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>