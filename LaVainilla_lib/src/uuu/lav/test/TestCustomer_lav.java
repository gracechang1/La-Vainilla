package uuu.lav.test;

import java.time.LocalDate;

import uuu.lav.entity.Customer_lav;

public class TestCustomer_lav extends Customer_lav {

	public static void main(String[] args) {
		Customer_lav c= new Customer_lav();
		c.setName("張一方");
		c.setBirthday(LocalDate.parse("2010-01-10"));
		c.setGender('M');
		c.setEmail("test123@uuu.com.tw");
		c.setPassword("12345;lkj");
		c.setPhone("09123456789");
		c.setAddress("   ");
		c.setSubscribed(true);
		
		System.out.println(c);
	}

}
