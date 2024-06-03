package uuu.lav.test;

import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.lav.entity.Customer_lav;
import uuu.lav.entity.Order_lav;
import uuu.lav.exception.LAVException;
import uuu.lav.service.CustomerService_lav;
import uuu.lav.service.OrderService_lav;

public class TestOrderHistory_lav {

	public static void main(String[] args) {

		CustomerService_lav cService = new CustomerService_lav();
		OrderService_lav oService = new OrderService_lav();

		try {
			Customer_lav member = cService.login("test123@uuu.com.tw", "12345;lkj");
			
//			List<Order_lav> list = oService.getOrdersHistory1MonthAgo(member);
//			System.out.println(list);
			
			Order_lav order = oService.getOrderById(member, "8");
			System.out.println(order);			
			
		} catch (LAVException e) {
			Logger.getLogger("查詢歷史訂單").log(Level.SEVERE, e.getMessage(),e);
		}

	}

}
