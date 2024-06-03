SELECT * FROM lav.customers;

UPDATE `lav`.`customers` SET `birthday` = '1976-12-20' WHERE (`email` = 'test678@uuu.com.tw');

/*UPDATE
UPDATE customers SET 
	name=?, birthday=?, gender=?, email=?, password=?, phone=?, address=?, subscribed=?
	WHERE(email=?);
*/    