package uuu.lav.exception;

public class LoginFailedException_lav extends LAVException {
	
//	登入失敗錯誤(屬中間程度錯誤，只需通知user)
//	Constructors from superclass	
	public LoginFailedException_lav() {
		this("登入失敗，帳號不存在或密碼錯誤，請重新輸入。");
		
	}

	public LoginFailedException_lav(String message, Throwable cause) {
		super(message, cause);
		
	}

	public LoginFailedException_lav(String message) {
		super(message);
	
	}
	

	
}
