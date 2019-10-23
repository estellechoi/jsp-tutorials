/**
 * 
 */
// 이전 페이지 이동
function Back() {
	history.back();
}

// 선택상품 삭제
function Drop_product() {
	
}

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

// 배송 정보 선택
function Delivery(d) {
	// 주문자 정보와 동일
	if (d == "0") {
		if (document.order.address_zip.value == "") {
			alert("저장된 주소가 없으므로 새로운 배송지를 입력해 주세요 !");
		}
		else {
			document.order.recipient.value = document.order.username.value;
			document.order.r_zip.value = document.order.address_zip.value;
			document.order.r_address1.value = document.order.address_address1.value;
			document.order.r_address2.value = document.order.address_address2.value;
			document.order.r_cell1.value = document.order.cell1.value;
			document.order.r_cell2.value = document.order.cell2.value;
			document.order.r_cell3.value = document.order.cell3.value;
		}
	}
	// 새로운 배송지
	else {
		document.order.id_address.value = "";
		document.order.recipient.value = "";
		document.order.r_zip.value = "";
		document.order.r_address1.value = "";
		document.order.r_address2.value = "";
		document.order.r_cell1.value = "010";
		document.order.r_cell2.value = "";
		document.order.r_cell3.value = "";
	}
}
// 새로운 배송지 등록
function Address_book(email) {
	
	// 새 창 열기
	var rr = window.open("../Product/product_buynow_address.jsp?email="+email, "주소록 즐겨찾기", "width=1000, height=500");
}

// 결제수단 선택에 따른 레이어 표시
function Pay_form(n) {
	for(var i=0; i<3; i++) {
		document.getElementsByClassName("pay_form")[i].style.display = "none";
	}
	document.getElementsByClassName("pay_form")[n].style.display = "block";
}


// submit
function Submit() {	
	// 구매진행 동의여부
	if (form.confirm.value != "1") {
		alert("구매 진행에 동의해야 결제 가능합니다.");
		return false;
	}
	else {
		return true;
	}
	
}
