/**
 * 
 */
// 체크박스 자동 체크/해제



// 부모창으로 돌아가기
function Opener(recipient, cell, zip, address1, address2) {
	
	var cell1 = cell.substring(0, 3);
	var cell2 = cell.substring(3,7);
	var cell3 = cell.substring(7, 11);
	// 부모창에 값 전달하기
	opener.form.r_username.value = recipient;
	opener.form.r_cell1.value = cell1;
	opener.form.r_cell2.value = cell2;
	opener.form.r_cell3.value = cell3;
	opener.form.r_zip.value = zip;
	opener.form.r_address1.value = address1;
	opener.form.r_address2.value = address2;
	
	// 창닫기
	close();
}