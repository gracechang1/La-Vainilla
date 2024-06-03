DROP VIEW IF EXISTS products_list_view;

/*E04-a 查詢全部*/
CREATE VIEW products_list_view AS
SELECT id, name, IFNULL(MIN(product_flavor_specs.unit_price), products.unit_price) AS unit_price, 
	IFNULL(IFNULL(sum(product_flavor_specs.stock) ,sum(product_flavors.stock)), products.stock) AS stock,
	products.photo_url, expiration_date, origin, category, description, discount 
	FROM products 
		LEFT JOIN product_flavors ON products.id=product_flavors.product_id		
        LEFT JOIN product_flavor_specs ON 
			products.id=product_flavor_specs.product_id AND (product_flavors.flavor_name = product_flavor_specs.flavor_name
				OR product_flavors.flavor_name IS NULL)
    GROUP BY id;