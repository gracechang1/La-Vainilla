package uuu.lav.entity;

public enum ShippingType_lav {
//	列舉值(SHOP、STORE、HOME)
	SHOP("門市自取", PaymentType_lav.SHOP), 
	STORE("超商取貨",60, PaymentType_lav.STORE, PaymentType_lav.ATM, PaymentType_lav.CARD), 
	HOME("宅配", 120, PaymentType_lav.ATM, PaymentType_lav.CARD, PaymentType_lav.HOME);

	private final String description;
	private final double fee;
	private final PaymentType_lav[] paymentTypeArray;	
	

	//	指定參數建構子，給初值	
	private ShippingType_lav(String description,
			PaymentType_lav... paymentTypeArray) {
			this(description, 0, paymentTypeArray);
		}

	private ShippingType_lav(String description, double fee,
			PaymentType_lav... paymentTypeArray) {
		this.description = description;
		this.fee = fee;
		this.paymentTypeArray = paymentTypeArray;
	}
	

//	Enum一開始必須給初值，故只有getter無setter	
	public String getDescription() {
		return description;
	}
	public double getFee() {
		return fee;
	}

	
	public String getPaymentTypesArray() {		
		StringBuilder arrayString = new StringBuilder();		
		for(PaymentType_lav pType:paymentTypeArray) {
			if(arrayString.length()>0)arrayString.append(",");
			arrayString.append(pType.name());
		}
		
		return arrayString.toString();
	}	
	
	
//	toString無法用工具直接產生	
	@Override
	public String toString() {
		return this.description + (fee>0? ","+fee+"元":"");
	}
	
}
