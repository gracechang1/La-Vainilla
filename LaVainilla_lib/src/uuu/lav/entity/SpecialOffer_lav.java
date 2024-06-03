package uuu.lav.entity;

import java.security.PublicKey;

public class SpecialOffer_lav extends Product_lav {
//	宣告屬性	
	private int discount;	//必要, 1~90% off
	
//	建構子	
	public SpecialOffer_lav() {
		super();
	}

//	封裝、設條件、
//	TODO 拋出錯誤	
	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		if(discount>=1 && discount<=90) {
			this.discount = discount;
		}else {
			System.out.println("產品折扣為1~90%之間");
		}
	}
	
//	台灣產品折扣計算(X折)
		public String getDiscountString() {
			int discount=100-this.discount;
			if(discount%10==0) {
				discount=discount/10;
			}
			return discount+"折";
		}
		
//	查詢折扣後售價
		@Override
		public double getUnitPrice() {
			return super.getUnitPrice()*((100D-this.discount)/100);
		}
		
// 查詢定價
		public double getListPrice() {
			return super.getUnitPrice();
		}
		
//	override:將物件所有屬性值串成一個字串回傳
		@Override
		public String toString() {
			return super.toString() 
					+"折扣=" + discount + "% off,即為" + getDiscountString()
							+ ",售價為=" + this.getUnitPrice();
		}
		

}
