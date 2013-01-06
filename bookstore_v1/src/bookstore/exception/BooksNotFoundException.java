/*
 * Copyright 2007 Sun Microsystems, Inc.
 * All rights reserved.  You may not modify, use,
 * reproduce, or distribute this software except in
 * compliance with  the terms of the License at:
 * http://developer.sun.com/berkeley_license.html
 */


package bookstore.exception;


/** This application exception indicates that books
 *  have not been found.
 */
public class BooksNotFoundException extends Exception {
    /**
	 * 
	 */
	private static final long serialVersionUID = 3665263370341401102L;

	public BooksNotFoundException() {
    }

    public BooksNotFoundException(String msg) {
        super(msg);
    }
}
