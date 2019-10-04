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