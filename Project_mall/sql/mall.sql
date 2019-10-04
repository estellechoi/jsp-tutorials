-- MySQL dump 10.13  Distrib 5.7.19, for Win64 (x86_64)
--
-- Host: localhost    Database: mall
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` char(30) DEFAULT NULL,
  `userid` char(50) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` char(20) DEFAULT NULL,
  `name` char(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `product_list` char(50) DEFAULT NULL,
  `product_main` char(50) DEFAULT NULL,
  `product_detail` char(50) DEFAULT NULL,
  `product_recommend` char(100) DEFAULT NULL,
  `laundry` int(11) DEFAULT NULL,
  `manufactured_date` date DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  `quantity_order` int(11) DEFAULT NULL,
  `quantity_sales` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (9,'p030201030001','satin halter dress',62000,'dress_list.PNG','dress_main.PNG','dress_detail.PNG','',3,'2019-01-01','2019-10-01',100,0),(10,'p03010103100010','mood ops',42000,'mood_list.PNG','mood_main.PNG','mood_detail.PNG','',0,'2019-01-01','2019-10-01',200,0),(11,'p03010101110011','white ops',49000,'white_list.PNG','white_main.PNG','white_detail.PNG','',0,'2019-01-01','2019-10-01',100,0),(12,'p03010104120012','denim ops',34000,'denim_list.PNG','denim_main.PNG','denim_detail.PNG','',0,'2019-01-01','2019-10-01',100,0),(13,'p03010201130013','unbalance mini ops',312000,'unbalance_list.PNG','unbalance_main.PNG','unbalance_detail.PNG','',2,'2019-01-01','2019-10-01',50,0),(14,'p03010203140014','angel ops',280000,'angel_list.PNG','angel_main.PNG','angel_detail.PNG','',2,'2019-01-01','2019-10-01',50,0),(15,'p03010203150015','isabelle ops',120000,'isabelle_list.PNG','isabelle_main.PNG','isabelle_detail.PNG','',0,'2019-01-01','2019-10-01',100,0),(16,'p03010203160016','grazia ops',78000,'grazia_list.PNG','grazia_main.PNG','grazia_detail.PNG','',0,'2019-01-01','2019-10-01',100,0),(17,'p03010104170017','xx ops',32000,'xx_list.PNG','xx_main.PNG','xx_detail.PNG','',0,'2019-01-01','2019-10-01',100,0),(18,'p01030103180018','princess top',58000,'through_list.PNG','through_main.PNG','through_detail.PNG','',2,'2019-01-01','2019-10-01',100,0),(19,'p01040103190019','puff top',32000,'puff_list.PNG','puff_main.PNG','puff_detail.PNG','',0,'2019-01-01','2019-10-01',100,0);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` char(30) DEFAULT NULL,
  `userid` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-02 17:49:47
