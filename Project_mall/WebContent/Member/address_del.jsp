<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Command.Address_del"%>
<%
	// 체크된 레코드의 id 값 (,로 연결된 문자열)
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	
	// 커맨드 객체
	Address_del cmd = new Address_del();

	// 메소드 실행
	cmd.Del(id);
	
	// 페이지 이동
	response.sendRedirect("address.jsp");
%>