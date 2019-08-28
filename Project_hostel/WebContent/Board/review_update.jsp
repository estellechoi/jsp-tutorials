<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/hostel?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	String id = request.getParameter("id");
	String sql = "select*from review where id=" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css?ver=1">
<link rel="stylesheet" href="../Image/categoriesStyle.css">
<style>
	table {
		margin: auto;
		width: 1000px;
		border: 1px solid grey;
		border-collapse: collapse;
	}
	
	table tr, td {
		border: 1px solid grey;
		text-align: center;
		font-size: 13px;
		height: 30px;
	}
	
	table #contentBox {
		height: 300px;
	}
	
	table #imgBox {
		height: 200px;
	}
</style>
<script>
	function cancelUpdate() {
		history.back();
	}
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article id="grid-container">
			<%@ include file="../Board/board_structure.jsp"%>
			<div>
				<form action="review_update_ok.jsp" method="post" enctype="multipart/form-data">
					<table>
						<input type="hidden" name="id" value="<%=id%>">
						<tr>
							<td>제목</td>
							<td colspan="3"><input type="text" name="title" value="<%=rs.getString("title")%>"></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><%=rs.getString("name")%></td>
							<td>조회수</td>
							<td><%=rs.getString("readnum")%></td>
						</tr>
						<tr id="contentBox">
							<td>내용</td>
							<td colspan="3">
								<textarea name="content" id="content" cols="40" rows="20">
									<%=rs.getString("content")%>
								</textarea>
							</td>
						</tr>
						<tr>
							<td id="imgBox">사진</td>
							<td colspan="3">
								<img src="../Image/<%=rs.getString("filename")%>" alt="이미지 없음" width="400px">
								<p></p>
								<input type="file" name="filename" value="<%=rs.getString("filename")%>">
							</td>
						</tr>
						<tr>
							<td>작성일</td>
							<td colspan="3"><%=rs.getString("writeday")%></td>
						</tr>
						<tr>
							<td colspan="4">
								<input type="submit" value="수정">
								<input type="button" value="취소" onclick="cancelUpdate()">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>