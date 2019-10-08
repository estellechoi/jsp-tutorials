<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt= conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	String id[] = request.getParameterValues("check");
	
	String str = "";
	for (int i = 0; i < id.length-1; i++) {
		str = str + id[i]+ ",";
	}
	
	// 마지막 인덱스 값은 뒤에 콤마 없이 연결해야 함
	str = str + id[id.length-1];
	
	String sql = "delete from address where id in (" + str + ")";
	stmt.executeUpdate(sql);
	
	stmt.close();
	conn.close();
	response.sendRedirect("product_buynow_address.jsp?email="+email);
%>