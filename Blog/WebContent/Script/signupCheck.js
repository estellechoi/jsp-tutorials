	function check() {
		// 라디오 체크여부 검토
		var radio = 0;
		for (var i = 0; i < 2; i++) {
			if (document.all.sex[i].checked)
				radio = 1;
		}
		var x = document.querySelectorAll('.x');
		if (document.all.userid.value == "") {
			x[0].innerText = "!!!"
			return false;
		} else if (document.all.password.value == "") {
			x[1].innerText = "!!!";
			return false;
		} else if (document.all.password.value != document.all.passwordCon.value) {
			x[2].innerText = "!!!";
			return false;
		} else if (document.all.name.value == "") {
			x[3].innerText = "!!!";
			return false;
		} else if (document.all.email.value.indexOf("@") <= 0) {
			x[4].innerText = "!!!";
			return false;
		} else if (radio == 0) {
			x[5].innerText = "!!!";
			return false;
		} else {
			return true;
		}
	}