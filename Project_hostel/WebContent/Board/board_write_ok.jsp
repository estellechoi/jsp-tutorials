<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%@ include file="../Common/Date.jsp"%>

<%
	// 사용자 입력값
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String day = request.getParameter("writeday");
//  	title=title.replace("<","&lt;");
//  	title=title.replace(">","&gt;");
// <xmp></xmp>
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	// radio
	String blood = request.getParameter("blood");
	// select
	String birth = request.getParameter("birthYear");
	// checkbox (배열 value를 가진다, 배열요소를 숫자로 가져오나 ?)
	String h[] = request.getParameterValues("hobby");
	String hobby = "";
	for (int i = 0; i < h.length; i++) {
		hobby = hobby + h[i] + ", ";
	}

	// 쿼리 실행
    sql ="insert into board(title, name, content, readnum, password, blood, birth, hobby, writeday)";
    sql = sql +" values('"+title+"', '"+name+"', '"+content+"', 0, '"+password+"', "+blood+", '"+birth+"', '"+hobby+"', '"+day+"')";
	stmt.executeUpdate(sql);

	response.sendRedirect("../Board/board_list.jsp");
	stmt.close();
	conn.close();
%>