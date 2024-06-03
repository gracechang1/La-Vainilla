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
-- Table structure for table `product_flavors`
--

DROP TABLE IF EXISTS `product_flavors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_flavors` (
  `product_id` int NOT NULL,
  `flavor_name` varchar(10) NOT NULL,
  `stock` int NOT NULL,
  `photo_url` varchar(300) DEFAULT NULL,
  `icon_url` varchar(250) DEFAULT NULL,
  `ordinal` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`flavor_name`),
  CONSTRAINT `FKEY_product_flavors_TO_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_flavors`
--

LOCK TABLES `product_flavors` WRITE;
/*!40000 ALTER TABLE `product_flavors` DISABLE KEYS */;
INSERT INTO `product_flavors` VALUES (6,'伯爵紅茶',16,'https://shoplineimg.com/5baafbf85f9cf10005b5b5a4/6513c5cf492b7e0014224677/800x.webp?source_format=png',NULL,0),(6,'威士忌',14,'https://scontent.ftpe7-4.fna.fbcdn.net/v/t1.6435-9/126971096_196986215389378_6240911695060533554_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=dd63ad&_nc_ohc=cPBK_YxrHLsAX9mXRp3&_nc_ht=scontent.ftpe7-4.fna&oh=00_AfAVRB-RwYToefKXq10nO3zJbm6D3IrfJFIPGKOSGwVEkA&oe=65F0052B',NULL,0),(6,'焦糖',20,'https://lh3.googleusercontent.com/p/AF1QipNtUtHHZb2S0kSooJaGKTwjh4_2XQBBUk61hahD=s1360-w1360-h1020',NULL,0),(7,'巧克力',10,'https://shoplineimg.com/5bc40aca5f9cf10005b5b92a/6316f6e9321a100010250c16/800x.webp?source_format=jpg',NULL,0),(7,'抹茶',10,'https://shoplineimg.com/5bc40aca5f9cf10005b5b92a/638da6df3447ba0022a31859/800x.webp?source_format=jpg',NULL,0),(7,'生乳',20,'https://shoplineimg.com/5bc40aca5f9cf10005b5b92a/6316f69f49cce96f35d7d692/800x.webp?source_format=jpg',NULL,0),(8,'焦糖',20,'https://shoplineimg.com/651545117bdc4c00649a8c73/6536341c51fbfe001192ad4a/800x.webp?source_format=jpg',NULL,0),(8,'酒香',20,'https://www.ningl.tw/wp-content/uploads/2023/05/1683610549-2612922357-g_l.jpg',NULL,0),(9,'杏仁',5,'https://www.acquadiparma.com.tw/wp-content/uploads/2023/10/ACQUA-DI-PARMA-%E8%97%8D%E8%89%B2%E5%9C%B0%E4%B8%AD%E6%B5%B7%E8%A5%BF%E8%A5%BF%E9%87%8C%E5%B3%B6%E6%9D%8F%E4%BB%81%E4%B8%AD%E6%80%A7%E6%B7%A1%E9%A6%99%E6%B0%B4-01.jpg',NULL,0),(9,'香橙',5,'https://www.acquadiparma.com.tw/wp-content/uploads/2023/10/ACQUA-DI-PARMA-%E8%97%8D%E8%89%B2%E5%9C%B0%E4%B8%AD%E6%B5%B7%E5%8D%A1%E6%99%AE%E9%87%8C%E5%B3%B6%E6%A9%99%E4%B8%AD%E6%80%A7%E6%B7%A1%E9%A6%99%E6%B0%B4-01.webp',NULL,0);
/*!40000 ALTER TABLE `product_flavors` ENABLE KEYS */;
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
