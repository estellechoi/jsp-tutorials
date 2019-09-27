/**
 * 
 */

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
