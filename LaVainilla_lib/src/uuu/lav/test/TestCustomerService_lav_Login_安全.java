package uuu.lav.test;

import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.lav.entity.Customer_lav;
import uuu.lav.exception.LAVException;
import uuu.lav.service.CustomerService_lav;

public class TestCustomerService_lav_Login_安全 {

	public static void main(String[] args) {
//	Scanner:讓程式可以讀入資料，以在程式中使用
		Scanner scanner=new Scanner(System.in);
		
		System.out.println("請輸入帳號");
		String email=scanner.next();
		
		System.out.println("請輸入密碼");
		String passward=scanner.next();
		
		final String sql="SELECT name, birthday, gender, email, password, phone, address, subscribed"
				+ "	FROM customers WHERE email=? AND password=?";
		
		Customer_lav c=null;
		CustomerService_lav service=new CustomerService_lav();
		try {
			c=service.login(email, passward);
			
		} catch (LAVException e) {
			Logger.getLogger("").log(Level.SEVERE, e.getMessage(), e);
		}
	}

}
