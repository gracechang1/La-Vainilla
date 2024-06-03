package uuu.lav.test;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.lav.entity.Product_lav;
import uuu.lav.exception.LAVException;
import uuu.lav.service.ProductService_lav;

public class TestProductService_lav_其他查詢測試 {

	public static void main(String[] args) {
		
		ProductService_lav service= new ProductService_lav();

		try {
//	測試依關鍵字查詢產品
//			List<Product_lav> list=service.getProductsByKeyword("優奇");
//			System.out.println(list);
//	測試依分類查詢產品	
//			List<Product_lav> list=service.getProductsByCategory("香草莢");
//			System.out.println(list);
//	測試依有效日期查詢產品
//			List<Product_lav> list=service.getProductsByExpirationDate();
//			System.out.println(list);
//	測試依產品id查詢產品		
//			System.out.println(service.getProductById("9"));
//	測試產品7(泡芙)	
//			System.out.println(service.getProductById("7"));
			Product_lav p= service.getProductById("7");
			System.out.printf("共%d口味\n", p.getFlavorMapSize());
			System.out.printf("%s口味的物件: %s\n", "抹茶", p.findFlavor("抹茶"));
			System.out.println(p);
			
		} catch (LAVException e) {
			Logger.getLogger("").log(Level.SEVERE, e.getMessage(), e);
		}
	}

}
