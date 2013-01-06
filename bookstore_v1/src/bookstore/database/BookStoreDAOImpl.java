/*
 * Copyright 2007 Sun Microsystems, Inc.
 * All rights reserved.  You may not modify, use,
 * reproduce, or distribute this software except in
 * compliance with  the terms of the License at:
 * http://developer.sun.com/berkeley_license.html
 */

package bookstore.database;

import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.PersistenceException;

import sun.reflect.generics.reflectiveObjects.NotImplementedException;
import bookstore.cart.ShoppingCart;
import bookstore.exception.AuthorNotFoundException;
import bookstore.exception.BookAlreadyExistsException;
import bookstore.exception.BookNotFoundException;
import bookstore.exception.InvalidAuthorException;
import bookstore.exception.InvalidBookException;
import bookstore.exception.OrderException;
import bookstore.util.DateUtils;

public class BookStoreDAOImpl implements BookStoreDAO {
	public EntityManager em = null;

	public BookStoreDAOImpl(EntityManager em) {
		this.em = em;
	}

	@Override
	public Author getAuthor(long authorId) throws AuthorNotFoundException {
		throw new NotImplementedException();
	}

	public Book getBook(long bookId) throws BookNotFoundException {
		throw new NotImplementedException();
	}

	public void deleteBook(long bookId) throws BookNotFoundException {
		throw new NotImplementedException();
	}

	public void buyBooks(ShoppingCart cart) throws OrderException {
		throw new NotImplementedException();
	}

	@Override
	public void updateBook(Book bookToUpdate) throws BookNotFoundException, InvalidBookException {
		throw new NotImplementedException();
	}

	@Override
	public void createBook(Book newBook) throws BookAlreadyExistsException, InvalidBookException {
		throw new NotImplementedException();
	}

	public void buyBook(long bookId, int quantity) throws OrderException {
		throw new NotImplementedException();
	}

	public void fillBookstore() {
		try {
			initiateBooks();
		} catch (InvalidAuthorException e) {
			System.out.println(e.getMessage());
		}
		System.out.println("Books library initialized.");
	}

	public boolean authorExists(long authorId) {
		throw new NotImplementedException();
	}

	public boolean bookExists(long bookId) {
		throw new NotImplementedException();
	}

	@Override
	public List<Book> getBooks() {
		return Collections.emptyList();
	}

	@Override
	public List<Author> getAuthors() {
		return Collections.emptyList();
	}

	@Override
	public void updateAuthor(Author author) throws AuthorNotFoundException, InvalidAuthorException {
		throw new NotImplementedException();
	}

	@Override
	public void deleteAuthor(String firstName, String lastName)
			throws AuthorNotFoundException {
		throw new NotImplementedException();
	}

	@Override
	public void deleteAuthor(long authorId) throws AuthorNotFoundException {
		throw new NotImplementedException();
	}

	@Override
	public void createAuthor(Author author) throws InvalidAuthorException {
		throw new NotImplementedException();
	}


	public void destroy() {
		throw new NotImplementedException();
	}

	protected void insertEntity(Object entity) {
		try {
			EntityTransaction transaction = em.getTransaction();
			transaction.begin();
			em.persist(entity);
			transaction.commit();
		} catch (PersistenceException exc) {
			System.out.println(exc.getMessage());
		} finally {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
		}
	}

	protected void removeEntity(Object entity) {
		try {
			EntityTransaction transaction = em.getTransaction();
			transaction.begin();
			em.remove(entity);
			transaction.commit();
		} catch (PersistenceException exc) {
			System.out.println(exc.getMessage());
		} finally {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
		}
	}

	// ----- HELPER methods --------------------------------------------------------------
	private void addAuthorToDatabaseIfMissing(Author author) throws InvalidAuthorException {
		if (!authorExists(author.getId())) {
			createAuthor(author);
		} else {
			System.out.println("Author [" + author.getFirstName() + " "
					+ author.getLastName() + "] is already in database.");
		}
	}

	private void addBookToDatabaseIfMissing(Book book) {
		if (!bookExists(book.getBookId())) {
			insertEntity(book);
			System.out.println("Book [" + book.getTitle()
					+ "] added to database");
		} else {
			System.out.println("Book [" + book.getTitle()
					+ "] is already in database");
		}
	}

	private void initiateBooks() throws InvalidAuthorException {
		HashMap<String, Book> map = new HashMap<String, Book>();
		Author johnSteinbeck = new Author("John", "Steinbeck",
				DateUtils.createDate(1902, 2, 27));
		addAuthorToDatabaseIfMissing(johnSteinbeck);
		map.put("1", new Book(johnSteinbeck, "Of mice and man", 10.99f, true,
				1937, "Classic", 1));
		Author geromeSalinger = new Author("Gerome", "Salinger",
				DateUtils.createDate(1919, 1, 1));
		addAuthorToDatabaseIfMissing(geromeSalinger);
		map.put("2", new Book(geromeSalinger, "The Catcher in the Rye", 8.99f,
				true, 1951, "Novel", 3));
		map.put("3", new Book(johnSteinbeck, "East of Eden", 20.99f, true,
				1952, "Classic", 5));
		Author ernestHemingway = new Author("Ernest", "Hemingway",
				DateUtils.createDate(1899, 7, 21));
		addAuthorToDatabaseIfMissing(ernestHemingway);
		map.put("4", new Book(ernestHemingway, "The Old Man and the Sea",
				11.99f, true, 1952, "Classic", 7));
		Author marioPuzo = new Author("Mario", "Puzo", DateUtils.createDate(
				1920, 9, 15));
		addAuthorToDatabaseIfMissing(marioPuzo);
		map.put("5", new Book(marioPuzo, "The Godfather", 12.99f, true, 1969,
				"Crime", 5));
		for (Iterator<String> keys = map.keySet().iterator(); keys.hasNext();) {
			String key = keys.next();
			Book book = map.get(key);
			addBookToDatabaseIfMissing(book);
		}
	}
}
