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
		// 다른 페이지에서 접속해보자 !
		// request 값은 사라짐, session 과 application 값음 남아있음
		out.print(request.getAttribute("name") + "<br>");
		// 다른 브라우저에서 접속해보자 ! (다른 사용자인척)
		// session 값은 사라짐, application 값은 남아있음
		out.print(session.getAttribute("name") + "<br>");
		out.print(application.getAttribute("name") + "<br>");
		
		
		// * 메소드
		// setAttribute(); 변수 생성하기
		// getAttribute(); 변수 값 가져오기
		// removeAttribute(); 변수 삭제하기
	%>
</body>
</html>