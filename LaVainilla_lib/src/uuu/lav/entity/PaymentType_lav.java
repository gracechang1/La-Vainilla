package uuu.lav.entity;

public enum PaymentType_lav {
//	列舉值(SHOP、STORE、ATM、CARD、HOME)
	SHOP("門市付款"),STORE("超商付款")
	,ATM("ATM轉帳"),CARD("信用卡")
	,HOME(80, "貨到付款");
	
	private final double fee;
	private final String description;

//	指定參數建構子，給初值	
	private PaymentType_lav(String description) {
		this(0, description);
	}
	
	private PaymentType_lav(double fee, String description) {
		this.fee = fee;
		this.description = description;
	}

//	Enum一開始必須給初值，故只有getter無setter		
	public double getFee() {
		return fee;
	}

	public String getDescription() {
		return description;
	}

//	toString無法用工具直接產生
	@Override
	public String toString() {
		return this.description + (fee>0?","+fee+"元":"");
	}
	

	
	
}
