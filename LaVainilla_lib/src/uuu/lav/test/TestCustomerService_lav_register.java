package uuu.lav.test;

import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.lav.entity.Customer_lav;
import uuu.lav.exception.LAVDataInvalidException;
import uuu.lav.exception.LAVException;
import uuu.lav.service.CustomerService_lav;

public class TestCustomerService_lav_register {

	public static void main(String[] args) {
		Customer_lav c=new Customer_lav();
		
		try {
			c.setName("李六坊");
			c.setBirthday("2010-06-01");
			c.setGender('O');
			c.setEmail("test678@uuu.com.tw");
			c.setPassword("67890;lkj");
			c.setPhone("0967891234");
			c.setAddress("");
			c.setSubscribed(false);
			
			System.out.println("測試用客戶:"+c);
			
//	會員註冊商業邏輯
			CustomerService_lav service=new CustomerService_lav();
			service.register(c);
			System.out.println("新增客戶成功:"+c);
			
			
		} catch (LAVDataInvalidException e) {
			System.err.println(e.getMessage());
		
		}catch (LAVException e) {
			System.err.println(e.getMessage()+",請聯絡管理人員");
			Logger.getLogger("").log(Level.SEVERE, e.getMessage(), e);
		}
		System.out.println("The End");
	}

}
