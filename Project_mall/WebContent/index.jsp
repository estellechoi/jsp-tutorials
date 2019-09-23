<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 네비게이션 바 -->
<!--
 * 동적인 JSP include : <jsp:include>
 * flush="true" : 문서의 출력 결과를 항상 버퍼내에서 갱신 하라는 의미
 
<%--  * 정적인 JSP include : <%@ include %> --%>
-->

<jsp:include page="nav.jsp" flush="false"></jsp>
<!-- 상품설명 -->
<div id="right"></div>


<!-- 메인 -->
<section>상품</section>


<!-- footer -->
<jsp:include page="footer.jsp" flush="false"></jsp>
</body>
</html>