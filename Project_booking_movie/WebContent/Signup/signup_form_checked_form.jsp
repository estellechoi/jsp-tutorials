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
	</style>
	<script>
		function check() {
			var form = document.form;
			// 성별 체크시 sex = "t"
			var sex = "f";
			for( var i=0; i<2; i++) {
				if(form.sex[i].checked) {
					sex = "t";
				}
			}
			
			// 항목별 체크
			if(form.userid.value == "") {
				alert("아이디를 입력해주세요.");
				return false;
			}
			else if(form.name.value == "") {
				alert("이름을 입력해주세요.");
				return false;
			}
			else if(form.pwd.value == "") {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			else if(form.email.value == "") {
				alert("이메일 주소를 입력해주세요.");
				return false;
			}
			else if(form.birth.value.length != 6) {
				alert("법정 생년월일 6자리를 올바르게 입력해주세요.");
				return false;
			}
			else if(!(form.cell.value.length == 7 || form.cell.value.length == 8)) {
				alert("휴대전화번호 뒷자리 7-8자리를 올바르게 입력해주세요.");
				return false;
			}
			else if (sex == "f") {
				alert("성별을 체크해주세요.");
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
			<form action="signup_form_checked_form_ok.jsp" method="post" name="form" onsubmit="return check()">
				<table>
					<tr>
						<td><input type="text" name="userid" placeholder="아이디"></td>
					</tr>
					<tr>
						<td><input type="text" name="name" placeholder="이름" size="7"></td>
					</tr>
					<tr>
						<td><input type="text" name="pwd" placeholder="비밀번호"></td>
					</tr>
					<tr>
						<td><input type="text" name="email" placeholder="이메일 주소"></td>
					</tr>
					<tr>
						<td><input type="text" name="birth" placeholder="법정 생년월일 6자리"></td>
					</tr>
					<tr>
						<td><input type="text" name="cell" placeholder="휴대전화번호 뒤 7~8자리 (01X 제외)"></td>
					</tr>
					<tr>
						<td>
							<input type="radio" name="sex" value="0">남
							<input type="radio" name="sex" value="1">여
						</td>
					</tr>
					<tr>
						<td><input type="submit" value="회원가입"></td>
					</tr>
				</table>
			</form>
		</div>
	</section>
</body>
</html>