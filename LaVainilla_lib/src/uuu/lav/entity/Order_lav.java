package uuu.lav.entity;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Order_lav {

	private int id; //PKEY, Auto-Increment
	private Customer_lav member; //必要
	private LocalDate orderDate; //必要
	private LocalTime orderTime; //必要	
	private int status; //0:新訂單, 1:已轉帳, 2:已付款, 3:已出貨, 4:已到店, 5:已簽收, 6:已完成(Happy Path)
	
	private ShippingType_lav shippingType; //必要
	private double shippingFee; //交易時價格, 必要
	private String shippingNote;//非必要
	
	private PaymentType_lav paymentType; //必要
	private double paymentFee; //交易時價格, 必要
	private String paymentNote;//非必要
	
	private String recipientName; //必要
	private String recipientEmail; //必要
	private String recipientPhone; //必要
	private String shippingAddress; //必要
	
	private Set<OrderItem_lav> orderItemSet = new HashSet<>();
	private double totalAmount;
	
	
//	集合屬性的getter
	public Set<OrderItem_lav> getOrderItemSet() {
		//return new HashSet<>(orderItemSet);//回傳複本
		return Collections.unmodifiableSet(orderItemSet);//回傳唯獨讀的正本
	}
	
//	集合屬性的getter, delegate Method
	public int size() {
		return orderItemSet.size();
	}
	
//	集合屬性的getter, business method
	public int getTotalQuantity() {
		int sum=0;
		for(OrderItem_lav orderItem:orderItemSet) {
			sum += orderItem.getQuantity();
		}		
		return sum;
	}
	
	
//	查詢歷史訂單時，用來記錄OrdersDAO查詢歷史訂單回來的total_amount	
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public double getTotalAmount() {
		double sum;
		if(!orderItemSet.isEmpty()) {		
			sum=0;
			for(OrderItem_lav orderItem:orderItemSet) {
				double amount = orderItem.getPrice() * orderItem.getQuantity(); 
				sum += amount;
			}		
		}else{
			sum = totalAmount;
		}
		return Math.round(sum);
	}	
	
	public double getTotalAmountWithFee() {
		return getTotalAmount()+shippingFee+paymentFee;
	}

//	集合屬性的setter: add, update(不支援), remove(不支援)
	public void add(ShoppingCart_lav cart) { //給CheckoutServlet從結帳畫面建立新訂單
		if(cart==null || cart.size()==0 || cart.getCheckOutTotalQuantity()==0) 
			throw new IllegalArgumentException("結帳時購物車不得為空的");
		
		member = cart.getMember();
		
		for(CartItem_lav cartItem:cart.getCartItemSet()) {
			if(!cartItem.isCheckOut()) continue;
			
			OrderItem_lav orderItem = new OrderItem_lav();
			
			orderItem.setProduct(cartItem.getProduct());
			orderItem.setFlavor(cartItem.getFlavor());
			orderItem.setSpec(cartItem.getSpec());
			
			orderItem.setPrice(cartItem.getUnitPrice());
			orderItem.setQuantity(cart.getQuantity(cartItem));
			
			orderItemSet.add(orderItem);			
		}
	}

	public void add(OrderItem_lav item) {
		orderItemSet.add(item);
	}
	
	public int getId() {
		return id;
	}
	
	public String getIdString() {
		return String.format("LAV%s-%05d", orderDate, id);
	}	
	
	public void setId(int id) {
		this.id = id;
	}
	public Customer_lav getMember() {
		return member;
	}
	public void setMember(Customer_lav member) {
		this.member = member;
	}
	public LocalDate getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}
	
// overloading: orderDate
	public void setOrderDate(String orderDate) {
		LocalDate oDate = LocalDate.parse(orderDate);
		this.setOrderDate(oDate);
	}
	
	public LocalTime getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(LocalTime orderTime) {
		this.orderTime = orderTime;
	}
	
