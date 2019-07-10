<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String room = request.getParameter("room");
	String yy = request.getParameter("yy");
	String mm = request.getParameter("mm");
	String dd = request.getParameter("dd");
	if (mm.length() == 1) {
		mm = "0" + mm;
	}
	if (dd.length()== 1) {
		dd = "0" + dd;
	}
	String date = yy + "-" + mm + "-" + dd + "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section>
		<table>
			<tr>
				<td>선택한 방</td>
				<td><%=room%></td>
			</tr>
			<tr>
				<td>예약자</td>
				<td><input type="text" name="userid"></td>
			</tr>
			<tr>
				<td>체크인</td>
				<td><%=date%></td>
			</tr>
			<tr>
				<td>숙박일</td>
				<td>
					<select name="nights" id="nights">
						<option value="1">1박2일</option>
						<option value="2">2박3일</option>
						<option value="3">3박4일</option>
						<option value="4">4박5일</option>
					</select>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
			</tr>
		</table>
	</section>

</body>
</html>