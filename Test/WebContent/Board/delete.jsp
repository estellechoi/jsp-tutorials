<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.Command.Delete"%>
<%
	String id = request.getParameter("id");

	//board.Command.Delete 클래스 사용을 위해 객체 생성
	Delete del = new Delete();
	
	// Delete 클래스 delete() 메소드 실행
	del.delete(id);
	
	// 페이지 이동
	response.sendRedirect("list.jsp");
%>