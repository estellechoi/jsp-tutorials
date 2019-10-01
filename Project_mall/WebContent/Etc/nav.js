/**
 * 
 */

function toggle(n, x) {
	// 메뉴 숨기기
	for (var i = 0; i < 4; i++) {
		document.getElementsByClassName("sub")[i].style.display = "none";
	}

	// 메뉴 보이기
	document.getElementsByClassName("sub")[n].style.display = "block";

	// 페이지 이동
	location = "../Product/product_list.jsp?code=" + n + "&category="+x;
}