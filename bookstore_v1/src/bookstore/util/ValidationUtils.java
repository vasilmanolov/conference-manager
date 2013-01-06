package bookstore.util;

import bookstore.database.Author;
import bookstore.database.Book;

public class ValidationUtils {
	
	public static ValidationResult checkBook(Book bookToCheck) {
		ValidationResult result = ValidationResult.OK;
		StringBuilder errMsg = new StringBuilder();
		if(bookToCheck == null || isEmpty(bookToCheck.getTitle())) { 
			errMsg.append("Book or book title cannot be empty or null");
		}
		if(bookToCheck.getPrice() <= 0.0) { 
			errMsg.append("Price cannot be 0 or negative value");
		}
		if(bookToCheck.getInventory() <= 0) { 
			errMsg.append("Quantity cannot be 0 or negative value");
		}
		if(bookToCheck.getCalendar_year() <= 0) { 
			errMsg.append("Year cannot be 0 or negative value");
		}
 		if(errMsg.length() > 0) { 
			result = new ValidationResult(errMsg.toString());
		}
		if(result.isOk()) { 
			checkAuthor(bookToCheck.getAuthor());
		}
		return result;
	}
	
	public static ValidationResult checkAuthor(Author author) {
		ValidationResult result = ValidationResult.OK;
		StringBuilder errMsg = new StringBuilder();
		if(author == null || isEmpty(author.getFirstName()) || isEmpty(author.getLastName())) { 
			errMsg.append("Author cannot be null or his/hers names to be empty");
		}
		if(errMsg.length() > 0) { 
			result = new ValidationResult(errMsg.toString());
		}
		return result;
	}
	
	private static boolean isEmpty(String toCheck) {
		return toCheck == null || toCheck.trim().isEmpty();
	} 
}
