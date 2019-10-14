<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	
	String sql = "select*from address where email='" + email + "'";
	ResultSet rs = stmt.executeQuery(sql);
	
	// rs 레코드의 개수
	rs.last();
	int n = rs.getRow();
	rs.beforeFirst(); // 제일 위로 (첫번째 레코드 이전 빈공간)
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
	table, #grid-container {
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
		font-size: 11px;
	}
	
	table td input[type=button] {
		border: 1px solid #495164;
		border-radius: 5px;
		font-size: 11px;
		font-weight: bold;
		background: none;
		cursor: pointer;
	}
	
	table #field td {
		font-weight: bold;
		background: #eeeeee;
	}
	
	#grid-container {
		padding-top: 30px;
		padding-bottom: 50px;
		display: grid;
		grid-template-columns: 1fr 1fr;
	}
	
	#grid-right {
		text-align: right;
	}
	
	#grid-left input[type=button],[type=submit] {
		border: 1px solid #495164;
		border-radius: 5px;
		background: #495164;
		color: white;
		font-size: 12px;
		width: 120px;
		height: 30px;
		cursor: pointer;
	}
	
	#grid-right input[type=button] {
		border: 1px solid #B5B5B5;
		border-radius: 5px;
		background: #B5B5B5;
		color: white;
		font-size: 12px;
		width: 120px;
		height: 30px;
		cursor: pointer;
	}
</style>
<script src="../Etc/product_buynow_address.js?ver=2"></script>
</head>
<body>
	<form action="product_buynow_address_del.jsp" method="post">
		<input type="hidden" name="email" value="<%=email%>">
		<table>
			<caption>배송지 주소록</caption>
			<tr id="field">
				<td><input type="checkbox" id="checkbox_master" onclick="Check_all(this, <%=n%>)"></td>
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
				<td><input type="checkbox" class="desti" name="check" value="<%=rs.getString("id")%>" onclick="Check_Master(<%=n%>)"></td>
				<td><%=rs.getString("destination")%></td>
				<td><%=rs.getString("recipient")%></td>
				<td><%=rs.getString("cell")%></td>
				<td>(<%=rs.getInt("zip")%>) <%=rs.getString("address1")%> <%=rs.getString("address2")%></td>
				<td><%=rs.getString("writeday")%></td>
				<td>
					<input type="button" class="apply" value="적용" onclick="Opener(this, <%=n%>, <%=rs.getInt("id")%>,'<%=rs.getString("recipient")%>', '<%=rs.getString("cell")%>', <%=rs.getInt("zip")%>, '<%=rs.getString("address1")%>', '<%=rs.getString("address2")%>')">
				</td>
				<td>-</td>
			</tr>
			<%
			}
			%>
		</table>
		<div id="grid-container">
			<div id="grid-left">
				<input type="submit" value="선택 배송지 삭제">
				<input type="button" value="배송지 등록" onclick="Add('<%=email%>')">
			</div>
			<div id="grid-right">
				<input type="button" value="완료" onclick="Close()">
			</div>
		</div>
	</form>

</body>
</html>