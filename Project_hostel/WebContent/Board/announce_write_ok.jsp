<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%@ include file="../Common/Date.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	sql = "insert into announce(title, userid, writeday, readnum, content)";
	sql = sql + " values('" + title + "', '관리자', '" + writeday
			+ "', 0, '" + content + "')";
	stmt.executeUpdate(sql);

	response.sendRedirect("../Board/announce_list.jsp");

	stmt.close();
	conn.close();
%>