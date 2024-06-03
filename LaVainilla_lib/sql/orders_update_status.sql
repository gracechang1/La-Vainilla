/*通知轉帳*/
UPDATE `lav`.`orders` SET `status` = '1', `payment_note` = ?
	WHERE (`id` = ? AND status=0 AND payment_type='ATM' AND member_id=?);
    
/*信用卡*/
UPDATE `lav`.`orders` SET `status` = '2', `payment_note` = ?
	WHERE (`id` = ? AND status=0 AND payment_type='CARD' AND member_id=?);    