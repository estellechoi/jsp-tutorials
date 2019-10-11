<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.Command.List"%>
<%@ page import="board.Dto.Board_dto"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		 width: 800px;
		 margin: auto;
		 border-collapse: collapse;
	}
	
	td {
		border: 1px solid #0A246A;
		text-align: center;
		font-size: 13px;
		height: 40px;
	}
	
	caption {
		font-size: 13px;
		font-weight: bold;
		text-align: right;
		vertical-align: center;
		padding-top: 20px;
		padding-bottom: 20px;
		padding-right: 10px;	
	}
</style>
</head>
<body>
	<%
		// board.Command.List 클래스 사용을 위해 객체 생성
		List li = new List();

		// list() 리턴 메소드의 반환값을 Ali 객체에 담자
		ArrayList<Board_dto> Ali = li.list();
	%>
	<table>
		<caption>
			<a href="write.jsp">글쓰기</a>
		</caption>
		<tr>
			<td>순</td>
			<td>이름</td>
			<td>제목</td>
			<td>조회수</td>
			<td>작성일</td>
		</tr>
		<%
			// 레코드 값을 담은 ArrayList의 크기 (= 레코드의 개수) 만큼 반복
			for (int i = 0; i < Ali.size(); i++) {
				
			// * ArrayList 각 요소 호출 메소드 : get(index)
			// * 여기에서 Ali의 요소들은 rs 값들을 담은 Board_dto 객체이다 !
			// * Board_dto 클래스의 getters 값 호출
			// 즉, Ali.get(i).getId() == dto.getId()
		%>
		<tr>
			<td><%=Ali.get(i).getId()%></td>
			<td><%=Ali.get(i).getName()%></td>
			<td><a href="content.jsp?id=<%=Ali.get(i).getId()%>"><%=Ali.get(i).getTitle()%></a></td>
			<td><%=Ali.get(i).getReadnum()%></td>
			<td><%=Ali.get(i).getWriteday()%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>