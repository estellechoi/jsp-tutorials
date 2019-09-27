<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function category_sub(first) {
		// top
		if(first == "01") {
			document.form.category2.options.length = 4;
			document.form.category2.options[0].text = "sleeveless";
			document.form.category2.options[1].text = "knit";
			document.form.category2.options[2].text = "blouse/shirt";
			document.form.category2.options[3].text = "tee";
			document.form.category2.options[0].value = "01";
			document.form.category2.options[1].value = "02";
			document.form.category2.options[2].value = "03";
			document.form.category2.options[3].value = "04";			
		}
		// bottom
		else if (first == "02") {		
			document.form.category2.options.length = 2;
			document.form.category2.options[0].text = "skirts";
			document.form.category2.options[1].text = "pants";
			document.form.category2.options[0].value = "01";
			document.form.category2.options[1].value = "02";			
		}
		// dress
		else if (first == "03") {		
			document.form.category2.options.length = 2;
			document.form.category2.options[0].text = "short";
			document.form.category2.options[1].text = "long";
			document.form.category2.options[0].value = "01";
			document.form.category2.options[1].value = "02";			
		}
	}
	
	function code() {
		var category1 = document.form.category1.value;
		var category2 = document.form.category2.value;
		var country = document.form.country.value;
		var maker = document.form.maker.value;
		
		if(category1 == "선택" || category2 == "") {
			alert("카테고리를 모두 선택하세요 !");
		}
		else {
			// product_code
			document.getElementById("product_code").innerText = "p" + category1 + category2 + country + maker;
		}
	}
</script>
</head>
<body>
<form action="product_no_ok.jsp" method="post" name="form">
	대분류
	<select name="category1" id="" onchange="category_sub(this.value)">
		<option value="선택">선택</option>
		<option value="01">top</option>
		<option value="02">bottom</option>
		<option value="03">dress</option>
	</select>

	중분류
	<select name="category2" id="" onchange="">
	</select>
	
	제조국
	<select name="country" id="">
		<option value="00">미확인</option>
		<option value="01">대한민국</option>
		<option value="02">미국</option>
		<option value="03">중국</option>
		<option value="04">일본</option>
	</select>
	
	제조사
	<select name="maker" id="">
		<option value="00">미확인</option>
		<option value="01">삼성물산</option>
		<option value="02">코오롱인더스트리</option>
		<option value="03">세아상역</option>
		<option value="04">한솔섬유</option>
	</select>
	<input type="button" value="상품코드 출력" onclick="code()">
	<p></p>
	상품코드 : <span id="product_code"></span> <input type="submit" value="확인">
</form>
</body>
</html>