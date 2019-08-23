<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/signupStyle.css">
<script>
	function check() {
		var email = document.all.email.value;

		if (document.all.userid.value == "") {
			useridx.innerText = "아이디를 입력하세요.";
			return false;
		} else if (document.all.name.value == "") {
			namex.innerText = "이름을 입력하세요.";
			return false;
		} else if (document.all.password.value == "") {
			passwordx.innerText = "비밀번호를 입력하세요.";
			return false;
		} else if (document.all.password.value != document.all.confirmPassword.value) {
			confirmPasswordx.innerText = "비밀번호 불일치";
			return false;
		} else if (email.indexOf("@") <= 0) {
			emailx.innerText = "올바르지 않은 이메일 주소";
			return false;
		} else {
			return true;
		}
	}
	
	// 아이디 중복체크 (AJAX)
	var useridChk = new XMLHttpRequest();
	
	function useridCheck(form) { // form <= this.form
			// 사용자 입력값을 변수에 저장
			var userid = encodeURIComponent(form.userid.value);
	
			// userid 존재유무 확인을 위해 JSP로 값 전송		
			url = "check_userid.jsp?userid=" + userid;
			
			// 전송방식 : get, 전송지 : url
			useridChk.open("get", url);
			
			// 전송지에 리턴값 요청 (JSP 값 호출)
			useridChk.send();
	}
	
	// * ready state (JSP → Javascript 값수신 상태) 변동시 함수 실행
	useridChk.onreadystatechange = function() {
		
		// 수신완료 (4단계)
		if(useridChk.readyState == 4) {
			var idk = document.getElementById("useridx");
			
			// 아이디 존재하는 경우
			if(useridChk.responseText.trim() == "yes") { // JSP 리턴값
				idk.innerHTML = "<b style='color:red'> 사용 불가 아이디</b>";
			}
			// 아이디 존재하지 않는 경우
			else {
				idk.innerHTML = "<b style='color:blue'> 사용 가능 아이디</b>";
			}
		}
	}
	
	// * 비밀번호 일치여부 체크
	function passwordCheck(form) {
		var pwd = form.password.value;
		var confirmPwd = form.confirmPassword.value;
		if(pwd == confirmPwd) {
			confirmPasswordx.innerHTML = "<b style='color: blue'>비밀번호 일치</b>";
		}
		else {
			confirmPasswordx.innerHTML = "<b style='color: red'>비밀번호 불일치</b>";
		}
	}
	
	function passwordCheckFocus(form) {
		if(form.confirmPassword.value == "") {
			form.confirmPassword.focus();
		}
	}
	
	// this : 해당 태그
	// this.form : 해당 태그가 속한 form 태그
	// this.value : 해당 태그의 value
	
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article>
			<form action="signup_ok.jsp" onsubmit="return check()">
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="userid" placeholder="anthony"></td>
						<td><input type="button" onclick="useridCheck(this.form)" value="아이디 중복확인"></td>
						<td id="useridx"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name" placeholder="안토니"></td>
						<td></td>
						<td id="namex"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="password"
							placeholder="숫자/영문 혼합" onblur="passwordCheckFocus(this.form)"></td>
						<td></td>
						<td id="passwordx"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" name="confirmPassword"
							placeholder="숫자/영문 혼합" onblur="passwordCheck(this.form)"></td>
						<td></td>
						<td id="confirmPasswordx"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="email"
							placeholder="anthony@gmail.com"></td>
						<td></td>
						<td id="emailx"></td>
					</tr>
					<tr>
						<td colspan="4"><input type="submit" value="가입하기"></td>
					</tr>
				</table>
			</form>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>