USE lav;
SELECT * FROM products;
SELECT * FROM product_flavors;

/* cross join */
SELECT * FROM products CROSS JOIN product_flavors;

/* inner join */
SELECT id, name, unit_price, products.stock, expiration_date, category,  products.photo_url, origin, description, discount,
 product_id, flavor_name, product_flavors.stock AS flavor_stock, product_flavors.photo_url AS flavor_photo, icon_url, ordinal
 FROM products INNER JOIN product_flavors
 ON products.id = product_flavors.product_id WHERE id = 6; 

/* LEFT OUTER JOIN */
SELECT id, name, unit_price, products.stock, expiration_date, category,  products.photo_url, origin, description, discount,
 product_id, flavor_name, product_flavors.stock AS flavor_stock , product_flavors.photo_url AS flavor_photo, icon_url, ordinal
 FROM products LEFT JOIN product_flavors
 ON products.id = product_flavors.product_id WHERE id = 7 ORDER BY ordinal;

/* RIGHT OUTER JOIN */
SELECT id, name, unit_price, products.stock, expiration_date, category,  products.photo_url, origin, description, discount,
 product_id, flavor_name, product_flavors.stock AS flavor_stock , product_flavors.photo_url AS flavor_photo, icon_url, ordinal
 FROM product_flavors RIGHT JOIN products
 ON products.id = product_flavors.product_id WHERE id = 8;

/* 將同一產品不同口味stock加總 */
SELECT id, name, unit_price, products.stock, SUM(product_flavors.stock) AS total_stock, expiration_date, category, 
 products.photo_url, origin, description, discount
 FROM products LEFT JOIN product_flavors 
 ON products.id = product_flavors.product_id WHERE id = 7 ORDER BY ordinal;

