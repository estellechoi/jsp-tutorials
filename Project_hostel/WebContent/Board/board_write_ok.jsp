<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%@ include file="../Common/Date.jsp"%>

<%
	// 사용자 입력값
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
 	title=title.replace("<","&lt;");
 	title=title.replace(">","&gt;");
// <xmp></xmp>
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	String password = request.getParameter("password");
	// radio
	String blood = request.getParameter("blood");
	// select
	 	String birthYear = request.getParameter("birthYear");
	// 	String birthMonth = request.getParameter("birthMonth");
	// 	String birthDate = request.getParameter("birthDate");
	// 	String birthstmt = birthYear + "-" + birthMonth + "-" + birthDate;

	// 	String birthYear = request.getParameter("birthYear");
	// 	String birthMonth = request.getParameter("birthMonth");
	// 	String birthDate = request.getParameter("birthDate");
	// 	// String → Date type
	// 	Date birthy = sdf.parse(birthYear);
	// 	Date birthm = sdf.parse(birthMonth);
	// 	Date birthd = sdf.parse(birthDate);

	// 	String birthstmt = birthYear + "-" + birthMonth + "-" + birthDate;
	// checkbox (배열 value를 가진다, 배열요소를 숫자로 가져오나 ?)
	String hobby[] = request.getParameterValues("hobby");
	String hobbystmt = "";

	for (int i = 0; i < hobby.length; i++) {
		hobbystmt = hobbystmt + hobby[i] + ", ";
	}

	// 	if (session.getAttribute("userid") == null) {
	// 		sql = "insert into board(title, name, content, blood, hobby, readnum, password) values('"
	// 				+ title + "', '" + name + "', '" + content
	// 				+ "', " + blood + ", '" + hobbystmt
	// 				+ "', 0, '" + password + "')";
	// 	} else {
	// 		sql = "insert into board(title, name, userid, content, blood, hobby, readnum) values('"
	// 				+ title + "', '" + session.getAttribute("name") + "', '"
	// 				+ session.getAttribute("userid") + "', '" + content
	// 				+ "', " + blood + ", '" + hobbystmt
	// 				+ "', 0)";
	// 	}

sql ="insert into board(title, name, content, readnum, password, blood) values('"+title+"', '"+name+"', '"+content+"', 0, '"+password+"', "+blood+")";

	stmt.executeUpdate(sql);

	response.sendRedirect("../Board/board_list.jsp");
	stmt.close();
	conn.close();
%>