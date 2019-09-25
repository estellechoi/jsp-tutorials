/**
 * 
 */

function toggle(n) {
	// 메뉴 숨기기
	for (var i = 0; i < 4; i++) {
		document.getElementsByClassName("sub")[i].style.display = "none";
	}

	// 메뉴 보이기
	document.getElementsByClassName("sub")[n].style.display = "block";
}