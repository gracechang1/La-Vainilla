SELECT name, birthday, gender, email, password, phone, address, subscribed, discount
	FROM customers;
    
/*登入會員
SELECT name, birthday, gender, email, password, phone, address, subscribed
	FROM customers WHERE email=?;
*/

/*登入會員(含discount)
SELECT name, birthday, gender, email, password, phone, address, subscribed, discount
	FROM customers WHERE email=?;
*/

/*註冊會員
INSERT INTO customers (name, birthday, gender, email, password, phone, address, subscribed) 
	VALUES (?,?,?, ?,?,?, ?,?)
 */
