<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// ☆ 웹 어플리케이션 설정값 application 객체를 통해 가져오기
		// - application 기본 객체를 이용하여 web.xml에 설정해준 초기 설정값을 가져올 수 있음
		// - Enumeration<String> = getInitParameterNames() : 설정 파라미터 이름 목록을 리턴
		// - String = getInitParameter(String paramName) : 정 파라미터명을 인자로 전달하면 그에 따른 값이 문자열로 리턴

		out.print(application.getInitParameter("logEnabled"));
		out.print(application.getInitParameter("debugLevel"));
	%>

	<%
		Enumeration enm = application.getInitParameterNames();
		while(enm.hasMoreElements()) {
			out.print(enm.nextElement()+"<br>");
		}
	%>

<!-- 	현재 홈페이지의 주소 : -->
<%-- 	<%=application.getInitParameter("address")%> --%>

</body>
</html>

<!-- 
 * web.xml에 초기 설정값 정의
 - 웹어플리케이션이 구동될 때 웹 어플리케이션 경로의 WEB-INF/web.xml 파일을 참고하도록 정의
 - web.xml은 배포서술자(Deployment Descriptor) 라고도 하며, 웹 어플리케이션에 대한 전반적인 설정을 하는 xml 설정파일
 - 서블릿 맵핑정보나 웹어플리케이션 운용시 사용하는 설정 값들을 정의
 - 서블릿 3.0 부터는 web.xml 대신 자바 클래스만으로 어플리케이션 설정이 가능
 - 설정값이 여러개인 경우에는 context-param 요소를 여러개 사용
 
 * web.xml에 초기값 설정시 장점
 - 설정파일에 값을 설정해두고 관리하면 코드에 설정값들을 하드코딩하여 관리하는 것보다 유지보수 및 개발 생산성이 높음
 - 데이터베이스 연동 관련, 로그 관련, 첨부파일 경로 등 어플리케이션 개발시 사용되는 설정값들을 하드코딩하게 되면
    정보가 변경될때마다 컴파일 및 빌드, 배포를 다시 해주어야 함
 - 설정값들을 파일로 관리하게 되면 해당 파일의 설정값들은 수정 후 서버를 재시작하면 되므로 효율 개선
 
 * 웹 어플리케이션 설정값 application 객체를 통해 가져오기
 - application 기본 객체를 이용하여 web.xml에 설정해준 초기 설정값을 가져올 수 있음
 - Enumeration<String> = getInitParameterNames() : 설정 파라미터 이름 목록을 리턴
 - String = getInitParameter(String paramName) : 정 파라미터명을 인자로 전달하면 그에 따른 값이 문자열로 리턴
 
 -->