<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	sql = "delete from announce where id=" + id;

	stmt.executeUpdate(sql);

	response.sendRedirect("../Board/announce_list.jsp");

	stmt.close();
	conn.close();
%>
