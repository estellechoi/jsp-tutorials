<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	String sql = "insert into test set name='테스트'";
	stmt.executeUpdate(sql);

	stmt.close();
	conn.close();

	if(true) { // 이 경우는 항상 "ok" 출력되도록 임시 설정
		out.println("ok");
	}
	else {
		out.println("no");
	}
%>