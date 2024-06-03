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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'test234@uuu.com.tw','2024-02-19','01:05:18',0,'HOME',120,NULL,'ATM',0,NULL,'張二方','test234@uuu.com.tw','0923456789','台北市復興南路99號2樓'),(4,'test234@uuu.com.tw','2024-02-19','01:10:02',0,'HOME',120,NULL,'ATM',0,NULL,'張二方','test234@uuu.com.tw','0923456789','台北市復興南路99號2樓'),(5,'test123@uuu.com.tw','2024-02-19','17:25:15',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(6,'test123@uuu.com.tw','2024-02-19','17:59:57',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(7,'test123@uuu.com.tw','2024-02-19','18:39:56',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(8,'test123@uuu.com.tw','2024-02-19','21:36:56',1,'HOME',120,'test','ATM',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市復興北路99號1樓'),(9,'test123@uuu.com.tw','2024-02-20','15:28:34',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(10,'test123@uuu.com.tw','2024-02-20','15:58:25',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','高雄市大樹區學城路一段10號'),(11,'test123@uuu.com.tw','2024-02-20','17:09:27',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號'),(12,'test123@uuu.com.tw','2024-02-20','18:04:35',0,'SHOP',0,NULL,'SHOP',0,NULL,'張一方','test123@uuu.com.tw','0912345678','台北市信義區市府路45號');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-20 22:16:35
