/**
 * 
 */

// 전체선택 체크박스
function Check_all(x, n) {
	if (x.checked) {
		for (var i=0; i < n; i++) {
			document.getElementsByClassName("checkbox")[i].checked = true;
		}
	} else {
		for (var i=0; i < n; i++) {
			document.getElementsByClassName("checkbox")[i].checked = false;
		}		
	}
}

// 체크박스 전체 선택/해제시, 전체선택 박스도 체크/해제
function Check_allbox(n) {
	var chk = 0;
	for (var i=0; i<n; i++) {
		if (document.getElementsByClassName("checkbox")[i].checked) {
			chk ++;
		}
	}
	
	if (chk == n) {
		document.getElementById("checkbox_all").checked = true;
	} else {
		document.getElementById("checkbox_all").checked = false;
	}
}

// 이메일 호스트 선택
function Email(x) {
	var host = x;
	if ( x == "직접입력") {
		document.getElementById("email_host").value = "";
	} else {
		document.getElementById("email_host").value = host;
	}
}

// 배송지 선택
function Recipient(x) {
	var username = document.form.username.value;
	var address = doucment.form.address.value;
	var cell1 = document.form.cell1.value;
	var cell2 = document.form.cell2.value;
	var cell3 = document.form.cell3.value;
	var zip = document.form.zip.value;
	var address1 = document.form.address1.value;
	var address2 = document.form.address2.value;
	
	if (x == 1) {
		document.form.r_username.value = document.form.username.value;
		document.form.r_zip.value = document.form.zip.value;
		document.form.r_address1.value = document.form.address1.value;
		document.form.r_address2.value = document.form.address2.value;
		document.form.r_cell1.value = document.form.cell1.value;
		document.form.r_cell2.value = document.form.cell2.value;
		document.form.r_cell3.value = document.form.cell3.value;
	}
	else {
		document.form.r_username.value = "";
		document.form.r_zip.value = "";
		document.form.r_address1.value = "";
		document.form.r_address2.value = "";
		document.form.r_cell1.value = "";
		document.form.r_cell2.value = "";
		document.form.r_cell3.value = "";
	}
}