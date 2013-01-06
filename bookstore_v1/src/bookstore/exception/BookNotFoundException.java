/*
 * Copyright 2007 Sun Microsystems, Inc.
 * All rights reserved.  You may not modify, use,
 * reproduce, or distribute this software except in
 * compliance with  the terms of the License at:
 * http://developer.sun.com/berkeley_license.html
 */


package bookstore.exception;


/** This application exception indicates that a book
 *  has not been found.
 */
public class BookNotFoundException extends Exception {
    /**
	 * 
	 */
	private static final long serialVersionUID = 2908182361765785889L;

	public BookNotFoundException() {
    }

    public BookNotFoundException(String msg) {
        super(msg);
    }
}
