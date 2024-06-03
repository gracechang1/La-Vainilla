package uuu.lav.test;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.lav.entity.Product_lav;
import uuu.lav.exception.LAVException;
import uuu.lav.service.ProductService_lav;

public class TestProductService_lav_getAllProducts {

	public static void main(String[] args) {
		
		ProductService_lav service=new ProductService_lav();
		
		try {
			List<Product_lav> list= service.getAllProducts();
			System.out.println(list);
		} catch (LAVException e) {
			Logger.getLogger("").log(Level.SEVERE, e.getMessage(), e);
		}

	}

}
