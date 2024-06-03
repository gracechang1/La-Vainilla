package uuu.lav.service;

import java.util.List;

import uuu.lav.entity.Product_lav;
import uuu.lav.entity.Spec_lav;
import uuu.lav.exception.LAVException;

public class ProductService_lav {

	private ProductsDAO_lav dao = new ProductsDAO_lav();
	
//	讀取依全部查詢產品
	public List<Product_lav> getAllProducts() throws LAVException{
		return dao.selectAllProducts();
	}
	
//	讀取依關鍵字查詢產品
	public List<Product_lav> getProductsByKeyword(String keyword) throws LAVException{
//	回傳的參數值不符合預期範圍或規定		
		if(keyword==null || keyword.length()==0) {
			throw new IllegalArgumentException("關鍵字查詢產品時，請輸入關鍵字");
		}
		return dao.selectProductsByKeyword(keyword);
	} 
	
//	讀取依分類查詢產品
	public List<Product_lav> getProductsByCategory(String category) throws LAVException{
		if(category==null || category.length()==0) {
//	回傳的參數值不符合預期範圍或規定				
			throw new IllegalArgumentException("分類查詢產品時，請輸入分類項目");
		}
		return dao.selectProductsByCategory(category);
	}

// 讀取依有效日期查詢產品
	public List<Product_lav> getProductsByExpirationDate() throws LAVException{
		return dao.selectProductsByExpirationDate();
	}

//	查指定代號(id)的產品(符合:回傳指定產品,不符合:null)
	public Product_lav getProductById(String id) throws LAVException{
		return dao.selectProductById(id);
	}

//	查詢產品規格(先確認productId、flavorName)
	public List<Spec_lav> getSpecList(String productId, String flavorName) throws LAVException{
		if(productId==null) throw new IllegalArgumentException("查詢產品[規格清單]時，productId不為null");
		if(flavorName==null) flavorName="";
		return dao.selectSpecList(productId, flavorName);
		
	}
//	查詢指定產品、味道、specName的規格物件
	public Spec_lav getSpecById(String productId, String flavorName, String specName) throws LAVException{
		if(specName==null) throw new IllegalArgumentException("查詢產品[規格]時，specName不得為null");
		
		List<Spec_lav> list= this.getSpecList(productId, flavorName);
		Spec_lav spec = null;
		if(list!=null && list.size()>0) {
			for(Spec_lav s:list) {
				if(specName.equals(s.getSpecName())) {
					spec = s;
					break;
				}
			}
		}
		return spec;
	}

// 查詢指定產品、味道、specName的即時庫存	
	public int getStockByProductIdFlavorNameSpecName(int productId, String flavorName, String specName) throws LAVException {
		if(productId<=0) throw new IllegalArgumentException("查詢庫存必須有productId");
		if(flavorName==null) flavorName = "";
		if(specName==null) specName = "";
		
		return dao.selectStockByProductIdFlavorNameSpecName(productId, flavorName, specName);
	}

	
}
