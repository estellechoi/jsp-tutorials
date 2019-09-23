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
	try {
		// 파라미터 값을 전송하는 이전 페이지가 없으므로 여기서 null point exception 발생
		// * exception 처리방법
		// ① try{} catch(){} 
		// ② 별도 에러 페이지 사용 (예외 코드(404, 500,..)별 처리 / 예외 종류별 처리)
%>

	name 파라미터 값 :
	<%=request.getParameter("name").toUpperCase()%>
<%-- 	<%=request.getParameter("name")%> --%>

<%
	} catch(Exception e) {
		out.println("시스템 점검중");
	}
%>
</body>
</html>