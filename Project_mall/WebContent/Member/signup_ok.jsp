<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="mall.Dto.Member"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="mem" class="mall.Dto.Member">
	<jsp:setProperty name="mem" property="*"/>
</jsp:useBean>
<!-- property="*" 자바빈 객체의 각 프로퍼티 값을 같은 이름을 갖는 파라미터 값으로 설정한다.  -->

<%
// 	JSP에서는 데이터를 자바빈(JavaBean)이라는 클래스에 담아서 값을 보여준다
// 	자바빈의 경우 데이터를 담을 프로퍼티(맴버변수)와 데이터를 가져오거나 세팅하는 기능을 하는 메서드로 구성
	
// 	<jsp:usebean></jsp:usebean>
// 	* id : JSP페이지에서 자바빈 객체에 접근 할 때 사용하는 이름
// 	* class : 패키지 이름을 포함한 자바빈 클래스의 완전한 이름
// 	* scope : 자바빈 객체가 저장될 영역 (page, request, session, application 중 하나), 기본값은 page
	
// 	<jsp:setProperty/>
// 	* name : 프로퍼티 값을 변경할 자바빈 객체의 이름
// 			 <jsp:useBean> 액션 태그의 id 속성에서 지정한 값을 사용
// 	* property : 값을 지정할 프로퍼티의 이름
// 	* value : 프로퍼티 값, 표현식 사용가능
	
// 	위의 액션태그를 코드로 바꾸면 아래와 같다.
	
// 	Member mem = (Member) request.getAttribute("member");
// 	if (mem == null) {
// 	mem = new Member();
// 	request.setAttribute("mem", mem);
%>

<%
	String sql = "insert into member(usertype, email, username, pwd, cell, zip, address1, address2, sex, birth, agree_SMS, agree_email, writeday)";
	sql = sql + " values(?,?,?,?,?,?,?,?,?,?,?,?,now())";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setInt(1, mem.getUsertype());
	pstmt.setString(2, mem.getEmail());
	pstmt.setString(3, mem.getUsername());
	pstmt.setString(4, mem.getPwd());
	pstmt.setInt(5, mem.getCell());
	pstmt.setInt(6, mem.getZip());
	pstmt.setString(7, mem.getAddress1());
	pstmt.setString(8, mem.getAddress2());
	pstmt.setInt(9, mem.getSex());
	pstmt.setString(10, mem.getBirth());
	pstmt.setString(11, mem.getAgree_SMS());
	pstmt.setString(12, mem.getAgree_email());
	
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	response.sendRedirect("signin.jsp");
%>

	
