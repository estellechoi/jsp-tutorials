<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- file은 크기가 크기 때문에 enctype 설정 (head content type 수정)-->
	<!-- 파일을 전송하는 모든 form 태그에 사용한다 -->
	<form action="up.jsp" method="post" enctype="multipart/form-data">	
		<input type="file" name="fileName">
		<input type="submit" value="전송">
	</form>
</body>
</html>