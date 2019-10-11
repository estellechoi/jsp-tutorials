<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Dto.Qna_dto"%>
<%@ page import="mall.Command.Qna_write"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- request 파라미터 값을 mall.Dto 패키지 Qna 클래스의 동명 변수에 전달 -->
<jsp:useBean id="dto" class="mall.Dto.Qna_dto">
	<jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<%
	// mall.Command 패키지 Qna_write 메소드 실행
	Qna_write wri = new Qna_write();
	// Command 클래스의 write 메소드 실행 → Dao 클래스의 쿼리실행 메소드 실행
	wri.write(dto);
	
	// 페이지 이동
	response.sendRedirect("qna_list.jsp");
%>
</body>
</html>