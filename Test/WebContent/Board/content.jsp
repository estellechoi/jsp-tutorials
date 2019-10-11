<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.Command.Content"%>
<%@ page import="board.Dto.Board_dto"%>
<%@ page import="java.util.ArrayList"%>
<%
	// 사용자 선택 값 (파라미터)
	request.setCharacterEncoding("UTF-8");
	int id = Integer.parseInt(request.getParameter("id"));

	// board.Command.Content 클래스 사용을 위해 객체 생성
	Content c = new Content();

	// Content 클래스 content(int id) 메소드 실행
	ArrayList<Board_dto> Ali = c.content(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		 width: 600px;
		 margin: auto;
		 border-collapse: collapse;
	}
	
	table td {
		border: 1px solid #0A246A;
		text-align: center;
		vertical-align: center;
		font-size: 13px;
		height: 40px;
	}
	
	caption {
		font-size: 15px;
		font-weight: bold;
		text-align: left;
		vertical-align: center;
		padding-top: 20px;
		padding-bottom: 20px;
		padding-left: 10px;
	}
</style>
<script>
	function Open_status() {
		var open = <%=Ali.get(0).getOpen()%>;
		for (var i = 0; i < 2; i++) {
			if (open == i) {
				document.getElementsByName("open")[i].checked = true;
			}
		}
	}
</script>
</head>
<body onload="Open_status()">
	<table>
		<caption><%=Ali.get(0).getTitle()%></caption>
		<tr>
			<td>작성자</td>
			<td><%=Ali.get(0).getName()%></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%=Ali.get(0).getTitle()%></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><%=Ali.get(0).getReadnum()%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=Ali.get(0).getContent()%></td>
		</tr>
		<tr>
			<td>공개여부</td>
			<td>
				<input type="radio" name="open" value="0" disabled>공개
				<input type="radio" name="open" value="1" disabled>비공개
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<a href="update.jsp?id=<%=id%>">수정</a>
				<a href="delete.jsp?id=<%=id%>">삭제</a>
				<a href="list.jsp">목록</a>
			</td>
		</tr>
	</table>
</body>
</html>