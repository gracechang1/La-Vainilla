-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: lav
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_email` varchar(60) NOT NULL,
  `order_date` date NOT NULL,
  `order_time` time NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `shipping_type` varchar(10) NOT NULL,
  `shipping_fee` double NOT NULL,
  `shipping_note` varchar(100) DEFAULT NULL,
  `payment_type` varchar(10) NOT NULL,
  `payment_fee` double NOT NULL,
  `payment_note` varchar(100) DEFAULT NULL,
  `recipient_name` varchar(20) NOT NULL,
  `recipient_email` varchar(60) NOT NULL,
  `recipient_phone` varchar(20) NOT NULL,
  `shipping_address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKEY_orders_TO_customers_idx` (`member_email`),
  CONSTRAINT `FKEY_orders_TO_customers` FOREIGN KEY (`member_email`) REFERENCES `customers` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'test234@uuu.com.tw','2024-02-19','01:05:18',0,'HOME',120,NULL,'ATM',0,NULL,'張二方','test234@uuu.com.tw','0923456789','台北市復興南路99號2樓'),(4,'test234@uuu.com.tw','2024-02-19','01:10:02',0,'HOME',120,NULL,'ATM',0,NULL,'張二方','test234@uuu.com.tw','0923456789','台北市復興南路99號2樓'),(5,'test123@uuu.com.tw','2024-02-19','17:25:15',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(6,'test123@uuu.com.tw','2024-02-19','17:59:57',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(7,'test123@uuu.com.tw','2024-02-19','18:39:56',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(8,'test123@uuu.com.tw','2024-02-19','21:36:56',1,'HOME',120,'test','ATM',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市復興北路99號1樓'),(9,'test123@uuu.com.tw','2024-02-20','15:28:34',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(10,'test123@uuu.com.tw','2024-02-20','15:58:25',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','高雄市大樹區學城路一段10號'),(11,'test123@uuu.com.tw','2024-02-20','17:09:27',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(12,'test123@uuu.com.tw','2024-02-20','18:04:35',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(13,'test123@uuu.com.tw','2024-02-22','09:34:15',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(14,'test123@uuu.com.tw','2024-02-22','09:36:27',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(15,'test123@uuu.com.tw','2024-02-22','09:38:31',0,'STORE',60,NULL,'STORE',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家慶城店,台北市松山區慶城街8號,店號:2710'),(16,'test123@uuu.com.tw','2024-02-22','09:39:57',0,'STORE',60,NULL,'CARD',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家慶城店,台北市松山區慶城街8號,店號:2710'),(17,'test123@uuu.com.tw','2024-02-22','09:41:09',0,'STORE',60,NULL,'STORE',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家慶城店,台北市松山區慶城街8號,店號:2710'),(18,'test123@uuu.com.tw','2024-02-22','11:18:54',0,'HOME',120,NULL,'ATM',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市復興北路99號1樓'),(19,'test123@uuu.com.tw','2024-02-22','11:21:53',0,'HOME',120,NULL,'CARD',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市復興北路99號1樓'),(20,'test123@uuu.com.tw','2024-02-22','11:59:03',0,'STORE',60,NULL,'STORE',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家慶城店,台北市松山區慶城街8號,店號:2710'),(21,'test123@uuu.com.tw','2024-02-22','12:35:47',0,'STORE',60,NULL,'CARD',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家慶城店,台北市松山區慶城街8號,店號:2710'),(22,'test123@uuu.com.tw','2024-02-22','12:39:15',0,'STORE',60,NULL,'STORE',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家慶城店,台北市松山區慶城街8號,店號:2710'),(23,'test123@uuu.com.tw','2024-02-22','15:06:11',0,'STORE',60,NULL,'CARD',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家慶城店,台北市松山區慶城街8號,店號:2710'),(24,'test123@uuu.com.tw','2024-02-22','15:54:23',0,'STORE',60,NULL,'CARD',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家慶城店,台北市松山區慶城街8號,店號:2710'),(25,'test123@uuu.com.tw','2024-02-22','17:06:45',0,'STORE',60,NULL,'CARD',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家長復店,台北市松山區長安東路二段219號,店號:4281'),(26,'test123@uuu.com.tw','2024-02-22','17:37:40',0,'STORE',60,NULL,'CARD',0,NULL,'張一方','test123@uuu.com.tw','0912345678','全家長復店,台北市松山區長安東路二段219號,店號:4281'),(27,'test123@uuu.com.tw','2024-02-22','17:39:07',2,'STORE',60,NULL,'CARD',0,'paymentNote = 信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-02-22T17:39:31','張一方','test123@uuu.com.tw','0912345678','全家長復店,台北市松山區長安東路二段219號,店號:4281'),(28,'test123@uuu.com.tw','2024-02-22','17:45:28',2,'STORE',60,NULL,'CARD',0,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-02-22T17:45:50.869098','張一方','test123@uuu.com.tw','0912345678','全家長復店,台北市松山區長安東路二段219號,店號:4281');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_orders_status` AFTER UPDATE ON `orders` FOR EACH ROW INSERT INTO order_logs(order_id, old_status, new_status, payment_note, shipping_note) 
		VALUES (new.id, old.status, new.status, new.payment_note, new.shipping_note) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-22 17:49:13
