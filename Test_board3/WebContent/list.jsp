<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
// to do
// 게시글 직접 검색하기 기능 - 검색어 입력 후 다음 페이지 링크를 누르면 검색필터가 사라지는 문제
// content.jsp에서 목록 버튼 눌렀을 때, 이전에 보던 목록 그대로 보여주기 기능을 추가해야 함
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
		// get method 변수 : page (임의설정)
	} else {
		pageNum = Integer.parseInt(request.getParameter("page"));
		index = (pageNum - 1) * 10; // 데이터 조회 인덱스
	}
	
	
	// * 게시글 검색하기
	// limit n : 상위 n개 데이터만 조회
	// limit index, n : index(0 ~) 부터 n개 데이터만 조회
	
	String sField = request.getParameter("sField");
	String sWord = request.getParameter("sWord");
	String sql;
	if (sField == null) {
		sql = "select*from testboard order by id desc limit " + index + ", 10";
		// * 검색창에 null 값을 표시하지 않기 위한 조치
		sField = "";
		sWord = "";
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
	// * 검색창 선택값 보여주기
	 function showSelected() {
		 <%
		 	// selected field, page 보여주기 (*사용자의 field 선택값이 있을 때만)
		 	if( sField != "") {
		 %>
		 		document.getElementById("sField").value = <%=sField%>;
		 		document.getElementById("movePage").selectedIndex = <%=pageNum-1%>;
		 <%
		 	}
		 %>
	 }
	 
	 // * <select> 태그로 페이지 이동하기
	 function movePage(sel) {
		 // * sel = this.value; (this == selected)
		 location = "list.jsp?page="+sel+"&sField=<%=sField%>&sWord=<%=sWord%>";
	 }
	 
	 // * 페이지 이동 <select> 값을 현재 페이지에 맞게 보여주기
	 // ☆ showSelected() 와 따로 함수를 만든 이유는 ?
	 function showInitialSelected() {
		 document.getElementById("movePage").value = <%=pageNum%>;
<%-- 	document.getElementById("movePage").selectedIndex = <%pageNum-1%>; --%>
	 }
	 
	 showInitialSelected(); // ☆onload 호출과 뭐가 다르지 ?
	 
</script>

</head>
<body onload="showSelected()">
	<table>
		<caption>게시판</caption>
		<caption>
			<a href="write.jsp">글쓰기</a> <a href="forceInput.jsp">강제 데이터 입력</a>
		</caption>
		<caption>
			<!-- Search Box -->
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
			<td><a href="readnum.jsp?id=<%=rs.getString("id")%>&page=<%=pageNum%>"><%=rs.getString("title")%></a></td>
			<td><%=rs.getString("user")%></td>
			<td><%=rs.getString("writeday")%></td>
			<td><%=rs.getInt("readnum")%></td>
		</tr>

		<%
			}
		%>

		<!-- 페이지 이동 링크 시작 -->
		<tr>
			<td colspan="5">
				<a href="list.jsp?page=1&sField=<%=sField%>&sWord=<%=sWord%>">◀◀</a>
				<%
				if (pageNum > 10) {
				%>
					<a href="list.jsp?page=<%=pageNum - 10%>&sField=<%=sField%>&sWord=<%=sWord%>">◀-10</a>
				<%
				}
				if (pageNum !=1) {
				%>
					<a href="list.jsp?page=<%=pageNum - 1%>&sField=<%=sField%>&sWord=<%=sWord%>">◀</a>
				<%
				}
					// 페이지 링크 반복문 시작

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
					// * 현재 페이지의 폰트색을 red 설정하기
					String pageLinkColor = "";
					
					for (int i = p; i <= pend; i++) {
						
						if (i != pageNum) {
							pageLinkColor = "style='color:red'";
						} else {
							pageLinkColor = "";
						}
						
						// sField, sWord 값 carry -> 여기서 왜 ?
 				%>
 						<a href="list.jsp?page=<%=i%>&sField=<%=sField%>&sWord=<%=sWord%>" id="pageLink" <%=pageLinkColor%>><%=i%></a>
 				<%	
					}
						
						// * 다음페이지 링크 불러오기
						// * 현재페이지가 마지막페이지인 경우 다음페이지 링크 비활성화
						
						if (pageNum != totalPage) {
 				%>
 							<a href="list.jsp?page=<%=pageNum + 1%>&sField=<%=sField%>&sWord=<%=sWord%>">▶</a>
 				<%
						} else {			
				%>
							▶
				<%
						}
					
						// * 현재페이지가 마지막 링크반복 구역인 경우 다음구역 링크 비활성화
						// ? if ( 여기 이해가 안댐 ) ?
						
						if (pageNum <= totalPage - 10) {
 				%>
 							<a href="list.jsp?page=<%=pageNum + 10%>&sField=<%=sField%>&sWord=<%=sWord%>">▶+10</a>
 				<%
						} else {
				%>
							▶+10
				<%
						}
						
						// * 마지막 링크 반복분으로 바로 이동하기
 				%>					
						<a href="list.jsp?page=<%=totalPage%>&sField=<%=sField%>&sWord=<%=sWord%>">▶▶</a>

						<!-- select 로 페이지 이동하기 -->
						<select name="movePage" id="movePage" onchange="movePage(this.value)">
							<%
							for (int i=1; i<=totalPage; i ++) {
								
								// * <option> 속성을 이용해서 선택된 값 보여주기
// 								String sel = ""; 
// 								if (i == pageNum) {
// 									sel = "selected";
// 								}
// 								else {
// 									sel = "";
// 								}
							%>
								<option value="<%=i%>"><%=i%> page</option>
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
	rs.close();
	conn.close();
	stmt.close();
%>