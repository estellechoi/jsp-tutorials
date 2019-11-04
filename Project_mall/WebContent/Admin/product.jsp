<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.product_manage_section {
		height: 900px;
		overflow: scroll;
	}
	
	.list_header {
		height: 200px;
		display: flex;
		align-items: center;
		justify-content: center;
	/* 	font-family: 'Gill Sans MT Std'; */
		font-weight: 700;
		letter-spacing: 2px;
		font-size: 14px;
		color: #353535;
	}
	
	table {
		width : 1000px;
		margin: auto;
		border: 1px solid grey;
		border-radius: 5px;
	}
	
	table caption {
		text-align: right;
		padding-top: 20px;
		padding-bottom: 15px;
	}
	
	/* 목록으로 돌아가기 */
	table caption a {
		text-decoration: none;
		font-size: 12px;
		font-weight: bold;
		color: #495164;
		letter-spacing: 3px;
	}
	table caption a:hover {
		text-decoration: underline;
	}
	
	table th, td {
		padding: 12px;
		font-size: 12px;
	}
	
	/* 버튼 */
	input[type=button] {
		border: 1px solid #495164;
		border-radius: 5px;
		background: #495164;
		color: white;
		padding: 5px;
		cursor: pointer;
		font-size: 12px;
	}
	
	input[type=submit] {
		border: 1px solid #600000;
		border-radius: 5px;
		background: #600000;
		color: white;
		padding: 5px;	
		cursor: pointer;
		font-size: 12px;
	}
</style>
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
			var code = "p" + category1 + category2 + country + maker;
			document.form.product_code.value = code;
			document.getElementById("print_code").innerText = code;
		}
	}

	function check_form() {
		if(form.product_code.value == "") {
			return false;
			alert("상품코드 저장 오류 !");
		}
		else if(form.name.value == "") {
			return false;
			alert("상품명을 입력하세요 !");
		}
		else if(form.price.value == "") {
			return false;
			alert("상품 가격을 입력하세요 !");
		}
		else if(form.quantity_order.value == "") {
			return false;
			alert("입고수량을 입력하세요 !");
		}
		else {
			return true;
		}
	}
</script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="product_manage_section">
				<!-- 대분류 텍스트 -->
				<div class="list_header">상품 등록</div>
				<div class="list_main">
					<!-- 폼 -->
					<div>
						<form action="product_ok.jsp" method="post" name="form" enctype="multipart/form-data" onsubmit="return check_form()">
						<table>
							<caption><a href="product_manage.jsp">목록으로 돌아가기</a></caption>
							<tr>
								<th>상품분류</th>
								<td>
										대분류
										<select name="category1" onchange="category_sub(this.value)">
											<option value="선택">선택</option>
											<option value="01">top</option>
											<option value="02">bottom</option>
											<option value="03">dress</option>
										</select>
								</td>
								<td>	
										중분류
										<select name="category2">
											<option value="00">선택</option>
										</select>
								</td>
								<td>
										제조국
										<select name="country" id="">
											<option value="00">미확인</option>
											<option value="01">대한민국</option>
											<option value="02">미국</option>
											<option value="03">중국</option>
											<option value="04">일본</option>
										</select>
								</td>
								<td>
										제조사
										<select name="maker">
											<option value="00">미확인</option>
											<option value="01">삼성물산</option>
											<option value="02">코오롱인더스트리</option>
											<option value="03">세아상역</option>
											<option value="04">한솔섬유</option>
										</select>
								</td>
								<td>
										<!-- 상품코드 출력 버튼 -->
										<input type="button" value="상품코드 출력" onclick="code()">
								</td>
							</tr>
							<tr>
								<th>상품코드</th>
								<td colspan="5"><input type="text" name="product_code" readonly style="background:#80FF80; border: 1px solid #00FF00"></td>
							</tr>
							<tr>
								<th>상품이름</th>
								<td colspan="5"><input type="text" name="name"></td>
							</tr>
							<tr>
								<th>상품가격</th>
								<td colspan="5"><input type="text" name="price"></td>
							</tr>
							<tr>
								<th>세탁정보</th>
								<td colspan="5">
									<select name="laundry" id="laundry">
										<option value="0">물세탁</option>
										<option value="1">손세탁</option>
										<option value="2">드라이클리닝</option>
										<option value="3">울세탁</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>생산일자 </th>
								<td colspan="5">
									<!-- manufactured_date -->
									<select name="yy" id="yy">
										<option value="2019">2019</option>
										<option value="2018">2018</option>
										<option value="2017">2017</option>
									</select>
									<select name="mm">
										<%
											for(int i=1;i<=12;i++)
											{
										%>
										<option value="<%=i%>"><%=i%></option>
										<%
											}
										%>
										</select>
										<select name="dd">
										<%
											for(int i=1;i<=12;i++)
											{
										%>
										<option value="<%=i%>"><%=i%></option>
										<%
											}
										%>
									</select>		
								</td>
							</tr>
							<tr>
								<th>입고수량</th>
								<td colspan="5"><input type="text" name="quantity_order"></td>
							</tr>
							<tr>
								<th>상품 이미지(대표)</th>
								<td colspan="5"><input type="file" name="product_list"></td>
							</tr>
							<tr>
								<th>상품 이미지(상세1)</th>
								<td colspan="5"><input type="file" name="product_main"></td>
							</tr>
							<tr>
								<th>상품 이미지(상세2)</th>
								<td colspan="5"><input type="file" name="product_detail"></td>
							</tr>
							<tr>
								<th>상품 설명</th>
								<td colspan="5">
									<textarea name="information" cols="40" rows="10"></textarea>
								</td>
							</tr>
							<tr>
								<th></th>
								<td colspan="5"><input type="submit" value="상품 등록"></td>
							</tr>
						</table>
						</form>	
					</div>
					<!-- 관리자용 navigation -->
					<jsp:include page="admin_nav.jsp" flush="false"/>
				</div>
			</section>
		</div>
	</div>

</body>
</html>