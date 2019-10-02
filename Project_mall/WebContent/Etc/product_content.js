/**
 * 
 */

function Cart(id) {
	var size = document.getElementById("size").value;
	var qty = document.getElementById("qty").value;
	location = "cart_ok.jsp?id=" + id + "&size=" + size + "&qty=" + qty;
}

function Wishlist(id) {
	location = "wishlist_ok.jsp?id=" + id;
}