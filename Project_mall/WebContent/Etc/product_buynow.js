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

// 휴대폰 번호 자리수 입력제한
// 일단 미적용 ... class 쓰던지 수정해야할듯
function Cell(cell2) {
	if (cell2.value.length >= 4) {
		$(function() {
			$("cell2").next("input").focus();
		});
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
document.form.username.value = "";
document.form.zip.value = "";
document.form.address1.value = "";
document.form.address2.value = "";
document.form.cell1.value = "";
document.form.cell2.value = "";
document.form.cell3.value = "";

function Recipient(r) {
	
	if (r == 1) {
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
		document.form.r_cell1.value = "010";
		document.form.r_cell2.value = "";
		document.form.r_cell3.value = "";
	}
}

// 새로운 배송지 등록
function Address_book(email) {
	
	// 새 창 열기
	var rr = window.open("product_buynow_address.jsp?email="+email, "주소록 즐겨찾기", "width=1000, height=500");
}

// 포인트 사용하기
function Point(p) {
	var point = parseInt(document.getElementById("point").value);
	point = point - parseInt(p);
	document.getElementById("point").value = point;
}