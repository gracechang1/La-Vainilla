package uuu.lav.test;

import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.lav.entity.Customer_lav;
import uuu.lav.exception.LAVDataInvalidException;
import uuu.lav.exception.LAVException;
import uuu.lav.service.CustomerService_lav;

public class TestCustomerService_lav_update {

	public static void main(String[] args) {
//	先登入再修改會員		
		CustomerService_lav cService= new CustomerService_lav();
		try {
			Customer_lav member= cService.login("test678@uuu.com.tw", "67890;lkj");
			System.out.println(member);
//	修改會員:name、address		
			member.setName("李六鈁");
			member.setAddress("台北市復興南路99號6樓");
			cService.update(member);
		} catch (LAVDataInvalidException e) {
			System.err.println(e.getMessage()+",修改會員失敗");
			
		} catch(LAVException e) {
			Logger.getLogger(null).log(Level.SEVERE, e.getMessage(), e);
			System.err.println(e.getMessage()+",請聯絡管理員");
		}
		

	}

}
