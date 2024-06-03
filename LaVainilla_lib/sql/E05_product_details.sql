SELECT id, flavor_name, spec_flavor_group, spec_name_group, spec_count, name,
	unit_price, discount, spec_unit_price_group, spec_unit_price_min, spec_unit_price_max,
    stock, flavor_old_stock , totproduct_detailsal_spec_stock, flavor_stock, spec_stock_group, 
    expiration_date, category, origin, description, photo_url, flavor_photo, product_id, icon_url, ordinal
 FROM product_details_view;
 
 /* for AJAX */
 SELECT product_id, flavor_name, spec_name,
	product_flavor_specs.unit_price AS list_price,
    product_flavor_specs.unit_price * (100-discount)/100 AS price,
	product_flavor_specs.stock,
    product_flavor_specs.photo_url, ordinal
  FROM product_flavor_specs JOIN products 
	ON products.id = product_flavor_specs.product_id
 WHERE products.id = "1" AND flavor_name = '' ORDER BY ordinal;  