<%@ page import="bookstore.cart.ShoppingCart"%>
<%
	ShoppingCart sCard = (ShoppingCart) session.getAttribute("cart");
%>
<p>
	Current Amount <strong><%=sCard.getTotal()%></strong>
<p>
Purchase
<form action="../books/bookreceipt" method="post">
	<table summary="layout">
		<tr>
			<td><strong>Name</strong></td>
			<td><input type="text" name="cardname" value="Gwen Canigetit" size="19"></td>
		</tr>
		<tr>
			<td><strong>CCNumber</strong></td>
			<td><input type="text" name="cardnum" value="xxxx xxxx xxxx xxxx" size="19"></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="Submit"></td>
		</tr>
	</table>
</form>
