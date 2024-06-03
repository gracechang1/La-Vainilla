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
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `unit_price` double NOT NULL,
  `stock` int NOT NULL,
  `expiration_date` date NOT NULL,
  `category` varchar(10) NOT NULL,
  `photo_url` varchar(250) DEFAULT NULL,
  `origin` varchar(20) DEFAULT NULL,
  `length` varchar(20) DEFAULT NULL,
  `weight` varchar(20) DEFAULT NULL,
  `description` varchar(300) NOT NULL DEFAULT '',
  `discount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'馬達加斯加香草莢',80,50,'2024-08-15','香草莢','https://down-tw.img.susercontent.com/file/sg-11134201-22100-0urqfz1omaiv3c','巴布亞新幾內亞','17-18','2-3','風味特色: 蘭姆酒、焦糖、奶油、莓果、葡萄乾、木質、煙燻，交織出濃郁無比的迷人奶香。',20),(2,'大溪地香草莢',60,40,'2024-07-15','香草莢','https://down-tw.img.susercontent.com/file/tw-11134207-7r98o-lnx4h2hbdsf1d7','印尼','15-16','2-3','蜜餞、葡萄乾、花香、果香，展現壯闊絕美的優雅風味',20),(3,'天然香草籽醬',300,30,'2024-06-15','香草醬','https://down-tw.img.susercontent.com/file/c1fc7eff0e39a604d9de8e633da237f0','德國',NULL,'100','以馬達加斯加波本香草莢與香草香料所製成，以天然香料與天然色料所製成，不含任何人工色料與人工香料，更不含任何添加物、防腐劑等。',20),(4,'有機香草精',200,20,'2024-05-15','香草精','https://down-tw.img.susercontent.com/file/13debfc3ce540bd53cdf330f070cab00','美國',NULL,'60','精選世界最好的有機香草豆，萃取其香味精華，以有機酒精將其濃郁的香味完整保存。',0),(5,'優奇香草精',100,10,'2024-04-15','香草精','https://down-tw.img.susercontent.com/file/1ddde2e6174fe9b3015fe19b6503e8f7','台灣',NULL,'40','可代替香草粉.香草莢使用 使用於烘焙蛋糕.餅乾.甜點...等，可去除蛋腥味，增加烘焙香氣。',0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-10 17:14:50
