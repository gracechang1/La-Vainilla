package uuu.lav.entity;

import uuu.lav.exception.LAVDataInvalidException;

public class VIP_lav extends Customer_lav {
//	宣告屬性		
	private int discount; //1~90% off
	
//	建構子
	public VIP_lav() {
		super();
	}
	
// 封裝、設條件	
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		if(discount>=1 && discount<=90) {
			this.discount = discount;
		}else {
//			System.err.printf("VIP折扣為1~90% off,%s不在此區間中", discount);
			String errMsg= String.format("VIP折扣為1~90% off,%s不在此區間中", discount);
			throw new LAVDataInvalidException(errMsg);
		}
	}
	
//	台灣產品折扣計算(X折)	
	public String getDiscountString() {
		int discount= 100-this.discount;
		if(discount%10==0) {
			discount= discount/10;
		}
		return discount + "折";
	}
	
//	override:將物件所有屬性值串成一個字串回傳		
	@Override
	public String toString() {
		return super.toString() +
				"\n, VIP折扣= " + discount + "% off, 即為" + getDiscountString();
	}
}
