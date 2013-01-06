package bookstore.util;

public class ValidationResult {
	private final boolean ok;
	private final String message;
	/**
	 * The "OK" instance (without message)
	 */
	public static ValidationResult OK = new ValidationResult();

	private ValidationResult() {
		this.ok = true;
		this.message = "";
	}

	ValidationResult(String message) {
		this.ok = false;
		this.message = message;
	}

	/**
	 * @return a message describing the problem or an empty String if {@link #isOk()} is true
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @return if the validation returned with OK
	 */
	public boolean isOk() {
		return ok;
	}
}
