<%@page import="bookstore.cart.ShoppingCartItem"%>
<%@ page
	import="bookstore.cart.ShoppingCart, java.util.*, bookstore.database.BookStoreDAO, bookstore.database.Book, java.text.*, bookstore.exception.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>



<%
	ResourceBundle messages = (ResourceBundle) session.getAttribute("messages");

	ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

	// If the user has no cart, create a new one
	if (cart == null) {
		cart = new ShoppingCart();
		session.setAttribute("cart", cart);
	}
%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TitleShoppingCart</title>
</head>
<body>

	<%
		String bookId = request.getParameter("Remove");
		Book bd;

		if (bookId != null) {
			BookStoreDAO bookDB = (BookStoreDAO) application
					.getAttribute("bookDBAO");
			bd = bookDB.getBook(Long.parseLong(bookId));
			cart.remove(bookId);
	%>
	<font color="#ff00000" size="+2"><%=messages.getString("CartRemoved")%><strong><%=bd.getTitle()%></strong><br>
		&nbsp; <br></font>
	<%
		} else if (request.getParameter("Clear") != null) {
			cart.clear();
	%>
	<font color="#ff0000" size="+2"><strong><%=messages.getString("CartCleared")%></strong>
		<br>&nbsp; <br> </font>

	<%
		}

		int num = cart.getNumberOfItems();

		if (num > 0) {
			String cartItem = messages.getString("CartContents")
					+ num
					+ ((num == 1) ? messages.getString("CartItem")
							: messages.getString("CartItems"));
	%>

	<font size="+2"><%=cartItem%>
		<table summary="layout">
			<tr>
				<th align=left><%=messages.getString("ItemQuantity")%></TH>
				<th align=left><%=messages.getString("ItemTitle")%></TH>
				<th align=left><%=messages.getString("ItemPrice")%></TH>
			</tr>
			<%
				Iterator<ShoppingCartItem> i = cart.getItems().iterator();
					Currency c = (Currency) session.getAttribute("currency");
					if (c == null) {
						c = Currency.getInstance(request.getLocale());
						session.setAttribute("currency", c);
					}

					NumberFormat format = NumberFormat.getInstance();
					format.setMaximumFractionDigits(2);
					format.setCurrency(c);

					while (i.hasNext()) {
						ShoppingCartItem item = (ShoppingCartItem) i.next();
						bd = (Book) item.getItem();
						StringBuilder encodeURL = new StringBuilder();
						encodeURL.append("\"");
						encodeURL.append(response.encodeURL(request
								.getContextPath()
								+ "/books/bookdetails?bookId="
								+ bd.getBookId()));
						encodeURL.append("\"");
						StringBuilder removeLink = new StringBuilder();
						removeLink.append("\"");
						removeLink.append(response.encodeURL(request
								.getContextPath()
								+ "/books/bookshowcart?Remove="
								+ bd.getBookId()));
						removeLink.append("\"");
			%>
			<tr>
				<td align="right" bgcolor="#ffffff"><%=item.getQuantity()%></td>
				<td bgcolor="#ffffaa"><strong><a href=<%=encodeURL%>><%=bd.getTitle()%></a>
				</strong></td>
				<td bgcolor="#ffffaa" align="right"><%=format.format(bd.getPrice())%></td>
				<td bgcolor="#ffffaa"><strong><a href=<%=removeLink%>><%=messages.getString("RemoveItem")%></a></strong></td>
			</tr>

			<tr>
				<td colspan="5" bgcolor="#ffffff"><br></td>
			</tr>
			<tr>
				<td colspan="2" align="right" bgcolor="#ffffff"><%=messages.getString("Subtotal")%></td>
				<td bgcolor="#ffffaa" align="right"><%=format.format(cart.getTotal())%></td>
				<td><br></td>
			</tr>
		</table>
		<p>
			&nbsp; <strong><a
				href=<%=new StringBuilder()
							.append("\"")
							.append(response.encodeURL(request.getContextPath()
									+ "/books/bookcatalog")).append("\"")%>><%=messages.getString("ContinueShopping")%></a>&nbsp;
				&nbsp; &nbsp; <a
				href=<%=new StringBuilder()
							.append("\"")
							.append(response.encodeURL(request.getContextPath()
									+ "/books/bookcashier")).append("\"")%>><%=messages.getString("Checkout")%></a>
				&nbsp; &nbsp; &nbsp; <a
				href=<%=new StringBuilder()
							.append("\"")
							.append(response.encodeURL(request.getContextPath()
									+ "/books/bookshowcart?Clear=clear"))
							.append("\"")%>><%=messages.getString("ClearCart")%></a>
			</strong>
		</p> <%
 	}
 	} else {
 %> <font size="+2"><%=messages.getString("CartEmpty")%></font><br>
		&nbsp; <br>
		<center>
			<a
				href=<%=new StringBuilder()
						.append("\"")
						.append(response.encodeURL(request.getContextPath()
								+ "/books/bookcatalog")).append("\"")%>><%=messages.getString("Catalog")%></a>
		</center> <%
 	}
 %>
</body>
</html>