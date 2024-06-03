/* use lav;*/

DROP TABLE IF EXISTS order_logs;
CREATE TABLE `order_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int unsigned NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `old_status` int NOT NULL ,
  `new_status` int NOT NULL ,
  `payment_note` varchar(120) DEFAULT NULL,
  `shipping_note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TRIGGER IF EXISTS log_orders_status;
CREATE TRIGGER log_orders_status AFTER UPDATE ON orders FOR EACH ROW
    INSERT INTO order_logs(order_id, old_status, new_status, payment_note, shipping_note) 
		VALUES (new.id, old.status, new.status, new.payment_note, new.shipping_note);
COMMIT;