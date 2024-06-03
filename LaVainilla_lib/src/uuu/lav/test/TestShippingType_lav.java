package uuu.lav.test;

import uuu.lav.entity.ShippingType_lav;

public class TestShippingType_lav {

	public static void main(String[] args) {
//		System.out.println(ShippingType_lav.SHOP);
//		System.out.println(ShippingType_lav.SHOP.getFee());
//		System.out.println(ShippingType_lav.SHOP.getDescription());

//		System.out.println(ShippingType_lav.STORE);
//		System.out.println(ShippingType_lav.STORE.getFee());
//		System.out.println(ShippingType_lav.STORE.getDescription());
		
//		System.out.println(ShippingType_lav.HOME);
//		System.out.println(ShippingType_lav.HOME.getFee());
//		System.out.println(ShippingType_lav.HOME.getDescription());
		
		for(ShippingType_lav shType:ShippingType_lav.values()) {	
			System.out.println(shType.name());
			System.out.println(shType.getFee());
//			System.out.println(shType.getDescription());	
			System.out.println(shType);
		}

	}

}
