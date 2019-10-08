<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Dto.Qna"%>
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
<jsp:usebean id="dto" class="mall.Dto.Qna">
	<jsp:setproperty name="dto" property="*"/>
</jsp:usebean>

<%
	// mall.Command 패키지 Qna_write 메소드 실행
	Qna_write cmd = new Qna_write();
	// Command 클래스의 write 메소드 실행 → Dao 클래스의 쿼리실행 메소드 실행
	cmd.write(dto); // 이거 왜 에러 ??
	
	response.sendRedirect("qna_list.jsp");
%>
</body>
</html>