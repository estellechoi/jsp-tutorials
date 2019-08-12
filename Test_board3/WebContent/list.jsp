<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();	
	request.setCharacterEncoding("UTF-8");

	// select*from testboard limit index, n; (index 부터 n 개)
	int index;
	int pageNum = 0;
	// pageNum = 1 왜 처음부터 안쓰고 if문에 값을 다시 할당한다고 ? 관례라고 ?

	// 사용자가 페이지 선택하기 전 → 초기값 : index = 0
	if (request.getParameter("page") == null) {
		index = 0;
		pageNum = 1;

		// 1 페이지10 개씩
		// 사용자가 선택값을 담는 get방식 변수 : page (임의설정)
	} else {
		pageNum = Integer.parseInt(request.getParameter("page"));
		index = (pageNum - 1) * 10;
	}
	
	
	// * 게시글 검색하기
	// limit n : 상위 n개 데이터만 조회
	// limit index, n : index(0 ~) 부터 n개 데이터만 조회
	
	String sField = request.getParameter("sField");
	String sWord = request.getParameter("sWord");
	String sql;
	if (sField == null) {
		sql = "select*from testboard order by id desc limit " + index + ", 10";
	}
	else if (sField.equals("0")) {
		sql = "select*from testboard where title like '%"+sWord+"%' order by id desc limit " + index + ", 10";
	}
	else if (sField.equals("1")) {
		sql = "select*from testboard where content like '%"+sWord+"%' order by id desc limit " + index + ", 10";
	}
	else {
		sql = "select*from testboard where user like '%"+sWord+"%' order by id desc limit " + index + ", 10";
	}
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	margin: auto;
	width: 1000px;
	border: 1px solid #eeeeee;
	border-collapse: collapse;
}

caption:nth-child(1) {
	padding-top: 20px;
	padding-bottom: 20px;
	font-weight: bold;
}

caption:nth-child(2) {
	text-align: right;
	padding-bottom: 10px;
}

tr {
	border: 1px solid #eeeeee;
	font-size: 13px;
}

td {
	height: 30px;
	text-align: center;
}

#field {
	font-weight: bold;
}

#fieldTitle {
	width: 500px;
}

#pageLink {
	border: 3px solid pink;
	border-radius: 5px;
	text-decoration: none;
}
</style>
<script>
	 function movePage() {
		 var y = document.all.movePage.value;
		 location = "list.jsp?page="+y;
	 }
</script>

</head>
<body>
	<table>
		<caption>게시판</caption>
		<caption>
			<a href="write.jsp">글쓰기</a> <a href="forceInput.jsp">강제 데이터 입력</a>
		</caption>
		<caption>
			<form action="list.jsp" method="post">
				<!-- 필드 선택 -->
				<select name="sField" id="sField">
					<option value="0">제목</option>
					<option value="1">내용</option>
					<option value="2">작성자</option>
				</select>
				<!-- 검색값 입력 -->
				<input type="text" name="sWord" size="8">
				<input type="submit" value="검색">
			</form>
		</caption>
		<tr id="field">
			<td>순</td>
			<td id="fieldTitle">제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		<%
			int n = 0;
			while (rs.next()) {
				n++;
		%>
		<tr>
			<td><%=n%></td>
			<td><a href="readnum.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("title")%></a></td>
			<td><%=rs.getString("user")%></td>
			<td><%=rs.getString("writeday")%></td>
			<td><%=rs.getInt("readnum")%></td>
		</tr>

		<%
			}
		%>

		<tr>
			<td colspan="5">
				<a href="list.jsp?page=1">처음</a>
				<%
				if (pageNum > 10) {
				%>
					<a href="list.jsp?page=<%=pageNum - 10%>">이전-10</a>
				<%
				}
				if (pageNum !=1) {
				%>
					<a href="list.jsp?page=<%=pageNum - 1%>">이전</a>
				<%
				}
					// 페이지 링크 반복문

					sql = "select*from testboard order by id desc";
					rs = stmt.executeQuery(sql);

					// * 총 레코드 수 구하기
					rs.last(); // 마지막 레코드로 이동
					int totalRec = rs.getRow(); // 현재 레코드의 행을 리턴 ( 1 ~ )

					// * 총 레코드 수 구하기 (다른 방법)
					// sql = "select count(id) as cnt from board"; // id 레코드의 개수 조회 (필드명 : cnt)
					// rs = stmt.executeQuery(sql);
					// rs.next();
					// int total_record = rs.getInt("cnt");

					// * 총 페이지 수 구하기
					int totalPage = totalRec / 10;

					if (totalRec % 10 != 0) {
						totalPage = totalPage + 1;
					}

					// * 페이지 링크 반복문에 필요한 시작값 (p) 생성하기
					// pageNum : 사용자가 선택한 페이지
					// 01 (p) ~ 10 (p+9)
					// 11 (p) ~ 20 (p+9)
					// 21 (p) ~ 30 (p+9)
					// p 는 10자리수만 바뀌고 끝자리 수는 항상 1
					
					// p 변수선언값 : p의 10자리수
					int p = (int) pageNum / 10;

					// pageNum = 10, 20, 30,.. 일 때 p++ 되므로 (10의 자리수가 바뀌므로),  p-- 해준다
					if (pageNum % 10 == 0) {
						p = p - 1;
					}

					// p 재선언 : p1 (01, 11, 21,..)
					p = Integer.parseInt(p + "1");
					
					// * 페이지 링크의 마지막값 (pend) 생성하기
					int pend = p + 9;
					if (pend > totalPage) {
						pend = totalPage;
					}

					// * 페이지 링크 반복문
					for (int i = p; i <= pend; i++) {
						
						// * 현재 페이지의 폰트색을 red 설정하기
						
						if (i != pageNum) {
				%>
							<a href="list.jsp?page=<%=i%>" id="pageLink"><%=i%></a> 
				<%
 						} else {
 				%>
 							<a href="list.jsp?page=<%=i%>" id="pageLink" style="color: red"><%=i%></a>
 				<%
 						}
					}
						
						// * 다음 페이지링크 불러오기
						
						// 뭐야 이거
						
						if (pageNum != totalPage) {
 				%>
 							<a href="list.jsp?page=<%=pageNum + 1%>">다음</a>
 				<%
						}
					
						// * 현재 페이지가 링크 반복문의 마지막 차례가 아니라면
						
						if (pageNum <= totalPage - 10) {
 				%>
 							<a href="list.jsp?page=<%=pageNum + 10%>">다음+10</a>
 				<%
						}
						
						// * 마지막 링크 반복분으로 바로 이동하기
 				%>					
						<a href="list.jsp?page=<%=totalPage%>">마지막</a>
						
						<!-- select 로 페이지 이동하기 -->
						<select name="movePage" id="movePage" onchange="movePage()">
							<%
							for (int i=1; i<=totalPage; i ++) {
								String sel = "";
								if (i == pageNum) {
									sel = "selected";
								}
								else {
									sel = "";
								}
							%>
								<option value="<%=i%>" <%=sel%>><%=i%></option>
							<%
							}
							%>
						</select>
			</td>
		</tr>
	</table>
	
</body>
</html>

<%
	conn.close();
	stmt.close();
%>