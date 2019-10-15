/**
 * 
 */
// 배송지 등록
function Add(email) {
	location = "product_buynow_address_add.jsp?email="+email;
}


// 체크박스 자동 체크/해제
function Check_all(master, n) {
	if (master.checked) {
		for (var i = 0; i < n; i++) {
			document.getElementsByClassName("desti")[i].checked = true;
		}
	}
	else {
		for (var i = 0; i < n; i++) {
			document.getElementsByClassName("desti")[i].checked = false;
		}		
	}
}

function Check_Master(n) {
	for (var i = 0; i < n; i++) {
		if (document.getElementsByClassName("desti")[i].checked) {
			document.getElementById("checkbox_master").checked = true;
		}
		else {
			document.getElementById("checkbox_master").checked = false;
		}
	}	
}

// 부모창에 값 전달하기
function Opener(x, n, id, recipient, cell, zip, address1, address2) {

	var cellSplit = cell.split("-");
	opener.form.r_username.value = recipient;
	opener.form.id_address.value = id + "";
	opener.form.r_cell1.value = cellSplit[0]; // select 태그 왜 안되지 ?
	opener.form.r_cell2.value = cellSplit[1];
	opener.form.r_cell3.value = cellSplit[2];
	opener.form.r_zip.value = zip;
	opener.form.r_address1.value = address1;
	opener.form.r_address2.value = address2;
	
	// 모든 버튼 색상 디폴트로 변경
	for (var i = 0; i < n; i ++) {
		// document.querySelector(".apply")[i] 왜 안되지 ??? ;;;;
		document.getElementsByClassName("apply")[i].style.background = "white";
		document.getElementsByClassName("apply")[i].style.color = "#495164";
	}
	
	// 적용된 주소록 버튼만 색상 다시 변경
	x.style.background = "#495164";
	x.style.color = "white";
}

// 창 닫기
function Close() {
	close();
}