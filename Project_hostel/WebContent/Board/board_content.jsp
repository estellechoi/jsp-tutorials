<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	String id = request.getParameter("id");
	sql = "select*from board where id=" + id;
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
				<caption>게시판</caption>
				<caption>
					<%
						if (session.getAttribute("userid") != null) {
							if (session.getAttribute("userid").equals(rs.getString("userid"))) {
					%>
					<a href="../Board/board_delete.jsp?id=<%=rs.getInt("id")%>">삭제</a>
					<a href="../Board/board_update.jsp?id=<%=rs.getInt("id")%>">수정</a>
					<%
							}
						} 
					%>
					<a href="../Board/board_list.jsp">목록</a>
				</caption>
				
				<tr id="fields">
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
				</tr>
				
				<tr class="contentInfo">
				<!-- replace("&lt;", "<", "&gt;", ">") ???? -->
					<td><%=rs.getString("title")%></td>
					<td><%=rs.getString("userid")%></td>
					<td><%=rs.getString("writeday")%></td>
				</tr>
				
				<tr id="fields">
					<td colspan="3">내용</td>
				</tr>
				
				<tr id="content">
					<td colspan="3">
						<%=rs.getString("content").replace("\r\n", "<br>")%>
						<p></p>
						나이 : 
						<%
						long age = 2020 - rs.getLong("birth");
						%>
						<%=age%>
						<p></p>
						혈액형 :
						<%
								String blood = "";
								switch (rs.getInt("blood")) {
									case 0 :
										blood = "A";
										break;
									case 1 :
										blood = "B";
										break;
									case 2 :
										blood = "AB";
										break;
									case 3 :
										blood = "O";
										break;
								}
						%>
						<%=blood%>
						<p></p>
						 취미 : 
						<%
								String h[] = rs.getString("hobby").split(",");
								String hobby = "";
								for (int i = 0; i < h.length-1; i++) {
									switch (h[i]) {
										case "0" :
											hobby = hobby + "수영 ";
											break;
										case "1" :
											hobby = hobby + "그림 ";
											break;
										case "2" :
											hobby = hobby + "춤 ";
											break;
										case "3" :
											hobby = hobby + "독서 ";
											break;
									}
								}
						%>
						<%=hobby%>
						<p></p> 
						생일 : 
						<%=rs.getString("birth")%>
						<p></p>
					</td>
				</tr>
			</table>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>