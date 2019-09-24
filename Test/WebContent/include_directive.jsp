<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page include file="include_testfile.jsp" %>
<%
	String name = "테스트 변수 (인클루드)";
	// 웹브라우저가 해석하지 않은 코드 전체 (자바 코드 포함) 복붙 개념이므로, 변수 중복으로 에러 발생 !
	
	// * 정적 인클루드를 사용하는 경우 ?
	// 모든 페이지의 자바코드에서 공통으로 사용할 변수를 인클루드되는 파일에 선언하여 페이지끼리 공유할 수 있다.
%>

</body>
</html>