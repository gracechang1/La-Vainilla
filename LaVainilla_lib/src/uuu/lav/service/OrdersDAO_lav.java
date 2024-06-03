package uuu.lav.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import uuu.lav.entity.Customer_lav;
import uuu.lav.entity.Flavor_lav;
import uuu.lav.entity.OrderItem_lav;
import uuu.lav.entity.OrderStatusLog_lav;
import uuu.lav.entity.Order_lav;
import uuu.lav.entity.PaymentType_lav;
import uuu.lav.entity.Product_lav;
import uuu.lav.entity.Spec_lav;
import uuu.lav.exception.LAVException;
import uuu.lav.exception.StockShortageException_lav;


public class OrdersDAO_lav {

	private static final String UPDATE_STOCK_products = "UPDATE products SET stock=stock-? WHERE stock>=? AND id=?";
	private static final String UPDATE_STOCK_product_flavors = "UPDATE product_flavors SET stock=stock-? WHERE stock>=? AND product_id=? "
																	+ "AND flavor_name=?";
	private static final String UPDATE_STOCK_product_flavor_specs = "UPDATE product_flavor_specs SET stock=stock-? WHERE stock>=? AND product_id=? "
																	+ "AND flavor_name=? AND spec_name=?";	

	private static final String INSERT_ORDERS="INSERT INTO orders"
			+ "	(id, member_email, order_date, order_time, status,"
			+ "		shipping_type, shipping_fee, payment_type, payment_fee,"
			+ "        recipient_name, recipient_email, recipient_phone, shipping_address)"
			+ "	VALUES(?,?,?,?,0,?,?,?,?, ?,?,?,?)";
	
	private static final String INSERT_ORDER_ITEMS="INSERT INTO order_items"
			+ "	(order_id, product_id, flavor_name, spec_name, price, quantity)"
			+ "    VALUES(?,?,?,?,?,?)";
	
	void insert(Order_lav order) throws LAVException {
		try (Connection connection = MySQLConnection_lav.getConnection(); // 1,2取得連線
				
				PreparedStatement pstmt01 = connection.prepareStatement(UPDATE_STOCK_products);
				PreparedStatement pstmt02 = connection.prepareStatement(UPDATE_STOCK_product_flavors);
				PreparedStatement pstmt03 = connection.prepareStatement(UPDATE_STOCK_product_flavor_specs);
				
				PreparedStatement pstmt1 = connection.prepareStatement(INSERT_ORDERS, Statement.RETURN_GENERATED_KEYS); // 3.準備指令 pstmt1																														
				PreparedStatement pstmt2 = connection.prepareStatement(INSERT_ORDER_ITEMS);// 3.準備指令 pstmt2
		) {
			connection.setAutoCommit(false); //取得交易控制權，類似 beginTransaction
			try {			
			//修改庫存
				for (OrderItem_lav orderItem : order.getOrderItemSet()) {
					PreparedStatement pstmt;
					//3.1 對應正確的指令，並傳入?的值
					if(orderItem.getSpec()!=null) {
						pstmt = pstmt03;
						pstmt.setString(4, orderItem.getFlavorName());
						pstmt.setString(5, orderItem.getSpecName());
					}else if(orderItem.getFlavor()!=null) {
						pstmt = pstmt02;
						pstmt.setString(4, orderItem.getFlavorName());
					}else {
						pstmt = pstmt01;
					}
					
					pstmt.setInt(1, orderItem.getQuantity()); //購買數量
					pstmt.setInt(2, orderItem.getQuantity()); //購買數量
					pstmt.setInt(3, orderItem.getProduct().getId());
					// System.out.println(pstmt);  //for test
					int rows = pstmt.executeUpdate(); //rows是傳回來的修改筆數
					if(rows<1) throw new StockShortageException_lav(orderItem);
				}
			//修改庫存結束

			
			
			//3.1 傳入pstmt1的?值
			pstmt1.setInt(1, order.getId()); //當order.getId()為0時，就會觸發自動給號
			pstmt1.setString(2, order.getMember().getEmail()); //customer的PKEY欄位
			pstmt1.setString(3, String.valueOf(order.getOrderDate()));
			pstmt1.setString(4, String.valueOf(order.getOrderTime()));
			
			pstmt1.setString(5, order.getShippingType().name());
			pstmt1.setDouble(6, order.getShippingFee());
			pstmt1.setString(7, order.getPaymentType().name());
			pstmt1.setDouble(8, order.getPaymentFee());
			
			pstmt1.setString(9, order.getRecipientName());
			pstmt1.setString(10, order.getRecipientEmail());
			pstmt1.setString(11, order.getRecipientPhone());
			pstmt1.setString(12, order.getShippingAddress());
			
			//4.執行pstmt1指令
			pstmt1.executeUpdate();
			
			//取得自動給號的order_id
			try(ResultSet rs = pstmt1.getGeneratedKeys();){
				//處理自動給號的rs
				while(rs.next()) {
					int id = rs.getInt(1);
					order.setId(id); //訂單編號就是自動給號的值
				}				
			}
			
			for(OrderItem_lav orderItem:order.getOrderItemSet()) {
				//3.1 傳入pstmt2的?值
				pstmt2.setInt(1, order.getId());
				pstmt2.setInt(2, orderItem.getProduct().getId());
				pstmt2.setString(3, orderItem.getFlavorName());
				pstmt2.setString(4, orderItem.getSpecName());
				pstmt2.setDouble(5, orderItem.getPrice());
				pstmt2.setInt(6, orderItem.getQuantity());
				
				//4.執行pstmt2指令
				pstmt2.executeUpdate();
			}
			connection.commit(); //	[確認交易]
			} catch (Exception e) {
				connection.rollback(); //發生任何錯誤皆須[取消交易]
				throw e;			   //將exception物件e拋回原錯誤處理流程
			} finally {
				connection.setAutoCommit(true); //將connection的AutoCommit設定還原為true，避免connection pool機制中的connection預設設定被破壞
			}	
			
		} catch (SQLException e) {
			throw new LAVException("建立訂單失敗", e);
		}
	}

