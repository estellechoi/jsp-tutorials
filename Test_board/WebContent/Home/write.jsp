<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/listStructure.css">
</head>
<body>
	<form action="../Home/write_ok.jsp" method="post">
		<table>
			<caption>게시판</caption>
			<caption>
				<input type="submit" value="저장">
				<a href="../Home/board_list.jsp">목록</a>
			</caption>
			<tr id="fieldName">
				<td>제목</td>
				<td>이름</td>
				<td>성별</td>
			</tr>
			<tr>
				<td><input type="text" name="title"></td>
				<td><input type="text" name="name"></td>
				<td>
					<input type="radio" name="sex" value="남"> 남 
					<input type="radio" name="sex" value="여"> 여 
				</td>
			</tr>
			<tr>
				<td colspan="3" id="contentField">
					<textarea name="content" cols="90" rows="30"></textarea>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>