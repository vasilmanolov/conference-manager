<%@ page
	import="bookstore.cart.ShoppingCart, java.util.*, bookstore.database.BookStoreDAO, bookstore.database.Book, java.text.*, bookstore.exception.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>




<%
	ResourceBundle messages = (ResourceBundle) session.getAttribute("messages");
	ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

	if (cart == null) {
		cart = new ShoppingCart();
		session.setAttribute("cart", cart);
	}

	// Update the inventory

	// Payment received -- invalidate the session
	session.invalidate();

	// set content type header before accessing the Writer
	StringBuilder sb = new StringBuilder();
	sb.append("\"");
	String s = response.encodeURL(request.getContextPath() + "/books/bookstore");
	sb.append(s);
	sb.append("\"");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TitleReceipt</title>
</head>
<body>

<h3><%= messages.getString("ThankYou") + request.getParameter("cardname") %></h3>
<p> &nbsp; <p><strong><a href=<%=sb %>><%=messages.getString("ContinueShopping") %></a>&nbsp; &nbsp; &nbsp;</strong>

</body>
</html>