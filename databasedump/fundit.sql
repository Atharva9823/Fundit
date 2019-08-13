-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: fundit
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `company` (
  `c_id` int(11) NOT NULL,
  `c_name` varchar(50) DEFAULT NULL,
  `valuation` decimal(13,2) DEFAULT NULL,
  `founded` date DEFAULT NULL,
  `capital` decimal(13,2) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `passwd` varchar(50) DEFAULT NULL,
  `stake` decimal(13,2) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holdings`
--

DROP TABLE IF EXISTS `holdings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `holdings` (
  `aadhar` int(11) DEFAULT NULL,
  `c_id` int(11) DEFAULT NULL,
  `bond_date` date DEFAULT NULL,
  `bond_val` decimal(13,2) DEFAULT NULL,
  `stake` decimal(13,2) DEFAULT NULL,
  `offer` decimal(13,2) DEFAULT NULL,
  KEY `c_id` (`c_id`),
  KEY `aadhar` (`aadhar`),
  CONSTRAINT `holdings_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `company` (`c_id`),
  CONSTRAINT `holdings_ibfk_2` FOREIGN KEY (`aadhar`) REFERENCES `investor` (`aadhar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holdings`
--

LOCK TABLES `holdings` WRITE;
/*!40000 ALTER TABLE `holdings` DISABLE KEYS */;
/*!40000 ALTER TABLE `holdings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investor`
--

DROP TABLE IF EXISTS `investor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `investor` (
  `aadhar` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `ipasswd` varchar(50) DEFAULT NULL,
  `icapital` decimal(13,2) DEFAULT NULL,
  PRIMARY KEY (`aadhar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investor`
--

LOCK TABLES `investor` WRITE;
/*!40000 ALTER TABLE `investor` DISABLE KEYS */;
/*!40000 ALTER TABLE `investor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `logs` (
  `c_id` int(11) DEFAULT NULL,
  `aadhar_buy` int(11) DEFAULT NULL,
  `aadhar_sell` int(11) DEFAULT NULL,
  `stake` decimal(13,2) DEFAULT NULL,
  `offer` decimal(13,2) DEFAULT NULL,
  `t_date` date DEFAULT NULL,
  `t_time` time DEFAULT NULL,
  KEY `c_id` (`c_id`),
  KEY `aadhar_buy` (`aadhar_buy`),
  KEY `aadhar_sell` (`aadhar_sell`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `company` (`c_id`),
  CONSTRAINT `logs_ibfk_2` FOREIGN KEY (`aadhar_buy`) REFERENCES `investor` (`aadhar`),
  CONSTRAINT `logs_ibfk_3` FOREIGN KEY (`aadhar_sell`) REFERENCES `investor` (`aadhar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_logs` AFTER INSERT ON `logs` FOR EACH ROW begin



declare flag_buy int default 0;

declare flag_sell int default 0;



set flag_buy = (select count(*) from holdings where aadhar=new.aadhar_buy and c_id = new.c_id);



IF(flag_buy>0) THEN

update holdings

set stake=stake+new.stake,

bond_val=stake*new.offer,

offer=new.offer

where aadhar=new.aadhar_buy and c_id = new.c_id;

ELSE

insert into holdings values(new.aadhar_buy, new.c_id, curdate(), new.offer*new.stake, new.stake, new.offer);

END IF;



set flag_sell = (select count(*) from holdings where aadhar=new.aadhar_sell and c_id = new.c_id);



IF(flag_sell>0) THEN

update holdings

set stake=stake-new.stake,

bond_val=stake*new.offer,

offer=new.offer

where aadhar=new.aadhar_sell and c_id = new.c_id;

END IF;



update holdings

set offer=new.offer

where c_id=new.c_id;



update holdings 

set bond_val=offer*stake

where c_id=new.c_id;



update company

set valuation=new.offer*100

where c_id=new.c_id;

delete from needs
where stake =0;



IF new.aadhar_sell IS NULL then call holdings_update_company_no_sell_id(new.aadhar_buy, new.c_id, new.stake, new.offer);

ELSE call holdings_update_investor(new.aadhar_buy, new.aadhar_sell, new.c_id, new.stake, new.offer);

END IF;



IF new.aadhar_buy IS NULL then call holdings_update_company_no_buy_id(new.aadhar_sell, new.c_id, new.stake, new.offer);

ELSE call holdings_update_investor(new.aadhar_buy, new.aadhar_sell, new.c_id, new.stake, new.offer);

END IF;



delete from holdings where aadhar IS NULL;



end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `needs`
--

DROP TABLE IF EXISTS `needs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `needs` (
  `c_id` int(11) DEFAULT NULL,
  `aadhar` int(11) DEFAULT NULL,
  `buy` int(11) DEFAULT NULL,
  `sell` int(11) DEFAULT NULL,
  `stake` decimal(13,2) DEFAULT NULL,
  `offer` decimal(13,2) DEFAULT NULL,
  KEY `c_id` (`c_id`),
  KEY `aadhar` (`aadhar`),
  CONSTRAINT `needs_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `company` (`c_id`),
  CONSTRAINT `needs_ibfk_2` FOREIGN KEY (`aadhar`) REFERENCES `investor` (`aadhar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `needs`
--

LOCK TABLES `needs` WRITE;
/*!40000 ALTER TABLE `needs` DISABLE KEYS */;
/*!40000 ALTER TABLE `needs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'fundit'
--
/*!50003 DROP PROCEDURE IF EXISTS `accept_needs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `accept_needs`(IN req_stake numeric(13, 2), IN temp_c_id int, IN temp_aadhar_buy int,IN temp_aadhar_sell int, IN temp_offer numeric(13, 2))
begin



insert into logs values(temp_c_id, temp_aadhar_buy, temp_aadhar_sell, req_stake, temp_offer, curdate(), curtime());



end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_needs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_needs`(IN req_stake numeric(13, 2), IN temp_aadhar int, IN temp_aadhar_init int, IN temp_c_id int)
begin

declare temp_aadhar_buy int;
declare temp_aadhar_sell int;
declare temp_offer numeric(13, 2);
declare flag int default 1;
declare temp_stake numeric(13, 2);

IF(temp_aadhar IS NULL) THEN
set flag = (select buy from needs where c_id=temp_c_id and aadhar IS NULL and sell = 1);
ELSE
set flag = (select buy from needs where c_id=temp_c_id and aadhar = temp_aadhar);
END IF;

IF(flag IS NULL) THEN
set flag = 1;
END IF;

IF(temp_aadhar IS NULL and flag = 0) THEN
set temp_stake = (select stake from needs where temp_c_id = c_id and aadhar IS NULL and sell = 1);
ELSEIF(temp_aadhar IS NULL and flag = 1) THEN
set temp_stake = (select stake from needs where temp_c_id = c_id and aadhar IS NULL and buy = 1);
ELSE
set temp_stake = (select stake from needs where temp_c_id = c_id and aadhar=temp_aadhar);
END IF;

delete from needs where stake = 0.0;

IF(temp_aadhar IS NULL and flag = 0) THEN
set temp_offer=(select offer from needs where c_id=temp_c_id and aadhar IS NULL and sell = 1);
ELSEIF(temp_aadhar IS NULL and flag = 1) THEN
set temp_offer=(select offer from needs where c_id=temp_c_id and aadhar IS NULL and buy = 1);
ELSE
set temp_offer=(select offer from needs where c_id=temp_c_id and aadhar=temp_aadhar);
END IF;

IF(flag=0) THEN 
set temp_aadhar_buy=temp_aadhar_init;
set temp_aadhar_sell=temp_aadhar;
ELSE 
set temp_aadhar_buy=temp_aadhar;
set temp_aadhar_sell=temp_aadhar_init;
END IF;

IF(temp_aadhar IS NULL and flag = 0) THEN
update needs
set stake = stake-req_stake
where c_id=temp_c_id and aadhar IS NULL and sell = 1;
ELSEIF(temp_aadhar IS NULL and flag = 1) THEN
update needs
set stake = stake-req_stake
where c_id=temp_c_id and aadhar IS NULL and buy = 1;
ELSE
update needs
set stake = stake-req_stake
where c_id=temp_c_id and aadhar=temp_aadhar;
END IF;

call accept_needs(req_stake, temp_c_id, temp_aadhar_buy, temp_aadhar_sell, temp_offer);

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `holdings_update_company_no_buy_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `holdings_update_company_no_buy_id`(IN temp_aadhar int, IN temp_c_id int, IN temp_stake numeric(13, 2), IN temp_offer numeric(13, 2))
begin



update company

set valuation=temp_offer*100, 

capital=capital-(temp_stake * temp_offer), 

stake = stake+temp_stake

where c_id = temp_c_id; 



update investor

set icapital=icapital+(temp_stake * temp_offer)

where aadhar=temp_aadhar;



end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `holdings_update_company_no_sell_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `holdings_update_company_no_sell_id`(IN temp_aadhar int, IN temp_c_id int, IN temp_stake numeric(13, 2), IN temp_offer numeric(13, 2))
begin 



update company

set valuation=temp_offer*100, 

capital=capital+(temp_stake * temp_offer), 

stake = stake-temp_stake

where c_id = temp_c_id; 



update investor

set icapital=icapital-(temp_stake * temp_offer)

where aadhar=temp_aadhar;



end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `holdings_update_investor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `holdings_update_investor`(IN temp_aadhar_buy int, IN temp_aadhar_sell int, IN temp_c_id int, IN temp_stake numeric(7, 2), IN temp_offer numeric(7, 2))
begin
update investor
set icapital=icapital-(temp_stake*temp_offer)
where aadhar=temp_aadhar_buy;
update investor
set icapital=icapital+(temp_stake*temp_offer)
where aadhar=temp_aadhar_sell;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_needs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_needs`(IN temp_c_id INT, IN temp_aadhar int, IN temp_buy int, IN temp_sell int, IN temp_stake numeric(13, 2), IN temp_offer numeric(13, 2))
begin



declare count int default 0;



IF(temp_aadhar IS NULL) THEN

set count = (select count(*) from needs where temp_c_id=c_id and aadhar IS NULL and buy=temp_buy);

ELSE

set count = (select count(*) from needs where temp_c_id=c_id and aadhar=temp_aadhar and buy=temp_buy);

END IF;



IF(count>0) THEN



IF(temp_aadhar IS NULL) THEN

update needs set offer=temp_offer, stake=stake+temp_stake where c_id=temp_c_id and aadhar IS NULL and buy=temp_buy;

ELSE

update needs set offer=temp_offer, stake=stake+temp_stake where c_id=temp_c_id and aadhar=temp_aadhar and buy=temp_buy;

END IF;



ELSE



insert into needs values(temp_c_id, temp_aadhar, temp_buy, temp_sell, temp_stake, temp_offer);

END IF;



IF(temp_aadhar IS NULL) THEN

update needs

set offer = temp_offer

where c_id = temp_c_id;

END IF;



end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test`(IN number int)
begin select * from company where c_id=number; end ;;
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

-- Dump completed on 2019-08-13 18:35:22
