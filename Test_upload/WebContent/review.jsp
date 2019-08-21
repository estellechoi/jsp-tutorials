<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		margin: auto;
		width: 600px;
	}
</style>
</head>
<body>
	<form action="review_ok.jsp" method="post" enctype="multipart/form-data">
		<table>
			<caption>여행후기</caption>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="user"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content" id="content" cols="30" rows="3"></textarea></td>
			</tr>
			<tr>
				<td>이미지</td>
				<td><input type="file" name="image"></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center"><input type="submit" value="저장"></td>
			</tr>
		</table>
	</form>
</body>
</html>