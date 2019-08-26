<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	String id = request.getParameter("id");
	sql = "select*from announce where id=" + id;
	rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/writeStructure.css?ver=1">
<link rel="stylesheet" href="../Image/categoriesStyle.css">
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article id="grid-container">
		<%@ include file="../Board/board_structure.jsp"%>
		<div>
			<table id="announceContentTable">
				<caption>공지사항</caption>
				<caption>
					<%
						if (session.getAttribute("userid") != null) {
							if (session.getAttribute("userid").equals("admin")) {
					%>
					<a href="../Board/announce_delete.jsp?id=<%=rs.getInt("id")%>">삭제</a>
					<a href="">수정</a>
					<%
							}
						}
					%>
					<a href="../Board/announce_list.jsp">목록</a>
				</caption>
				<tr id="fields">
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
				</tr>
				<tr class="contentInfo">
					<td><%=rs.getString("title")%></td>
					<td><%=rs.getString("userid")%></td>
					<td><%=rs.getString("writeday")%></td>
				</tr>
				<tr id="fields">
					<td colspan="3">내용</td>
				</tr>
				<tr id="content">
					<td colspan="3"><%=rs.getString("content")%></td>
				</tr>
			</table>
			<table id="replyContentTable">
			<!-- 댓글 출력창 -->
			<%
			sql = "select*from announce_reply where rid=" + id;
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				String content = rs.getString("content");
				String name = rs.getString("name");
				String rid = rs.getString("rid"); // 수정/삭제 후 페이지 복귀를 위해 필요
				String id_reply = rs.getString("id");
			%>
				<tr class="showReplies">
					<td>
						<%=content%>
						<!-- 댓글 수정/삭제 버튼 -->
						<a href="javascript:replyUpdate('<%=content%>', '<%=name%>', '<%=id_reply%>')" onclick="replyUpdate()">ⓡ</a>
						<a href="javascript:replyDel(<%=id_reply%>)">ⓧ</a>
					</td>
					<td><%=name%></td>
					<td><%=rs.getString("writeday")%></td>
				</tr>
			<%
			}
			%>

			<script>
			// * 댓글 수정창 스크립트
				function replyUpdate(content, name, id_reply) {
					document.replyWriteForm.name.value = name;
					document.replyWriteForm.content.value = content;
					// rid에 게시글의 id 아닌, 댓글 고유의 id 값을 넣어준다 .여기서만 임시로 ??
					// 댓글 등록(id 없는 경우) 때와 같은 form 공유하기 위해 .. ?
					document.replyWriteForm.rid.value = id_reply;
					
					// * 댓글 입력 버튼을 수정 버튼으로 바꿔주기 (post 방식 유지)
					document.replyWriteForm.action = "announce_reply_update_ok.jsp";
					document.replyWriteForm.sub.value= "수정";
				}
			
			// * 댓글 삭제창 스크립트 (AJAX)
			// * AJAX (비동기방식)으로 서버에 접근 및 동작
				var xml = new XMLHttpRequest();
				function replyDel(id_reply) {
					xml.open("get", "announce_reply_del_ok.jsp?id_reply="+id_reply);
					xml.send();					
				}
				xml.onreadystatechange = function() {
					if(xml.readyState == 4) {
						if(xml.responseText.trim() == "ok") {
							location.reload(); // 페이지 새로고침
						}
					}
				}
			</script>
			
			<!-- 댓글 입력창 -->	
			<%
			if (session.getAttribute("userid") != null) {
			%>
				<form action="announce_reply_ok.jsp" method="post" name="replyWriteForm">			
					<tr class = "inputReplies">
						<input type="hidden" name="rid" value="<%=id%>">
						<input type="hidden" name="userid" value="<%=session.getAttribute("userid")%>">
						<!-- textarea size 최대 cols=40, rows=5 -->
						<td><textarea name="content" id="content" cols="40" rows="1" placeholder="댓글 입력"></textarea></td>
						<td><input type="text" name="name" value="<%=session.getAttribute("name")%>" readonly></td>
						<td><input type="submit" name="sub" value="댓글달기"></td>
					</tr>
				</form>
			<%
			} else {
			%>
			<tr>
				<td colspan="3">댓글을 입력하려면 로그인 하세요 ♥</td>
			</tr>
			<%
			}
			%>
			</table>
		</div>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>