	private static final String SELECT_ORDERS_HISTORY="SELECT id, order_date, order_time, status,"
			+ " shipping_type, shipping_fee, payment_type, payment_fee,"
			+ "	SUM(price*quantity) as total_amount"
			+ "	FROM orders JOIN order_items ON orders.id=order_items.order_id"
			+ "	WHERE member_email=? AND order_date BETWEEN date_add(curdate(),INTERVAL ? MONTH) AND curdate()"
			+ "    GROUP BY orders.id ORDER BY order_date DESC, order_time DESC";

	List<Order_lav> selectOrdersHistory(String email, int xMonthAgo) throws LAVException{
		List<Order_lav> list = new ArrayList<>();
		
		try(
			Connection connection = MySQLConnection_lav.getConnection(); //1,2 取得連線
			PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDERS_HISTORY);//3.準備指令
				) {
			
			//3.1 傳入?的值
			pstmt.setString(1, email);
			pstmt.setInt(2, xMonthAgo);

			try(
				ResultSet rs = pstmt.executeQuery();  //4.執行指令	
					){
				while(rs.next()) {//5.處理rs
					Order_lav order = new Order_lav();
					order.setId(rs.getInt("id"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderTime(rs.getString("order_time"));
					order.setStatus(rs.getInt("status"));
				
					Customer_lav member = new Customer_lav();
					member.setEmail(email);

					order.setShippingType(rs.getString("shipping_type"));
					order.setShippingFee(rs.getDouble("shipping_fee"));

					order.setPaymentType(rs.getString("payment_type"));
					order.setPaymentFee(rs.getDouble("payment_fee"));
					
					order.setTotalAmount(rs.getDouble("total_amount"));

					list.add(order);
				}
				
			}
			
		} catch (SQLException e) {
			throw new LAVException("查詢歷史訂單失敗", e);
		}
		
		return list;
	
	}

	private static final String SELECT_ORDER_BY_ID ="SELECT orders.id, member_email, order_date, order_time, status,"
			+ "	shipping_type, shipping_fee, shipping_note, payment_type, payment_fee, payment_note,"
			+ "    recipient_name, recipient_email, recipient_phone, shipping_address,"
			+ "    order_items.product_id, products.name as p_name, order_items.flavor_name, order_items.spec_name, price, quantity"
			+ "    , product_flavor_specs.photo_url AS spec_photo, product_flavors.photo_url AS flavor_photo, products.photo_url"
			+ "    FROM orders JOIN order_items ON orders.id = order_items.order_id"
			+ "		JOIN products ON order_items.product_id = products.id"
			+ "        LEFT JOIN product_flavors ON order_items.product_id = product_flavors.product_id AND order_items.flavor_name = product_flavors.flavor_name"
			+ "        LEFT JOIN product_flavor_specs ON order_items.product_id = product_flavor_specs.product_id"
			+ "					AND order_items.flavor_name = product_flavor_specs.flavor_name AND order_items.spec_name = product_flavor_specs.spec_name"
			+ "	WHERE member_email=? AND orders.id=?";
	
	Order_lav selectOrderById(String memberEmail, String orderId)throws LAVException {
		Order_lav order = null;	
		
		try(
			Connection connection = MySQLConnection_lav.getConnection(); //1,2 取得連線
			PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_BY_ID);//3.準備指令
				) {
			//3.1 傳入?的值
			pstmt.setString(1, memberEmail);
			pstmt.setString(2, orderId);

			try(
				ResultSet rs = pstmt.executeQuery();  //4.執行指令	
					){
				
				while(rs.next()) {//5.處理rs
					if(order==null) {
						order = new Order_lav();
						order.setId(rs.getInt("id"));
						order.setOrderDate(rs.getString("order_date"));
						order.setOrderTime(rs.getString("order_time"));	
						order.setStatus(rs.getInt("status"));
				
						Customer_lav member = new Customer_lav();
						member.setEmail(rs.getString("member_email"));
						order.setMember(member);
						
						order.setShippingType(rs.getString("shipping_type"));
						order.setShippingFee(rs.getDouble("shipping_fee"));
						order.setShippingNote(rs.getString("shipping_note"));
						
						order.setPaymentType(rs.getString("payment_type"));
						order.setPaymentFee(rs.getDouble("payment_fee"));
						order.setPaymentNote(rs.getString("payment_note"));
						
						order.setRecipientName(rs.getString("recipient_name"));
						order.setRecipientEmail(rs.getString("recipient_email"));
						order.setRecipientPhone(rs.getString("recipient_phone"));
						order.setShippingAddress(rs.getString("shipping_address"));
						
					}
		
					OrderItem_lav orderItem = new OrderItem_lav();
					
					Product_lav p = new Product_lav();
					p.setId(rs.getInt("product_id"));
					p.setName(rs.getString("p_name"));
					p.setPhotoUrl(rs.getString("photo_url"));
					orderItem.setProduct(p);

					Flavor_lav flavor = new Flavor_lav();
					flavor.setFlavorName(rs.getString("flavor_name"));
					flavor.setPhotoUrl(rs.getString("flavor_photo"));
					orderItem.setFlavor(flavor);

					Spec_lav spec = new Spec_lav();
					spec.setFlavorName(rs.getString("flavor_name"));
					spec.setSpecName(rs.getString("spec_name"));
					spec.setPhotoUrl(rs.getString("spec_photo"));
					orderItem.setSpec(spec);
					
					orderItem.setPrice(rs.getDouble("price"));
					orderItem.setQuantity(rs.getInt("quantity"));
					
					order.add(orderItem);					
				
				}
			}
			
		} catch (SQLException e) {
			throw new LAVException("查詢訂單明細失敗", e);
		}

		return order;

	}

