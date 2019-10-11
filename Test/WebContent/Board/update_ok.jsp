<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.Command.UpdateOk"%>
<%
	request.setCharacterEncoding("UTF-8");
	int id = Integer.parseInt(request.getParameter("id"));
%>

<!-- useBean 액션태그로 DTO에 값 전달 -->
<!-- 
	값을 입력/수정 할 때는 바로 DB 연결 후 데이터를 처리하기보다
	DTO 자바빈 객체에 파라미터 값들을 모두 저장한 후 (jsp:useBean 액션태그 사용)
	해당 DTO 객체를 매개변수로 하는 커맨드 메소드를 통해 DB 연결 및 데이터 처리를 한다.
 -->
<jsp:useBean id="dto" class="board.Dto.Board_dto">
	<jsp:setProperty name="dto" property="*"/>
</jsp:useBean>

<%
	// board.Command.UpdateOk 객체 생성
	UpdateOk upok = new UpdateOk();

	// 메소드 실행 (파라미터값을 전달 받은 dto 객체를 매개변수로 함)
	upok.updateok(dto);
	
	// 페이지 이동
	response.sendRedirect("content.jsp?id="+id);
	// → 여기에서 id 대신 dto.getId() 사용 가능
%>
