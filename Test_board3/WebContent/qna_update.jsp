<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pageNum = request.getParameter("page");
	
	String sql="select*from qna where id="+id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function showChecked() {
		// age 체크
		document.getElementById("age").value = "<%=rs.getString("age")%>";
		
		// sex 체크
		for(var i=0; i<=1; i++) {		
			if(i == <%=rs.getString("sex")%>) {
				document.qnaUpdateForm.sex[i].checked = true;
				break;
			}
		}
	}
	
	// 비밀번호 체크
	function checkPassword() {
		if (qnaUpdateForm.pwd.value != "<%=rs.getString("pwd")%>") {
			alert("비밀번호가 틀립니다!");
		}
		else {
			document.getElementById("pwdChecked").innerText = "확인완료";
		}
	}
	
	function check() {
		if(document.getElementById("pwdChecked").innerText == "확인완료") {
			return true;
		}
		else {
			alert("비밀번호를 확인하세요!");
			return false;
		}
	}
</script>
</head>
<body onload="showChecked()">
	<form action="qna_update_ok.jsp" method="post" name="qnaUpdateForm" onsubmit="return check()">
		<input type="hidden" name="id" value="<%=id%>">
		<input type="hidden" name="page" value="<%=pageNum%>">		
		<!-- 사용자 입력공간 -->
		제목 <input type="text" name="title" size="50" value="<%=rs.getString("title")%>">
		<p></p>
		내용
		<textarea name="content" id="content" cols="50" rows="6"><%=rs.getString("content")%></textarea>
		<p></p>
		작성자 <input type="text" name="user" size="8" value="<%=rs.getString("user")%>">
		<p></p>
		나이 <select name="age" id="age">
			<option value="10대">10대</option>
			<option value="20대">20대</option>
			<option value="30대">30대</option>
			<option value="40대">40대</option>
			<option value="50대">50대</option>
		</select>
		<p></p>
		성별 <input type="radio" name="sex" value="0"> 남자 <input type="radio" name="sex" value="1">여자
		<p></p>
		비밀번호 <input type="password" name="pwd">
		<input type="button" value="비밀번호 확인" onclick="checkPassword()">
		<span id="pwdChecked"></span>
		<p></p>
		<input type="submit" value="수정">
	</form>
</body>
</html>