<%@ page
	import="java.util.*, bookstore.database.BookStoreDAO, bookstore.database.Book"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book Administrator Panel</title>
<%
	ResourceBundle messages = (ResourceBundle) session.getAttribute("messages");
	BookStoreDAO bookDB = (BookStoreDAO) application.getAttribute("bookDBAO");
	List<Book> coll = bookDB.getBooks();
	String bookId = request.getParameter("bookId");
%>
</head>
<body>
<p align="center">
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
				<td bgcolor="#ffffaa">
					<a href=<%=request.getContextPath()
						+ "/books/bookdelete?bookId=" + bookId%>><%=messages.getString("DeleteBook")%></a>
				</td>
				<td bgcolor="#ffffaa">
					<a href=<%=request.getContextPath()
						+ "/books/bookedit?bookId=" + bookId%>><%=messages.getString("EditBook")%></a>
				</td>
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
		<a href=<%=request.getContextPath()
						+ "/books/bookedit"%>><%=messages.getString("CreateBook")%></a>
		<br/>
		<a href=<%=request.getContextPath()
						+ "/books/bookstore"%>>Back to Store</a>
</p>
</body>
</html>