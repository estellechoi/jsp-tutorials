/**
 * 
 */

function Close_cart() {
	document.getElementById("layer_cart").display = "none";
}

function Move_cart() {
	location = "../Member/cart.jsp";
}

function Close_wishlist() {
	document.getElementById("layer_wishlist").display = "none";
}

function Move_wishlist() {
	location = "../Member/wishlist.jsp";
}

// 장바구니/위시리스트 담기 AJAX

var cart = new XMLHttpRequest();
var wishlist = new XMLHttpRequest();

function Cart(id) {
	var size = document.getElementById("size").value;
	var qty = document.getElementById("qty").value;
	url = "cart_ok.jsp?id=" + id + "&size=" + size + "&qty=" + qty;
	cart.open("get", url);
	cart.send();
}

cart.onreadystatechange = function() {
	if (cart.readyState == 4) {
		if (cart.responseText.trim() == "ok") {
			// JSP <html> 출력값이 "ok" 하나만 있어야 하며, 다른 값이 있을 경우 전달되지 않는다.
			document.getElementById("layer_cart").display = "block";
		}
	}
}

function Wishlist(id) {
	url = "wishlist_ok.jsp?id=" + id;
	wishlist.open("get", url);
	wishlist.send();
}

wishlist.onreadystatechange = function() {
	if (wishlist.readyState == 4) {
		if (wishlist.responseText.trim() == "ok") {
			document.getElementById("layer_wishlist").display = "block";
		}
	}
}
