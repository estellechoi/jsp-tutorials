<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// * request 영역 : 현재 문서
	// * session 영역 : 하나의 웹브라우저
	// * application 영역 : 하나의 웹어플리케이션(웹프로젝트)
	// * 메소드 : setAttribute(), getAttribute(), removeAttribute()
	request.setAttribute("name", "유진");
	session.setAttribute("name", "보민");
	application.setAttribute("name", "용기");
%>

<%
	out.print(request.getAttribute("name") + "<br>");
	out.print(session.getAttribute("name") + "<br>");
	out.print(application.getAttribute("name") + "<br>");
%>