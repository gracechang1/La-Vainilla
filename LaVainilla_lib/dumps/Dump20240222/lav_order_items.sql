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
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `flavor_name` varchar(10) NOT NULL DEFAULT '',
  `spec_name` varchar(30) NOT NULL DEFAULT '',
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`,`flavor_name`,`spec_name`),
  KEY `FKEY_order_items_TO_products_idx` (`product_id`),
  CONSTRAINT `FKEY_order_items_TO_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FKEY_order_items_TO_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,6,'焦糖','',90,1),(1,7,'抹茶','',65,1),(1,9,'杏仁','75毫升',450,2),(1,9,'香橙','150毫升',540,1),(4,6,'焦糖','',90,1),(4,7,'抹茶','',65,1),(4,9,'杏仁','75毫升',450,2),(4,9,'香橙','150毫升',540,1),(5,1,'','2公克',64,1),(6,1,'','2公克',64,1),(7,4,'','',200,1),(8,8,'焦糖','',45,1),(9,3,'','40公克',240,1),(10,2,'','2公克',48,1),(11,1,'','2公克',64,1),(12,1,'','2公克',64,1),(13,1,'','3公克',72,1),(14,1,'','2公克',64,1),(15,1,'','2公克',64,1),(16,1,'','2公克',64,1),(17,1,'','2公克',64,1),(18,1,'','2公克',64,1),(19,1,'','2公克',64,1),(20,1,'','2公克',64,1),(21,1,'','2公克',64,1),(22,1,'','2公克',64,1),(23,1,'','2公克',64,1),(24,1,'','2公克',64,1),(25,1,'','2公克',64,1),(26,1,'','2公克',64,1),(27,1,'','2公克',64,1),(28,1,'','2公克',64,1);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-22 17:49:13
