<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!--
 * Enumeration 인터페이스
 	- 객체들의 집합(Vector)에서 각각의 객체들을 한순간에 하나씩 처리할 수 있는 메소드를 제공하는 켈렉션
 	- 인터페이스이므로 new 연산자로 객체를 생성할 수 없음
 	- Enumeration 인터페이스에 선언된 메소드는 인터페이스를 사용하는 클래스로 구현해서 사용해야만 함
 	- Vector의 요소들을 Enumeration에 저장한 후 하나씩 순서대로 출력
-->
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Map"%>

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
	
	out.println("<hr>");

	
	// 3) getParameterNames() : 존재하는 name의 이름 모두 호출
	//    ☆ 리턴값은 Enumeration 객체 (임포트 필요)
	Enumeration enm = request.getParameterNames();
	
	while(enm.hasMoreElements()) { // name 존재여부 (boolean)
		out.println(enm.nextElement().toString()); // 다음 name 값 호출 (Object)
	}
	
	out.println("<hr>");
	
	
	// 4) getParameterMap() : key 값 (name의 이름) value 값 호출
	//    ☆ Map.get("name") 메소드의 리턴값은 String[]
	Map map = request.getParameterMap();
	String map_name[] = (String[]) map.get("name");
	String map_address[] = (String[]) map.get("address");
	String map_hobby[] = (String[]) map.get("hobby");
	
	out.println(map_name[0]);
	out.println(map_address[0]);
	out.println(map_hobby[2]);
%>