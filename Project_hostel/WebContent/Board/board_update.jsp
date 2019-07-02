<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/hostel?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();

	String id = request.getParameter("id");
	String sql = "select*from board where id=" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="../Image/structure.css">
	<link rel="stylesheet" href="../Image/writeStructure.css">
	<link rel="stylesheet" href="../Image/categoriesStyle.css">
	<script>
		function checked() {
			// radio check
			var b = <%=rs.getInt("blood")%>;
			document.getElementsByName("blood")[b].checked = "true";
	
			// checkbox check
			// ※ rs.getString() 값을 문자열로 이용하려면 "" 와 함께 사용 ..
			var h = "<%=rs.getString("hobby")%>";
			var hobbyArr = h.split(",");
				for(var i = 0; i < hobbyArr.length-1; i++) {
					document.getElementsByName("hobby")[hobbyArr[i]].checked = "true";
				}
				
			// select check
			document.getElementById("birthYear").value = "<%=rs.getString("birth")%>";
		}
	</script>
</head>

<body onload="checked()">
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article id="grid-container">
			<%@ include file="../Board/board_structure.jsp"%>
			<div>
				<form action="../Board/board_update_ok.jsp" method="post" name="form">
					<input type="hidden" name="id" value=<%=id%>>
					<!-- ☆ id 값 넘기기 필수 -->
					<table>
						<caption>게시판</caption>
						<caption>
							<a href="../Board/board_list.jsp">목록</a>
						</caption>

						<tr id="fields">
							<td>제목</td>
							<td>작성자</td>
							<td>작성일</td>
						</tr>
						
						<tr class="contentInfo">
							<td><input type="text" name="title" value="<%=rs.getString("title")%>"></td>
							<td><%=rs.getString("name")%></td>
							<td><input type="date" name="writeday" value="<%=rs.getDate("writeday")%>" disabled></td>
						</tr>
						
						<tr id="fields">
							<td>취미</td>
							<td>혈액형</td>
							<td>생일연도</td>
						</tr>
						
						<tr class="contentInfo">
							<td>
								<input type="checkbox" name="hobby" value="0"> 수영 
								<input type="checkbox" name="hobby" value="1"> 그림 
								<input type="checkbox" name="hobby" value="2"> 춤 
								<input type="checkbox" name="hobby" value="3"> 독서 
							</td>
							<td>
								<input type="radio" name="blood" value="0"> A 
								<input type="radio" name="blood" value="1"> B 
								<input type="radio" name="blood" value="2"> AB 
								<input type="radio" name="blood" value="3"> O
							</td>
							<td>
								<select name="birthYear" id="birthYear">
										<option value="select">생일 연도</option>
										<%
											for (int i = 2019; i >= 1900; i--) {
										%>
										<option value="<%=i%>"><%=i%></option>
										<%
											}
										%>
								</select>
							</td>
						</tr>
						
						<tr id="fields">
							<td colspan="3">내용</td>
						</tr>
						
						<tr id="content">
							<td colspan="3">
								<textarea name="content" id="" cols="100px" rows="40px">
								<%=rs.getString("content")%>
								</textarea>
							</td>
						</tr>
						
						<tr>
							<td colspan="3"><input type="submit" value="저장"></td>
						</tr>
					</table>
				</form>
			</div>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>
<%
stmt.close();
conn.close();
%>