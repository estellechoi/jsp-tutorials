/**
 * 
 */

// 장바구니/위시리스트 이동

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
