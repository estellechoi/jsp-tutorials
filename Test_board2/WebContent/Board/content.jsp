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
	
	String sex;
	if(rs.getInt("sex") == 0) {
		sex = "남";
	} else {
		sex = "여";
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/list.css">
<script>
	function checkboxShow() {
		var f = "<%=rs.getString("food")%>";
		var food = f.split(",");
		for (var i = 0; i < food.length - 1; i++) {
			document.getElementsByName("food")[food[i]].checked = "true";
		}
	}
</script>
</head>
<body onload="checkboxShow()">
	<table>
		<caption>테스트게시판</caption>
		<caption>
			<a href="../Board/del.jsp?id=<%=rs.getString("id")%>">삭제</a>
			<a href="../Board/update.jsp?id=<%=rs.getString("id")%>">수정</a>
			<a href="../Board/list.jsp">목록</a>
		</caption>
		<tr>
			<td>이름</td>
			<td class="input"><%=rs.getString("name")%></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td class="input"><%=rs.getString("email")%></td>
		</tr>
		<tr>
			<td>성별</td>
			<td class="input"><%=sex%></td>
		</tr>
		<tr>
			<td>주소</td>
			<td class="input"><%=rs.getString("address")%></td>
		</tr>
		<tr>
			<td>좋아하는 음식</td>
			<td class="input">
				<input type="checkbox" name="food" value="0" disabled> 라면
				<input type="checkbox" name="food" value="1" disabled> 햄버거
				<input type="checkbox" name="food" value="2" disabled> 피자
				<input type="checkbox" name="food" value="3" disabled> 스시
				<input type="checkbox" name="food" value="4" disabled> 국밥
				<input type="checkbox" name="food" value="5" disabled> 삼겹살
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td class="input"><input type="text" name="title" value="<%=rs.getString("title")%>" readonly></td>
		</tr>
		<tr>
			<td>내용</td>
			<td class="input"><textarea name="content" id="content" cols="30" rows="10" readonly><%=rs.getString("content")%></textarea></td>
		</tr>
		<tr>
		<td colspan="2"></td>
		</tr>
	</table>
</body>
</html>