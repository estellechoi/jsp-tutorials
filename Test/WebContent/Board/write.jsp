<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table td {
		height: 40px;
		font-size: 13px;
		text-align: center;
	}
	
	.input {
		text-align: left;
	}
	
	input[type=submit] {
		border: 1px solid #0A246A;
		border-radius: 5px;
		background: #0A246A;
		color: white;
		font-size: 12px;
		font-weight: bold;
	}
</style>
</head>
<body>
	<form action="write_ok.jsp" method="post">
		<table>
			<caption>게시글 작성</caption>
			<tr>
				<td>이름</td>
				<td class="input"><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td class="input"><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td class="input"><textarea name="content" id="" cols="40" rows="3"></textarea></td>
			</tr>
			<tr>
				<td>공개여부</td>
				<td class="input">
					<input type="radio" name="open" value="0">공개 
					<input type="radio" name="open" value="1">비공개
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="저장"></td>
			</tr>
		</table>
	</form>
</body>
</html>