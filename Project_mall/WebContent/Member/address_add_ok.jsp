<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Command.Address_add"%>
<%@ page import="mall.Dto.Address"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- Dto 변수에 파라미터값 전달 -->
<jsp:useBean id="dto" class="mall.Dto.Address">
	<jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<%
	// 커맨드 객체 생성
	Address_add cmd = new Address_add();

	// 메소드 실행
	cmd.Add(dto);
	
	// 페이지 이동
	response.sendRedirect("address.jsp");
%>