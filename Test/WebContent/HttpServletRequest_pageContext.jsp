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
		// ServletRequest = getRequest(); request 기본 객체를 반환
		HttpServletRequest httprequest = (HttpServletRequest) pageContext.getRequest();
	%>
	<!-- 기본객체 request에 httprequest 객체를 담기 -->
	<%=request == httprequest%>

	<!-- 예제 -->
	<!-- pageContext.getOut() 이 반환하는 Writer 객체가 실제로 out 기본객체인지를 판단 -->
	<%
		JspWriter pageOut = pageContext.getOut();
		out.print(pageOut == out);
		pageContext.getOut().print("출력");
	%>

	<!-- 
* pageContext 객체
- JSP 기본객체로 JSP 페이지에서 따로 선언하지 않아도 참조하여 사용 가능
- pageContext는 JSP 페이지에 대해 1:1로 연결된 객체로 JSP 페이지당 하나의 pageContext 객체 생성

* pageContext 객체의 기능
- 같은 JSP 페이지 내에서 서로 값을 공유할 수 있음
- 주요 기능은 다른 기본 객체들을 구할때 사용하거나 페이지 흐름을 제어할 때 사용
- pageContext를 직접 사용하는 경우는 드물고 커스텀 태그를 구현할때 주로 사용
- JSP 페이지가 서블릿으로 변환될 때 기본객체들을 생성하는데에 사용
  JSP가 서블릿으로 변환되는 과정에서 pageContext 객체를 통해 request, response, out 등의 기본객체를 생성해주기 때문에 우리는 JSP를 작성할 때 별다른 선언없이 사용이 가능했던 것

* pageContext 객체의 메소드
- ServletRequest = getRequest(); request 기본 객체를 반환
- JspWriter = getOut(); out 기본 객체를 반환

 -->

</body>
</html>