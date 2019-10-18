<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	String sql = "select*from address where email='" + session.getAttribute("email") + "'";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		width: 800px;
		margin: auto;
		border: 1px solid #495164;
		border-radius: 5px;
	}
	
	#button_box {
		width: 800px;
		margin: auto;
		padding-top: 20px;
	}
	
	table caption {
		padding-top: 30px;
		padding-bottom: 30px;
		font-size: 14px;
		font-weight: bold;
		letter-spacing: 5px;
		color: #495164;
	}
	
	table td {
		font-size: 13px;
		padding: 10px;
		text-align: center;
	}
	
	#field td {
		font-weight: bold;
	}
	
	/* 버튼 구간 */
	
	input[type=button] {
		border: 1px solid #495164;
		border-radius: 5px;
		background: #495164;
		color: white;
		font-size: 12px;
		font-weight: bold;
		width: 50px;
		height: 25px;
		cursor: pointer;	
	}
	
	#button_box input[type=submit] {
		border: 1px solid #495164;
		border-radius: 5px;
		background: #495164;
		color: white;
		font-size: 12px;
		font-weight: bold;
		width: 150px;
		height: 30px;
		cursor: pointer;
	}
	
	#button_box input[type=button] {
		border: 1px solid #E9923C;
		border-radius: 5px;
		background: #E9923C;
		color: white;
		font-size: 12px;
		font-weight: bold;
		width: 100px;
		height: 30px;
		cursor: pointer;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function AddressApply(xx, id, zip, address1, address2) {
		// 부모창의 폼에 값 전달
		opener.document.getElementById("zip").value = zip;
		opener.document.getElementById("address1").value = address1;
		opener.document.getElementById("address2").value = address2;
		alert("적용되었습니다 !");
		
		// 현재창에서 기본 배송지 표시
		// 모든 버튼 스타일 초기화
		$(".apply").css("background-color", "#495164");
		$(".apply").css("color", "white");
		$(".apply").val("적용");
		// 선택한 버튼 스타일 부여 / 왜 안될까 ? ㅠ ... 슬프다
		xx.style.backgroundColor = "#FFFFE0";
		xx.style.color = "#495164";
		xx.value = "V";
		
		// DB isdefault 값변경
		location = "address_apply.jsp?id=" + id;
	}
	
	function AddressAdd() {
		location = "address_add.jsp";
	}
	
	function Close() {
		close();
	}
</script>
</head>
<body>
	<form action="address_del.jsp" method="post" name="form">
		<table>
			<caption>MY ADDRESS</caption>
			<tr id="field">
				<td><input type="checkbox" name="delete_controller"></td>
				<td>배송지</td>
				<td>수령인</td>
				<td>주소</td>
				<td>휴대전화</td>
				<td>적용</td>
			</tr>
			<%
				while (rs.next()) {
			%>
			<tr>
				<td><input type="checkbox" name="id" value="<%=rs.getString("id")%>"></td>
				<td><%=rs.getString("destination")%></td>
				<td><%=rs.getString("recipient")%></td>
				<td>(<%=rs.getString("zip")%>) <%=rs.getString("address1")%> <%=rs.getString("address2")%></td>
				<td><%=rs.getString("cell")%></td>
				<td><input type="button" value="적용" class="apply" onclick="AddressApply(this, <%=rs.getInt("id")%>,'<%=rs.getString("zip")%>', '<%=rs.getString("address1")%>', '<%=rs.getString("address2")%>')"></td>
			</tr>
			<%
				}
			%>
		</table>
		<div id="button_box">
			<input type="submit" value="선택한 배송지 삭제">
			<input type="button" value="배송지 추가" onclick="AddressAdd()">
			<input type="button" value="나가기" onclick="Close()">
		</div>
	</form>
</body>
</html>