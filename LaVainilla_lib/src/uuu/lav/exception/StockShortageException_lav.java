package uuu.lav.exception;

import uuu.lav.entity.OrderItem_lav;

public class StockShortageException_lav extends LAVException{

	private final OrderItem_lav orderItem;
	

	public OrderItem_lav getOrderItem() {
		return orderItem;
	}

	public StockShortageException_lav(OrderItem_lav orderItem) {
		this("庫存不足!", orderItem);	
		
	}

	public StockShortageException_lav(String message, OrderItem_lav orderItem, Throwable cause) {
		super(message, cause);
		this.orderItem = orderItem;
	}

	public StockShortageException_lav(String message, OrderItem_lav orderItem) {
		super(message);
		this.orderItem = orderItem;
	}

	public String toString() {
		String errorMsg=String.format("%s: %s-%s-%s ", getMessage(), 
					orderItem.getProduct().getId(), orderItem.getFlavorName(), orderItem.getSpecName());
		return errorMsg;
	}	

}
