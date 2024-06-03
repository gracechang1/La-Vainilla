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
  `photo_url` varchar(300) DEFAULT NULL,
  `origin` varchar(20) DEFAULT NULL,
  `description` varchar(300) NOT NULL DEFAULT '',
  `discount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'馬達加斯加香草莢',80,100,'2024-08-15','原料','https://down-tw.img.susercontent.com/file/sg-11134201-22100-0urqfz1omaiv3c','巴布亞新幾內亞','風味特色: 蘭姆酒、焦糖、奶油、莓果、葡萄乾、木質、煙燻，交織出濃郁無比的迷人奶香。',20),(2,'大溪地香草莢',60,90,'2024-07-15','原料','https://down-tw.img.susercontent.com/file/tw-11134207-7r98o-lnx4h2hbdsf1d7','印尼','蜜餞、葡萄乾、花香、果香，展現壯闊絕美的優雅風味。',20),(3,'天然香草籽醬',300,80,'2024-06-15','原料','https://down-tw.img.susercontent.com/file/c1fc7eff0e39a604d9de8e633da237f0','德國','以馬達加斯加波本香草莢與香草香料所製成，以天然香料與天然色料所製成，不含任何人工色料與人工香料，更不含任何添加物、防腐劑等。',20),(4,'有機香草精',200,70,'2024-05-15','原料','https://down-tw.img.susercontent.com/file/13debfc3ce540bd53cdf330f070cab00','美國','精選世界最好的有機香草豆，萃取其香味精華，以有機酒精將其濃郁的香味完整保存。',0),(5,'優奇香草精',100,60,'2024-04-15','原料','https://down-tw.img.susercontent.com/file/1ddde2e6174fe9b3015fe19b6503e8f7','台灣','可代替香草粉.香草莢使用 使用於烘焙蛋糕.餅乾.甜點...等，可去除蛋腥味，增加烘焙香氣。',0),(6,'可麗露',90,50,'2024-03-15','甜品','https://cdn.store-assets.com/s/860819/i/68162902.jpeg?width=1024&format=webp','台灣','源自法國的甜點可麗露，因小巧可愛的外型與令人驚豔的口感，而有「天使之鈴」的美稱。',0),(7,'泡芙',65,40,'2024-04-20','甜品','https://im.marieclaire.com.tw/s800c450h100b0/\nassets/mc/202306/647D84CEA235F1685947598.jpeg','台灣','泡芙，台灣又稱「奶油空心餅」，是一種源自法國的球形糕點。',0),(8,'昭和風硬布丁',45,40,'2024-05-20','甜品','https://scontent.ftpe7-3.fna.fbcdn.net/v/t1.18169-9/14937291_583333195187860_6511687022314147368_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=c2f564&_nc_ohc=DXDPSiJyfDcAX9SMeyB&_nc_ht=scontent.ftpe7-3.fna&oh=00_AfBXKTLQsq0gQzRFBjqPpjlI1Ml03cLyyYyvRYJ9hVLFPQ&oe=65F2B8A3','台灣','不同於一般的焦糖布丁，有著截然不同的成熟韻味，在脫模後的布丁上擠一圈香緹鮮奶油，放上一顆鮮紅可愛的糖漬櫻桃，既懷舊又優雅。',0),(9,'香草淡香精',400,10,'2025-06-20','香氛','https://www.acquadiparma.com.tw/wp-content/uploads/2023/10/ACQUA-DI-PARMA-%E8%97%8D%E8%89%B2%E5%9C%B0%E4%B8%AD%E6%B5%B7%E8%A5%BF%E8%A5%BF%E9%87%8C%E5%B3%B6%E6%9D%8F%E4%BB%81%E4%B8%AD%E6%80%A7%E6%B7%A1%E9%A6%99%E6%B0%B4-01.jpg','義大利','帕爾瑪之水藍色地中海系列精選地中海7大島嶼和古城，汲取義大利歷史文化之精髓，從中擷取無數閃光的靈感。',10);
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

-- Dump completed on 2024-02-14 12:52:18
