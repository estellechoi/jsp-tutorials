<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var xml = new XMLHttpRequest();

	function testAjax2() {
		// * 페이지 이동없이 뒷단에서 jsp 문서에 접근
		xml.open("post", "ajax2_ok.jsp");
		xml.send();
	}
	
	xml.onreadystatechange = function() {
		if(xml.readyState == 4) { // 값 수신 완료시
			pop.innerHTML = pop.innerHTML + xml.responseText
		}
	}
	
	// * Ajax에서 서버로부터 전달받은 데이터 확인하기
	// * xml.responseText; 서버에 요청하여 응답으로 받은 데이터를 문자열로 반환
	// * xml.responseXML; 서버에 요청하여 응답으로 받은 데이터를 XML DOM 객체로 반환
	// 1) out.print 출력값만 존재하는 경우 : out.print() 출력값
	// 2) <html> 태그 존재하는 경우 : out.print() 출력값 및 태그 전체
</script>
</head>
<body>
	<input type="button" onclick="testAjax2()" value="click">
	<div id="pop"></div>
</body>
</html>