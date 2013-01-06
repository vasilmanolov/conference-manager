<%@ page
	import="bookstore.cart.ShoppingCart, java.util.*, bookstore.database.BookStoreDAO, bookstore.database.Book, java.text.*, bookstore.exception.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%
ResourceBundle messages = (ResourceBundle) session.getAttribute("messages");

// Get the identifier of the book to display
String bookId = request.getParameter("bookId");

if (bookId != null) {
	// and the information about the book
	try {
		BookStoreDAO bookDB = (BookStoreDAO) application.getAttribute("bookDBAO");
		Book bd = bookDB.getBook(Long.parseLong(bookId));
		Currency c = (Currency) session.getAttribute("currency");
		
		if (c == null) {
			c = Currency.getInstance(request.getLocale());
			session.setAttribute("currency", c);
		}
		
		NumberFormat format = NumberFormat.getInstance();
		format.setMaximumFractionDigits(2);
		format.setCurrency(c);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=messages.getString("TitleBookCatalog")%></title>
</head>
<body>
	<h2><%=bd.getTitle() %></h2>
	&nbsp;
	<%=messages.getString("By")%>
	
	<em><%=bd.getAuthor().getFirstName()%> <%=bd.getAuthor().getLastName()%> + "
	</em> &nbsp; &nbsp;
	<%=bd.getCalendar_year()%>	
	<br> &nbsp;
	<br>
	<h4>
		<%=messages.getString("Critics")%>		
	</h4>	
	<blockquote>		
		<%=bd.getDescription()%>		
	</blockquote>	
	<h4>		
		<%=messages.getString("Price")%>		
		<%=format.format(bd.getPrice())%>		
	</h4>	
	<p>
		<strong><a href=<%=request.getContextPath() + "/books/bookcatalog?bookId=" + bookId%>>
				+ <%=messages.getString("CartAdd")%> + "
		</a>&nbsp;&nbsp;&nbsp;" + "<a href=<%=request.getContextPath() + "/books/bookcatalog"%> >
		<%=messages.getString("ContinueShopping")%>
		</a>
	</p>
	</strong>
<%

} catch (BookNotFoundException ex) {
	response.resetBuffer();
	throw new ServletException(ex);
}
}

%>
</body>
</html>
