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
-- Table structure for table `order_logs`
--

DROP TABLE IF EXISTS `order_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int unsigned NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `old_status` int NOT NULL,
  `new_status` int NOT NULL,
  `payment_note` varchar(120) DEFAULT NULL,
  `shipping_note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_logs`
--

LOCK TABLES `order_logs` WRITE;
/*!40000 ALTER TABLE `order_logs` DISABLE KEYS */;
INSERT INTO `order_logs` VALUES (1,8,'2024-02-20 07:07:06',0,1,NULL,'test'),(2,27,'2024-02-22 09:43:08',0,2,'paymentNote = 信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-02-22T17:39:31',NULL),(3,28,'2024-02-22 09:45:50',0,2,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-02-22T17:45:50.869098',NULL),(4,29,'2024-02-23 16:21:52',0,2,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-02-24T00:21:52.133849700',NULL),(5,33,'2024-02-27 09:47:07',0,2,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-02-27T17:47:07.606242900',NULL),(6,34,'2024-02-28 14:16:21',0,2,'信用卡號:4311-95**-****2222,授權碼:777777,交易時間:2024-02-28T22:16:21.298272600',NULL);
/*!40000 ALTER TABLE `order_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-28 22:19:34
