package bookstore.exception;

public class AuthorNotFoundException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public AuthorNotFoundException() {
		super();
	}

	public AuthorNotFoundException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public AuthorNotFoundException(String arg0) {
		super(arg0);
	}

	public AuthorNotFoundException(Throwable arg0) {
		super(arg0);
	}

}
