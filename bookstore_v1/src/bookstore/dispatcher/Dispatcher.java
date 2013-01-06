/*
 * Copyright 2007 Sun Microsystems, Inc.
 * All rights reserved.  You may not modify, use,
 * reproduce, or distribute this software except in
 * compliance with  the terms of the License at:
 * http://developer.sun.com/berkeley_license.html
 */


package bookstore.dispatcher;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bookstore.cart.ShoppingCart;
import bookstore.database.Book;
import bookstore.database.BookStoreDAO;
import bookstore.exception.BookNotFoundException;

@WebServlet(name = "Dispatcher", urlPatterns = {"/books/*", "/error/*"})
public class Dispatcher extends HttpServlet {    
	private static final long serialVersionUID = 1L;

	public void doGet(
        HttpServletRequest request,
        HttpServletResponse response) {
        String bookId = null;
        String clear = null;
        Book book = null;
        BookStoreDAO bookDBAO = (BookStoreDAO) getServletContext()
                                           .getAttribute("bookDBAO");
        HttpSession session = request.getSession();
        String selectedScreen = request.getServletPath();

        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }

        if (selectedScreen.equals("/books/bookcatalog")) {
            bookId = request.getParameter("bookId");            
            if (bookId != null && !new String("").equals(bookId)) {
                try {
                    book = bookDBAO.getBook(Long.parseLong(bookId));
                    cart.add(bookId, book);
                } catch (BookNotFoundException ex) {
                    ex.printStackTrace();
                }
            }
        } else if (selectedScreen.equals("/books/bookshowcart")) {
            bookId = request.getParameter("Remove");

            if (bookId != null) {
                cart.remove(bookId);
            }

            clear = request.getParameter("Clear");

            if ((clear != null) && clear.equals("clear")) {
                cart.clear();
            }
        } else if (selectedScreen.equals("/books/bookreceipt")) {
            try {
                //utx.begin();
                bookDBAO.buyBooks(cart);
                //utx.commit();
            } catch (Exception ex) {               
            	ex.printStackTrace();
                selectedScreen = "/books/bookordererror";
            }
        }

        String screen = selectedScreen + ".jsp";

        try {
            request.getRequestDispatcher(screen)
                   .forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void doPost(
        HttpServletRequest request,
        HttpServletResponse response) {
        String screen = request.getServletPath() + ".jsp";

        try {
            request.getRequestDispatcher(screen)
                   .forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
