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
-- Table structure for table `product_flavor_specs`
--

DROP TABLE IF EXISTS `product_flavor_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_flavor_specs` (
  `product_id` int NOT NULL,
  `flavor_name` varchar(10) NOT NULL,
  `spec_name` varchar(30) NOT NULL,
  `unit_price` double NOT NULL,
  `stock` int NOT NULL,
  `photo_url` varchar(300) DEFAULT NULL,
  `ordinal` int DEFAULT NULL,
  PRIMARY KEY (`product_id`,`flavor_name`,`spec_name`),
  CONSTRAINT `FKEY_product_flavor_specs_TO_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_flavor_specs`
--

LOCK TABLES `product_flavor_specs` WRITE;
/*!40000 ALTER TABLE `product_flavor_specs` DISABLE KEYS */;
INSERT INTO `product_flavor_specs` VALUES (1,'','2公克',80,60,'',1),(1,'','3公克',90,40,'',2),(2,'','2公克',60,50,'',1),(2,'','3公克',70,40,'',2),(3,'','40公克',300,50,'',1),(3,'','80公克',400,30,'',2),(9,'杏仁','150毫升',600,1,NULL,3),(9,'杏仁','30毫升',400,2,NULL,1),(9,'杏仁','75毫升',500,2,NULL,2),(9,'香橙','150毫升',600,1,NULL,3),(9,'香橙','30毫升',400,2,NULL,1),(9,'香橙','75毫升',500,2,NULL,2);
/*!40000 ALTER TABLE `product_flavor_specs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-20 22:16:34
