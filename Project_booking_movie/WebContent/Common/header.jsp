<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	body {
		margin: 0px;
	}
	header #ad {
		height: 80px;
	}
	
	header #topBar {
		height: 30px;
		display: flex;
		justify-content: flex-end;
	}
	
	header #topBar div:nth-child(1) {
		display: flex;
		align-items: center;
		/* ??? */
	}
	
	header #topBar div:nth-child(2) {
		float: left;
		margin-left: 50px;
		margin-right: 100px;
		display: flex;
		align-items: center;
	}
	
	header #topBar div:nth-child(2) a {
		text-decoration: none;
		font-size: 14px;
		font-weight: bold;
		color: black;
		margin: 20px;
	}
	
	header #imageBar {
		height: 120px;
		background-image: url("../Img/jelly.jpg");
		background-size: 500px;
	}
</style>
<header>
<div id="ad"><img src="../Img/ad_sample.PNG" alt="no image"></div>
<div id="topBar">
	<div>
		<form action="">
			<input type="search">
			<input type="submit" value="검색">
		</form>
	</div>
	<div>
		<a href="../Signup/signin.jsp">로그인</a>
		<a href="">마이페이지</a>
		<a href="">English</a>
	</div>
</div>
<div id="imageBar"></div>
</header>