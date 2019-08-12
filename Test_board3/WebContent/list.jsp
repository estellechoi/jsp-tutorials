<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	// select*from testboard limit index, n; (index 부터 n 개)
	int index;
	int pageNum = 1;

	// 사용자가 페이지 선택하기 전 → 초기값 : index = 0
	if (request.getParameter("page") == null) {
		index = 0;

		// 1 페이지10 개씩
		// 사용자가 선택값을 담는 변수 : page (임의설정)
	} else {
		pageNum = Integer.parseInt(request.getParameter("page"));
		index = (pageNum - 1) * 10;
	}
	// pageNum = 1 왜 안쓴다고 ?

	// limit n : 상위 n개 데이터만 조회
	// limit index, n : index(0 ~) 부터 n개 데이터만 조회
	String sql = "select*from testboard order by id desc limit " + index
			+ ", 10";
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
</head>
<body>
	<table>
		<caption>게시판</caption>
		<caption>
			<a href="write.jsp">글쓰기</a> <a href="forceInput.jsp">강제 데이터 입력</a>
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
				<%
					// 페이지 링크

					sql = "select*from testboard order by id desc";
					rs = stmt.executeQuery(sql);

					// * 총 레코드 수 구하기
					rs.last(); // 마지막 레코드로 이동
					int totalRec = rs.getRow(); // 현재 레코드의 행을 리턴 ( 1 ~ )

					// * 안토니가 알려준 방법 (총 레코드 수 구하기)
					// sql = "select count(id) as cnt from board"; // id 레코드의 개수 조회 (필드명 : cnt)
					// rs = stmt.executeQuery(sql);
					// rs.next();
					// int total_record = rs.getInt("cnt");

					// * 총 페이지 수 구하기
					int totalPage = totalRec / 10;

					if (totalRec % 10 != 0) {
						totalPage = totalPage + 1;
					}

					// * 페이지 링크에 필요한 시작값 (p) 생성하기
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

					// * 페이지 링크
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
						
						// * 다음 페이지링크 불러오기
						
						if (pageNum != totalPage) {
 				%>
 							<a href="">다음</a>
 				<%
						}
 				%>
 					
			</td>
		</tr>
	</table>
</body>
</html>

<%
	conn.close();
	stmt.close();
%>