package uuu.lav.entity;

import java.time.LocalDate;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

public class Product_lav extends Object {
//	宣告屬性	
		private int id;						//PKey, auto-increment(自動創建PKey值), >0
		private String name;				//必要, unique, 內容>=1~60個字元
		private double unitPrice;			//必要, 售價即為定價
		private int stock;					//必要
		private LocalDate expirationDate;	//必要, 有效日期
		private String category;			//必要, 香草莢/香草醬/香草精
		private String photoUrl;			//非必要
		private String origin;				//非必要, 產地
		private String description="";		//非必要
		
		private int specCount;
		
		
		public int getSpecCount() {
			return specCount;
		}

		public void setSpecCount(int specCount) {
			this.specCount = specCount;
		}

		private Map<String, Flavor_lav> flavorMap= new HashMap<>();

//	集合型態屬性的getter，不可直接回傳正本,只能回傳複本
//		public Map<String, Flavor> getColorMap() {
//			return flavorMap; //TODO:不可直接回傳正本，,只能回傳複本
//			//return new HashMap<>(flavorMap); //回傳複本
//		}		
		
//		public List<Flavor_lav> getFlavorList() {
//			List<Flavor_lav> list= new ArrayList<>(flavorMap.values());
//			Collections.sort(list);
//			return list;
//		}
		
		public Collection<Flavor_lav> getFlavorList(){
			Set<Flavor_lav> list = new TreeSet<>(flavorMap.values());
			//Collections.sort(list);
			return list;
		}

		public int getFlavorMapSize() {
			return flavorMap.size();
		}
		
//	for購物車
		public Flavor_lav findFlavor(String flavorName) {
			return flavorMap.get(flavorName);
		}
		
//	集合型態屬性不可提供setter，要換成add
		public void addFlavor(Flavor_lav flavor) {
			flavorMap.put(flavor.getFlavorName(), flavor);
		}
		
//	建構子		
		public Product_lav() {
			super();
		}

		
//	封裝、設條件、
//	TODO 拋出錯誤		
		public int getId() {
			return id;
		}

		public void setId(int id) {
			if(id>0) {
				this.id = id;
			}else {
				System.out.println("產品編號須為>0之正整數");
			}
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			if(name!=null && name.length()>0) {
				this.name = name;
			}else {
				System.out.println("產品名稱為1~60個字");
			}
		}

		public double getUnitPrice() {
			return unitPrice;
		}

		public void setUnitPrice(double unitPrice) {
			this.unitPrice = unitPrice;
		}

		public int getStock() {
			if(flavorMap!=null && flavorMap.size()>0) {
				int sum=0;
				for(Flavor_lav flavor:flavorMap.values()) {
					sum= sum+flavor.getStock(); 
				}
				return sum;
			}
			return stock;
		}

		public void setStock(int stock) {
			this.stock = stock;
		}

		public LocalDate getExpirationDate() {
			return expirationDate;
		}

		public void setExpirationDate(LocalDate expirationDate) {
			this.expirationDate = expirationDate;
		}

//	日期轉型字串		
		public void setExpirationDate(String expirationDate) {
			LocalDate date=LocalDate.parse(expirationDate);
			this.setExpirationDate(date); 
		}
		
		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public String getPhotoUrl() {
			return photoUrl;
		}

		public void setPhotoUrl(String photoUrl) {
			this.photoUrl = photoUrl;
		}

		public String getOrigin() {
			return origin;
		}

		public void setOrigin(String origin) {
			this.origin = origin;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

//	toString:將物件所有屬性值串成一個字串回傳	
		@Override
		public String toString() {
//	單純取得類別名稱(Product_lav)方法
			return this.getClass().getSimpleName()
					+"[產品編號=" + id + ", 產品名稱=" + name + ", 定價=" + unitPrice + ", 庫存=" + stock
					+ ", 有效日期=" + expirationDate + ", 分類=" + category + ", 產品圖片=" + photoUrl
					+ ", 產品產地=" + origin + ", 產品描述="+ description + ", 味道Map="+ flavorMap
					+"]";
		}


//	equals and hashCode (PKey)
//	hashCode:回傳物件記憶體位址		
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + id;
			return result;
		}


//	equals:比較this與傳入的物件obj是否相同		
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			Product_lav other = (Product_lav) obj;
			if (id != other.id)
				return false;
			return true;
		}




		
}

