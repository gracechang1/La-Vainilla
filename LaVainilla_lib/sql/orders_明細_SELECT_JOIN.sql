/* E11查詢訂單明細(SELECT_ORDERS_HISTORY) */
SELECT orders.id, member_email, order_date, order_time, status, 
	shipping_type, shipping_fee, shipping_note, payment_type, payment_fee, payment_note, 
    recipient_name, recipient_email, recipient_phone, shipping_address,
    product_id, products.name as p_name, flavor_name, spec_name, price, quantity
    , products.photo_url
    FROM orders JOIN order_items ON orders.id = order_items.order_id
		JOIN products ON order_items.product_id = products.id
	WHERE member_email="test123@uuu.com.tw" AND orders.id='5';
    
/* E11查詢訂單明細(SELECT_ORDER_BY_ID) */
SELECT orders.id, member_email, order_date, order_time, status, 
	shipping_type, shipping_fee, shipping_note, payment_type, payment_fee, payment_note, 
    recipient_name, recipient_email, recipient_phone, shipping_address,
    order_items.product_id, products.name as p_name, order_items.flavor_name, order_items.spec_name, price, quantity
    , product_flavor_specs.photo_url AS spec_photo, product_flavors.photo_url AS flavor_photo, products.photo_url 
    FROM orders JOIN order_items ON orders.id = order_items.order_id
		JOIN products ON order_items.product_id = products.id
        LEFT JOIN product_flavors ON order_items.product_id = product_flavors.product_id AND order_items.flavor_name = product_flavors.flavor_name
        LEFT JOIN product_flavor_specs ON order_items.product_id = product_flavor_specs.product_id 
					AND order_items.flavor_name = product_flavor_specs.flavor_name AND order_items.spec_name = product_flavor_specs.spec_name
	WHERE member_email='test123@uuu.com.tw' AND orders.id='5';    