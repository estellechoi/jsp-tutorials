/**
 * 
 */

// 사업자회원 양식 변경 (이름 대신 상호명, 사업자번호)
function BusinessForm(b) {
	if (b == "1") {
		document.getElementById("business_name").innerText = "상호명 * ";
		document.getElementById("business_no").innerText = "사업자번호 * ";
		document.getElementById("business_no_form").innerHTML = "<input type='text' name='sex'>";
	}
	else {
		document.getElementById("business_name").innerText = "이름 * ";
		document.getElementById("business_no").innerText = "성별";
		document.getElementById("business_no_form").innerHTML = 
											"<input type='radio' name='sex' value='0' checked>남" +
											"<input type='radio' name='sex' value='1'>여";
	}
}

// 이메일 입력 선택
function Host() {
	var host = document.getElementById("email_host_selector").value;
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
	for(var i =0; i<2; i++) {
		if(document.getElementsByClassName("agree")[i].checked) {
			n++;
		}
	}
	if (document.getElementsByClassName("agree_SMS")[0].checked)
		n++;
	if (document.getElementsByClassName("agree_email")[0].checked)
		n++;
	
	if(n == 4) {
		document.getElementById("agree_master").checked = true;		
	}
	else {
		document.getElementById("agree_master").checked = false;	
	}
}

// 회원가입 폼 작성여부 검사
// 이메일, 생년월일을 하나의 값으로 넘기기

function Submit_form(form) {
	// 이메일, 생년월일을 하나의 값으로 넘기기
	form.email.value = form.email_id.value + "@" + form.email_host.value;
	form.birth.value = form.birth_year.value + "-" + form.birth_month.value + "-" + form.birth_date.value;
	
	// 필수 이용약관 체크여부 확인
	var agree = document.getElementsByClassName("agree");	
	var n = 0;
	for (var i = 0; i < 2; i++) {
		if (agree[i].checked) {
			n++;	
		}
	}
	
	// 선택 이용약관 체크여부 확인 및 값 주기
	for (var i = 2; i < 4; i++) {
		if (!(agree[i].checked)) {
			agree[i] = "N";			
		}
	}
	
	// 회원가입 폼 작성여부 검사
	var alert = "<span style='color:red; font-size:15px'>ⓧ</span>";
	
	if (form.email_id.value == "" || form.email_host.value == "") {
		document.getElementById("email_x").innerHTML = alert;
		return false;
	}
	else if (form.username.value == "") {
		document.getElementById("username_x").innerHTML = alert;
		return false;
	}
	else if (form.pwd.value == "") {
		document.getElementById("pwd_x").innerHTML = alert;
		return false;		
	}
	else if (form.pwd_check.value != form.pwd.value) {
		document.getElementById("pwd_check_x").innerHTML = alert;
		return false;		
	}
	// 필수 이용약관 동의여부 체크...... 왜안되 ??
	else if (n < 2) {
		alert("필수 이용약관 동의 후 회원가입 가능합니다.");
		return false;
	}
	// 사업자등록번호 10자리 입력 여부	
	else if (form.usertype.value == "1" && form.sex.value.length != 10) {
		document.getElementById("sex_x").innerHTML = alert;
		return false;
	}
	else
		return true;
}