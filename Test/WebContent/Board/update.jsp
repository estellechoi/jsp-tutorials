<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.Command.Update"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.Dto.Board_dto"%>
<%
	String id = request.getParameter("id");

	// board.Command.Update 객체 생성
	Update up = new Update();
	
	// ArrayList 객체에 리턴값을 담자
	ArrayList<Board_dto> Ali = up.update(id);
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
		text-align: left;
		vertical-align: center;
		padding-top: 20px;
		padding-bottom: 20px;
		padding-left: 10px;
	}
	#input_title {
		font-size: 15px;
		font-weight: bold;
		border: none;
		color: #FF00FF;
	}
	
	input:focus {
		outline: none;
	}
	
	textarea {
		color: #FF00FF;	
	}
	
</style>
<script>
	function Open_status() {
		var open = <%=Ali.get(0).getOpen()%>;
		for (var i =0; i<2; i++) {
			if (open == i) {
				document.getElementsByName("open")[i].checked = true;
			}
		}
	}
</script>
</head>
<body onload="Open_status()">
	<form action="update_ok.jsp?id=<%=id%>" method="post">
		<table>
			<caption><input type="text" name="title" id="input_title" value="<%=Ali.get(0).getTitle()%>"></caption>
			<tr>
				<td>작성자</td>
				<td><%=Ali.get(0).getName()%></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=Ali.get(0).getWriteday()%></td>
			</tr>
			<tr>
				<td>조회수</td>
				<td><%=Ali.get(0).getReadnum()%></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content" id="" cols="40" rows="3"><%=Ali.get(0).getContent()%></textarea></td>
			</tr>
			<tr>
				<td>공개여부</td>
				<td>
					<input type="radio" name="open" value="0">공개
					<input type="radio" name="open" value="1">비공개
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="content.jsp?id=<%=id%>">이전 페이지</a>
					<a href="list.jsp">목록</a>		
				</td>
			</tr>
		</table>
	</form>
</body>
</html>