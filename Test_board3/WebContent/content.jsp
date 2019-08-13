<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	String id = request.getParameter("id");
	String pageNum = request.getParameter("page");
	
	String sql = "select*from testboard where id =" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	span {
		border: 1px solid #eeeeee;
		height: 20px;
	}
	
	#contentBox {
		margin: auto;
		width: 1000px;
		border: 1px solid #eeeeee;
		border-radius: 10px;
	}
	
	#replyBox, #replyList {
		margin: auto;
		width: 1000px;
		border: 1px solid #eeeeee;
		border-radius: 10px;	
	}
	
	#replyList td {
		margin: auto;
		text-align: center;
		border: 1px solid #eeeeee;
	}
	
	#replyList td:nth-child(1) {
		width: 20%;
	}
	
	#replyList td:nth-child(2) {
		width: 60%;
	}
	
	#replyList td:nth-child(3) {
		width: 10%;
	}
	
	#replyList td:nth-child(4) {
		width: 5%;
	}
	
	#replyList td:nth-child(5) {
		width: 15%;
	}
</style>
<!-- 
<input type="radio"> & <select> 문서 로드시 체크 설정하기
 -->
<script>
	function sexCheck() {
		document.form.sex[<%=rs.getInt("sex")%>].checked = true;
	}
	
	function ageCheck() {
		var age = "<%=rs.getString("age")%>";
		document.form.age.value = age;
	}
</script>
</head>
<body onload="sexCheck(), ageCheck()">
	<form action="write_ok.jsp" method="post" name="form">
		<div id="contentBox">
			제목 <span><%=rs.getString("title")%></span>
			<p></p>
			내용
			<textarea name="content" id="content" cols="50" rows="6"><%=rs.getString("content")%></textarea>
			<p></p>
			작성자 <span><%=rs.getString("user")%></span>
			<p></p>
			나이 
			<select name="age" id="age">
				<option value="10대">10대</option>
				<option value="20대">20대</option>
				<option value="30대">30대</option>
				<option value="40대">40대</option>
				<option value="50대">50대</option>
			</select>
			<p></p>
			성별 <input type="radio" name="sex" value="0"> 남자
			   <input type="radio" name="sex" value="1"> 여자
			<p></p>
			<a href="update.jsp?id=<%=id%>">수정</a>
<%-- 			<a href="del.jsp?id=<%=rs.getString("id")%>">삭제</a> --%>
			<a href="javascript:del()">삭제</a>
			<a href="list.jsp?page=<%=pageNum%>">목록</a>
		</div>
	</form>
	<!-- 게시글 삭제를 위한 팝업창 -->
	<script>
		function hide() {
			document.getElementById("delBox").style.display="none";
		}
		function del() {
			document.getElementById("delBox").style.display="block";
		}
	</script>
	<div id="delBox" style="display:none">
		<form method="post" action="delete_ok.jsp">
      		<input type="hidden" name="id" value="<%=id%>">
         	비밀번호 <input type="password" name="pwd">
      		<input type="submit" value="삭제">
      		<input type="button" value="취소" onclick="hide()">
    	</form>
	</div>
	
	<!-- 댓글 입력창 -->
	<script>
	 function check() {
		 if(replyForm.name.value == "") {
			 alert("이름을 입력하세요!");
			 replyForm.name.focus();
			 return false;
		 }
		 else if(replyForm.content.value == "") {
			 alert("내용을 입력하세요!");
			 replyForm.content.focus();
			 return false;
		 }
		 else if (replyForm.pwd.value == "") {
			 alert("비밀번호를 입력하세요!");
			 replyForm.pwd.focus();
			 return false;
		 }
		 else {
			 return true;
		 }
	 }
	</script>
	<div id="replyBox">
		<form action="reply_ok.jsp" method="post" name="replyForm" onsubmit="return check()">
			<input type="hidden" name="page" value="">
			<input type="hidden" name="rid" value="<%=id%>">
			<!-- 글자수 제한 속성 : maxlength="" -->
			이름 <input type="text" name="name" size="7" maxlength="30"> 
			내용 <textarea name="content" id="content" cols="40" rows="1" maxlength="50"></textarea>
			비밀번호 <input type="password" name="pwd" maxlength="10">
			<input type="submit" value="확인">
		</form>
	</div>
	
	<!-- 댓글 출력창 -->
	<%
	// 해당 게시글의 id 값을 가진 댓글 데이터 조회
	sql = "select*from reply where rid="+id;
	ResultSet rs2 = stmt.executeQuery(sql);
	%>
	<div id="replyList">
		<table>
		<%
		while(rs2.next()) {
		%>
			<tr>
				<td><%=rs2.getString("name")%></td>
				<td><%=rs2.getString("content")%></td>
				<td><%=rs2.getString("writeday")%></td>
				<td><a href="">수정</a></td>
				<td><a href="">삭제</a></td>
			</tr>
		<%
		}
		%>
		</table>
	</div>

</body>
</html>

<%
	rs.close();
	rs2.close();
	conn.close();
	stmt.close();
%>