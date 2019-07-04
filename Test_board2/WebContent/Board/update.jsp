<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/test?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	
	String id = request.getParameter("id");
	String sql = "select*from test where id="+id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/list.css">
<script>
 function AllCheckedShow() {
	 // sex radio
	 var sexIndex = <%=rs.getInt("sex")%>;
	 document.getElementsByName("sex")[sexIndex].checked = "true";
	 
	 // address select
	 var address = "<%=rs.getString("address")%>";
	 document.getElementById("address").value = address;
	 
	 // food checkbox
	 var f = "<%=rs.getString("food")%>";
	 var foodArr = f.split(",");
	 for(var i=0; i<foodArr.length-1; i++) {
		 document.getElementsByName("food")[foodArr[i]].checked ="true";
	 }
	 
 }
</script>
</head>
<body onload="AllCheckedShow()">
<form action="../Board/update_ok.jsp" method="post">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="readnum" value="<%=rs.getInt("readnum")%>">
	<table>
		<caption>테스트게시판</caption>
		<caption>
			<a href="../Board/list.jsp">목록</a>
		</caption>
		<tr>
			<td>이름</td>
			<td class="input"><input type="text" name="name" value="<%=rs.getString("name")%>" readonly></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td class="input"><input type="text" name="email" value="<%=rs.getString("email")%>"></td>
		</tr>
		<tr>
			<td>성별</td>
			<td class="input">
				<input type="radio" name="sex" value="0"> 남
				<input type="radio" name="sex" value="1"> 여
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td class="input">
				<select name="address" id="address">
					<option value="선택하기">선택하기</option>
					<option value="서울">서울</option>
					<option value="양양">양양</option>
					<option value="고성">고성</option>
					<option value="대전">대전</option>
					<option value="제주">제주</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>좋아하는 음식</td>
			<td class="input">
				<input type="checkbox" name="food" value="0"> 라면
				<input type="checkbox" name="food" value="1"> 햄버거
				<input type="checkbox" name="food" value="2"> 피자
				<input type="checkbox" name="food" value="3"> 스시
				<input type="checkbox" name="food" value="4"> 국밥
				<input type="checkbox" name="food" value="5"> 삼겹살
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td class="input"> <input type="text" name="title" value="<%=rs.getString("title")%>"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td class="input">
				<textarea name="content" id="content" cols="30" rows="10">
				<%=rs.getString("content")%></textarea>
			</td>
		</tr>
		<tr>
		<td colspan="2"> <input type="submit" value="수정"></td>
		</tr>
	</table>
</form>
</body>
</html>