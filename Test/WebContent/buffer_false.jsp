<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page buffer="1kb" autoFlush="false"%>
<!-- 
	autoFlush="false" 버퍼용량 1kb 다 차면 예외 발생
	java.io.IOException: 오류: JSP 버퍼 오버플로우
-->
<!-- autoFlush="true" 버퍼용량 1kb 다 차면 자동 전송 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	안녕하세요
	<%
		for(int i=0; i<1000; i++) {
			out.print(i);
		}
	%>
</body>
</html>