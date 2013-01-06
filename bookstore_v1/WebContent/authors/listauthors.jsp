<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="bookstore.util.DateUtils"%>
<%@page import="bookstore.database.Author"%>
<%@page import="bookstore.database.BookStoreDAO"%>
<%@page import="bookstore.util.CrudOperation"%>
<%@page import="java.util.ResourceBundle"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	ResourceBundle messages = (ResourceBundle) session
	.getAttribute("messages");
	if (messages == null) {
		Locale locale = request.getLocale();
		messages = ResourceBundle.getBundle("bookstore.messages.BookstoreMessages", locale);
		session.setAttribute("messages", messages);
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=messages.getString("TitleApp")%></title>

<script type="text/javascript">
	function submitForm(entity, crudType) {
		var authorForm = document.getElementById("authorForm");
		authorForm.elements["crudOperation"].value = crudType;
		authorForm.elements["firstName"].value = entity.parentElement.parentElement.cells[0].children[0].value;
		authorForm.elements["lastName"].value = entity.parentElement.parentElement.cells[1].children[0].value;
		authorForm.elements["birthDateDay"].value = entity.parentElement.parentElement.cells[2].children[0].value;
		authorForm.elements["birthDateMonth"].value = entity.parentElement.parentElement.cells[3].children[0].value;
		authorForm.elements["birthDateYear"].value = entity.parentElement.parentElement.cells[4].children[0].value;
		authorForm.elements["authorId"].value = entity.parentElement.parentElement.cells[5].children[0].value;
		document.getElementById("authorForm").submit();
	}
</script>
</head>

<%
	BookStoreDAO dao = (BookStoreDAO) application.getAttribute("bookDBAO");

	if (request.getParameter("crudOperation") != null) {
		String crudOperation = request.getParameter("crudOperation");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int birthDateDay = Integer.parseInt(request
				.getParameter("birthDateDay"));
		int birthDateMonth = Integer.parseInt(request
				.getParameter("birthDateMonth"));
		int birthDateYear = Integer.parseInt(request
				.getParameter("birthDateYear"));
		Author author = new Author(firstName, lastName,
				DateUtils.createDate(birthDateYear, birthDateMonth - 1, birthDateDay));

		if (CrudOperation.CREATE.toString().equals(
				crudOperation)) {
			try {
				dao.createAuthor(author);
				out.println(String.format(
						messages.getString("AuthorAdded"),
						author.getFirstName(), author.getLastName()));
			} catch (Exception e) {
				out.println(String.format(messages
						.getString("AuthorNotAdded")));
			}
		} else if (CrudOperation.UPDATE.toString().equals(
				crudOperation)) {
			try {
				int authorId = Integer.parseInt(request
						.getParameter("authorId"));
				author.setId(authorId);
				
				dao.updateAuthor(author);
				out.println(String.format(
						messages.getString("AuthorUpdated"),
						author.getFirstName(), author.getLastName()));
			} catch (Exception e) {
				out.println(String.format(
						messages.getString("AuthorNotUpdated"),
						author.getFirstName(), author.getLastName()));
			}
		} else if (CrudOperation.DELETE.toString().equals(
				crudOperation)) {
			try {
				dao.deleteAuthor(firstName, lastName);
				out.println(String.format(
						messages.getString("AuthorDeleted"), firstName,
						lastName));
			} catch (Exception e) {
				out.println(String.format(
						messages.getString("AuthorNotDeleted"),
						author.getFirstName(), author.getLastName()));
			}

		}

		//TODO - update and delete
	}
	List<Author> authors = dao.getAuthors();
%>

<body>
<p><h3><%=messages.getString("AuthorAdministrationTitle") %></h3>
	<form action="../authors/listauthors.jsp" method="post"
		name="authorForm" id="authorForm">
		<input type="hidden" name="crudOperation">
		<input type="hidden" name="firstName"> 
		<input type="hidden" name="lastName">
		<input type="hidden" name="birthDateDay">
		<input type="hidden" name="birthDateMonth">
		<input type="hidden" name="birthDateYear">
		<input type="hidden" name="authorId">
		
	</form>

	<table summary="layout">
		<%
			for (Author author : authors) {
		%>
		<tr>
			<td><input type="text" name="firstName"
				value="<%=author.getFirstName()%>" size="19"></td>
			<td><input type="text" name="lastName"
				value="<%=author.getLastName()%>" size="19"></td>
			<td><input type="text" name="birthDateDay"
				value="<%=DateUtils.getDayFromDate(author.getBirthDate())%>"
				size="2"></td>
			<td><input type="text" name="birthDateMonth"
				value="<%=DateUtils.getMonthFromDate(author.getBirthDate())%>"
				size="2"></td>
			<td><input type="text" name="birthDateYear"
				value="<%=DateUtils.getYearFromDate(author.getBirthDate())%>"
				size="4"></td>
			<td><input type="hidden" name="authorId"
				value="<%=author.getId()%>"></td>
			<td><input type="button" name="Update"
				value="<%=messages.getString("UpdateAuthor")%>" size="19"
				onclick="submitForm(this,'<%=CrudOperation.UPDATE%>')"></td>
			<td><input type="button" name="Update"
				value="<%=messages.getString("DeleteAuthor")%>" size="19"
				onclick="submitForm(this,'<%=CrudOperation.DELETE%>')"></td>
		</tr>

		<%
			}
		%>
	</table>
	<p><%=messages.getString("HintAddNewAuthor")%></p>
	<table summary="layout">
		<tr>
			<td><input type="text" name="firstName" size="19"></td>
			<td><input type="text" name="lastName" size="19"></td>
			<td><input type="text" name="birthDateDay" size="2"></td>
			<td><input type="text" name="birthDateMonth" size="2"></td>
			<td><input type="text" name="birthDateYear" size="4"></td>
			<td><input type="button" name="Add"
				value="<%=messages.getString("CreateAuthor")%>"
				onclick="submitForm(this,'<%=CrudOperation.CREATE%>')"></td>
		</tr>
	</table>
	<a href=<%=request.getContextPath()
						+ "/books/bookstore"%>>Back to Store</a>
</body>
</html>