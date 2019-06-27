<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	// 조회수 추가
	String id = request.getParameter("id");
	sql = "update board set readnum=readnum+1 where id=" + id;
	stmt.executeUpdate(sql);
	
	response.sendRedirect("../Board/board_content.jsp?id="+id);
%>