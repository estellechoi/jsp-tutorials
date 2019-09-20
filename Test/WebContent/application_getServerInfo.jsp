<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
서버정보 리턴 (웹 컨테이너 이름과 버전, JSP 컨테이너 정보) : <%=application.getServerInfo()%>
<br>
서버가 지원하는 서블릿 규약의 메이저 버전 리턴 : <%=application.getMajorVersion()%>
<br>
서버가 지원하는 서블릿 규약의 마이너 버전 리턴 : <%=application.getMinorVersion()%>

</body>
</html>

<!-- 
 * application
 - application 객체는 하나의 WAS(웹서버)에 하나만 생성
 - application 객체는 JSP 기본객체로 JSP 페이지에서 따로 선언하지 않아도 참조하여 사용 가능
 - application 기본객체는 자신이 속한 웹어플리케이션 범위 안의 모든 JSP 범위에서 공유됨
 - 웹 어플리케이션이 시작될 때 설정되는 초기 설정 정보를 포함하여 설정값들을 얻을 수 있음
 - 웹 어플리케이션 사용자는 파일 자원도 가져올 수 있음
 -->