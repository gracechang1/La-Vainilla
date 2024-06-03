package uuu.lav.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import uuu.lav.entity.Customer_lav;
import uuu.lav.entity.OrderStatusLog_lav;
import uuu.lav.entity.Order_lav;
import uuu.lav.exception.LAVException;

public class OrderService_lav {

	private OrdersDAO_lav dao = new OrdersDAO_lav();
// 結帳時:至資料庫建立訂單	
	public void checkOut(Order_lav order) throws LAVException {
		if (order==null || order.size()==0) 
			throw new IllegalArgumentException("建立新訂單時，order物件必須有值");
		
		dao.insert(order);
	}

// 查詢一個月內的歷史訂單	
	private static final int ONE_MONTH_AGO = -1; 
	public List<Order_lav> getOrdersHistory1MonthAgo(Customer_lav member)throws LAVException{
		return dao.selectOrdersHistory(member.getEmail(), ONE_MONTH_AGO);
	}

//	查詢6個月內的歷史訂單	
	private static final int SIX_MONTHS_AGO = -6; 
	public List<Order_lav> getOrdersHistory6MonthsAgo(Customer_lav member)throws LAVException{
		return dao.selectOrdersHistory(member.getEmail(), SIX_MONTHS_AGO);
	}
	
//	查詢2年內的歷史訂單	
	private static final int TWO_YEARS_AGO = -24;
	public List<Order_lav> getOrdersHistory2YearsAgo(Customer_lav member)throws LAVException{
		return dao.selectOrdersHistory(member.getEmail(), TWO_YEARS_AGO);
	}

// 查詢該會員指定的一筆訂單	
	public Order_lav getOrderById(Customer_lav member, String orderId)throws LAVException{
		return dao.selectOrderById(member.getEmail(), orderId);
	}
	
// 將訂單狀態改為已轉帳 Order.Status.TRANSFERED
	public void updateStatusToTransfered(Customer_lav member, String orderId, // 記得要 [alt+/] import LocalDate
			String bank, String last5, double amount, LocalDate TransferedDate, String TransferedTime)
			throws LAVException {
		if (member == null || orderId == null || !orderId.matches("\\d+")) {
			throw new IllegalArgumentException("通知轉帳時，member或orderId不得為null");
		}

		StringBuilder paymentNote = new StringBuilder();
		paymentNote.append(bank).append(",後五碼:").append(last5);
		paymentNote.append(",轉帳金額:").append(amount);
		paymentNote.append(",轉帳時間約:").append(TransferedDate).append(" ").append(TransferedTime);

		dao.updateStatusToTransfered(member.getEmail(), Integer.parseInt(orderId), paymentNote.toString());
	}
	
	public List<OrderStatusLog_lav> getOrderStatusLog(String orderId)//記得要import OrderStatusLog
	          throws LAVException{
	       return dao.selectOrderStatusLog(orderId);
	}

//	將該會員指定的的訂單狀態改為已付款 Order.Status.PAID
	 public void updateOrderStatusToPAID(Customer_lav member,String orderId, String cardF6, String cardL4,
	            String auth, String paymentDate, String amount) throws LAVException {
	      StringBuilder paymentNote = new StringBuilder("信用卡號:");
	      paymentNote.append(cardF6==null?"4311-95":cardF6).append("**-****").append(cardL4==null?2222:cardL4);
	      paymentNote.append(",授權碼:").append(auth==null?"777777":auth);
	      paymentNote.append(",交易時間:").append(paymentDate==null?LocalDateTime.now():paymentDate); //必須import java.time.LocalDateTime

//	    paymentNote.append(",刷卡金額:").append(amount);

	      System.out.println("orderId = " + orderId);
	      System.out.println("memberEmail = " + member.getEmail());
	      System.out.println("paymentNote = " + paymentNote);
	      dao.updateOrderStatusToPAID(member.getEmail(), Integer.parseInt(orderId), paymentNote.toString());
	}

}
