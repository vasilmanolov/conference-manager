<%@page import="bookstore.exception.BookNotFoundException"%>
<%@ page
	import="java.util.*, bookstore.database.BookStoreDAO, bookstore.database.Book"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book Deletion Status</title>
<%
	ResourceBundle messages = (ResourceBundle) session.getAttribute("messages");
	BookStoreDAO bookDB = (BookStoreDAO) application.getAttribute("bookDBAO");
	List<Book> coll = bookDB.getBooks();
	String bookId = request.getParameter("bookId");
%>
</head>
<body>
	<%
	try { 
		bookDB.deleteBook(Long.parseLong(bookId));
%>
	<h3><%=messages.getString("BookDeleteSuccess")%></h3>
	<%	} catch (BookNotFoundException exc)  {%>
	<h3><%=messages.getString("BookDeleteFail")%></h3>
	<%} %>
	<a href=<%=request.getContextPath() + "/books/bookadmin"%>>
				+ <%=messages.getString("BackToAdminUi")%> + "
	</a>
</body>
</html>