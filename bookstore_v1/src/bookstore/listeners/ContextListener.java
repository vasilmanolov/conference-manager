/*
 * Copyright 2007 Sun Microsystems, Inc.
 * All rights reserved.  You may not modify, use,
 * reproduce, or distribute this software except in
 * compliance with  the terms of the License at:
 * http://developer.sun.com/berkeley_license.html
 */

package bookstore.listeners;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import bookstore.database.BookStoreDAO;
import bookstore.database.BookStoreDAOImpl;
import bookstore.util.Counter;

public final class ContextListener implements ServletContextListener {

	private ServletContext context = null;

	public void contextInitialized(ServletContextEvent event) {
		try {
			context = event.getServletContext();
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("bookstoreDatabase");
			BookStoreDAO bookDBAO = new BookStoreDAOImpl(emf.createEntityManager());
			context.setAttribute("hitCounter", new Counter());
			context.setAttribute("bookDBAO", bookDBAO);
		} catch (Exception ex) {
			System.err.println("Couldn't create bookstore database bean: "
					+ ex.getMessage());
			ex.printStackTrace(System.err);
		}
	}

	public void contextDestroyed(ServletContextEvent event) {
		context = event.getServletContext();
		BookStoreDAO bookDBAO = (BookStoreDAOImpl) context.getAttribute("bookDBAO");
		bookDBAO.destroy();
		context.removeAttribute("bookDBAO");
	}
}
