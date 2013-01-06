<%@ page
	import="bookstore.cart.ShoppingCart, java.util.*, bookstore.database.BookStoreDAO, bookstore.database.Book, java.text.*, bookstore.exception.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	%>

<%
	ResourceBundle messages = (ResourceBundle) session.getAttribute("messages");

	if (messages == null) {
		Locale locale = request.getLocale();
		messages = ResourceBundle.getBundle("bookstore.messages.BookstoreMessages", locale);
		session.setAttribute("messages", messages);
	}

	BookStoreDAO bookDB = (BookStoreDAO) application.getAttribute("bookDBAO");
	List<Book> allBooks = bookDB.getBooks();
	StringBuilder sb = new StringBuilder();

	String s = request.getContextPath() + "/books/bookdetails?bookId=1";
	sb.append(s);
	StringBuilder sb2 = new StringBuilder();
	
	sb2.append(request.getContextPath()).append("/books/bookcatalog");
	
	StringBuilder sb3 = new StringBuilder();
	sb3.append(request.getContextPath()).append("/books/bookadmin");
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Duke's Bookstore</title>
</head>
<body>
	<p align=center>
	<a href=<%=sb2 %>><%=messages.getString("Start") %></a>
	<a href=<%=sb3 %>><%=messages.getString("BookAdmin") %></a>
	<a href='../authors/listauthors.jsp'>Authors administration</a> <br/>
	</p>
	<br>
	<br> &nbsp;
	<br>&nbsp;
	<br> &nbsp;

</body>
</html>