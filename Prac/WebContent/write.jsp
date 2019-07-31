<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	margin: auto;
	width: 600px;
	border: 1px solid grey;
	border-collapse: collapse;
}

tr, td {
	height: 40px;
	border: 1px solid grey;
	padding-left: 10px;
	padding-right: 10px;
}

input[type=submit] {
	border: 2px solid pink;
	border-radius: 5px;
	text-align: center; /* 안먹네 */
}
</style>
<script>
	function moveInput() {
		if (document.getElementById("birth").value.length == 6) {
			document.getElementById("sex").focus();
		}
	}
</script>
</head>
<body>
	<form action="tutorial_signup_form_ok.jsp" method="post">
		<table>
			<caption>양식 보내기</caption>
			<tr>
				<td>이름</td>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>생년</td>
				<td><input type="text" name="birth" id="birth"
					onkeyup="moveInput()"> - <input type="text" name="sex"
					id="sex" maxlength="1"></td>
			</tr>
			<tr>
				<td>흡연</td>
				<td>비흡연<input type="radio" name="smoker" value="비흡연">
					흡연 <input type="radio" name="smoker" value="흡연"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><select name="address" id="address">
						<option value="서울시">서울시</option>
						<option value="경기도">경기도</option>
						<option value="강원도">강원도</option>
						<option value="충청도">충청도</option>
						<option value="전라도">전라도</option>
						<option value="경상도">경상도</option>
						<option value="제주도">제주도</option>
						<option value="해외">해외</option>
				</select></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="저장"></td>
			</tr>
		</table>
	</form>

</body>
</html>