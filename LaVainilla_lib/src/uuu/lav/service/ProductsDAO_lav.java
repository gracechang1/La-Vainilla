package uuu.lav.service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import uuu.lav.entity.Flavor_lav;
import uuu.lav.entity.Product_lav;
import uuu.lav.entity.Spec_lav;
import uuu.lav.entity.SpecialOffer_lav;
import uuu.lav.exception.LAVException;

class ProductsDAO_lav {
//	MySQL指令(查詢全部產品)
	private static final String SELECT_ALL_PRODUCTS=
			"SELECT id, name, unit_price, stock, expiration_date, category, photo_url, origin, description, discount"
			+ "	FROM products_list_view";
	
	List<Product_lav> selectAllProducts() throws LAVException{
//	ArrayList:集合中元素有順序性、允許重複性		
		List<Product_lav> list = new ArrayList<Product_lav>();
	
		try(
//	1,2取得連線					
			Connection connection=MySQLConnection_lav.getConnection();
//	3.準備指令物件
			PreparedStatement pstmt=connection.prepareStatement(SELECT_ALL_PRODUCTS);
				) {
//	3.1傳入?的值(NO)			
			
//	4.執行指令			
			try(
				ResultSet rs=pstmt.executeQuery();
					){
//	5.處理rs
			while(rs.next()) {
				Product_lav p;	// p=new Product_lav();
				
				int discount=rs.getInt("discount");
				if(discount>0) {
					p=new SpecialOffer_lav();
					((SpecialOffer_lav)p).setDiscount(discount);
				}else p=new Product_lav();
					
				p.setId(rs.getInt("id"));	
				p.setName(rs.getString("name"));
				p.setUnitPrice(rs.getDouble("unit_price"));
				p.setStock(rs.getInt("stock"));
				p.setExpirationDate(rs.getString("expiration_date"));
				p.setCategory(rs.getString("category"));
				p.setPhotoUrl(rs.getString("photo_url"));
				p.setOrigin(rs.getString("origin"));
				p.setDescription(rs.getString("description"));
				
				list.add(p);
				}	
			}
			
		} catch (SQLException e) {
			throw new LAVException("查詢全部產品失敗", e);
		}
		return list;	
	}
	
//	MySQL指令(依關鍵字查詢)
	private static final String SELECT_PRODUCTS_BYKEYWORD=
			SELECT_ALL_PRODUCTS+" WHERE name LIKE ?";
	
	List<Product_lav> selectProductsByKeyword(String keyword) throws LAVException{
		List<Product_lav> list= new ArrayList<Product_lav>();
		
		try(
//	1,2取得連線		
			Connection connection=MySQLConnection_lav.getConnection();
//	3.準備指令				
			PreparedStatement pstmt=connection.prepareStatement(SELECT_PRODUCTS_BYKEYWORD);	
				){
//	3.1傳入?的值			
			pstmt.setString(1,'%'+keyword+"%" );
//	4.執行指令		
			try(
				ResultSet rs= pstmt.executeQuery();
			){
//	5.處理rs				
			while(rs.next()) {
				Product_lav p; // p=new Product_lav();
				
				int discount=rs.getInt("discount");
				if(discount>0) {
					p=new SpecialOffer_lav();
					((SpecialOffer_lav)p).setDiscount(discount);
				}else p=new Product_lav();
				
				p.setId(rs.getInt("id"));	
				p.setName(rs.getString("name"));
				p.setUnitPrice(rs.getDouble("unit_price"));
				p.setStock(rs.getInt("stock"));
				p.setExpirationDate(rs.getString("expiration_date"));
				p.setCategory(rs.getString("category"));
				p.setPhotoUrl(rs.getString("photo_url"));
				p.setOrigin(rs.getString("origin"));
				p.setDescription(rs.getString("description"));
				
				list.add(p);
				} 
			}
			
		} catch (SQLException e) {
			throw new LAVException("依關鍵字查詢產品失敗", e);
		  }
		
		return list;
	}
	
//	MySQL指令(依分類查詢)	
	private static final String SELECT_PRODUCTS_BYCATEGORY=
			SELECT_ALL_PRODUCTS+" WHERE category=?";

