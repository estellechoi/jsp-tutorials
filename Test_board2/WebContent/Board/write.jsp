<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/list.css">
</head>
<body>
<form action="../Board/write_ok.jsp" method="post">
	<table>
		<caption>테스트게시판</caption>
		<caption>
			<a href="../Board/list.jsp">목록</a>
		</caption>
		<tr>
			<td>이름</td>
			<td class="input"><input type="text" name="name"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td class="input"><input type="text" name="email"></td>
		</tr>
		<tr>
			<td>성별</td>
			<td class="input">
				<input type="radio" name="sex" value="0"> 남
				<input type="radio" name="sex" value="1"> 여
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td class="input">
				<select name="address" id="address">
					<option value="선택하기">선택하기</option>
					<option value="서울">서울</option>
					<option value="양양">양양</option>
					<option value="고성">고성</option>
					<option value="대전">대전</option>
					<option value="제주">제주</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>좋아하는 음식</td>
			<td class="input">
				<input type="checkbox" name="food" value="0"> 라면
				<input type="checkbox" name="food" value="1"> 햄버거
				<input type="checkbox" name="food" value="2"> 피자
				<input type="checkbox" name="food" value="3"> 스시
				<input type="checkbox" name="food" value="4"> 국밥
				<input type="checkbox" name="food" value="5"> 삼겹살
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td class="input"> <input type="text" name="title"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td class="input"><textarea name="content" id="content" cols="30" rows="10"></textarea></td>
		</tr>
		<tr>
		<td colspan="2"> <input type="submit" value="저장"></td>
		</tr>
	</table>
</form>
</body>
</html>