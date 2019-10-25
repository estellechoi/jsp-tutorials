<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String board = request.getParameter("board");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.grid_container {
	display: grid;
	grid-template-colums: 200px 1fr;
}

table {
	width: 1000px;
	margin: auto;
	border: 1px solid #0A246A;
	border-radius: 5px;
	padding: 10px;
}

table caption {
	text-align: left;
	padding: 20px;
}

table caption input {
	border: none;
	background: none;
	height: 30px;
	font-size: 15px;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="grid_container">
		<div class="grid_left">
			<jsp:include page="../nav.jsp" flush="false" />
		</div>
		<section>
			<form action="write_ok.jsp" method="post">
				<input type="hidden" name="board" value="<%=board%>"><!-- 무슨 게시판인지 ? -->
				<input type="hidden" name="email" value="<%=session.getAttribute("email")%>"><!-- jsp:useBean 사용을 위해 필요 -->
				<table>
					<caption>
						<input type="text" name="title" placeholder="제목">
					</caption>
					<tr>
						<th>작성자</th>
						<td><input type="text" name="username" value="<%=session.getAttribute("username")%>" readonly></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea name="content" cols="40" rows="3"></textarea></td>
					</tr>
					<tr>
						<th></th>
						<td>
							<input type="submit" value="저장">
							<input type="button" value="취소">
						</td>
					</tr>
				</table>
			</form>
		</section>
	</div>
</body>
</html>