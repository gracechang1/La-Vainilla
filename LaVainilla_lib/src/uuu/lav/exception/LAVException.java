package uuu.lav.exception;

public class LAVException extends Exception {

//	屬於嚴重程度錯誤，需通知admin、user	
	public LAVException() {
		super();
	}

	public LAVException(String message, Throwable cause) {
		super(message, cause);
	}

	public LAVException(String message) {
		super(message);
	}
	
}
