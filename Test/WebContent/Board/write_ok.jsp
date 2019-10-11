<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.Dto.Board_dto"%>
<%@ page import="board.Command.Write"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
* useBean 액션태그를 사용하여 Dto 에 값 전달
1) id : 빈 이름
2) class : 자바빈 클래스 이름
3) name : 프로퍼티 값을 변경할 자바빈 객체의 이름 지정 (id 값을 사용)
4) property : 값을 지정할 프로퍼티의 이름

-->
<jsp:useBean id="dto" class="board.Dto.Board_dto">
	<jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<%

// * Write.write() 메소드 실행 / DB 엑세스 및 데이터 처리
	Write w = new Write();
	w.write(dto);

// 페이지 이동
	response.sendRedirect("list.jsp");
%>
</body>
</html>
