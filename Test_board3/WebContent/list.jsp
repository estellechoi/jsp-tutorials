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
	int pageNum = 0;

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
					rs.next();
					int id = Integer.parseInt(rs.getString("id"));
					
					int p = pageNum / 10;
					
					if(pageNum%10 == 0) {
						p = p - 1; // pageNum = 10 일 때 p++ 되므로,  p-- 해준다.
					}
					p = Integer.parseInt(p + "1");
					for(int i = p; i <= p + 9; i++) {
				%>
						<a href="list.jsp?page=<%=i%>" id="pageLink"><%=i%></a> 
				<%
					}
				%>
					<a href="">다음</a>
			</td>
		</tr>
	</table>
</body>
</html>

<%
	conn.close();
	stmt.close();
%>