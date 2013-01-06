<%@ page
	import="java.util.*, bookstore.database.BookStoreDAO, bookstore.database.Book, bookstore.database.Author, java.text.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Book Panel</title>
<%
	ResourceBundle messages = (ResourceBundle) session
			.getAttribute("messages");
	if (messages == null) {
		Locale locale = request.getLocale();
		messages = ResourceBundle.getBundle(
				"bookstore.messages.BookstoreMessages", locale);
		session.setAttribute("messages", messages);
	}

	// Get the identifier of the book to display
	String bookId = request.getParameter("bookId");
	// and the information about the book
	try {
		BookStoreDAO bookDB = (BookStoreDAO) application
				.getAttribute("bookDBAO");
		Book newBook = null;
		if (bookId != null && !bookId.equals("0")) {
			newBook = bookDB.getBook(Long.parseLong(bookId));
		} else {
			newBook = new Book();
		}
		List<Author> allAuthors = bookDB.getAuthors();
		long currentAuthorId = -1L;
		if (newBook.getAuthor() != null) {
			currentAuthorId = newBook.getAuthor().getId();
		}
%>
</head>
<body>
	<center>
		<form name="myForm" action="bookedit?bookUpdateExecuted" method="post">
			<table>
				<tr>
					<td>Title:</td>
					<td><input type="text" name="bookTitle"
						value="<% if(newBook.getTitle() != null) {out.print(newBook.getTitle());}%>"></td>
				</tr>
				<tr>
					<td>Description:</td>
					<td><input type="text" name="bookDescription"
						value="<% if(newBook.getDescription() != null) {out.print(newBook.getDescription());}%>"></td>
				</tr>
				<tr>
					<td>Price:</td>
					<td><input type="text" name="bookPrice"
						value="<% if(newBook.getPrice() > 0) {out.print(newBook.getPrice());}%>"></td>
				</tr>
				<tr>
					<td>Quantity:</td>
					<td><input type="text" name="bookInventory"
						value="<% if(newBook.getInventory() > 0) {out.print(newBook.getInventory());}%>"></td>
				</tr>
				<tr>
					<td>Year:</td>
					<td><input type="text" name="bookYear"
						value="<% if(newBook.getCalendar_year() > 0) {out.print(newBook.getCalendar_year());}%>"></td>
				</tr>
				<tr>
					<td>Author:</td>
					<td><select id="authorsDropDown" name="authorsDropDown">
							<%
								for (Author author : allAuthors) {
										boolean isCurrent = author.getId() == currentAuthorId;
							%>
							<option value=<%=author.getId()%>
								<% if (isCurrent) {
						out.print(" selected");
					}%>><%=author.getFirstName() + " "
							+ author.getLastName()%></option>
							<%
								}
							%>
					</select></td>
				</tr>
			</table>
			<input type="hidden" name="bookId" value="<%=newBook.getBookId()%>">
			<input type="submit">
		</form>
		<a href=<%=request.getContextPath() + "/books/bookadmin"%>> + <%=messages.getString("BackToAdminUi")%>
			+ "
		</a>
		<%
			String updatePerformed = request
						.getParameter("bookUpdateExecuted");
				if (updatePerformed != null) {
					newBook.setAuthor(bookDB.getAuthor(Long.parseLong(request
							.getParameter("authorsDropDown"))));
					newBook.setTitle(request.getParameter("bookTitle"));
					newBook.setDescription(request
							.getParameter("bookDescription"));
					newBook.setPrice(Float.parseFloat(request
							.getParameter("bookPrice")));
					newBook.setCalendar_year(Integer.parseInt(request
							.getParameter("bookYear")));
					newBook.setInventory(Integer.parseInt(request.getParameter("bookInventory")));
					if (bookId != null && !bookId.equals("0")) {
						bookDB.updateBook(newBook);
						response.sendRedirect(request.getContextPath()
								+ "/books/bookedit?bookId=" + bookId);
					} else {
						bookDB.createBook(newBook);
						response.sendRedirect(request.getContextPath()
								+ "/books/bookadmin");
					}
		%>
	</center>
	<%
		}
	%>
	<%
		} catch (Exception exc) { %>
		<h3><%=exc.getMessage() %></h3>	
	<%}%>

</body>
</html>