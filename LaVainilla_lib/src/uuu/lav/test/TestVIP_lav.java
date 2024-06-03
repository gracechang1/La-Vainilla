package uuu.lav.test;

import uuu.lav.entity.VIP_lav;

public class TestVIP_lav {

	public static void main(String[] args) {
		 VIP_lav vip= new VIP_lav();
		 vip.setName("李七坊");
		 vip.setBirthday(2010,2,2);
		 vip.setGender('O');
		 vip.setEmail("test789@uuu.com.tw");
		 vip.setPassword("78901;lkj");
		 vip.setPhone("0978912345");
		 vip.setAddress("");
		 vip.setSubscribed(false);
		 vip.setDiscount(10);
		 
		 System.out.printf("vip: %s\n", vip);
		 
	}

}
