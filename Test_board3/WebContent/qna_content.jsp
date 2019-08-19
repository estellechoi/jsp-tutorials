<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	// content.jsp는 하나의 레코드의 내용을 전부 보여준다...

	// DB연결
	String aa = "jdbc:mysql://localhost:3307/java?useSSL=false";
	String bb = "root";
	String cc = "1234";
	Connection conn = DriverManager.getConnection(aa, bb, cc);
	Statement stmt = conn.createStatement();
	// 읽어오고자 하는 레코드의 id값을 받기
	String id = request.getParameter("id");
	String Page = request.getParameter("page");

	// 쿼리작성 => 하나의 레코드만 읽어오는 쿼리
	String sql = "select * from qna where id=" + id;
	// select * from board where id=3;
	// select한 결과값을 사용하려고 하면 ResultSet에 가져와야 된다.
	ResultSet rs = stmt.executeQuery(sql);
	// 하나의 레코드만 읽어온다..
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 이름, 제목, 내용, 조회수, 작성일, 나이, 성별 -->
	<table width=600 border=1 cellspacing=0>
		<tr>
			<td>제 목</td>
			<td colspan=3><%=rs.getString("title")%></td>
		</tr>
		<tr>
			<td>이 름</td>
			<td><%=rs.getString("user")%></td>
			<td>조회수</td>
			<td><%=rs.getString("readnum")%></td>
		</tr>
		<tr height=200>
			<td>내 용</td>
			<td colspan=3><%=rs.getString("content")%></td>
		</tr>
		<%
			String age = "";
			switch (rs.getString("age")) // 10대 ~50대 => 0,1,2,3,4
			{
				case "10대" :
					age = "10대";
					break;
				case "20대" :
					age = "20대";
					break;
				case "30대" :
					age = "30대";
					break;
				case "40대" :
					age = "40대";
					break;
				case "50대" :
					age = "50대";
					break;
			}

			String sung;
			if (rs.getInt("sex") == 0) // 0이면 남자, 1이면 여자
				sung = "남자";
			else
				sung = "여자";
		%>
		<tr>
			<td>나 이</td>
			<td><%=age%></td>
			<td>성 별</td>
			<td><%=sung%></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td colspan=3><%=rs.getString("writeday")%></td>
		</tr>
		<tr>
			<td colspan=4 align=center><a href="qna_update.jsp?id=<%=id%>">
					수정 </a> <a href="javascript:del()"> 삭제 </a> <a
				href="qna_list.jsp?page=<%=Page%>"> 목록 </a></td>
		</tr>
	</table>

	<div id=delete style="display: none">
		<form method=post action=qna_del_ok.jsp>
			<input type=hidden name=id value=<%=id%>> <input type=hidden
				name=page value=<%=Page%>> 비밀번호 <input type=password
				name=pwd> <input type=submit value=삭제> <input
				type=button onclick=hide() value=취소>
		</form>
	</div>
	<!-- 비밀번호 입력폼을 숨겼다가 위의 삭제를 클릭하면 보이기 -->
	<script>
		function del() // 비밀번호 입력폼을 보이게 하기
		{
			document.getElementById("delete").style.display = "block";
			//document.all.delete.style.display="block";
		}
		function hide() // 비밀번호 입력폼을 숨기기
		{
			document.getElementById("delete").style.display = "none";
			//document.all.delete.style.display="none";
		}
	</script>
	<style>
#delete { /* 나타나는 폼을 여기서 꾸민다 */
	border: 1px solid red;
	position: absolute; /* 내가 원하는 위치 */
	left: 100px;
	top: 100px;
	background: white;
}
</style>
</body>
</html>















