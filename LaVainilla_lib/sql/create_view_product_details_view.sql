
CREATE VIEW product_details_view AS
SELECT id, product_flavors.flavor_name, 
	group_concat(product_flavor_specs.flavor_name) AS spec_flavor_group,
    group_concat(spec_name ORDER BY product_flavor_specs.ordinal) AS spec_name_group,
    COUNT(spec_name) AS spec_count,
		name, IFNULL(min(product_flavor_specs.unit_price), products.unit_price) AS unit_price, discount,
    group_concat(product_flavor_specs.unit_price ORDER BY product_flavor_specs.ordinal) AS spec_unit_price_group,
    min(product_flavor_specs.unit_price) AS spec_unit_price_min,
	max(product_flavor_specs.unit_price) AS spec_unit_price_max,
	 products.stock, product_flavors.stock AS flavor_old_stock ,	
    SUM(product_flavor_specs.stock) AS totproduct_detailsal_spec_stock, 
    IFNULL(SUM(product_flavor_specs.stock), product_flavors.stock) AS flavor_stock,
	group_concat(product_flavor_specs.stock ORDER BY product_flavor_specs.ordinal) AS spec_stock_group,
	 expiration_date, category, origin, description,
     products.photo_url, product_flavors.photo_url AS flavor_photo,
	 product_flavors.product_id, icon_url,
     product_flavors.ordinal
  FROM products 
	LEFT JOIN product_flavors ON products.id = product_flavors.product_id
    LEFT JOIN product_flavor_specs ON products.id = product_flavor_specs.product_id
		AND( product_flavors.flavor_name = product_flavor_specs.flavor_name
        OR product_flavors.flavor_name IS NULL)
	/*WHERE id =9;*/
  GROUP BY id,  product_flavors.flavor_name; 
