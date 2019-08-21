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
<%@ page import = "java.io.*" %>
<%
	// ○ 사용자가 업로드한 파일은 어디에 저장될까 ?
			
	// 1) 전통적인 방법 (편집기 X 아파치 톰캣 서버를 직접 실행할 때)
	// * 브라우저 사용자(클라이언트)들이 접근할 수 있는 웹서버 폴더가 제한되어 있다
	// * Apache Software Foundatione/Tomcat9.0/webapps/ROOT 폴더로 제한 !
 	// * 가상 디렉토리 설정 : Webapps의 하위 디렉토리인 것처럼 설정 (실제로는 다른 곳에 위치한 디렉토리)
 	
 	// 2) 요즘 방법 (편집기에서 서버 실행할 때)
 	// * 파일 업로드 디렉토리는 무조건 WebContent 폴더 내에 생성 !

 	// 파일 저장공간
	String path = "c:/users/alfo1-2/jspwork_git/Test_upload/WebContent/imsi";

	// 파일 크기
	int max = 1024*1024*10;
	
	// ○ 생성자 실행 !
	// * Request : 데이터만 요청 / MultipartRequest : 파일 요청
	// * 서버에서는 파일 업로드시 이름이 동일한 파일이 있으면 무조건 덮어씌움
	// * multi : 업로드파일의 정보를 가진 객체
	// * (요청, 파일 저장공간, 파일크기, 인코딩, 동일파일명 존재할 경우 자동으로 파일명 변경 후 저장)
	MultipartRequest multi = new MultipartRequest(request, path, max, "UTF-8", new DefaultFileRenamePolicy());	
	
	
	// ○ 업로드된 파일 정보 가져오기
	// 실제 저장된 파일명
	out.print(multi.getFilesystemName("fileName"));

	// 실제 저장된 파일명과 사용자가 요청한 파일명
	// (파일명 동일한 파일 존재하는 경우 자동으로 파일명이 변경됨)
	out.print(multi.getOriginalFileName("fileName"));
	
	// * MultipartRequest.getfile(); 파일 정보를 요청하는 메소드
	//   파일 길이/날짜/크기 등 요청 가능
	File file = multi.getFile("fileName");
	out.print(file.length());

%>