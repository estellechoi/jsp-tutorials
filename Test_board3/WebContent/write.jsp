<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
* post : <header>에 포함되어 값 전송 (값 노출 X)
* get : 문서이름 뒤에 붙어 값 전송/주소창에 표시 ; write_ok.jsp?id=3 (값 노출)
--> 
	<form action="write_ok.jsp" method="post"> 
		제목 <input type="text" name="title" size="50">
		<p></p>
		내용
		<textarea name="content" id="content" cols="50" rows="6"></textarea>
		<p></p>
		작성자 <input type="text" name="user" size="8">
		<p></p>
		나이 <select name="age" id="age">
			<option value="10대">10대</option>
			<option value="20대">20대</option>
			<option value="30대">30대</option>
			<option value="40대">40대</option>
			<option value="50대">50대</option>
		</select>
		<p></p>
		성별 <input type="radio" name="sex" value="남자"> 남자 <input type="radio" name="sex" value="여자">여자
		<p></p>
		비밀번호 <input type="password" name="pwd">
		<p></p>
		<input type="submit" value="저장">
	</form>

</body>
</html>