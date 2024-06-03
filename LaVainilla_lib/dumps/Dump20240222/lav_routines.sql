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
-- Temporary view structure for view `products_list_view`
--

DROP TABLE IF EXISTS `products_list_view`;
/*!50001 DROP VIEW IF EXISTS `products_list_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `products_list_view` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `unit_price`,
 1 AS `stock`,
 1 AS `photo_url`,
 1 AS `expiration_date`,
 1 AS `origin`,
 1 AS `category`,
 1 AS `description`,
 1 AS `discount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `product_details_view`
--

DROP TABLE IF EXISTS `product_details_view`;
/*!50001 DROP VIEW IF EXISTS `product_details_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `product_details_view` AS SELECT 
 1 AS `id`,
 1 AS `flavor_name`,
 1 AS `spec_flavor_group`,
 1 AS `spec_name_group`,
 1 AS `spec_count`,
 1 AS `name`,
 1 AS `unit_price`,
 1 AS `discount`,
 1 AS `spec_unit_price_group`,
 1 AS `spec_unit_price_min`,
 1 AS `spec_unit_price_max`,
 1 AS `stock`,
 1 AS `flavor_old_stock`,
 1 AS `totproduct_detailsal_spec_stock`,
 1 AS `flavor_stock`,
 1 AS `spec_stock_group`,
 1 AS `expiration_date`,
 1 AS `category`,
 1 AS `origin`,
 1 AS `description`,
 1 AS `photo_url`,
 1 AS `flavor_photo`,
 1 AS `product_id`,
 1 AS `icon_url`,
 1 AS `ordinal`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `products_list_view`
--

/*!50001 DROP VIEW IF EXISTS `products_list_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `products_list_view` AS select `products`.`id` AS `id`,`products`.`name` AS `name`,ifnull(min(`product_flavor_specs`.`unit_price`),`products`.`unit_price`) AS `unit_price`,ifnull(ifnull(sum(`product_flavor_specs`.`stock`),sum(`product_flavors`.`stock`)),`products`.`stock`) AS `stock`,`products`.`photo_url` AS `photo_url`,`products`.`expiration_date` AS `expiration_date`,`products`.`origin` AS `origin`,`products`.`category` AS `category`,`products`.`description` AS `description`,`products`.`discount` AS `discount` from ((`products` left join `product_flavors` on((`products`.`id` = `product_flavors`.`product_id`))) left join `product_flavor_specs` on(((`products`.`id` = `product_flavor_specs`.`product_id`) and ((`product_flavors`.`flavor_name` = `product_flavor_specs`.`flavor_name`) or (`product_flavors`.`flavor_name` is null))))) group by `products`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `product_details_view`
--

/*!50001 DROP VIEW IF EXISTS `product_details_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `product_details_view` AS select `products`.`id` AS `id`,`product_flavors`.`flavor_name` AS `flavor_name`,group_concat(`product_flavor_specs`.`flavor_name` separator ',') AS `spec_flavor_group`,group_concat(`product_flavor_specs`.`spec_name` order by `product_flavor_specs`.`ordinal` ASC separator ',') AS `spec_name_group`,count(`product_flavor_specs`.`spec_name`) AS `spec_count`,`products`.`name` AS `name`,ifnull(min(`product_flavor_specs`.`unit_price`),`products`.`unit_price`) AS `unit_price`,`products`.`discount` AS `discount`,group_concat(`product_flavor_specs`.`unit_price` order by `product_flavor_specs`.`ordinal` ASC separator ',') AS `spec_unit_price_group`,min(`product_flavor_specs`.`unit_price`) AS `spec_unit_price_min`,max(`product_flavor_specs`.`unit_price`) AS `spec_unit_price_max`,ifnull(sum(`product_flavor_specs`.`stock`),`products`.`stock`) AS `stock`,`product_flavors`.`stock` AS `flavor_old_stock`,sum(`product_flavor_specs`.`stock`) AS `totproduct_detailsal_spec_stock`,ifnull(sum(`product_flavor_specs`.`stock`),`product_flavors`.`stock`) AS `flavor_stock`,group_concat(`product_flavor_specs`.`stock` order by `product_flavor_specs`.`ordinal` ASC separator ',') AS `spec_stock_group`,`products`.`expiration_date` AS `expiration_date`,`products`.`category` AS `category`,`products`.`origin` AS `origin`,`products`.`description` AS `description`,`products`.`photo_url` AS `photo_url`,`product_flavors`.`photo_url` AS `flavor_photo`,`product_flavors`.`product_id` AS `product_id`,`product_flavors`.`icon_url` AS `icon_url`,`product_flavors`.`ordinal` AS `ordinal` from ((`products` left join `product_flavors` on((`products`.`id` = `product_flavors`.`product_id`))) left join `product_flavor_specs` on(((`products`.`id` = `product_flavor_specs`.`product_id`) and ((`product_flavors`.`flavor_name` = `product_flavor_specs`.`flavor_name`) or (`product_flavors`.`flavor_name` is null))))) group by `products`.`id`,`product_flavors`.`flavor_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-22 17:49:13
