<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- onchange="" 이벤트 사용하기 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function selView()
	{
		alert(document.pkc.food.value);
	}
	function moveSite() {
		location = document.form.site.value;
	}
	function check() {
		var ch = 3;
// 		document.form.food.selectedIndex = ch;
		document.form.food.value = ch;
	}
</script>
</head>
<body onload="check()">
	<form action="" name="form">
		<select name="food" id="food" onchange="selView()">
			<option value="0">선택</option>
			<option value="1">짜장면</option>
			<option value="2">우동</option>
			<option value="3">라조기</option>
		</select>
		<!--
		<input type="button" onclick="selView()" value="확인">
		-->
		<select name="site" id="site" onchange="moveSite()">
		<option value="">family sites</option>
			<option value="http://www.naver.com">네이버</option>
			<option value="">네이버</option>
			<option value="">네이버</option>
			<option value="">네이버</option>
		</select>
	</form>
</body>
</html>