<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	
	String sql = "select*from recipient where email='" + email + "'";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
		width: 100%;
	}
	table {
		width: 1100px;
		margin: auto;
		border-collapse: collapse;
	}
	
	table caption {
		padding-top: 20px;
		padding-bottom: 20px;
		font-weight: bold;
	}
	
	table td {
		border: 1px solid #495164;
		text-align: center;
		vertical-align: center;
		padding-top: 7px;
		padding-bottom: 7px;
	}
	
	
	table #field td {
		font-size: 12px;
		font-weight: bold;
	}
</style>
<script src="..Etc/product_buynow_recipient.js"></script>
</head>
<body>
	<table>
		<caption>배송지 즐겨찾기 목록</caption>
		<tr id="field">
			<td><input type="checkbox"></td>
			<td>배송지명</td>
			<td>수령인</td>
			<td>휴대전화</td>
			<td>주소</td>
			<td>등록일</td>
			<td>관리</td>
			<td>주소록 고정</td>
		</tr>
		<%
		while (rs.next()) {
		%>
		<tr>
			<td><input type="checkbox" class="desti"></td>
			<td><%=rs.getString("destination")%></td>
			<td><%=rs.getString("recipient")%></td>
			<td><%=rs.getString("cell")%></td>
			<td>(<%=rs.getInt("zip")%>) <%=rs.getString("address1")%> <%=rs.getString("address2")%></td>
			<td><%=rs.getString("writeday")%></td>
			<td>
				<input type="button" value="적용" onclick="Opener('<%=rs.getString("recipient")%>', '<%=rs.getString("cell")%>', <%=rs.getInt("zip")%>, '<%=rs.getString("address1")%>', '<%=rs.getString("address2")%>')"> <p></p>
				<input type="button" value="삭제">
			</td>
			<td>-</td>
		</tr>
		<%
		}
		%>
	</table>

</body>
</html>