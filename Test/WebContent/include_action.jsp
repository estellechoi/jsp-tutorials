<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="include_testfile.jsp" flush="false"/>
	<%
	String name = "테스트 변수 (인클루드)";
	
	// 동적 JSP 인클루드는 <html> 코드를 인클루드한다. (자바 코드는 이미 번역된 후이므로 testfile의 name 변수는 사라진 후 !)
	
	// 장점 : param 코드 전달할 수 있다. → ?
	%>
	
	
<!-- 
 * flush="true" : 문서의 출력 결과를 항상 버퍼내에서 갱신 하라는 의미
 
 * flush란?
	어떤 jsp 파일에서 내용을 작성할 때 곧바로 웹브라우저로 결과를 내려보내지 말고 중간에 잠깐 버퍼링을 했다가 끝난 후에 한꺼번에 내려보낼 수 있습니다.
	
	그런데 그 중에 jsp:include 를 사용해서 다른 페이지의 결과를 요청시(request-time)에 받아와서 출력해준다고 하면 문제가 생길 수 있습니다.
	
	원래 jsp 파일에서 버퍼링을 하고 있었으니 jsp:include 로 가져온 결과를 화면에 출력해버리면,
	
	출력 순서가 뒤죽박죽이 되는 경우가 생긴다는 것입니다.
	
	때문에 flush="true" 라는 속성을 사용하여 만약 jsp:include 를 만나기 전까지
	페이지 결과를 버퍼링 하고 있었다면 전부 쏟아버리고 (flush, 출력해버리고)
	jsp:include 결과를 화면에 표시하라고 해석할 수 있습니다.
	
	간단히 말해서 jsp:include 한 페이지 뿌리기 전에 확실하게 이전까지 내용 출력해놔라는 거죠.
	
	단순히 생각해서 버퍼링 했으면 jsp:include 내용도 버퍼링 하면 되지 왜 복잡하게 하냐,
	싶어도 구현 상의 문제와 여러 가지 정황을 따져 만든 기능입니다.
	
 * 주소창에 .jsp 없이 파일명만 써도 됨 ?
 -->
</body>
</html>