package uuu.lav.test;

import uuu.lav.entity.Customer_lav;
import uuu.lav.entity.Product_lav;
import uuu.lav.entity.ShoppingCart_lav;
import uuu.lav.entity.Spec_lav;
import uuu.lav.exception.LAVException;
import uuu.lav.service.CustomerService_lav;
import uuu.lav.service.ProductService_lav;

public class TestShoppingCart_lav {

	public static void main(String[] args) {
		
		CustomerService_lav cService = new CustomerService_lav();
		ProductService_lav pService = new ProductService_lav();
		
		try {
			Customer_lav c1 = cService.login("test234@uuu.com.tw","23456;lkj");
			System.out.println(c1);
			
//			Customer_lav vip = cService.login("test123@uuu.com.tw", "12345;lkj");
//			System.out.println(vip);
			
			ShoppingCart_lav cart = new ShoppingCart_lav();
			cart.setMember(c1);
			
//			{//1st測試
//				Product_lav p = pService.getProductById("2");
//				cart.add(p, null, null, 1);
//			}

			{ //2nd 測試
				Product_lav p = pService.getProductById("6");
				cart.add(p, "焦糖", null, 1);			
			}
			
			{ //3rd 測試
				Product_lav p = pService.getProductById("7");
				cart.add(p, "抹茶", null, 1);			
			}
			
//			{ //4th 測試
//				Product_lav p = pService.getProductById("6");
//				cart.add(p, null, null, 1);			
//			}
			
			{ //5th 測試
				
//				Product_lav p = pService.getProductById("9");
//				List<Spec_lav> list = pService.getSpecList(String.valueOf(p.getId()), "杏仁");
//				Spec_lav spec = null;
//				for(Spec_lav s:list) {
//					if("30毫升".equals(s.getSpecName())) {
//						spec = s;
//						break;
//			}
//		}				
//		cart.add(p, "杏仁", spec, 1);			
				
				Product_lav p = pService.getProductById("9");				
				Spec_lav spec = pService.getSpecById("9", "香橙", "150毫升");								
				cart.add( p, "香橙",spec,1);			
			}			

//			{ //6th 測試
//				Product_lav p = pService.getProductById("6");
//				cart.add(p, null, null, 1);			
//			}
			
			{ //7th 測試
				
//				Product_lav p = pService.getProductById("9");
//				List<Spec_lav> list = pService.getSpecList(String.valueOf(p.getId()), "香橙");
//				Spec_lav spec = null;
//				for(Spec_lav s:list) {
//					if("75毫升".equals(s.getSpecName())) {
//						spec = s;
//						break;
//					}
//				}
//				cart.add(p, "香橙", spec, 1);	
				
				Product_lav p = pService.getProductById("9");				
				Spec_lav spec = pService.getSpecById("9", "杏仁", "75毫升");		
				
				cart.add(p, "杏仁", spec, 2);			
				
			}
			System.out.println(cart);
			
			
			
		} catch (LAVException e) {
			
		}

	}

}
