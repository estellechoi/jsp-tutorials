<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Dto.Member"%>
<%@ page import="mall.Command.Account_edit"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!--
* useBean 액션태그를 사용하여 Dto 에 값 전달
1) id : 빈 이름
2) class : 자바빈 클래스 이름
3) name : 프로퍼티 값을 변경할 자바빈 객체의 이름 지정 (id 값을 사용)
4) property : 값을 지정할 프로퍼티의 이름
-->
<jsp:useBean id="dto" class="mall.Dto.Member">
	<jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<%
	// mall.Command 패키지
	Account_edit cmd = new Account_edit();
	cmd.Edit(dto);
	
	// 페이지 이동
	response.sendRedirect("account.jsp");
%>