<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// getCookies() 메소드의 리턴 타입은 배열
		Cookie cookies[] = request.getCookies();

		// 쿠키 이름과 값을 출력해보자
		for (int i = 0; i < cookies.length; i++) {
			out.print(cookies[i].getName() + " / " + cookies[i].getValue() + "<br>");
		}
	%>

</body>
</html>