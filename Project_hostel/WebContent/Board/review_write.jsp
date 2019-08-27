<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/categoriesStyle.css">
<style>
	section article:nth-child(1) {
		height: 150px;
		background-image: url(../Image/arizona.jpg);
		background-size: 100%;
		background-repeat: no-repeat;
	}
	
	section article:nth-child(2) {
		height: 1000px;
		
	}
	
	table {
		margin: auto;
		width: 1000px;
		border: 1px solid lightgrey;
		border-collapse: collapse;
	}
	
	table caption:nth-child(1) {
		font-weight: bold;
	}
	
	table caption:nth-child(2) {
		text-align: right;
	}
	
</style>
</head>
<body>
<%@ include file="../Common/header.jsp"%>
<section>
	<article></article>
	<article id="grid-container">
		<%@ include file="../Board/board_structure.jsp"%>
		<div>
			<form action="review_write_ok.jsp" method="post" enctype="multipart/form-data">
				<table>
					<caption>여행후기</caption>
					<caption>
						<a href="../Board/review_list.jsp">목록</a>
					</caption>
					<input type="hidden" name="userid" value="<%=session.getAttribute("userid")%>">
					<tr class="fields">
						<td>제목</td>
						<td>작성자</td>
					</tr>
					<tr class="contentInfo">
						<td><input type="text" name="title"></td>
						<td><input type="text" name="name" value="<%=session.getAttribute("name")%>" readonly></td>
					</tr>
					<tr class="fields">
						<td colspan="2">내용</td>
					</tr>
					<tr>
						<td colspan = "2">
							<textarea name="content" id="content" cols="30" rows="10"></textarea><p></p>
							<input type="file" name="filename">
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="저장"></td>
					</tr>
				</table>
			</form>
		</div>
	</article>
</section>
<%@ include file="../Common/footer.jsp"%>
</body>
</html>