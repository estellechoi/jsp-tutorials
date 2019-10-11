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
	// 쿠키 생성
	Cookie cookie = new Cookie("name", "youjin");
	// Cookie 클래스는 매개변수가 없는 생성자가 존재하지 않음
	// new Cookie("쿠키이름", "값");
	
	// Cookie 클래스의 메소드
	cookie.getName();
	
	// 쿠키 존재 시간 설정 (초단위)
	cookie.setMaxAge(30*60);
	
	// 클라이언트 응답(response)에 쿠키 추가
	// 클라이언트 하드디스크에 txt 파일로 저장된다 ?
	// addCookie(저장할 쿠키 객체);
	response.addCookie(cookie);
	
	// 쿠키 생성시 같은 쿠키이름을 사용하면 값이 덮어쓰기 된다
	Cookie cookie2 = new Cookie("name", "bomin");
	cookie2.setMaxAge(30*60);
	response.addCookie(cookie2);
	
	// 또 다른 쿠키
	Cookie cookie3 = new Cookie("product", "dress");
	cookie3.setMaxAge(30*60);
	response.addCookie(cookie3);
	
	// 페이지 이동
	response.sendRedirect("cookie_view.jsp");

%>

</body>
</html>

<!-- 
* 쿠키란 ?
- 웹 서버가 브라우저에게 지시하여 사용자의 로컬 컴퓨터에 파일 또는 메모리에 저장하는 작은 기록 정보 파일
- 파일에 담긴 정보는 인터넷 사용자가 같은 웹사이트를 방문할 때마다 읽히고 수시로 새로운 정보로 바뀔 수 있음

* 쿠키 구성요소
Name 쿠키 이름
Value 쿠키 값
Expires 쿠키가 언제 삭제되는지 결정
Domain 쿠키가 사용되는 도메인을 지정
Path 쿠키를 반환할 경로를 결정
Secure 보안 연결 설정
HttpOnly Http외에 다른 통신 사용 가능 설정


 -->