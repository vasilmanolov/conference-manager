/*
 * Copyright 2007 Sun Microsystems, Inc.
 * All rights reserved.  You may not modify, use,
 * reproduce, or distribute this software except in
 * compliance with  the terms of the License at:
 * http://developer.sun.com/berkeley_license.html
 */


package bookstore.exception;


/** This application exception indicates that an order cannot be completed.
 */
public class OrderException extends Exception {
    /**
	 * 
	 */
	private static final long serialVersionUID = 744611657167922517L;

	public OrderException() {
    }

    public OrderException(String msg) {
        super(msg);
    }
}
