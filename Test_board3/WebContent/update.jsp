<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	String id = request.getParameter("id");
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
		
		// document.form.age.options[n].selected = true;
		// document.form.age.selectedIndex = n;
		
	}
</script>
</head>
<body onload="sexCheck(), ageCheck()">
	<form action="update_ok.jsp" method="post" name="form">
	<input type="hidden" name="id" value="<%=id%>">
		제목 <input type="text" name="title" value="<%=rs.getString("title")%>">
		<p></p>
		내용
		<textarea name="content" id="content" cols="50" rows="6"><%=rs.getString("content")%></textarea>
		<p></p>
		작성자 <span><%=rs.getString("user")%></span>
		<p></p>
		나이 <select name="age" id="age">
			<option value="10대">10대</option>
			<option value="20대">20대</option>
			<option value="30대">30대</option>
			<option value="40대">40대</option>
			<option value="50대">50대</option>
		</select>
		<p></p>
		성별
		<input type="radio" name="sex" value="0"> 남자 
		<input type="radio" name="sex" value="1"> 여자
		<p></p>
		비밀번호 <input type="password" name="pwd">
		<p></p>
		<input type="submit" value="저장">
	</form>

</body>
</html>

<%
	conn.close();
	stmt.close();
%>