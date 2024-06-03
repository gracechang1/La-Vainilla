SELECT * FROM lav.products;

USE lav;
SELECT id, name, unit_price, stock, expiration_date, category, photo_url, origin, description, discount 
	FROM lav.products;

/*新增產品*/
INSERT INTO `lav`.`products` (`name`, `unit_price`, `stock`, `expiration_date`, `category`, `photo_url`, `origin`, `description`) 
	VALUES ('優奇香草精', '100', '10', '2024-04-15', '香草精', 'https://down-tw.img.susercontent.com/file/1ddde2e6174fe9b3015fe19b6503e8f7', '台灣' ,  `可代替香草粉.香草莢使用 使用於烘焙蛋糕.餅乾.甜點...等，可去除蛋腥味，增加烘焙香氣。`);

/*新增產品
INSERT INTO `lav`.`products` (id, name, unit_price, stock, expiration_date, category, photo_url, origin, description, discount)
	VALUES(?,?,?,?,?,?,?,?,?,?,?,?);
*/

/*依關鍵字查詢
SELECT id, name, unit_price, stock, expiration_date, category, photo_url, origin, description, discount
	FROM products WHERE name LIKE ?;
*/    
 
/*依分類查詢
SELECT id, name, unit_price, stock, expiration_date, category, photo_url, origin, description, discount
	FROM products WHERE category=?;
*/  

/*查詢越晚到期的產品
  SELECT id, name, unit_price, stock, expiration_date, category, photo_url, origin, description, discount
	FROM products ORDER BY expiration_date DESC LIMIT 5;
*/   
  
  /*查詢指定代號的產品
  SELECT id, name, unit_price, stock, expiration_date, category, photo_url, origin, description, discount 
	FROM lav.products WHERE id=?;
  
  */
  