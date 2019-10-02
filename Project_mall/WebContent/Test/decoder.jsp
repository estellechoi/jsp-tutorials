<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder"%>
<%
	// <jsp:param/> 값 가져오기
	// 사용 이유 ?
	String name = URLDecoder.decode(request.getParameter("name").toString());
	String age = request.getParameter("age");
	String address = request.getParameter("address");
%>

이름 : <%=name%>
나이 : <%=age%>
주소 : <%=address%>
