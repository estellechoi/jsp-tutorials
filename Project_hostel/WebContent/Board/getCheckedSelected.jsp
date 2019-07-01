<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function getCheck() {
		// index 번호에 rs.getInt()
		// checked : true/false
		document.getElementsByName("sex")[0].checked = "true";
	}
	function getSel() {
		// y 대신 rs.getInt("year")
		// selectedIndex : 0 ~ 
		var y = 2017;
		var n = 2020 - y;
		document.getElementById("year").selectedIndex = n;
	}
	function getCheckbox() {
		// rs.getString("hobby")
		var h = "2,4,6,";
		var hobbyArr = h.split(",");
		// hobbyArr.length = 4
		for (var i = 0; i < hobbyArr.length-1; i++) {
			document.getElementsByName("hobby")[hobbyArr[i]].checked = "true";
		}
	}
</script>
</head>
<body onload="getCheck(), getSel(), getCheckbox()">
	<form action="" name="form">
		성별 : <input type="radio" name="sex" value="남"> 남 <input
			type="radio" name="sex" value="여"> 여
		<p></p>
		연도 선택 : <select name="year" id="year">
			<option value="">선택하기</option>
			<%
				for (int i = 2019; i >= 1950; i--) {
			%>
			<option value="<%=i%>"><%=i%></option>
			<%
				}
			%>
		</select>
		<p></p>
		취미 : <input type="checkbox" name="hobby"> 여행 <input
			type="checkbox" name="hobby"> 독서 <input type="checkbox"
			name="hobby"> 그림 <input type="checkbox" name="hobby">
		노래 <input type="checkbox" name="hobby"> 요리 <input
			type="checkbox" name="hobby"> 명상 <input type="checkbox"
			name="hobby"> 영화
	</form>

</body>
</html>