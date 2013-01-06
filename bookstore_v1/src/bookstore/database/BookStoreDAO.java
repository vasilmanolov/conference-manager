package bookstore.database;

import java.util.List;

import bookstore.cart.ShoppingCart;
import bookstore.exception.AuthorNotFoundException;
import bookstore.exception.BookAlreadyExistsException;
import bookstore.exception.BookNotFoundException;
import bookstore.exception.InvalidAuthorException;
import bookstore.exception.InvalidBookException;
import bookstore.exception.OrderException;

public interface BookStoreDAO {
	
	public void createBook(Book newBook) throws BookAlreadyExistsException, InvalidBookException;

	public Book getBook(long bookId) throws BookNotFoundException;

	public List<Book> getBooks();

	public void updateBook(Book bookToUpdate) throws BookNotFoundException, InvalidBookException;

	public void deleteBook(long bookId) throws BookNotFoundException;
	
	public void createAuthor(Author author) throws InvalidAuthorException;
	
	public Author getAuthor(long authorId) throws AuthorNotFoundException;
	
	public List<Author> getAuthors();

	public void updateAuthor(Author authorToUpdate)
			throws AuthorNotFoundException, InvalidAuthorException;

	public void deleteAuthor(long authorId) throws AuthorNotFoundException;

	public void deleteAuthor(String firstName, String lastName)
			throws AuthorNotFoundException;

	public void buyBooks(ShoppingCart cart) throws OrderException;

	public void buyBook(long bookId, int quantity) throws OrderException;

	public void fillBookstore();

	public boolean authorExists(long authorId);

	public boolean bookExists(long bookId);

	public void destroy();

}
