/**
 * 
 */

// 사업자회원 양식 변경 (이름 대신 상호명, 사업자번호)
function BusinessForm(b) {
	if (b == "1") {
		document.getElementById("business_name").innerText = "상호명 * ";
		document.getElementById("business_no").innerText = "사업자번호 * ";
		document.getElementById("business_no_form").innerHTML = "<input type='text' name='email'>";
	}
	else {
		document.getElementById("business_name").innerText = "이름 * ";
		document.getElementById("business_no").innerText = "이메일 * ";
		document.getElementById("business_no_form").innerHTML = 
											"<input type='text' name='email_id' size='7'> @ <input type='text' name='email_host' size='7' id='email_host'>" +
											"<select name='email' id='email' onchange='Host()'>" +
												"<option value='직접입력'>직접 입력</option>" +
												"<option value='naver.com'>naver.com</option>" +
												"<option value='daum.net'>daum.net</option>" +
												"<option value='gmail.com'>gmail.com</option>" +
												"<option value='yahoo.com'>yahoo.com</option></select>" +
												"<input type='hidden' name='email'>";
	}
}

// 이메일 입력 선택
function Host() {
	var host = document.getElementById("email").value;
	if(host == "직접입력") {
		document.getElementById("email_host").value = "";
	}
	else {
		document.getElementById("email_host").value = host;
	}
}

// 전체동의 박스 체크/해제시, 모든 체크박스 체크/해제되는 스크립트

function AgreeAll(master) {
	var agree = document.getElementsByClassName("agree");
	if(master.checked) {
		for (var i = 0; i < 4; i++) {
			agree[i].checked = true;
		}
	}
	else {
		for (var i = 0; i < 4; i++) {
			agree[i].checked = false;
		}
	}
}

// 모든 체크박스가 체크되면 전체동의 박스도 자동 체크, 하나라도 체크되지 않았다면 전체동의 박스도 자동 해제

function Agree() {
	var n = 0;
	for(var i =0; i<4; i++) {
		if(document.getElementsByClassName("agree")[i].checked) {
			n++;
		}
	}
	
	if(n == 4) {
		document.getElementById("agree_master").checked = true;		
	}
	else {
		document.getElementById("agree_master").checked = false;	
	}
}

// 회원가입 폼 작성여부 검사
function Check_form(form) {
	
}