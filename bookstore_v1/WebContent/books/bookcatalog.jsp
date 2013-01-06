<%@ page
	import="bookstore.cart.ShoppingCart, java.util.*, bookstore.database.BookStoreDAO, bookstore.database.Book, java.text.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	ResourceBundle messages = (ResourceBundle) session
			.getAttribute("messages");
	ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

	// If the user has no cart, create a new one
	if (cart == null) {
		cart = new ShoppingCart();
		session.setAttribute("cart", cart);
	}

	//Information on the books is from the database through its front end
	// Additions to the shopping cart
	String bookId = request.getParameter("bookId");
	BookStoreDAO bookDB = (BookStoreDAO) application.getAttribute("bookDBAO");

	List<Book> coll = bookDB.getBooks();

	Currency c = (Currency) session.getAttribute("currency");

	if (c == null) {
		c = Currency.getInstance(Locale.getDefault());
		session.setAttribute("currency", c);
	}
	NumberFormat format = NumberFormat.getInstance();
	format.setMaximumFractionDigits(2);
	format.setCurrency(c);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=messages.getString("TitleBookCatalog")%></title>
</head>
<body>
	<%
		if (bookId != null) {
			Book book = bookDB.getBook(Long.parseLong(bookId));
			cart.add(bookId, book);
	%>
	<p>
	<h3>
		<font color="#ff0000"><%=messages.getString("CartAdded1")%> <i>
				<%=book.getTitle()%></i><%=messages.getString("CartAdded2")%></font>
	</h3>

	<%
		}
	%>

	<%
		if (cart.getNumberOfItems() > 0) {
	%>
	<p>
		<strong><a
			href=<%=request.getContextPath() + "/books/bookshowcart"%>><%=messages.getString("CartCheck")%></a>
			&nbsp;&nbsp;&nbsp; <a
			href=<%=request.getContextPath() + "/books/bookcashier"%>><%=messages.getString("Buy")%></a></strong>
	</p>
	<%
		}
	%>
	<br>&nbsp;
	<h3><%=messages.getString("Choose")%></h3>
	<center>
		<table summary="layout">
			<%
			for(Book book : coll) {
					bookId = Long.toString(book.getBookId());
			%>
			<tr>
				<td bgcolor="#ffffaa"><a
					href=<%=request.getContextPath()
						+ "/books/bookdetails?bookId=" + bookId%>><%=book.getBookId() + " " + book.getTitle()%></a>
				</td>
				<td bgcolor="#ffffaa" rowspan=2><%=format.format(book.getPrice())%>
				</td>
				<td bgcolor="#ffffaa" rowspan=2><a
					href="<%=response.encodeURL(request.getContextPath())%>/books/bookcatalog?bookId=<%=bookId%>">
						&nbsp;<%=messages.getString("CartAdd")%>
				</a></td>
			</tr>
			<tr>
				<td bgcolor="#ffffff">&nbsp;&nbsp;<%=messages.getString("By")%>
					<em><%=book.getAuthor().getFirstName()%> <%=book.getAuthor().getLastName()%></em>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</center>
</body>
</html>
</body>
</html>