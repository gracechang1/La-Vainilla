package uuu.lav.service;

import uuu.lav.entity.Customer_lav;
import uuu.lav.exception.LAVDataInvalidException;
import uuu.lav.exception.LAVException;
import uuu.lav.exception.LoginFailedException_lav;

public class CustomerService_lav {
	
	private CustomersDAO_lav dao=new CustomersDAO_lav();
//	會員登入	
	public Customer_lav login(String email, String password) throws LAVException{
		if(email==null || email.length()==0 || password==null || password.length()==0 ) 
//	拋出參數值不符合預期範圍或規定錯誤			
			throw new IllegalArgumentException("登入會員時，請輸入帳號密碼");
		
//	呼叫dao.帳號查詢客戶			
		Customer_lav c=dao.selectCustomerByEmail(email);
		if(c!=null && password.equals(c.getPassword())) {
			return c;
		}
//			throw new LAVException("登入會員失敗，帳號或密碼不正確");
			throw new LoginFailedException_lav();
	}	
	
//	會員註冊
	public void register(Customer_lav c) throws LAVException{
//	客戶c為null時，拋出錯誤
		if(c==null) throw new IllegalArgumentException("註冊會員時客戶物件不得為null");
//	呼叫dao.新增客戶		
		dao.insert(c);
	}

//	修改會員	
	public void update(Customer_lav c) throws LAVException{
//	客戶c為null時，拋出錯誤	
		if(c==null) throw new IllegalArgumentException("修改會員時客戶物件不得為nul");
//	呼叫dao.修改客戶
		dao.update(c);
	}
	
}
