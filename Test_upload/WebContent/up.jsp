<!-- 

	 * 파일업로드에 필요한 컴포넌트(라이브러리) 설치
	 - cos.jar
	 - servletapi....?
	 
	 * 프로젝트에 외부 JAR 파일(cos.jar) 추가
	 - 방법 : Build path - Configure build path - Libraries - add external jar files..
	 - 결과 확인 : 이렇게 하니까 Web App Lib 에 cos.jar 추가됨
	 - ? 다른사람은 Reference Lib에 추가되고, WEB-INF/lib에 jar 파일 없어도 에러가 발생하지 않음
	 
	 * 에러 해결방안 한 가지 !
	 : WEB-INF/lib 폴더에 cos.jar 파일을 직접 추가
 
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	// 파일 저장공간
	String path = "c:/imsi";

	// 파일 크기
	int max = 1024*1024*10;
	
	// 생성자 실행 !
	MultipartRequest multi = new MultipartRequest(request, path, max, "UTF-8", new DefaultFileRenamePolicy());
// (요청, 파일 저장공간, 파일크기, 인코딩, 동일파일명 존재할 경우 자동으로 파일명 변경 후 저장)
// * Request : 데이터만 요청
// * MultipartRequest : 파일, 데이터 다 요청 가능 ?
// * 서버에서는 파일 업로드시 이름이 동일한 파일이 있으면 무조건 덮어씌움

%>
<script>
	location="upform.jsp";
</script>