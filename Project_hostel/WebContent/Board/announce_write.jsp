<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/Date.jsp"%>

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
					<a href="../Board/announce_list.jsp">목록</a>
				</caption>
				<form action="../Board/announce_write_ok.jsp" method="post">
				<tr id="fields">
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
				</tr>
				<tr id="contentInfo">
					<td><input type="text" name="title"></td>
					<td><input type="text" name="userid"
						value="<%=session.getAttribute("userid")%>" disabled></td>
					<td><input type="date" name="writeday" value="<%=writeday%>"
						disabled></td>
				</tr>
				<tr id="fields">
					<td colspan="3">내용</td>
				</tr>
				<tr id="content">
					<td colspan="3"><textarea name="content" id="" cols="100px"
							rows="40px"></textarea></td>
				</tr>
				<tr>
					<td colspan="3"><input type="submit" value="저장"></td>
				</tr>
				</form>
			</table>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>