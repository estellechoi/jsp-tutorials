/**
 * 
 */

function toggle(n, clicked, h) {
	// 메뉴 숨기기
	for (var i = 0; i < 4; i++) {
		document.getElementsByClassName("sub")[i].style.display = "none";
		document.getElementsByClassName("sub")[i].style.height = "25px";
	}

	// 메뉴 보이기
	document.getElementsByClassName("sub")[n].style.display = "block";
	document.getElementsByClassName("sub")[n].style.height = h + "px";
}