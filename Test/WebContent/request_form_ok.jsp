<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 1) getParameter() : form 입력값 호출
	out.println(request.getParameter("name"));
	out.println(request.getParameter("address"));

	// ☆ 같은 name이 복수인 경우, 첫번째 요소의 value만 호출 [ex]checkbox
	out.println(request.getParameter("hobby") + "<hr>");

	
	// 2) getParameterValues() : 같은 name이 복수인 경우, 모든 요소의 value 호출
	//    ☆ 리턴값은 String 배열 !
	String hobby[] = request.getParameterValues("hobby");
	for (int i = 0; i < hobby.length; i++) {
		out.println(hobby[i]);
	}

	// 3) getParameterNames()
	request.getParameterNames();

	// 4) getParameterMap()
	request.getParameterMap();
%>