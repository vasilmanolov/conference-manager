/*
 * Copyright 2007 Sun Microsystems, Inc.
 * All rights reserved.  You may not modify, use,
 * reproduce, or distribute this software except in
 * compliance with  the terms of the License at:
 * http://developer.sun.com/berkeley_license.html
 */


package bookstore.filters;

import java.io.CharArrayWriter;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;


public class CharResponseWrapper extends HttpServletResponseWrapper {
    private CharArrayWriter output;

    public CharResponseWrapper(HttpServletResponse response) {
        super(response);
        output = new CharArrayWriter();
    }

    public String toString() {
        return output.toString();
    }

    public PrintWriter getWriter() {
        return new PrintWriter(output);
    }
}
