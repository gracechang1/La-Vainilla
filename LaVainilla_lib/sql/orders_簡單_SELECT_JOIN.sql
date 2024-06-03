/* E10查詢歷史訂單 */
SELECT id, order_date, order_time, status, shipping_type, shipping_fee, payment_type, payment_fee,
	SUM(price*quantity) as total_amount
	FROM orders JOIN order_items ON orders.id=order_items.order_id
	WHERE member_email="test123@uuu.com.tw" AND order_date BETWEEN date_add(curdate(),INTERVAL -1 MONTH) AND curdate()
    GROUP BY orders.id ORDER BY order_date DESC, order_time DESC;

SELECT id, order_date, order_time, status, shipping_type, shipping_fee, payment_type, payment_fee,
	SUM(price*quantity) as total_amount
	FROM orders JOIN order_items ON orders.id=order_items.order_id
	WHERE  member_email="test123@uuu.com.tw" AND order_date BETWEEN date_add(curdate(),INTERVAL -6 MONTH) AND curdate()    
    GROUP BY orders.id 
    ORDER BY order_date DESC, order_time DESC;
    
SELECT id, order_date, order_time, status, shipping_type, shipping_fee, payment_type, payment_fee,
	SUM(price*quantity) as total_amount
	FROM orders JOIN order_items ON orders.id=order_items.order_id
	WHERE  member_email="test123@uuu.com.tw" AND order_date BETWEEN date_add(curdate(),INTERVAL -2 YEAR) AND curdate()
    GROUP BY orders.id 
    ORDER BY order_date DESC, order_time DESC;