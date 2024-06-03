INSERT INTO orders
	(id, member_email, order_date, order_time, status,
		shipping_type, shipping_fee, payment_type, payment_fee, 
        recipient_name, recipient_email, recipient_phone, shipping_address)
	VALUES(?,?,?,?,0,?,?,?,?, ?,?,?,?);
    
INSERT INTO order_items  
	(order_id, product_id, flavor_name, spec_name, price, quantity)
    VALUES(?,?,?,?,?,?)