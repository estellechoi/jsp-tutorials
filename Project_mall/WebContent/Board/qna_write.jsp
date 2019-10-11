<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/qna_write.css">
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div>
		<div id="grid_right">
			<section class="board_section">
				<!-- 게시글 분류 텍스트 -->
				<div class="board_header">Q&A</div>
				<!-- 테이블 -->
				<div class="board_table">
					<div class="board_link">
						<a href="qna_list.jsp">목록</a>
					</div>
					<form action="qna_write_ok.jsp" method="post">
						<table>
							<caption><input type="text" name="title"></caption>
							<tr>
								<td>이름</td>
								<td><input type="text" name="username"></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><input type="text" name="email"></td>
							</tr>
							<tr>
								<td>제목</td>
								<td><input type="text" name="title"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea name="content" id="" cols="30" rows="4"></textarea></td>
							</tr>
							<tr>
								<td colspan="2"><input type="submit" value="저장"></td>
							</tr>
						</table>
					</form>
				</div>
			</section>
			<!-- footer -->
			<jsp:include page="../footer.jsp" flush="false"/>			
		</div>
	</div>
</body>
</html>