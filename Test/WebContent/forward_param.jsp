<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	JSP:forward 포워딩 페이지에 파라미터 값 전송하기
	<jsp:forward page="forward_param_ok.jsp">
		<jsp:param name="name1" value="var1" />
		<jsp:param name="name2" value="var2" />
	</jsp:forward>
</body>
</html>