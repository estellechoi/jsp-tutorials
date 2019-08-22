<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css?ver=1">
<style>
	table {
		width: 400px;
		height: 150px;
		margin: auto;
		border: 1px solid #eeeeee;
		border-radius: 10px;
	}
</style>
<script>
	// * javascript에서 JSP 파일 접근하기 (화면전환 깜빡임 없이 나타내기)
	
	// 1) 아이디 찾기
	var xml = new XMLHttpRequest(); // 객체 생성
	
	function searchId() {
		var name = document.searchIdForm.name.value;
		var email = document.searchIdForm.email.value;
		var url = "search_id.jsp?name="+name+"&email="+email;
		
		xml.open("get", url); // open("전송방식", 접근할 JSP의 주소);
		xml.send(); // JSP 파일내 값 호출
	}
	
	// readyState (0 ~ 4) 값 발생/변화할 때마다 function() 실행
	// readyState 4단계 : jsp값 수신완료 단계
	xml.onreadystatechange = function() {
		if(xml.readyState == 4) {	
			searchIdResultBox.innerHTML = xml.responseText.trim();
			// responseText(); → JSP 파일에서 out.print() 값 가져오기
			// trim(); 문자열 좌우 공백 제거
		}
	}
	
	// 2) 비밀번호 찾기
	
	var xml2 = new XMLHttpRequest();
	
	function searchPwd() {
		var userid = document.searchPwdForm.userid.value;
		var name = document.searchPwdForm.name.value;
		var email = document.searchPwdForm.email.value;
		var url = "search_pwd.jsp?name="+name+"&email="+email+"&userid="+userid;
		
		xml2.open("get", url);
		xml2.send();
	}
	
	xml2.onreadystatechange = function() {
		if(xml2.readyState == 4) {	
			searchPwdResultBox.innerHTML = xml2.responseText.trim();
			// responseText(); → JSP 파일에서 out.print() 값 가져오기
			// trim(); 문자열 좌우 공백 제거
		}
	}
	
	
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article>
			<form action="search_id.jsp" method="post" name="searchIdForm">
				<table>
					<caption>아이디 찾기</caption>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="email"></td>
					</tr>
					<tr>
						<td colspan="2">
							<!-- get 방식 테스트를 위해 type=button 으로 변경했음 -->
							<input type="button" value="아이디 찾기" onclick="searchId()">
							<span id="searchIdResultBox"></span>
							<!-- ※javascript 함수명과 id 를 겹치게 했더니 실행 안되네 -->
						</td>
					</tr>
				</table>
			</form>
			<form action="search_pwd.jsp" method="post" name="searchPwdForm">
				<table>
					<caption>비밀번호 찾기</caption>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="userid"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="email"></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="button" value="비밀번호 찾기" onclick="searchPwd()">
							<span id="searchPwdResultBox"></span>
						</td>
					</tr>
				</table>
			</form>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>