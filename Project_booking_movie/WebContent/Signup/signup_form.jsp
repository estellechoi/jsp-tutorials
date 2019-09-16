<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#welcomeBar {
	height: 100px;
	background: #222222;
}
#titleBar {
	height: 130px;
	text-align: center;
	color: #333333;
	font-size: 15px;
}
#formBox {
	margin: auto;
	width: 1000px;
	height: 300px;
	border: 1px solid #333333;
	border-radius: 10px;
	display: flex;
}

#formBox #noticeBox, #form {
	margin: auto;
	width: 400px;
	text-align: center;
	font-size: 13px;
}

#formBox #form table {
	width: 400px;
	height: 200px;
}

#formBox #form td {
	text-align: center;
	vertical-align: center;
}

#formBox #form input {
	width: 400px;
}

#formBox #form input[type=submit] {
	border: 0px solid #333333;
	border-radius: 10px;
	color: white;
	font-size: 15px;
	background: #333333;
	height: 50px;
}
</style>
<script>
 function check() {
	 if(document.form.name.value == "" || document.form.birth.value == "" || document.form.cell.value == "") {
		 alert("양식을 올바르게 입력해주세요.");
		 return false;
	 }
	 else {
		 return true;
	 }
 }
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<div id="welcomeBar"></div>
		<div id="titleBar">
			<h1>통합회원 가입</h1>
			통합 아이디로 브랜드 혜택도 받고 ! 포인트도 쌓고 !
		</div>
		<div id="formBox">
			<div id="noticeBox">
				<h3>회원가입 여부 안내</h3>
				<ul>
					<li>기존 회원가입 정보와 일치하는 정보를 입력하셔야 회원가입 여부를 정확하게 확인하실 수 있습니다. 입력하신 정보는 회원가입 여부에만 사용되며 저장되지 않습니다.</li>
					<li>전자상거래에 의거하여 만 14세 미만의 어린이/학생의 회원가입을 제한합니다.</li>
				</ul>
			</div>
			<div id="form">
				<form action="signup_form_checked.jsp" method="post" name="form" onsubmit="return check()">
					<table>
						<tr>
							<td><input type="text" name="name" placeholder="이름" size="7"></td>
						</tr>
						<tr>
							<td><input type="text" name="birth" placeholder="법정 생년월일 6자리"></td>
						</tr>
						<tr>
							<td><input type="text" name="cell" placeholder="휴대전화번호 뒤 7~8자리 (01X 제외)"></td>
						</tr>
						<tr>
							<td><input type="submit" value="가입여부 확인"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</section>
</body>
</html>