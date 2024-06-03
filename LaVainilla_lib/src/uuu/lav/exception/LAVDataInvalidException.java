package uuu.lav.exception;

public class LAVDataInvalidException extends RuntimeException {
//	資料無效錯誤(屬輕微程度錯誤，只需通知user)
	public LAVDataInvalidException() {
		super();
	}

	public LAVDataInvalidException(String message, Throwable cause) {
		super(message, cause);
	}

	public LAVDataInvalidException(String message) {
		super(message);
	}

}
