<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	
	// 지우려는 글의 ref, depth, seq
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String ref = request.getParameter("ref");
	int depth = Integer.parseInt(request.getParameter("depth"));
	String seq = request.getParameter("seq");
	
	String sql = "";
	
	// 질문일 때
	// 질문의 답글까지 삭제
	if(depth == 1) {
		sql ="delete from qna where ref="+ref;
		stmt.executeUpdate(sql);
	}
	// 답글일 때
	// 답글의 답글까지 삭제
	else {
		sql = "delete from qna where id="+id;
		stmt.executeUpdate(sql);
		// depth는 더 크지만, 다른 답글의 답글인 것들 .. (질문은 같을 때)
		// 다른건 seq 차이나는 것 뿐 ?
		
		sql = "update qna set seq=seq-1 where seq>"+seq+" and ref="+ref;
		stmt.executeUpdate(sql);
	}
%>
	<script>
		location="qna_list.jsp";
	</script>
<%
	stmt.close();
	conn.close();
%>