<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page
	import="bookstore.database.BookStoreDAO, bookstore.database.Book, bookstore.exception.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Init Database Information</title>
<%
	BookStoreDAO bookDB = (BookStoreDAO) application.getAttribute("bookDBAO");
	bookDB.fillBookstore();
%>
</head>
<body>
	<p>
	<h3>
		<font color="green">Initial Information into database added successfully</font>
	</h3>
	<p>
	<a href='../authors/listauthors.jsp'>Authors administration</a> <br/>
	<a href='bookadmin.jsp'>Book administration</a><br/>
</body>
</html>