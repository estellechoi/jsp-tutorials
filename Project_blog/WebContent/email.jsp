<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="blog.Util.NaverMail"%>
<%
	// POST 전송값
	request.setCharacterEncoding("utf-8");
	String recipient = request.getParameter("recipient");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 
	NaverMail mailPro = NaverMail.getInstance();
	int state = mailPro.setEmail(recipient, title, content);
%>