// overloading:	orderTime
	public void setOrderTime(String orderTime) {
		LocalTime oTime = LocalTime.parse(orderTime);
		this.setOrderTime(oTime);
	}
	
	/**
	 * 將this訂單物件的狀態轉換成中文
	 * @return 0:新訂單, 1:已轉帳, 2:已付款, 3:已出貨,...
	 */
	public String getStatusString() {		
		return getStatusString(this.status);		
	}
	
	/**
	 * 將參數status轉換成對應的狀態中文訊息
	 * @param status
	 * @return 0:新訂單, 1:已轉帳, 2:已付款, 3:已出貨,...
	 */
	public static String getStatusString(int status) {
		if(status>=0 && status<Status.values().length) {
			return Status.values()[status].getDescription();
		}else {
			return String.valueOf(status);
		}
	}
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public ShippingType_lav getShippingType() {
		return shippingType;
	}
	public void setShippingType(ShippingType_lav shippingType) {
		this.shippingType = shippingType;
	}
	
	public void setShippingType(String shippingType) {
		ShippingType_lav shType = ShippingType_lav.valueOf(shippingType);
		this.setShippingType(shType);
	}
	
	public double getShippingFee() {
		return shippingFee;
	}
	public void setShippingFee(double shippingFee) {
		this.shippingFee = shippingFee;
	}
	public String getShippingNote() {
		return shippingNote;
	}
	public void setShippingNote(String shippingNote) {
		this.shippingNote = shippingNote;
	}
	public PaymentType_lav getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(PaymentType_lav paymentType) {
		this.paymentType = paymentType;
	}
	
	public void setPaymentType(String paymentType) {
		PaymentType_lav pType = PaymentType_lav.valueOf(paymentType);
		this.paymentType = pType;
	}

	public double getPaymentFee() {
		return paymentFee;
	}
	public void setPaymentFee(double paymentFee) {
		this.paymentFee = paymentFee;
	}
	public String getPaymentNote() {
		return paymentNote;
	}
	public void setPaymentNote(String paymentNote) {
		this.paymentNote = paymentNote;
	}
	public String getRecipientName() {
		return recipientName;
	}
	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}
	public String getRecipientEmail() {
		return recipientEmail;
	}
	public void setRecipientEmail(String recipientEmail) {
		this.recipientEmail = recipientEmail;
	}
	public String getRecipientPhone() {
		return recipientPhone;
	}
	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}
	public String getShippingAddress() {
		return shippingAddress;
	}
	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Order_lav))
			return false;
		Order_lav other = (Order_lav) obj;
		if (id != other.id)
			return false;
		return true;
	}
	

	@Override
	public String toString() {
		return 	this.getClass().getSimpleName()
				+"[id=" + id + ", 訂購人=" + member.getName() 
				+ ", 訂購時間=" + orderDate + " " + orderTime
				+ ", 狀態=" + status //0:新訂單, 1:已轉帳, 2:已付款, 3:已出貨
				+ ",\n 貨運方式/Fee/Note=" + shippingType + "," + shippingFee 
				+ ", " + shippingNote 
				+ ",\n 付款方式/Fee/Note=" + paymentType + "," + paymentFee
				+ "," + paymentNote 
				+ ",\n 收件人=" + recipientName + ","+ recipientEmail + "," + recipientPhone 
				+ ",\n 收件地址=" + shippingAddress + "]"
				+ "\n訂購明細:\n"
				+ orderItemSet
				+ "\n 共" + size() + "項," + getTotalQuantity() + "件，總金額:" + getTotalAmount() 
				+ "元,\n 含手續費: 共" + getTotalAmountWithFee() + "元";
	}
	
//	@Override
//	public String toString() {
//		return this.getClass().getSimpleName()
//				+"[id=" + id + ", 訂購人=" + member+ ", 訂購時間=" + orderDate + " " + orderTime
//				+ ", 狀態=" + status 
//				+ ",\n 貨運方式/Fee/Note=" + shippingType + "," + shippingFee
//				+ "," + shippingNote 
//				+ ",\n 付款方式/Fee/Note" + paymentType + "," + paymentFee
//				+ "," + paymentNote 
//				+ ",\n 收件人=" + recipientName + "," + recipientEmail + "," + recipientPhone 
//				+ ",\n 收件地址=" + shippingAddress+ "]"
//				+ "\n訂購明細:\n"
//				+ "\n 共" + size() + "項," + getTotalQuantity() + "件，總金額:" + getTotalAmount() 
//				+ "元,\n 含手續費: 共" + getTotalAmountWithFee() + "元";
//	}
	
	
	
	
	enum Status{
		NEW("新訂單"),TRANSFERED("已轉帳"),PAID("已付款"),SHIPPED("已出貨"),ARRIVED("已到貨"),CHECKED("已簽收"),COMPLETED("已完成");
		
		private final String description;
		
		private Status(String description) {
			this.description= description;
		}

		public String getDescription() {
			return description;
		}
	
	}




	
}
