SELECT @@SESSION.sql_mode;

SET SESSION sql_mode= 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

/*
SELECT  id, name, products.unit_price, products.stock, expiration_date, category, products.photo_url, origin, description, discount,
		product_flavors.product_id, product_flavors.flavor_name, product_flavors.stock AS flavor_stock , product_flavors.photo_url, icon_url, product_flavors.ordinal,
		product_flavor_specs.product_id, product_flavor_specs.flavor_name, spec_name, product_flavor_specs.unit_price, product_flavor_specs.stock AS specs_stock , product_flavor_specs.photo_url, product_flavor_specs.ordinal
 FROM products 
	LEFT JOIN product_flavors ON products.id = product_flavors.product_id
    LEFT JOIN product_flavor_specs ON products.id = product_flavor_specs.product_id
		AND( product_flavors.flavor_name = product_flavor_specs.flavor_name
        OR product_flavors.flavor_name IS NULL)
	WHERE id =9;
    */
    
/*Master-details1-details2*/
SELECT  id, name, products.unit_price, products.stock, expiration_date, category, products.photo_url, origin, description, discount,
		product_flavors.product_id, product_flavors.flavor_name, product_flavors.stock AS flavor_stock , product_flavors.photo_url, icon_url, product_flavors.ordinal,
		product_flavor_specs.product_id, product_flavor_specs.flavor_name, spec_name, product_flavor_specs.unit_price, product_flavor_specs.stock AS spec_stock , product_flavor_specs.photo_url, product_flavor_specs.ordinal AS spec_ordinal
		/*SUM(product_color_specs.stock) AS spec_stock,*/
 FROM products 
	LEFT JOIN product_flavors ON products.id = product_flavors.product_id
    LEFT JOIN product_flavor_specs ON products.id = product_flavor_specs.product_id
		AND( product_flavors.flavor_name = product_flavor_specs.flavor_name
        OR product_flavors.flavor_name IS NULL)
	WHERE id <=9;


SELECT id, product_flavors.flavor_name, 
	group_concat(product_flavor_specs.flavor_name) AS spec_flavor_group,
    group_concat(spec_name ORDER BY product_flavor_specs.ordinal) AS spec_name_group,
    COUNT(spec_name) AS spec_count,
		name, products.unit_price, discount,
    group_concat(product_flavor_specs.unit_price * (100-discount)/100 ORDER BY product_flavor_specs.ordinal) AS spec_unit_price_group,
    min(product_flavor_specs.unit_price * (100-discount)/100) AS spec_unit_price_min,
	max(product_flavor_specs.unit_price * (100-discount)/100) AS spec_unit_price_max,
	 products.stock, product_flavors.stock AS flavor_stock ,	
    SUM(product_flavor_specs.stock) AS total_spec_stock, 
    IFNULL(SUM(product_flavor_specs.stock), product_flavors.stock) AS flavor_stock,
	group_concat(product_flavor_specs.stock ORDER BY product_flavor_specs.ordinal) AS spec_stock_group,
	 expiration_date, category, origin, description,
     products.photo_url, product_flavors.photo_url,
	 product_flavors.product_id, icon_url,
     product_flavors.ordinal
  FROM products 
	LEFT JOIN product_flavors ON products.id = product_flavors.product_id
    LEFT JOIN product_flavor_specs ON products.id = product_flavor_specs.product_id
		AND( product_flavors.flavor_name = product_flavor_specs.flavor_name
        OR product_flavors.flavor_name IS NULL)
	/*WHERE id =9;*/
  GROUP BY id,  product_flavors.flavor_name; 
    