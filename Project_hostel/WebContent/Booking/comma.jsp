<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	// * 정규식으로 금액에 콤마 표시하기
	function comma(amount) {
		
		var hasComma = amount.replace(/\B(?=(\d{3})+(?!\d))/g,","); // replace : 문자열에 대한 함수
		return hasComma;
	}
	var amountHasComma = comma("1000000"); // replace 함수 사용을 위해 문자를 넣어준다
	alert(amountHasComma);
	
	// * 교수님 방법 ????
	function putComma(amount) {
		var amountWithComma = "";
		
		for (var i = 0; i < amount.length; i++) {
			if (i % 3 == 0 && i != 0) {
				amountWithComma = "," + amountWithComma;
			}
			else {
				amountWithComma = amount.substr(amount.length - 1, 1) + amountWithComma; // substr(start index, length) 문자열의 일부 추출
				amount = amount.substring(0, amount.length - 2 - i); // substring(start, end)
			}
		}
	}	
	amountHasComma = putComma("1000000");
	alert(amountHasComma);
	
</script>
</head>
<body>

</body>
</html>