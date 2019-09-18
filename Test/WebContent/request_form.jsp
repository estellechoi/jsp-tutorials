<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="request_form_ok.jsp" method="post">
	<input type="text" name="name" placeholder="이름"> <p></p>
	<input type="text" name="address" placeholder="주소"> <p></p>
	취미 :
	<input type="checkbox" name="hobby" value="낚시">낚시
	<input type="checkbox" name="hobby" value="헬스">헬스
	<input type="checkbox" name="hobby" value="소주">소주
	<input type="checkbox" name="hobby" value="여행">여행
	<hr>
	<input type="submit" value="전송">
</form>

</body>
</html>