	private static final String UPDATE_STATUS_TO_TRANSFERED = "UPDATE orders SET status=1" // 狀態設定為已轉帳
			+ ", payment_note=? WHERE status=0 AND payment_type='" + PaymentType_lav.ATM.name()
			+ "' AND id=? AND member_email=?";

	void updateStatusToTransfered(String memberEmail, int orderId, String paymentNote) throws LAVException {
		
		try (
			Connection connection = MySQLConnection_lav.getConnection(); // 2. 建立連線
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_TRANSFERED) // 3. 準備指令
		) {
			
			// 3.1 傳入?的值
			pstmt.setString(1, paymentNote);
			pstmt.setInt(2, orderId);
			pstmt.setString(3, memberEmail);

			// 4. 執行指令
			pstmt.executeUpdate();
		} catch (SQLException ex) {
			throw new LAVException("[通知轉帳]失敗!", ex);
		}
	}

// 查詢order修改紀錄資料
	private static final String SELECT_ORDER_STATUS_LOG = "SELECT order_id, update_time, old_status, new_status "
			+ " FROM lav.order_logs WHERE order_id=?";
	
	List<OrderStatusLog_lav> selectOrderStatusLog(String orderId) throws LAVException {
		
		List<OrderStatusLog_lav> list = new ArrayList<>();
		
		try (
			Connection connection = MySQLConnection_lav.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_STATUS_LOG);
		) {
			
			// 3.1 傳入?的值
			pstmt.setString(1, orderId);
			
			// 4. 執行指令
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					OrderStatusLog_lav log = new OrderStatusLog_lav(); // 記得要import OrderStatusLog
					log.setId(rs.getInt("order_id"));
					log.setOldStatus(rs.getInt("old_status"));
					log.setStatus(rs.getInt("new_status"));
					log.setLogTime(rs.getString("update_time"));
					list.add(log);
				}
			}
			return list;
		} catch (SQLException ex) {
			throw new LAVException("查詢訂單狀態Log失敗", ex);
		}
	}

//	紀錄信用卡付款相關資料	
	 private static final String UPDATE_STATUS_TO_PAID = "UPDATE orders"
		        + " SET status=2"   //狀態設定為已付款
		            + ", payment_note=? WHERE member_email=? AND id=?"
		            + " AND status=0" + " AND payment_type='" + PaymentType_lav.CARD.name() + "'";

	    void updateOrderStatusToPAID(String memberEmail, int orderId, String paymentNote) throws LAVException {
	    	
	        try (Connection connection = MySQLConnection_lav.getConnection(); //2. 建立連線
	             PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_PAID) //3. 準備指令
	        ) {
	            //3.1 傳入?的值
	            pstmt.setString(1, paymentNote);
	            pstmt.setString(2, memberEmail);
	            pstmt.setInt(3, orderId); 

	            //4. 執行指令
	            pstmt.executeUpdate();
	        } catch (SQLException ex) {
	            System.out.println("修改信用卡付款入帳狀態失敗-" + ex);
	            throw new LAVException("修改信用卡付款入帳狀態失敗!", ex);
	        }
	    }

}

