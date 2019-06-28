<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	sql = "insert into event(name, phone) values('" + name + "', '"
			+ phone + "')";
	stmt.executeUpdate(sql);

	response.sendRedirect("../Home/home.jsp");

	stmt.close();
	conn.close();
%>