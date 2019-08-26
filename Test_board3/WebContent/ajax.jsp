<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	// * 페이지 이동
	//   location = "ajax_ok.jsp";
	
	// * 페이지 이동없이 뒷단에서 jsp 문서에 접근 및 값 가져오기 (비동기 방식 ajax)
	var xml = new XMLHttpRequest();
	function testAjax() {
		xml.open("post", "ajax_ok.jsp", true); // true 인자 생략 가능
		xml.send();		
	}
	
	// * new XMLHttpRequest();
	// 1) open() 메소드의 async 인자가 true : 비동기 방식 (인자 명시 생략 가능)
	// 2) open() 메소드의 async 인자가 false : 동기적 방식
	
	xml.onreadystatechange = function() {
		if(xml.readyState == 4) { // 값 수신 완료시
			if(xml.responseText == "ok") { 
				alert("완료 !");
				// 이거 왜자꾸 실패 뜨지 ? ;;;
			} else {
				alert("실패 .."); 
			}
		}
	}
</script>
</head>
<body>
	<input type="button" onclick="testAjax()" value="click">
</body>
</html>