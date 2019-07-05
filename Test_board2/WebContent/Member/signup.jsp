<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/signup.css">
<script>
	function check() {
		var sex = 0;
		for (var i = 0; i < 2; i++) {
			if (document.getElementsByName("sex")[i].checked) {
				sex = 1;
			}
		}
		var icon = "<img src='../Image/alert.png' alt='이미지' width='25'>";
		
		if (document.sign.userid.value == "") {
			document.querySelectorAll(".xx")[0].innerHTML = icon;
			return false;
		}
		else if (document.sign.userid.value.length > 10) {
			document.querySelectorAll(".xx")[0].innerHTML = icon;
			return false;
		}
		else if (document.sign.password.value == "") {
			document.querySelectorAll(".xx")[1].innerHTML = icon;
			return false;
		}
		else if (document.sign.password.value != document.sign.passwordCon.value) {
			document.querySelectorAll(".xx")[2].innerHTML = icon;
			return false;
		}
		else if (document.sign.name.value == ""){
			document.querySelectorAll(".xx")[3].innerHTML = icon;
			return false;
		}
		else if (document.sign.email.value.indexOf("@") <= 0) {
			document.querySelectorAll(".xx")[4].innerHTML = icon;
			return false;
		}
		else if (sex == 0) {
			document.querySelectorAll(".xx")[5].innerHTML = icon;
			return false;
		}
		else if (document.sign.birthYear.value == "생일연도") {
			document.querySelectorAll(".xx")[6].innerHTML = icon;
			return false;
		}
		else if (document.sign.birthMonth.value == "생일월") {
			document.querySelectorAll(".xx")[6].innerHTML = icon;
			return false;
		}
		else if (document.sign.birthDate.value == "생일일자") {
			document.querySelectorAll(".xx")[6].innerHTML = icon;
			return false;
		}
		else {
			return true;
		}
	}
 </script>
</head>
<body>
<%@ include file="../Common/header.jsp" %>
<section>
	<form name="sign" action="../Member/signup_ok.jsp" method="post" onsubmit="return check()">
		<table>
			<caption>회원가입</caption>
			<tr>
				<td>
					<input type="text" name="userid" placeholder="아이디">
				</td>
				<td class="xx">
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="password" placeholder="비밀번호">
				</td>
				<td class="xx">
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="passwordCon" placeholder="비밀번호 확인">
				</td>
				<td class="xx">
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="name" placeholder="이름">
				</td>
				<td class="xx">
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="email" placeholder="Email">
				</td>
				<td class="xx">
				</td>
			</tr>
			<tr>
				<td>
					<input type="radio" name="sex" value="0">남
					<input type="radio" name="sex" value="1">여
				</td>
				<td class="xx">
				</td>
			</tr>
			<tr>
				<td>
				<select name="birthYear" id="birthYear">
					<option value="생일연도">생일연도</option>
					<%
					for(int i=2019; i>=1900; i--) {
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
					}
					%>
				</select>
				<select name="birthMonth" id="birthMonth">
					<option value="생일월">생일월</option>
					<%
					for(int i=1; i<=12; i++) {
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
					}
					%>
				</select>
				<select name="birthDate" id="birthDate">
					<option value="생일일자">생일</option>
					<%
					for(int i=1; i<=31; i++) {
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
					}
					%>
				</select>
				</td>
				<td class="xx">
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="가입하기"></td>
			</tr>
		</table>
	</form>
</section>
</body>
</html>