	List<Product_lav> selectProductsByCategory(String category) throws LAVException{
		List<Product_lav> list= new ArrayList<Product_lav>();
		
		try(
//	1,2取得連線	
			Connection connection=MySQLConnection_lav.getConnection();
//	3.準備指令
			PreparedStatement pstmt=connection.prepareStatement(SELECT_PRODUCTS_BYCATEGORY);
			){
//	3.1傳入?的值		
			pstmt.setString(1, category);
//	4.執行指令
			try(
				ResultSet rs=pstmt.executeQuery(); 	
				){
//	5.處理rs	
				while(rs.next()) {
					Product_lav p; // p=new Product_lav();
					
					int discount=rs.getInt("discount");
					if(discount>0) {
						p=new SpecialOffer_lav();
						((SpecialOffer_lav)p).setDiscount(discount);
					}else p=new Product_lav();
					
					p.setId(rs.getInt("id"));	
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setExpirationDate(rs.getString("expiration_date"));
					p.setCategory(rs.getString("category"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setOrigin(rs.getString("origin"));
					p.setDescription(rs.getString("description"));
					
					list.add(p);
				}
			}
			
	} catch (SQLException e) {
		throw new LAVException("依分類查詢產品失敗",e);
	}	
	
		return list;
	}
	
//	MySQL指令(依有效日期查詢)	
	private static final String SELECT_PRODUCTS_BYEXPIRATION_DATE=
			SELECT_ALL_PRODUCTS+" ORDER BY expiration_date DESC LIMIT 5";

	List<Product_lav> selectProductsByExpirationDate() throws LAVException{
		List<Product_lav> list=new ArrayList<Product_lav>();
		
		try(
//	1,2 取得連線		
			Connection connection=MySQLConnection_lav.getConnection();
//	3.準備指令
			PreparedStatement pstmt=connection.prepareStatement(SELECT_PRODUCTS_BYEXPIRATION_DATE);
				) {
//	3.1傳入?的值(NO)

//	4.執行指令			
			try(
				ResultSet rs=pstmt.executeQuery();	
					){
//	5.處理rs				
			while(rs.next()) {
				Product_lav p;// p=new Product_lav();
				
				int discount=rs.getInt("discount");
				if(discount>0) {
					p=new SpecialOffer_lav();
					((SpecialOffer_lav)p).setDiscount(discount);
				}else p=new Product_lav();
				
				p.setId(rs.getInt("id"));	
				p.setName(rs.getString("name"));
				p.setUnitPrice(rs.getDouble("unit_price"));
				p.setStock(rs.getInt("stock"));
				p.setExpirationDate(rs.getString("expiration_date"));
				p.setCategory(rs.getString("category"));
				p.setPhotoUrl(rs.getString("photo_url"));
				p.setOrigin(rs.getString("origin"));
				p.setDescription(rs.getString("description"));
				
				list.add(p);
				}
			}
			
		} catch (Exception e) {
			throw new LAVException("依到期日查詢產品失敗", e);
		}
		return list;
		
	}

//	MySQL指令(依產品id查詢)
	private static final String SELECT_PRODUCT_BY_ID="SELECT id, flavor_name, spec_flavor_group, spec_name_group, spec_count, name,"
			+ "	unit_price, discount, spec_unit_price_group, spec_unit_price_min, spec_unit_price_max,"
			+ "    stock, flavor_old_stock , totproduct_detailsal_spec_stock, flavor_stock, spec_stock_group,"
			+ "    expiration_date, category, origin, description, photo_url, flavor_photo, product_id, icon_url, ordinal"
			+ " FROM product_details_view"
			+ "    WHERE id=?";
			
//			"SELECT id, name, unit_price, products.stock, expiration_date, category,"
//			+ " products.photo_url, origin, description, discount,"
//			+ " product_id, flavor_name, product_flavors.stock AS flavor_stock , product_flavors.photo_url AS flavor_photo,"
//			+ " icon_url, ordinal"
//			+ " FROM products LEFT JOIN product_flavors"
//			+ " ON products.id = product_flavors.product_id WHERE id =? ORDER BY ordinal";
	
//			"SELECT id, name, unit_price, stock, expiration_date, category, photo_url, origin, description, discount"
//			+ "	FROM lav.products WHERE id=?";
	
	public Product_lav selectProductById(String id) throws LAVException{
		Product_lav p= null;
		try(
			Connection connection= MySQLConnection_lav.getConnection();
			PreparedStatement pstmt= connection.prepareStatement(SELECT_PRODUCT_BY_ID);	
				) {
			
			pstmt.setString(1, id);
			
			try(
				ResultSet rs= pstmt.executeQuery();
					){
				
				while(rs.next()) {
					if(p==null) {
						int discount= rs.getInt("discount");
						if(discount>0) {
							p=new SpecialOffer_lav();
							((SpecialOffer_lav)p).setDiscount(discount);
						}else {
							p=new Product_lav();
						}
					
						p.setId(rs.getInt("id"));	
						p.setName(rs.getString("name"));
						p.setUnitPrice(rs.getDouble("unit_price"));
						p.setSpecCount(rs.getInt("spec_count"));
						p.setStock(rs.getInt("stock"));
						p.setExpirationDate(rs.getString("expiration_date"));
						p.setCategory(rs.getString("category"));
						p.setPhotoUrl(rs.getString("photo_url"));
						p.setOrigin(rs.getString("origin"));
						p.setDescription(rs.getString("description"));
					
					}

//	判斷是否要讀取flavor資料
					if(rs.getObject("product_id")!=null) {
						Flavor_lav flavor= new Flavor_lav();
						flavor.setFlavorName(rs.getString("flavor_name"));
						flavor.setStock(rs.getInt("flavor_stock"));
						flavor.setPhotoUrl(rs.getString("flavor_photo"));
						flavor.setIconUrl(rs.getString("icon_url"));
						flavor.setOrdinal(rs.getInt("ordinal"));
						
						p.addFlavor(flavor);
					}
				
				}
			}
			
		} catch (SQLException e) {
			throw new LAVException("查詢指定產品id失敗", e);
		}
		
		
		return p;
	}

//	MySQL指令(查詢產品-味道規格)
	private static final String SELECT_SPEC_LIST=" SELECT product_id, flavor_name, spec_name,"
			+ "	product_flavor_specs.unit_price AS list_price,"
			+ "    product_flavor_specs.unit_price * (100-discount)/100 AS price,"
			+ "	product_flavor_specs.stock,"
			+ "    product_flavor_specs.photo_url, ordinal"
			+ "  FROM product_flavor_specs JOIN products"
			+ "	ON products.id = product_flavor_specs.product_id"
			+ " WHERE products.id =? AND flavor_name =? ORDER BY ordinal";

	List<Spec_lav> selectSpecList(String productId, String flavorName) throws LAVException {
		List<Spec_lav> list = new ArrayList<>();
//TODO:		
		try(
			Connection connection= MySQLConnection_lav.getConnection();
			PreparedStatement pstmt= connection.prepareStatement(SELECT_SPEC_LIST);	
					) {
			
			pstmt.setString(1, productId);
			pstmt.setString(2, flavorName);
			
			try(
				ResultSet rs=pstmt.executeQuery();	
						){	
				
				while(rs.next()) {
					Spec_lav spec = new Spec_lav();
					spec.setProductId(rs.getInt("product_id"));
					spec.setFlavorName(rs.getString("flavor_name"));
					spec.setSpecName(rs.getString("spec_name"));
					spec.setListPrice(rs.getDouble("list_price"));
					spec.setUnitPrice(rs.getDouble("price"));
					spec.setStock(rs.getInt("stock"));
					spec.setPhotoUrl(rs.getString("photo_url"));

					list.add(spec);
				}				
			}
			
		} catch (SQLException e) {
			String errMsg = String.format("查詢指定產品味道之規格 [%s-%s]失敗", productId, flavorName);			
			throw new LAVException(errMsg, e);
		}	
	
		return list;
	} 

//	查詢產品及時庫存
	private static final String select_stock_BY_ProductId_flavorName_specName="SELECT id,name, "
			+ "	IFNULL(product_flavor_specs.flavor_name, IFNULL(product_flavors.flavor_name,'')) as flavor_name, "
			+ " IFNULL(product_flavor_specs.spec_name,'') as spec_name, "
			+ "	IFNULL(product_flavor_specs.stock, IFNULL(product_flavors.stock, products.stock)) as stock "
			+ "	FROM products  "
			+ "		LEFT JOIN product_flavors ON products.id=product_flavors.product_id          "
			+ "        LEFT JOIN product_flavor_specs ON products.id=product_flavor_specs.product_id  "
			+ "			AND(product_flavors.flavor_name = product_flavor_specs.flavor_name OR product_flavor_specs.flavor_name='') "
			+ "        WHERE products.id = ?"
			+ "        HAVING flavor_name=? AND spec_name=?";

	int selectStockByProductIdFlavorNameSpecName(int productId, String flavorName, String specName) throws LAVException{
		int stock=0;
		try (				
				Connection connection = MySQLConnection_lav.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(select_stock_BY_ProductId_flavorName_specName); //3.準備指令
			){
			//3.1 傳入?的值
			pstmt.setInt(1, productId);
			pstmt.setString(2, flavorName==null? "":flavorName);
			pstmt.setString(3, specName==null? "":specName);
			
			try(ResultSet rs = pstmt.executeQuery()){
				while (rs.next()) {
					stock = rs.getInt("stock");
				}
			}
		} catch (SQLException e) {
			throw new LAVException("用[查詢指定產品-顏色-規格]失敗", e);
		}
		return stock;
	}

}
