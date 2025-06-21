-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: Elecon
-- ------------------------------------------------------
-- Server version	5.7.44

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
-- Table structure for table `ASSETS_BASIC_DATA`
--

DROP TABLE IF EXISTS `ASSETS_BASIC_DATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSETS_BASIC_DATA` (
  `asset_id` varchar(7) NOT NULL,
  `asset_name` varchar(300) NOT NULL,
  `asset_add_dt_tm` datetime DEFAULT CURRENT_TIMESTAMP,
  `asset_value` decimal(8,2) DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `ass_grp_id` int(11) NOT NULL,
  `curr_code` varchar(5) NOT NULL,
  `org_code` int(11) NOT NULL,
  `prnt_asset_id` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  KEY `fk_ASSETS_BASIC_DATA_ASSETS_GROUPS1_idx` (`ass_grp_id`),
  KEY `fk_ASSETS_BASIC_DATA_CURRENCIES1_idx` (`curr_code`),
  KEY `fk_ASSETS_BASIC_DATA_ORGANIZATIONS1_idx` (`org_code`),
  KEY `fk_ASSETS_BASIC_DATA_ASSETS_BASIC_DATA1_idx` (`prnt_asset_id`),
  CONSTRAINT `fk_ASSETS_BASIC_DATA_ASSETS_BASIC_DATA1` FOREIGN KEY (`prnt_asset_id`) REFERENCES `ASSETS_BASIC_DATA` (`asset_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSETS_BASIC_DATA_ASSETS_GROUPS1` FOREIGN KEY (`ass_grp_id`) REFERENCES `ASSETS_GROUPS` (`ass_grp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSETS_BASIC_DATA_CURRENCIES1` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSETS_BASIC_DATA_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSETS_BASIC_DATA`
--

LOCK TABLES `ASSETS_BASIC_DATA` WRITE;
/*!40000 ALTER TABLE `ASSETS_BASIC_DATA` DISABLE KEYS */;
INSERT INTO `ASSETS_BASIC_DATA` VALUES ('1','Asset Test 1','2024-06-07 15:27:46',100.00,NULL,1,'AED',2,NULL);
/*!40000 ALTER TABLE `ASSETS_BASIC_DATA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSETS_DEPRECIATION_TYPES`
--

DROP TABLE IF EXISTS `ASSETS_DEPRECIATION_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSETS_DEPRECIATION_TYPES` (
  `ass_depr_id` int(11) NOT NULL AUTO_INCREMENT,
  `ass_depr_name` varchar(200) NOT NULL,
  `yearly_depreciation_perc` decimal(2,2) DEFAULT NULL,
  `increase_or_fixed` varchar(2) DEFAULT NULL,
  `year_or_hours` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ass_depr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSETS_DEPRECIATION_TYPES`
--

LOCK TABLES `ASSETS_DEPRECIATION_TYPES` WRITE;
/*!40000 ALTER TABLE `ASSETS_DEPRECIATION_TYPES` DISABLE KEYS */;
INSERT INTO `ASSETS_DEPRECIATION_TYPES` VALUES (1,'Automotives',0.03,'F','Y');
/*!40000 ALTER TABLE `ASSETS_DEPRECIATION_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSETS_GROUPS`
--

DROP TABLE IF EXISTS `ASSETS_GROUPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSETS_GROUPS` (
  `ass_grp_id` int(11) NOT NULL AUTO_INCREMENT,
  `ass_grp_name` varchar(200) NOT NULL,
  `yearly_depreciation_perc` decimal(2,2) NOT NULL,
  `ass_depr_id` int(11) NOT NULL,
  PRIMARY KEY (`ass_grp_id`),
  KEY `fk_ASSETS_GROUPS_ASSETS_DEPRECIATION_TYPES1_idx` (`ass_depr_id`),
  CONSTRAINT `fk_ASSETS_GROUPS_ASSETS_DEPRECIATION_TYPES1` FOREIGN KEY (`ass_depr_id`) REFERENCES `ASSETS_DEPRECIATION_TYPES` (`ass_depr_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSETS_GROUPS`
--

LOCK TABLES `ASSETS_GROUPS` WRITE;
/*!40000 ALTER TABLE `ASSETS_GROUPS` DISABLE KEYS */;
INSERT INTO `ASSETS_GROUPS` VALUES (1,'Automotive Transport Cars',0.03,1),(2,'Automotive Sedan Cars',0.03,1);
/*!40000 ALTER TABLE `ASSETS_GROUPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSETS_ITEMS`
--

DROP TABLE IF EXISTS `ASSETS_ITEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSETS_ITEMS` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registr` datetime DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `asset_id` varchar(7) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ASSETS_ITEMS_ASSETS_BASIC_DATA1_idx` (`asset_id`),
  KEY `fk_ASSETS_ITEMS_ITEMS_LIST1_idx` (`item_code`),
  CONSTRAINT `fk_ASSETS_ITEMS_ASSETS_BASIC_DATA1` FOREIGN KEY (`asset_id`) REFERENCES `ASSETS_BASIC_DATA` (`asset_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSETS_ITEMS_ITEMS_LIST1` FOREIGN KEY (`item_code`) REFERENCES `ITEMS_LIST` (`item_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSETS_ITEMS`
--

LOCK TABLES `ASSETS_ITEMS` WRITE;
/*!40000 ALTER TABLE `ASSETS_ITEMS` DISABLE KEYS */;
/*!40000 ALTER TABLE `ASSETS_ITEMS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSETS_PROPERTIES`
--

DROP TABLE IF EXISTS `ASSETS_PROPERTIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSETS_PROPERTIES` (
  `ass_prop_id` int(11) NOT NULL,
  `ass_prop_name` varchar(100) NOT NULL,
  PRIMARY KEY (`ass_prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSETS_PROPERTIES`
--

LOCK TABLES `ASSETS_PROPERTIES` WRITE;
/*!40000 ALTER TABLE `ASSETS_PROPERTIES` DISABLE KEYS */;
INSERT INTO `ASSETS_PROPERTIES` VALUES (1,'Volt'),(2,'Current'),(3,'Ohom'),(4,'Power');
/*!40000 ALTER TABLE `ASSETS_PROPERTIES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSETS_PROPS_VALUES`
--

DROP TABLE IF EXISTS `ASSETS_PROPS_VALUES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSETS_PROPS_VALUES` (
  `asset_id` varchar(7) NOT NULL,
  `ass_property_value` varchar(100) NOT NULL,
  `ass_prop_id` int(11) NOT NULL,
  PRIMARY KEY (`asset_id`,`ass_prop_id`),
  KEY `fk_ASSETS_PROPS_VALUES_ASSETS_PROPERTIES1_idx` (`ass_prop_id`),
  CONSTRAINT `fk_ASSETS_PROPS_VALUES_ASSETS_BASIC_DATA1` FOREIGN KEY (`asset_id`) REFERENCES `ASSETS_BASIC_DATA` (`asset_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSETS_PROPS_VALUES_ASSETS_PROPERTIES1` FOREIGN KEY (`ass_prop_id`) REFERENCES `ASSETS_PROPERTIES` (`ass_prop_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSETS_PROPS_VALUES`
--

LOCK TABLES `ASSETS_PROPS_VALUES` WRITE;
/*!40000 ALTER TABLE `ASSETS_PROPS_VALUES` DISABLE KEYS */;
INSERT INTO `ASSETS_PROPS_VALUES` VALUES ('1','Null',2),('1','Null',3),('1','Null',4);
/*!40000 ALTER TABLE `ASSETS_PROPS_VALUES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSETS_TRANS_TYPES`
--

DROP TABLE IF EXISTS `ASSETS_TRANS_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSETS_TRANS_TYPES` (
  `ass_trns_type_code` int(11) NOT NULL AUTO_INCREMENT,
  `ass_trns_type_name` varchar(100) NOT NULL,
  `effect` varchar(2) NOT NULL,
  `ass_trns_type_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ass_trns_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSETS_TRANS_TYPES`
--

LOCK TABLES `ASSETS_TRANS_TYPES` WRITE;
/*!40000 ALTER TABLE `ASSETS_TRANS_TYPES` DISABLE KEYS */;
INSERT INTO `ASSETS_TRANS_TYPES` VALUES (1,'Test 1','I','2024-05-31 22:37:27'),(2,'Test 2','T','2024-05-31 22:37:43');
/*!40000 ALTER TABLE `ASSETS_TRANS_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSET_TRANS_DET`
--

DROP TABLE IF EXISTS `ASSET_TRANS_DET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSET_TRANS_DET` (
  `trans_det_id` int(11) NOT NULL AUTO_INCREMENT,
  `add_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `depreciation_val` decimal(7,2) DEFAULT NULL,
  `expenses_val` decimal(7,2) DEFAULT NULL,
  `curr_code` varchar(5) DEFAULT NULL,
  `trans_mast_id` int(11) NOT NULL,
  `asset_id` varchar(7) NOT NULL,
  PRIMARY KEY (`trans_det_id`),
  KEY `fk_ASSET_TRANS_DET_CURRENCIES1_idx` (`curr_code`),
  KEY `fk_ASSET_TRANS_DET_ASSET_TRANS_MAST1_idx` (`trans_mast_id`),
  KEY `fk_ASSET_TRANS_DET_ASSETS_BASIC_DATA1_idx` (`asset_id`),
  CONSTRAINT `fk_ASSET_TRANS_DET_ASSETS_BASIC_DATA1` FOREIGN KEY (`asset_id`) REFERENCES `ASSETS_BASIC_DATA` (`asset_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSET_TRANS_DET_ASSET_TRANS_MAST1` FOREIGN KEY (`trans_mast_id`) REFERENCES `ASSET_TRANS_MAST` (`trans_mast_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSET_TRANS_DET_CURRENCIES1` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSET_TRANS_DET`
--

LOCK TABLES `ASSET_TRANS_DET` WRITE;
/*!40000 ALTER TABLE `ASSET_TRANS_DET` DISABLE KEYS */;
/*!40000 ALTER TABLE `ASSET_TRANS_DET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSET_TRANS_MAST`
--

DROP TABLE IF EXISTS `ASSET_TRANS_MAST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSET_TRANS_MAST` (
  `trans_mast_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_desc` varchar(100) NOT NULL,
  `trans_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` varchar(200) DEFAULT NULL,
  `from_org_code` int(11) DEFAULT NULL,
  `to_org_code` int(11) DEFAULT NULL,
  `ass_trns_type_code` int(11) NOT NULL,
  PRIMARY KEY (`trans_mast_id`),
  KEY `fk_ASSET_TRANS_MAST_ORGANIZATIONS1_idx` (`from_org_code`),
  KEY `fk_ASSET_TRANS_MAST_ORGANIZATIONS2_idx` (`to_org_code`),
  KEY `fk_ASSET_TRANS_MAST_ASSETS_TRANS_TYPES1_idx` (`ass_trns_type_code`),
  CONSTRAINT `fk_ASSET_TRANS_MAST_ASSETS_TRANS_TYPES1` FOREIGN KEY (`ass_trns_type_code`) REFERENCES `ASSETS_TRANS_TYPES` (`ass_trns_type_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSET_TRANS_MAST_ORGANIZATIONS1` FOREIGN KEY (`from_org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSET_TRANS_MAST_ORGANIZATIONS2` FOREIGN KEY (`to_org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSET_TRANS_MAST`
--

LOCK TABLES `ASSET_TRANS_MAST` WRITE;
/*!40000 ALTER TABLE `ASSET_TRANS_MAST` DISABLE KEYS */;
/*!40000 ALTER TABLE `ASSET_TRANS_MAST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CURRENCIES`
--

DROP TABLE IF EXISTS `CURRENCIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CURRENCIES` (
  `curr_code` varchar(5) NOT NULL,
  `curr_symbol` varchar(20) DEFAULT NULL,
  `curr_name` varchar(45) DEFAULT NULL,
  `default_curr` varchar(2) DEFAULT 'Y',
  PRIMARY KEY (`curr_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CURRENCIES`
--

LOCK TABLES `CURRENCIES` WRITE;
/*!40000 ALTER TABLE `CURRENCIES` DISABLE KEYS */;
INSERT INTO `CURRENCIES` VALUES ('AED','د.إ','United Arab Emirates','N'),('AFN','؋','Afghan afghani','N'),('ALL','L','Albanian lek','N'),('AMD','','Armenian dram','N'),('AOA','Kz','Angolan kwanza','N'),('ARS','$','Argentine peso','N'),('AUD','$','Australian dollar','N'),('AWG','ƒ','Aruban florin','N'),('AZN','','Azerbaijani manat','N'),('BAM','KM or КМ','Bosnia and Herzegovi','N'),('BBD','$','Barbadian dollar','N'),('BDT','৳','Bangladeshi taka','N'),('BGN','лв','Bulgarian lev','N'),('BHD','.د.ب','Bahraini dinar','N'),('BIF','Fr','Burundian franc','N'),('BMD','$','Bermudian dollar','N'),('BND','$','Brunei dollar','N'),('BOB','Bs.','Bolivian boliviano','N'),('BRL','R$','Brazilian real','N'),('BTN','Nu.','Bhutanese ngultrum','N'),('BWP','P','Botswana pula','N'),('BYR','Br','Belarusian ruble','N'),('BZD','$','Belize dollar','N'),('CAD','$','Canadian dollar','N'),('CHF','Fr','Swiss franc','N'),('CLP','$','Chilean peso','N'),('CNY','¥ or 元','Chinese yuan','N'),('COP','$','Colombian peso','N'),('CRC','₡','Costa Rican colón','N'),('CUC','$','Cuban convertible pe','N'),('CVE','Esc or $','Cape Verdean escudo','N'),('CZK','Kč','Czech koruna','N'),('DJF','Fr','Djiboutian franc','N'),('DKK','kr','Danish krone','N'),('DOP','$','Dominican peso','N'),('DZD','د.ج','Algerian dinar','N'),('EGP','£ or ج.م','Egyptian pound','Y'),('ERN','Nfk','Eritrean nakfa','N'),('ETB','Br','Ethiopian birr','N'),('EUR','€','Euro','N'),('FKP','£','Falkland Islands pou','N'),('GBP','£','British pound','N'),('GEL','ლ','Georgian lari','N'),('GHS','₵','Ghana cedi','N'),('GIP','£','Gibraltar pound','N'),('GNF','Fr','Guinean franc','N'),('GTQ','Q','Guatemalan quetzal','N'),('GYD','$','Guyanese dollar','N'),('HNL','L','Honduran lempira','N'),('HTG','G','Haitian gourde','N'),('HUF','Ft','Hungarian forint','N'),('IDR','Rp','Indonesian rupiah','N'),('ILS','₪','Israeli new shekel','N'),('INR','₹','Indian rupee','N'),('IQD','ع.د','Iraqi dinar','N'),('IRR','﷼','Iranian rial','N'),('ISK','kr','Icelandic króna','N'),('JMD','$','Jamaican dollar','N'),('JOD','د.ا','Jordanian dinar','N'),('JPY','¥','Japanese yen','N'),('KES','Sh','Kenyan shilling','N'),('KGS','лв','Kyrgyzstani som','N'),('KHR','៛','Cambodian riel','N'),('KMF','Fr','Comorian franc','N'),('KWD','د.ك','Kuwaiti dinar','N'),('KYD','$','Cayman Islands dolla','N'),('KZT','','Kazakhstani tenge','N'),('LAK','₭','Lao kip','N'),('LBP','ل.ل','Lebanese pound','N'),('LKR','Rs or රු','Sri Lankan rupee','N'),('LRD','$','Liberian dollar','N'),('LSL','L','Lesotho loti','N'),('LYD','ل.د','Libyan dinar','N'),('MAD','د.م.','Moroccan dirham','N'),('MDL','L','Moldovan leu','N'),('MGA','Ar','Malagasy ariary','N'),('MMK','Ks','Burmese kyat','N'),('MNT','₮','Mongolian tögrög','N'),('MRO','UM','Mauritanian ouguiya','N'),('MUR','₨','Mauritian rupee','N'),('MVR','.ރ','Maldivian rufiyaa','N'),('MWK','MK','Malawian kwacha','N'),('MXN','$','Mexican peso','N'),('MYR','RM','Malaysian ringgit','N'),('MZN','MT','Mozambican metical','N'),('NAD','$','Namibian dollar','N'),('NGN','₦','Nigerian naira','N'),('NIO','C$','Nicaraguan córdoba','N'),('NOK','kr','Norwegian krone','N'),('NPR','₨','Nepalese rupee','N'),('NZD','$','New Zealand dollar','N'),('OMR','ر.ع.','Omani rial','N'),('PAB','B/.','Panamanian balboa','N'),('PEN','S/.','Peruvian nuevo sol','N'),('PGK','K','Papua New Guinean ki','N'),('PHP','₱','Philippine peso','N'),('PKR','₨','Pakistani rupee','N'),('PLN','zł','Polish złoty','N'),('PYG','₲','Paraguayan guaraní','N'),('QAR','ر.ق','Qatari riyal','N'),('RON','lei','Romanian leu','N'),('RSD','дин. or din.','Serbian dinar','N'),('RUB','','Russian ruble','N'),('RWF','Fr','Rwandan franc','N'),('SAR','ر.س','Saudi riyal','N'),('SBD','$','Solomon Islands doll','N'),('SCR','₨','Seychellois rupee','N'),('SDG','ج.س.','Sudanese pound','N'),('SEK','kr','Swedish krona','N'),('SHP','£','Saint Helena pound','N'),('SLL','Le','Sierra Leonean leone','N'),('SOS','Sh','Somali shilling','N'),('SRD','$','Surinamese dollar','N'),('SSP','£','South Sudanese pound','N'),('STD','Db','São Tomé and Príncip','N'),('SYP','£ or ل.س','Syrian pound','N'),('SZL','L','Swazi lilangeni','N'),('THB','฿','Thai baht','N'),('TJS','ЅМ','Tajikistani somoni','N'),('TMT','m','Turkmenistan manat','N'),('TND','د.ت','Tunisian dinar','N'),('TOP','T$','Tongan paʻanga','N'),('TRY','','Turkish lira','N'),('TTD','$','Trinidad and Tobago ','N'),('TWD','$','New Taiwan dollar','N'),('TZS','Sh','Tanzanian shilling','N'),('UAH','₴','Ukrainian hryvnia','N'),('UGX','Sh','Ugandan shilling','N'),('USD','$','United States dollar','N'),('UYU','$','Uruguayan peso','N'),('UZS','','Uzbekistani som','N'),('VEF','Bs F','Venezuelan bolívar','N'),('VND','₫','Vietnamese đồng','N'),('VUV','Vt','Vanuatu vatu','N'),('WST','T','Samoan tālā','N'),('XAF','Fr','Central African CFA ','N'),('XCD','$','East Caribbean dolla','N'),('XOF','Fr','West African CFA fra','N'),('XPF','Fr','CFP franc','N'),('YER','﷼','Yemeni rial','N'),('ZAR','R','South African rand','N'),('ZMW','ZK','Zambian kwacha','N');
/*!40000 ALTER TABLE `CURRENCIES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CURRENCY_TRANSFORM`
--

DROP TABLE IF EXISTS `CURRENCY_TRANSFORM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CURRENCY_TRANSFORM` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transform_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `multiply_by` decimal(15,5) NOT NULL DEFAULT '1.00000',
  `from_curr_code` varchar(5) NOT NULL,
  `to_curr_code` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_CURRENCY_TRANSFORM_CURRENCIES1_idx` (`from_curr_code`),
  KEY `fk_CURRENCY_TRANSFORM_CURRENCIES2_idx` (`to_curr_code`),
  CONSTRAINT `fk_CURRENCY_TRANSFORM_CURRENCIES1` FOREIGN KEY (`from_curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CURRENCY_TRANSFORM_CURRENCIES2` FOREIGN KEY (`to_curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CURRENCY_TRANSFORM`
--

LOCK TABLES `CURRENCY_TRANSFORM` WRITE;
/*!40000 ALTER TABLE `CURRENCY_TRANSFORM` DISABLE KEYS */;
INSERT INTO `CURRENCY_TRANSFORM` VALUES (7,'2023-05-20 14:15:39',1.00000,'EGP','AED'),(8,'2023-05-26 07:07:34',1.25000,'EGP','AWG'),(9,'2023-05-01 14:15:39',1.11000,'EGP','AED'),(10,'2023-04-01 14:15:39',8.00000,'EGP','AED'),(11,'2023-07-31 22:18:34',0.11000,'EGP','AED');
/*!40000 ALTER TABLE `CURRENCY_TRANSFORM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMERS`
--

DROP TABLE IF EXISTS `CUSTOMERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMERS` (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_name` varchar(100) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `mobile_no` varchar(45) DEFAULT NULL,
  `segel_no` varchar(45) DEFAULT NULL,
  `permitted_limit` decimal(10,2) DEFAULT NULL,
  `org_code` int(11) NOT NULL,
  `curr_code` varchar(5) NOT NULL,
  PRIMARY KEY (`cust_id`),
  KEY `fk_CUSTOMERS_ORGANIZATIONS_idx` (`org_code`),
  KEY `fk_CUSTOMERS_CURRENCIES_idx` (`curr_code`),
  CONSTRAINT `fk_CUSTOMERS_CURRENCIES` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CUSTOMERS_ORGANIZATIONS` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMERS`
--

LOCK TABLES `CUSTOMERS` WRITE;
/*!40000 ALTER TABLE `CUSTOMERS` DISABLE KEYS */;
INSERT INTO `CUSTOMERS` VALUES (2,'zzzxxxx','zzzxxxx','LLLLLLLLLLLLLLLLL','LLLLLLLLLLLLLLLLL',9999999.00,1,'EGP'),(3,'Mohamed Fayed','XXXXXXXX','11111111111','11111111111',1000.00,1,'EGP'),(4,'Fayed Elecon','address',NULL,NULL,12000.00,2,'EGP');
/*!40000 ALTER TABLE `CUSTOMERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEES`
--

DROP TABLE IF EXISTS `EMPLOYEES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EMPLOYEES` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(100) DEFAULT NULL,
  `marital_status` varchar(2) DEFAULT 'S',
  `emp_cat` varchar(2) DEFAULT 'P',
  `contract_no` varchar(45) DEFAULT NULL,
  `salary` decimal(9,2) DEFAULT '1.00',
  `id_no` varchar(45) DEFAULT NULL,
  `curr_code` varchar(5) NOT NULL,
  `job_id` int(11) DEFAULT NULL,
  `org_code` int(11) NOT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_EMPLOYEES_CURRENCIES1_idx` (`curr_code`),
  KEY `fk_EMPLOYEES_ORGANIZATIONS1_idx` (`org_code`),
  KEY `fk_EMPLOYEES_JOBS1_idx` (`job_id`),
  CONSTRAINT `fk_EMPLOYEES_CURRENCIES1` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEES_JOBS1` FOREIGN KEY (`job_id`) REFERENCES `JOBS` (`job_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEES_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEES`
--

LOCK TABLES `EMPLOYEES` WRITE;
/*!40000 ALTER TABLE `EMPLOYEES` DISABLE KEYS */;
INSERT INTO `EMPLOYEES` VALUES (1,'mohd','S','P','0000',2500.00,'0012345','EGP',NULL,0),(2,'Test','M','T','1111',1000.00,'5432100','EGP',NULL,0),(3,'Mohamed Zamzam','M','P',NULL,1000.00,NULL,'EGP',NULL,1),(4,'Mohamed Elecon','M','P',NULL,5000.00,NULL,'EGP',NULL,2);
/*!40000 ALTER TABLE `EMPLOYEES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEES_CONTRACTS`
--

DROP TABLE IF EXISTS `EMPLOYEES_CONTRACTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EMPLOYEES_CONTRACTS` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_desc` varchar(200) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `certificate` varchar(2) DEFAULT NULL,
  `certificate_dt` datetime DEFAULT NULL,
  `contract_apply_dt` datetime DEFAULT NULL,
  `salary` decimal(7,2) DEFAULT NULL,
  `emp_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `id_type` varchar(2) DEFAULT NULL,
  `id_no` varchar(45) DEFAULT NULL,
  `id_photo_path` varchar(200) DEFAULT NULL,
  `curr_code` varchar(5) NOT NULL,
  `responsible_for_no` int(11) DEFAULT '0',
  `bank_branch_name` varchar(100) DEFAULT NULL,
  `certificate_photo_path` varchar(100) DEFAULT NULL,
  `contract_end_dt` datetime DEFAULT NULL,
  `contact_no` varchar(45) DEFAULT NULL,
  `emergency_contact_no` varchar(45) DEFAULT NULL,
  `emergency_contact_name` varchar(45) DEFAULT NULL,
  `bank_acc_no` varchar(45) DEFAULT NULL,
  `contract_photo_path` varchar(100) DEFAULT NULL,
  `personal_photo_path` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`contract_id`),
  KEY `fk_EMPLOYEES_CONTRACTS_EMPLOYEES1_idx` (`emp_id`),
  KEY `fk_EMPLOYEES_CONTRACTS_JOBS1_idx` (`job_id`),
  KEY `fk_EMPLOYEES_CONTRACTS_CURRENCIES1_idx` (`curr_code`),
  CONSTRAINT `fk_EMPLOYEES_CONTRACTS_CURRENCIES1` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEES_CONTRACTS_EMPLOYEES1` FOREIGN KEY (`emp_id`) REFERENCES `EMPLOYEES` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEES_CONTRACTS_JOBS1` FOREIGN KEY (`job_id`) REFERENCES `JOBS` (`job_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1745683890 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEES_CONTRACTS`
--

LOCK TABLES `EMPLOYEES_CONTRACTS` WRITE;
/*!40000 ALTER TABLE `EMPLOYEES_CONTRACTS` DISABLE KEYS */;
INSERT INTO `EMPLOYEES_CONTRACTS` VALUES (1745176939,NULL,'Mohamed','Fayed','Abdelmonem',NULL,NULL,'2025-04-01 00:00:00',250.00,1,3,NULL,'1111111111111','/home/mfayed/FERB/IDs/1.jpeg','EGP',0,NULL,'/home/mfayed/FERB/CERTs/1.jpeg',NULL,NULL,NULL,NULL,'1234567890123456789','/home/mfayed/FERB/CONTRACTs/1.png','/home/mfayed/FERB/PERSONALs/1.png'),(1745678739,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,4,NULL,'222','/home/mfayed/FERB/IDs/2.png','EGP',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'/home/mfayed/FERB/PERSONALs/2.png'),(1745683889,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,5,NULL,'33333','','EGP',0,NULL,NULL,NULL,NULL,NULL,NULL,'abcdefghijklmnopqrstxyz',NULL,NULL);
/*!40000 ALTER TABLE `EMPLOYEES_CONTRACTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEE_JOB_HISTORY`
--

DROP TABLE IF EXISTS `EMPLOYEE_JOB_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EMPLOYEE_JOB_HISTORY` (
  `seq` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `frm_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `to_dt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`seq`,`emp_id`),
  KEY `fk_EMPLOYEE_JOB_HISTORY_EMPLOYEES1_idx` (`emp_id`),
  KEY `fk_EMPLOYEE_JOB_HISTORY_JOBS1_idx` (`job_id`),
  CONSTRAINT `fk_EMPLOYEE_JOB_HISTORY_EMPLOYEES1` FOREIGN KEY (`emp_id`) REFERENCES `EMPLOYEES` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEE_JOB_HISTORY_JOBS1` FOREIGN KEY (`job_id`) REFERENCES `JOBS` (`job_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEE_JOB_HISTORY`
--

LOCK TABLES `EMPLOYEE_JOB_HISTORY` WRITE;
/*!40000 ALTER TABLE `EMPLOYEE_JOB_HISTORY` DISABLE KEYS */;
/*!40000 ALTER TABLE `EMPLOYEE_JOB_HISTORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_ACC_ASSISTANCES`
--

DROP TABLE IF EXISTS `GL_ACC_ASSISTANCES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_ACC_ASSISTANCES` (
  `ass_code` varchar(20) NOT NULL,
  `ass_name` varchar(100) NOT NULL,
  `active` varchar(2) DEFAULT 'Y',
  `acc_code` int(11) NOT NULL,
  `org_code` int(11) NOT NULL,
  `gl_ass_tbl_id` varchar(3) NOT NULL,
  PRIMARY KEY (`ass_code`),
  KEY `fk_GL_ACC_ASSISTANCES_GL_ORG_ACC_CHART1_idx` (`acc_code`,`org_code`),
  KEY `fk_GL_ACC_ASSISTANCES_GL_ASSISTANCE_TABLES1_idx` (`gl_ass_tbl_id`),
  CONSTRAINT `fk_GL_ACC_ASSISTANCES_GL_ASSISTANCE_TABLES1` FOREIGN KEY (`gl_ass_tbl_id`) REFERENCES `GL_ASSISTANCE_TABLES` (`gl_ass_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_ACC_ASSISTANCES_GL_ORG_ACC_CHART1` FOREIGN KEY (`acc_code`, `org_code`) REFERENCES `GL_ORG_ACC_CHART` (`acc_code`, `org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_ACC_ASSISTANCES`
--

LOCK TABLES `GL_ACC_ASSISTANCES` WRITE;
/*!40000 ALTER TABLE `GL_ACC_ASSISTANCES` DISABLE KEYS */;
INSERT INTO `GL_ACC_ASSISTANCES` VALUES ('100010001-2','zzzxxxx','Y',100010001,2,'CL1'),('100010001-3','Mohamed Fayed','Y',100010001,2,'CL1'),('100010001-4','Fayed Elecon','Y',100010001,2,'CL1'),('2000100102-1','Supplier One','Y',2000100102,2,'SP1'),('2000100102-2','Supplier Elecon','Y',2000100102,2,'SP1'),('2000100102-3','WWWWWWWWWW','Y',2000100102,2,'SP1');
/*!40000 ALTER TABLE `GL_ACC_ASSISTANCES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_ACC_TYPES`
--

DROP TABLE IF EXISTS `GL_ACC_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_ACC_TYPES` (
  `gl_acc_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `gl_acc_type_name_a` varchar(100) DEFAULT NULL,
  `gl_acc_type_name_e` varchar(100) NOT NULL,
  PRIMARY KEY (`gl_acc_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_ACC_TYPES`
--

LOCK TABLES `GL_ACC_TYPES` WRITE;
/*!40000 ALTER TABLE `GL_ACC_TYPES` DISABLE KEYS */;
INSERT INTO `GL_ACC_TYPES` VALUES (1,'Acc Type 1','نوع حساب رقم 1');
/*!40000 ALTER TABLE `GL_ACC_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_ASSISTANCE_TABLES`
--

DROP TABLE IF EXISTS `GL_ASSISTANCE_TABLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_ASSISTANCE_TABLES` (
  `gl_ass_tbl_id` varchar(3) NOT NULL,
  `tbl_name_e` varchar(100) NOT NULL,
  `tbl_name_a` varchar(100) DEFAULT NULL,
  `select_stmnt` varchar(2000) NOT NULL,
  PRIMARY KEY (`gl_ass_tbl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_ASSISTANCE_TABLES`
--

LOCK TABLES `GL_ASSISTANCE_TABLES` WRITE;
/*!40000 ALTER TABLE `GL_ASSISTANCE_TABLES` DISABLE KEYS */;
INSERT INTO `GL_ASSISTANCE_TABLES` VALUES ('CL1','CUSTOMERS','العملاء','select'),('HR1','EMPLOYEES','الموظفين','select'),('SP1','SUPPLIERS','الموردين','select');
/*!40000 ALTER TABLE `GL_ASSISTANCE_TABLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_COST_CENTERS`
--

DROP TABLE IF EXISTS `GL_COST_CENTERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_COST_CENTERS` (
  `cost_center_code` int(11) NOT NULL,
  `cost_center_name_a` varchar(200) DEFAULT NULL,
  `cost_center_name_e` varchar(200) DEFAULT NULL,
  `org_code` int(11) NOT NULL,
  `prnt_cost_center_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`cost_center_code`),
  KEY `fk_GL_COST_CENTERS_ORGANIZATIONS1_idx` (`org_code`),
  KEY `fk_GL_COST_CENTERS_GL_COST_CENTERS1_idx` (`prnt_cost_center_code`),
  CONSTRAINT `fk_GL_COST_CENTERS_GL_COST_CENTERS1` FOREIGN KEY (`prnt_cost_center_code`) REFERENCES `GL_COST_CENTERS` (`cost_center_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_COST_CENTERS_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_COST_CENTERS`
--

LOCK TABLES `GL_COST_CENTERS` WRITE;
/*!40000 ALTER TABLE `GL_COST_CENTERS` DISABLE KEYS */;
INSERT INTO `GL_COST_CENTERS` VALUES (1000000000,'Elecon111','Elecon111',2,NULL);
/*!40000 ALTER TABLE `GL_COST_CENTERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_DOCUMENTS`
--

DROP TABLE IF EXISTS `GL_DOCUMENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_DOCUMENTS` (
  `gl_doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `gl_doc_name` varchar(100) DEFAULT NULL,
  `gl_doc_dt` datetime DEFAULT NULL,
  `reversed_flag` varchar(2) DEFAULT NULL,
  `balance_flag` varchar(2) DEFAULT NULL,
  `post_flag` varchar(2) DEFAULT NULL,
  `org_code` int(11) NOT NULL,
  `gl_trns_type_id` int(11) NOT NULL,
  `origin_gl_doc_id` int(11) DEFAULT NULL,
  `origin_org_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`gl_doc_id`,`org_code`),
  KEY `fk_GL_DOCUMENTS_ORGANIZATIONS1_idx` (`org_code`),
  KEY `fk_GL_DOCUMENTS_GL_TRANS_TYPES1_idx` (`gl_trns_type_id`),
  KEY `fk_GL_DOCUMENTS_GL_DOCUMENTS1_idx` (`origin_gl_doc_id`,`origin_org_code`),
  CONSTRAINT `fk_GL_DOCUMENTS_GL_DOCUMENTS1` FOREIGN KEY (`origin_gl_doc_id`, `origin_org_code`) REFERENCES `GL_DOCUMENTS` (`gl_doc_id`, `org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_DOCUMENTS_GL_TRANS_TYPES1` FOREIGN KEY (`gl_trns_type_id`) REFERENCES `GL_TRANS_TYPES` (`gl_trns_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_DOCUMENTS_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1719666161 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_DOCUMENTS`
--

LOCK TABLES `GL_DOCUMENTS` WRITE;
/*!40000 ALTER TABLE `GL_DOCUMENTS` DISABLE KEYS */;
INSERT INTO `GL_DOCUMENTS` VALUES (1712867823,'AAAA','2024-04-11 22:37:03','Y','Y','Y',2,1,1719649793,NULL),(1712897901,'BB','2024-04-12 06:58:20','Y','Y','Y',2,1,1719664550,NULL),(1719590323,NULL,'2024-04-28 17:58:43','N','Y','Y',2,1,NULL,NULL),(1719646886,NULL,'2024-04-29 09:41:26','Y','Y','Y',2,1,1719666160,NULL),(1719649793,'Reversed - AAAA','2024-06-29 11:29:53','','Y','Y',2,4,1712867823,2),(1719664550,'Reversed - BB','2024-06-29 15:35:50','','Y','N',2,4,1712897901,2),(1719666160,NULL,'2024-06-29 16:02:40','','Y','Y',2,4,1719646886,2);
/*!40000 ALTER TABLE `GL_DOCUMENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_FINANCIAL_YEARS`
--

DROP TABLE IF EXISTS `GL_FINANCIAL_YEARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_FINANCIAL_YEARS` (
  `fin_year_code` varchar(9) NOT NULL,
  `period_no` decimal(10,0) NOT NULL,
  `status_flag` varchar(2) NOT NULL,
  `start_dt` date DEFAULT NULL,
  `end_dt` date DEFAULT NULL,
  PRIMARY KEY (`fin_year_code`,`period_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_FINANCIAL_YEARS`
--

LOCK TABLES `GL_FINANCIAL_YEARS` WRITE;
/*!40000 ALTER TABLE `GL_FINANCIAL_YEARS` DISABLE KEYS */;
INSERT INTO `GL_FINANCIAL_YEARS` VALUES ('1',1,'','2024-02-01','2024-05-30');
/*!40000 ALTER TABLE `GL_FINANCIAL_YEARS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_GEN_ACC_CHART`
--

DROP TABLE IF EXISTS `GL_GEN_ACC_CHART`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_GEN_ACC_CHART` (
  `acc_code` int(11) NOT NULL,
  `acc_name_a` varchar(200) NOT NULL,
  `acc_name_e` varchar(200) DEFAULT NULL,
  `prnt_acc_code` int(11) DEFAULT NULL,
  `acc_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`acc_code`),
  KEY `fk_GL_GEN_ACC_CHART_GL_GEN_ACC_CHART1_idx` (`prnt_acc_code`),
  KEY `fk_GL_GEN_ACC_CHART_GL_ACC_TYPES1_idx` (`acc_type_id`),
  CONSTRAINT `fk_GL_GEN_ACC_CHART_GL_ACC_TYPES1` FOREIGN KEY (`acc_type_id`) REFERENCES `GL_ACC_TYPES` (`gl_acc_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_GEN_ACC_CHART_GL_GEN_ACC_CHART1` FOREIGN KEY (`prnt_acc_code`) REFERENCES `GL_GEN_ACC_CHART` (`acc_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_GEN_ACC_CHART`
--

LOCK TABLES `GL_GEN_ACC_CHART` WRITE;
/*!40000 ALTER TABLE `GL_GEN_ACC_CHART` DISABLE KEYS */;
INSERT INTO `GL_GEN_ACC_CHART` VALUES (1100000,'AAAA','AAAA',NULL,1);
/*!40000 ALTER TABLE `GL_GEN_ACC_CHART` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_JOURNALS`
--

DROP TABLE IF EXISTS `GL_JOURNALS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_JOURNALS` (
  `jornal_id` varchar(12) NOT NULL,
  `acc_code` int(11) NOT NULL,
  `org_code` int(11) NOT NULL,
  `ass_code` varchar(20) DEFAULT NULL,
  `curr_code` varchar(5) NOT NULL,
  `debit` decimal(20,5) DEFAULT NULL,
  `credit` decimal(20,5) DEFAULT NULL,
  `local_debit` decimal(20,5) DEFAULT NULL,
  `cost_center_code` int(11) DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `gl_doc_id` int(11) NOT NULL,
  `gl_documents_org_code` int(11) NOT NULL,
  `local_credit` decimal(20,5) DEFAULT NULL,
  PRIMARY KEY (`jornal_id`,`acc_code`,`org_code`,`gl_doc_id`,`gl_documents_org_code`),
  KEY `fk_GL_JOURNALS_GL_COST_CENTERS1_idx` (`cost_center_code`),
  KEY `fk_GL_JOURNALS_CURRENCIES1_idx` (`curr_code`),
  KEY `fk_GL_JOURNALS_GL_ACC_ASSISTANCES1_idx` (`ass_code`),
  KEY `fk_GL_JOURNALS_GL_ORG_ACC_CHART1_idx` (`acc_code`,`org_code`),
  KEY `fk_GL_JOURNALS_GL_DOCUMENTS1_idx` (`gl_doc_id`,`gl_documents_org_code`),
  CONSTRAINT `fk_GL_JOURNALS_CURRENCIES1` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_JOURNALS_GL_ACC_ASSISTANCES1` FOREIGN KEY (`ass_code`) REFERENCES `GL_ACC_ASSISTANCES` (`ass_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_JOURNALS_GL_COST_CENTERS1` FOREIGN KEY (`cost_center_code`) REFERENCES `GL_COST_CENTERS` (`cost_center_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_JOURNALS_GL_DOCUMENTS1` FOREIGN KEY (`gl_doc_id`, `gl_documents_org_code`) REFERENCES `GL_DOCUMENTS` (`gl_doc_id`, `org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_JOURNALS_GL_ORG_ACC_CHART1` FOREIGN KEY (`acc_code`, `org_code`) REFERENCES `GL_ORG_ACC_CHART` (`acc_code`, `org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_JOURNALS`
--

LOCK TABLES `GL_JOURNALS` WRITE;
/*!40000 ALTER TABLE `GL_JOURNALS` DISABLE KEYS */;
INSERT INTO `GL_JOURNALS` VALUES ('1712867831',100010001,2,NULL,'EGP',20.00000,0.00000,NULL,NULL,NULL,1712867823,2,NULL),('1712867831',100010001,2,NULL,'EGP',0.00000,20.00000,NULL,NULL,NULL,1719649793,2,NULL),('1712867839',100020001,2,NULL,'EGP',0.00000,20.00000,NULL,NULL,NULL,1712867823,2,NULL),('1712867839',100020001,2,NULL,'EGP',20.00000,0.00000,NULL,NULL,NULL,1719649793,2,NULL),('1712897908',200010001,2,NULL,'EGP',55.00000,0.00000,NULL,NULL,NULL,1712897901,2,NULL),('1712897908',200010001,2,NULL,'EGP',0.00000,55.00000,NULL,NULL,NULL,1719664550,2,NULL),('1712898463',2000100102,2,NULL,'EGP',0.00000,55.00000,NULL,NULL,NULL,1712897901,2,NULL),('1712898463',2000100102,2,NULL,'EGP',55.00000,0.00000,NULL,NULL,NULL,1719664550,2,NULL),('1719590438',100010001,2,NULL,'EGP',50.00000,0.00000,NULL,NULL,NULL,1719590323,2,NULL),('1719590473',100020001,2,NULL,'EGP',0.00000,50.00000,NULL,NULL,NULL,1719590323,2,NULL),('1719646897',200010001,2,NULL,'EGP',50.00000,0.00000,NULL,NULL,NULL,1719646886,2,NULL),('1719646897',200010001,2,NULL,'EGP',0.00000,50.00000,NULL,NULL,NULL,1719666160,2,NULL),('1719646909',2000100102,2,NULL,'EGP',0.00000,50.00000,NULL,NULL,NULL,1719646886,2,NULL),('1719646909',2000100102,2,NULL,'EGP',50.00000,0.00000,NULL,NULL,NULL,1719666160,2,NULL);
/*!40000 ALTER TABLE `GL_JOURNALS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_ORG_ACC_BALANCE`
--

DROP TABLE IF EXISTS `GL_ORG_ACC_BALANCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_ORG_ACC_BALANCE` (
  `org_code` int(11) NOT NULL,
  `acc_code` int(11) NOT NULL,
  `curr_code` varchar(5) NOT NULL,
  `open_credit` decimal(20,5) DEFAULT NULL,
  `open_debit` decimal(20,5) DEFAULT NULL,
  `close_credit` decimal(20,5) DEFAULT NULL,
  `close_debit` decimal(20,5) DEFAULT NULL,
  `local_open_credit` decimal(20,5) DEFAULT NULL,
  `local_open_debit` decimal(20,5) DEFAULT NULL,
  `local_close_credit` decimal(20,5) DEFAULT NULL,
  `local_close_debit` decimal(20,5) DEFAULT NULL,
  PRIMARY KEY (`org_code`,`acc_code`,`curr_code`),
  KEY `fk_GL_ORG_ACC_BALANCE_DETAILS_GL_ORG_ACC_CHART1_idx` (`acc_code`,`org_code`),
  KEY `fk_GL_ORG_ACC_BALANCE_DETAILS_CURRENCIES1_idx` (`curr_code`),
  CONSTRAINT `fk_GL_ORG_ACC_BALANCE_DETAILS_CURRENCIES1` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_ORG_ACC_BALANCE_DETAILS_GL_ORG_ACC_CHART1` FOREIGN KEY (`acc_code`, `org_code`) REFERENCES `GL_ORG_ACC_CHART` (`acc_code`, `org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_ORG_ACC_BALANCE`
--

LOCK TABLES `GL_ORG_ACC_BALANCE` WRITE;
/*!40000 ALTER TABLE `GL_ORG_ACC_BALANCE` DISABLE KEYS */;
INSERT INTO `GL_ORG_ACC_BALANCE` VALUES (2,100000000,'EGP',0.00000,0.00000,3220.00000,3220.00000,0.00000,0.00000,354.20000,354.20000),(2,100000001,'EGP',0.00000,0.00000,3220.00000,3220.00000,0.00000,0.00000,354.20000,354.20000),(2,100010001,'EGP',0.00000,0.00000,2440.00000,920.00000,0.00000,0.00000,268.40000,101.20000),(2,100020001,'EGP',0.00000,0.00000,780.00000,2300.00000,0.00000,0.00000,85.80000,253.00000),(2,200000000,'EGP',0.00000,0.00000,405.00000,405.00000,0.00000,0.00000,44.55000,44.55000),(2,200000001,'EGP',0.00000,0.00000,245.00000,300.00000,0.00000,0.00000,26.95000,33.00000),(2,200010001,'EGP',0.00000,0.00000,160.00000,105.00000,0.00000,0.00000,17.60000,11.55000),(2,2000100102,'EGP',0.00000,0.00000,245.00000,300.00000,0.00000,0.00000,26.95000,33.00000);
/*!40000 ALTER TABLE `GL_ORG_ACC_BALANCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_ORG_ACC_BAL_PERIOD`
--

DROP TABLE IF EXISTS `GL_ORG_ACC_BAL_PERIOD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_ORG_ACC_BAL_PERIOD` (
  `org_code` int(11) NOT NULL,
  `acc_code` int(11) NOT NULL,
  `curr_code` varchar(5) NOT NULL,
  `fin_year_code` varchar(9) NOT NULL,
  `period_no` decimal(10,0) NOT NULL,
  `open_credit` decimal(20,5) DEFAULT NULL,
  `open_debit` decimal(20,5) DEFAULT NULL,
  `close_credit` decimal(20,5) DEFAULT NULL,
  `close_debit` decimal(20,5) DEFAULT NULL,
  `trans_credit` decimal(20,5) DEFAULT NULL,
  `trans_debit` decimal(20,5) DEFAULT NULL,
  `local_open_credit` decimal(20,5) DEFAULT NULL,
  `local_open_debit` decimal(20,5) DEFAULT NULL,
  `local_close_credit` decimal(20,5) DEFAULT NULL,
  `local_close_debit` decimal(20,5) DEFAULT NULL,
  `local_trans_credit` decimal(20,5) DEFAULT NULL,
  `local_trans_debit` decimal(20,5) DEFAULT NULL,
  PRIMARY KEY (`org_code`,`acc_code`,`curr_code`,`fin_year_code`,`period_no`),
  KEY `fk_GL_ORG_ACC_BAL_PERIOD_GL_FINANCIAL_YEARS1_idx` (`fin_year_code`,`period_no`),
  KEY `fk_GL_ORG_ACC_BAL_PERIOD_GL_ORG_ACC_BALANCE1_idx` (`org_code`,`acc_code`,`curr_code`),
  CONSTRAINT `fk_GL_ORG_ACC_BAL_PERIOD_GL_FINANCIAL_YEARS1` FOREIGN KEY (`fin_year_code`, `period_no`) REFERENCES `GL_FINANCIAL_YEARS` (`fin_year_code`, `period_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_ORG_ACC_BAL_PERIOD_GL_ORG_ACC_BALANCE1` FOREIGN KEY (`org_code`, `acc_code`, `curr_code`) REFERENCES `GL_ORG_ACC_BALANCE` (`org_code`, `acc_code`, `curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_ORG_ACC_BAL_PERIOD`
--

LOCK TABLES `GL_ORG_ACC_BAL_PERIOD` WRITE;
/*!40000 ALTER TABLE `GL_ORG_ACC_BAL_PERIOD` DISABLE KEYS */;
INSERT INTO `GL_ORG_ACC_BAL_PERIOD` VALUES (2,100000000,'EGP','1',1,0.00000,0.00000,3220.00000,3220.00000,3220.00000,3220.00000,0.00000,0.00000,354.20000,354.20000,354.20000,354.20000),(2,100000001,'EGP','1',1,0.00000,0.00000,3220.00000,3220.00000,3220.00000,3220.00000,0.00000,0.00000,354.20000,354.20000,354.20000,354.20000),(2,100010001,'EGP','1',1,0.00000,0.00000,2440.00000,920.00000,2440.00000,920.00000,0.00000,0.00000,268.40000,101.20000,268.40000,101.20000),(2,100020001,'EGP','1',1,0.00000,0.00000,780.00000,2300.00000,780.00000,2300.00000,0.00000,0.00000,85.80000,253.00000,85.80000,253.00000),(2,200000000,'EGP','1',1,0.00000,0.00000,405.00000,405.00000,405.00000,405.00000,0.00000,0.00000,44.55000,44.55000,44.55000,44.55000),(2,200000001,'EGP','1',1,0.00000,0.00000,245.00000,300.00000,245.00000,300.00000,0.00000,0.00000,26.95000,33.00000,26.95000,33.00000),(2,200010001,'EGP','1',1,0.00000,0.00000,160.00000,105.00000,160.00000,105.00000,0.00000,0.00000,17.60000,11.55000,17.60000,11.55000),(2,2000100102,'EGP','1',1,0.00000,0.00000,245.00000,300.00000,245.00000,300.00000,0.00000,0.00000,26.95000,33.00000,26.95000,33.00000);
/*!40000 ALTER TABLE `GL_ORG_ACC_BAL_PERIOD` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`localhost`*/ /*!50003 TRIGGER `Elecon`.`GL_ORG_ACC_BAL_PERIOD_AFTER_INSERT` AFTER INSERT ON `GL_ORG_ACC_BAL_PERIOD` FOR EACH ROW
BEGIN
    update GL_ORG_ACC_BALANCE A ,
    (select 
    sum(open_credit) s_open_credit ,
    sum(open_debit) s_open_debit,
    sum(close_credit) s_close_credit,
    sum(close_debit) s_close_debit,
    sum(local_open_credit) s_local_open_credit ,
    sum(local_open_debit) s_local_open_debit,
    sum(local_close_credit) s_local_close_credit,
    sum(local_close_debit) s_local_close_debit
    from GL_ORG_ACC_BAL_PERIOD
    WHERE org_code = new.org_code
    AND   acc_code = new.acc_code
    AND   curr_code = new.curr_code ) AS B
SET A.open_credit = B.s_open_credit,
	A.open_debit = B.s_open_debit,
    A.close_credit = B.s_close_credit,
	A.close_debit = B.s_close_debit,
    A.local_open_credit = B.s_local_open_credit,
	A.local_open_debit = B.s_local_open_debit,
    A.local_close_credit = B.s_local_close_credit,
	A.local_close_debit = B.s_local_close_debit
    WHERE org_code = new.org_code
    AND   acc_code = new.acc_code
    AND   curr_code = new.curr_code;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`localhost`*/ /*!50003 TRIGGER `Elecon`.`GL_ORG_ACC_BAL_PERIOD_AFTER_UPDATE` AFTER UPDATE ON `GL_ORG_ACC_BAL_PERIOD` FOR EACH ROW
BEGIN
 update GL_ORG_ACC_BALANCE A ,
    (select 
    sum(open_credit) s_open_credit ,
    sum(open_debit) s_open_debit,
    sum(close_credit) s_close_credit,
    sum(close_debit) s_close_debit,
    sum(local_open_credit) s_local_open_credit ,
    sum(local_open_debit) s_local_open_debit,
    sum(local_close_credit) s_local_close_credit,
    sum(local_close_debit) s_local_close_debit
    from GL_ORG_ACC_BAL_PERIOD
    WHERE org_code = new.org_code
    AND   acc_code = new.acc_code
    AND   curr_code = new.curr_code ) AS B
SET A.open_credit = B.s_open_credit,
	A.open_debit = B.s_open_debit,
    A.close_credit = B.s_close_credit,
	A.close_debit = B.s_close_debit,
    A.local_open_credit = B.s_local_open_credit,
	A.local_open_debit = B.s_local_open_debit,
    A.local_close_credit = B.s_local_close_credit,
	A.local_close_debit = B.s_local_close_debit
    WHERE org_code = new.org_code
    AND   acc_code = new.acc_code
    AND   curr_code = new.curr_code;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `GL_ORG_ACC_CHART`
--

DROP TABLE IF EXISTS `GL_ORG_ACC_CHART`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_ORG_ACC_CHART` (
  `acc_code` int(11) NOT NULL,
  `org_code` int(11) NOT NULL,
  `acc_name_a` varchar(200) DEFAULT NULL,
  `acc_name_e` varchar(200) DEFAULT NULL,
  `gl_acc_type_id` int(11) DEFAULT NULL,
  `gl_ass_tbl_id` varchar(3) DEFAULT NULL,
  `prnt_acc_code` int(11) DEFAULT NULL,
  `prnt_org_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`acc_code`,`org_code`),
  KEY `fk_GL_ORG_ACC_CHART_GL_ACC_TYPES1_idx` (`gl_acc_type_id`),
  KEY `fk_GL_ORG_ACC_CHART_ORGANIZATIONS1_idx` (`org_code`),
  KEY `fk_GL_ORG_ACC_CHART_GL_ASSISTANCE_TABLES1_idx` (`gl_ass_tbl_id`),
  KEY `fk_GL_ORG_ACC_CHART_GL_ORG_ACC_CHART1_idx` (`prnt_acc_code`,`prnt_org_code`),
  CONSTRAINT `fk_GL_ORG_ACC_CHART_GL_ACC_TYPES1` FOREIGN KEY (`gl_acc_type_id`) REFERENCES `GL_ACC_TYPES` (`gl_acc_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_ORG_ACC_CHART_GL_ASSISTANCE_TABLES1` FOREIGN KEY (`gl_ass_tbl_id`) REFERENCES `GL_ASSISTANCE_TABLES` (`gl_ass_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_ORG_ACC_CHART_GL_ORG_ACC_CHART1` FOREIGN KEY (`prnt_acc_code`, `prnt_org_code`) REFERENCES `GL_ORG_ACC_CHART` (`acc_code`, `org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GL_ORG_ACC_CHART_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_ORG_ACC_CHART`
--

LOCK TABLES `GL_ORG_ACC_CHART` WRITE;
/*!40000 ALTER TABLE `GL_ORG_ACC_CHART` DISABLE KEYS */;
INSERT INTO `GL_ORG_ACC_CHART` VALUES (100000000,2,'Account 1','Account 1',1,NULL,NULL,NULL),(100000001,2,'Account 1-1','Account 1-1',1,NULL,100000000,2),(100010001,2,'???? ??????? ????','cash purchasing account',NULL,'CL1',100000001,2),(100020001,2,'???? ??????? ?????','credit purchasing account',NULL,NULL,100000001,2),(200000000,2,'Account 2','Account 2',1,NULL,NULL,NULL),(200000001,2,'Account 2-1','Account 2-1',1,NULL,200000000,2),(200010001,2,'???? ??? ??????','sell building account',NULL,NULL,200000000,2),(2000100102,2,'???? ??? ??????','sell cars account',NULL,'SP1',200000001,2);
/*!40000 ALTER TABLE `GL_ORG_ACC_CHART` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GL_TRANS_TYPES`
--

DROP TABLE IF EXISTS `GL_TRANS_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GL_TRANS_TYPES` (
  `gl_trns_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_name_a` varchar(200) DEFAULT NULL,
  `trans_name_e` varchar(200) NOT NULL,
  `trans_type` varchar(2) NOT NULL,
  `active` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`gl_trns_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GL_TRANS_TYPES`
--

LOCK TABLES `GL_TRANS_TYPES` WRITE;
/*!40000 ALTER TABLE `GL_TRANS_TYPES` DISABLE KEYS */;
INSERT INTO `GL_TRANS_TYPES` VALUES (1,'Test 11111','Test11111','1','Y'),(2,'Test2','Test2','3','Y'),(3,'Test 3','Test 3','5','Y'),(4,'??? ????','Reverse doc.','4','Y');
/*!40000 ALTER TABLE `GL_TRANS_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEMS_LIST`
--

DROP TABLE IF EXISTS `ITEMS_LIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEMS_LIST` (
  `item_code` varchar(100) NOT NULL,
  `item_indx` varchar(100) DEFAULT NULL,
  `item_name` varchar(300) DEFAULT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `unit_id` int(11) NOT NULL,
  `register_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_assmbly` varchar(2) DEFAULT 'N',
  `active` varchar(2) DEFAULT 'Y',
  `org_code` int(11) NOT NULL,
  `order_limit` decimal(8,2) DEFAULT NULL,
  `sales_profit_perc` int(3) DEFAULT NULL,
  `str_var_1` varchar(20) DEFAULT NULL,
  `str_var_2` varchar(20) DEFAULT NULL,
  `str_var_3` varchar(20) DEFAULT NULL,
  `str_var_4` varchar(20) DEFAULT NULL,
  `str_var_5` varchar(20) DEFAULT NULL,
  `str_var_6` varchar(20) DEFAULT NULL,
  `str_var_7` varchar(20) DEFAULT NULL,
  `str_var_8` varchar(20) DEFAULT NULL,
  `str_var_9` varchar(20) DEFAULT NULL,
  `str_var_10` varchar(20) DEFAULT NULL,
  `str_var_11` varchar(20) DEFAULT NULL,
  `str_var_12` varchar(20) DEFAULT NULL,
  `str_var_13` varchar(20) DEFAULT NULL,
  `str_var_14` varchar(20) DEFAULT NULL,
  `str_var_15` varchar(20) DEFAULT NULL,
  `str_var_16` varchar(20) DEFAULT NULL,
  `str_var_17` varchar(20) DEFAULT NULL,
  `str_var_18` varchar(20) DEFAULT NULL,
  `str_var_19` varchar(20) DEFAULT NULL,
  `str_var_20` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`item_code`),
  UNIQUE KEY `item_indx_UNIQUE` (`item_indx`),
  KEY `fk_ITEMS_LIST_ITEM_CATEGORIES_idx` (`cat_id`),
  KEY `fk_ITEMS_LIST_UNITS1_idx` (`unit_id`),
  KEY `fk_ITEMS_LIST_ORGANIZATIONS1_idx` (`org_code`),
  CONSTRAINT `fk_ITEMS_LIST_ITEM_CATEGORIES` FOREIGN KEY (`cat_id`) REFERENCES `ITEM_CATEGORIES` (`cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEMS_LIST_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEMS_LIST_UNITS` FOREIGN KEY (`unit_id`) REFERENCES `UNITS` (`unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEMS_LIST`
--

LOCK TABLES `ITEMS_LIST` WRITE;
/*!40000 ALTER TABLE `ITEMS_LIST` DISABLE KEYS */;
INSERT INTO `ITEMS_LIST` VALUES ('I-1','G001B001T3O01D0001N0000','ASTM - D2466&D3311(Sch40)TTU-40-تايلاند-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','N',2,0.00,0,'N0001','D0001','G001','B001','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10','G001B001T3O01D0001N0009','ASTM - D2466&D3311(Sch40)TTU-40-تايلاند-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B001','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-100','G001B001T3O05D0002N0009','ASTM - D2466&D3311(Sch40)TTU-40-ايطالىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B001','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-1000','G001B002T3O16D0002N0009','ASTM - D2466&D3311(Sch40)GM-40-اسبانىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B002','T3','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10000','G001B015T4O07D0002N0009','ASTM - D2466&D3311(Sch40)LINDA-80-تايوان-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B015','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10001','G001B015T4O08D0001N0000','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10002','G001B015T4O08D0001N0001','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10003','G001B015T4O08D0001N0002','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10004','G001B015T4O08D0001N0003','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10005','G001B015T4O08D0001N0004','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10006','G001B015T4O08D0001N0005','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10007','G001B015T4O08D0001N0006','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10008','G001B015T4O08D0001N0007','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-10009','G001B015T4O08D0001N0008','ASTM - D2466&D3311(Sch40)LINDA-80-روسىا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B015','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4693','G001B007T4O14D0002N0002','ASTM - D2466&D3311(Sch40)BIS-80-كورىا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B007','T4','O14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4694','G001B007T4O14D0002N0003','ASTM - D2466&D3311(Sch40)BIS-80-كورىا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B007','T4','O14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4695','G001B007T4O14D0002N0004','ASTM - D2466&D3311(Sch40)BIS-80-كورىا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B007','T4','O14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4696','G001B007T4O14D0002N0005','ASTM - D2466&D3311(Sch40)BIS-80-كورىا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B007','T4','O14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4697','G001B007T4O14D0002N0006','ASTM - D2466&D3311(Sch40)BIS-80-كورىا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B007','T4','O14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4698','G001B007T4O14D0002N0007','ASTM - D2466&D3311(Sch40)BIS-80-كورىا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B007','T4','O14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4699','G001B007T4O14D0002N0008','ASTM - D2466&D3311(Sch40)BIS-80-كورىا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B007','T4','O14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-47','G001B001T3O03D0001N0006','ASTM - D2466&D3311(Sch40)TTU-40-اتحاد اوربى-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B001','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-470','G001B001T4O07D0001N0009','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4700','G001B007T4O14D0002N0009','ASTM - D2466&D3311(Sch40)BIS-80-كورىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B007','T4','O14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4701','G001B007T4O15D0001N0000','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4702','G001B007T4O15D0001N0001','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4703','G001B007T4O15D0001N0002','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4704','G001B007T4O15D0001N0003','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4705','G001B007T4O15D0001N0004','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4706','G001B007T4O15D0001N0005','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4707','G001B007T4O15D0001N0006','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4708','G001B007T4O15D0001N0007','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4709','G001B007T4O15D0001N0008','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-471','G001B001T4O07D0002N0000','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4710','G001B007T4O15D0001N0009','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4711','G001B007T4O15D0002N0000','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4712','G001B007T4O15D0002N0001','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4713','G001B007T4O15D0002N0002','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4714','G001B007T4O15D0002N0003','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4715','G001B007T4O15D0002N0004','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4716','G001B007T4O15D0002N0005','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4717','G001B007T4O15D0002N0006','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4718','G001B007T4O15D0002N0007','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4719','G001B007T4O15D0002N0008','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-472','G001B001T4O07D0002N0001','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4720','G001B007T4O15D0002N0009','ASTM - D2466&D3311(Sch40)BIS-80-المانىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B007','T4','O15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4721','G001B007T4O16D0001N0000','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4722','G001B007T4O16D0001N0001','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4723','G001B007T4O16D0001N0002','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4724','G001B007T4O16D0001N0003','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4725','G001B007T4O16D0001N0004','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4726','G001B007T4O16D0001N0005','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4727','G001B007T4O16D0001N0006','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4728','G001B007T4O16D0001N0007','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4729','G001B007T4O16D0001N0008','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-473','G001B001T4O07D0002N0002','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4730','G001B007T4O16D0001N0009','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4731','G001B007T4O16D0002N0000','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4732','G001B007T4O16D0002N0001','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4733','G001B007T4O16D0002N0002','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4734','G001B007T4O16D0002N0003','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4735','G001B007T4O16D0002N0004','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4736','G001B007T4O16D0002N0005','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4737','G001B007T4O16D0002N0006','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4738','G001B007T4O16D0002N0007','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4739','G001B007T4O16D0002N0008','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-474','G001B001T4O07D0002N0003','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4740','G001B007T4O16D0002N0009','ASTM - D2466&D3311(Sch40)BIS-80-اسبانىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B007','T4','O16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4741','G001B007T4O17D0001N0000','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4742','G001B007T4O17D0001N0001','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4743','G001B007T4O17D0001N0002','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4744','G001B007T4O17D0001N0003','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4745','G001B007T4O17D0001N0004','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4746','G001B007T4O17D0001N0005','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4747','G001B007T4O17D0001N0006','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4748','G001B007T4O17D0001N0007','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4749','G001B007T4O17D0001N0008','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-475','G001B001T4O07D0002N0004','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4750','G001B007T4O17D0001N0009','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4751','G001B007T4O17D0002N0000','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4752','G001B007T4O17D0002N0001','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4753','G001B007T4O17D0002N0002','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4754','G001B007T4O17D0002N0003','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4755','G001B007T4O17D0002N0004','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4756','G001B007T4O17D0002N0005','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4757','G001B007T4O17D0002N0006','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4758','G001B007T4O17D0002N0007','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4759','G001B007T4O17D0002N0008','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-476','G001B001T4O07D0002N0005','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4760','G001B007T4O17D0002N0009','ASTM - D2466&D3311(Sch40)BIS-80-تركىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B007','T4','O17',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4761','G001B008T3O01D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4762','G001B008T3O01D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4763','G001B008T3O01D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4764','G001B008T3O01D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4765','G001B008T3O01D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4766','G001B008T3O01D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4767','G001B008T3O01D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4768','G001B008T3O01D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4769','G001B008T3O01D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-477','G001B001T4O07D0002N0006','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4770','G001B008T3O01D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4771','G001B008T3O01D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4772','G001B008T3O01D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4773','G001B008T3O01D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4774','G001B008T3O01D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4775','G001B008T3O01D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4776','G001B008T3O01D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4777','G001B008T3O01D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4778','G001B008T3O01D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4779','G001B008T3O01D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-478','G001B001T4O07D0002N0007','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4780','G001B008T3O01D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-تايلاند-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4781','G001B008T3O02D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4782','G001B008T3O02D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4783','G001B008T3O02D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4784','G001B008T3O02D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4785','G001B008T3O02D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4786','G001B008T3O02D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4787','G001B008T3O02D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4788','G001B008T3O02D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4789','G001B008T3O02D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-479','G001B001T4O07D0002N0008','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4790','G001B008T3O02D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4791','G001B008T3O02D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4792','G001B008T3O02D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4793','G001B008T3O02D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4794','G001B008T3O02D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4795','G001B008T3O02D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4796','G001B008T3O02D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4797','G001B008T3O02D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4798','G001B008T3O02D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4799','G001B008T3O02D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-48','G001B001T3O03D0001N0007','ASTM - D2466&D3311(Sch40)TTU-40-اتحاد اوربى-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B001','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-480','G001B001T4O07D0002N0009','ASTM - D2466&D3311(Sch40)TTU-80-تايوان-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B001','T4','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4800','G001B008T3O02D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-الصين-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4801','G001B008T3O03D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4802','G001B008T3O03D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4803','G001B008T3O03D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4804','G001B008T3O03D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4805','G001B008T3O03D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4806','G001B008T3O03D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4807','G001B008T3O03D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4808','G001B008T3O03D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4809','G001B008T3O03D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-481','G001B001T4O08D0001N0000','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4810','G001B008T3O03D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4811','G001B008T3O03D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4812','G001B008T3O03D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4813','G001B008T3O03D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4814','G001B008T3O03D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4815','G001B008T3O03D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4816','G001B008T3O03D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4817','G001B008T3O03D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4818','G001B008T3O03D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4819','G001B008T3O03D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-482','G001B001T4O08D0001N0001','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4820','G001B008T3O03D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-اتحاد اوربى-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4821','G001B008T3O04D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4822','G001B008T3O04D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4823','G001B008T3O04D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4824','G001B008T3O04D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4825','G001B008T3O04D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4826','G001B008T3O04D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4827','G001B008T3O04D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4828','G001B008T3O04D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4829','G001B008T3O04D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-483','G001B001T4O08D0001N0002','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4830','G001B008T3O04D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4831','G001B008T3O04D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4832','G001B008T3O04D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4833','G001B008T3O04D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4834','G001B008T3O04D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4835','G001B008T3O04D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4836','G001B008T3O04D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4837','G001B008T3O04D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4838','G001B008T3O04D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4839','G001B008T3O04D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-484','G001B001T4O08D0001N0003','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4840','G001B008T3O04D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-فيتنام-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O04',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4841','G001B008T3O05D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4842','G001B008T3O05D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4843','G001B008T3O05D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4844','G001B008T3O05D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4845','G001B008T3O05D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4846','G001B008T3O05D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4847','G001B008T3O05D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4848','G001B008T3O05D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4849','G001B008T3O05D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-485','G001B001T4O08D0001N0004','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4850','G001B008T3O05D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4851','G001B008T3O05D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4852','G001B008T3O05D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4853','G001B008T3O05D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4854','G001B008T3O05D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4855','G001B008T3O05D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4856','G001B008T3O05D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4857','G001B008T3O05D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4858','G001B008T3O05D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4859','G001B008T3O05D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-486','G001B001T4O08D0001N0005','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4860','G001B008T3O05D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-ايطالىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4861','G001B008T3O06D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4862','G001B008T3O06D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4863','G001B008T3O06D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4864','G001B008T3O06D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4865','G001B008T3O06D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4866','G001B008T3O06D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4867','G001B008T3O06D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4868','G001B008T3O06D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4869','G001B008T3O06D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-487','G001B001T4O08D0001N0006','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4870','G001B008T3O06D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4871','G001B008T3O06D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4872','G001B008T3O06D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4873','G001B008T3O06D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4874','G001B008T3O06D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4875','G001B008T3O06D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4876','G001B008T3O06D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4877','G001B008T3O06D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4878','G001B008T3O06D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4879','G001B008T3O06D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-488','G001B001T4O08D0001N0007','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4880','G001B008T3O06D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-ماليزيا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4881','G001B008T3O07D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4882','G001B008T3O07D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4883','G001B008T3O07D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4884','G001B008T3O07D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4885','G001B008T3O07D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4886','G001B008T3O07D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4887','G001B008T3O07D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4888','G001B008T3O07D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4889','G001B008T3O07D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-489','G001B001T4O08D0001N0008','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4890','G001B008T3O07D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4891','G001B008T3O07D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4892','G001B008T3O07D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4893','G001B008T3O07D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4894','G001B008T3O07D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4895','G001B008T3O07D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4896','G001B008T3O07D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4897','G001B008T3O07D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4898','G001B008T3O07D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4899','G001B008T3O07D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-49','G001B001T3O03D0001N0008','ASTM - D2466&D3311(Sch40)TTU-40-اتحاد اوربى-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B001','T3','O03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-490','G001B001T4O08D0001N0009','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4900','G001B008T3O07D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-تايوان-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4901','G001B008T3O08D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4902','G001B008T3O08D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4903','G001B008T3O08D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4904','G001B008T3O08D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4905','G001B008T3O08D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4906','G001B008T3O08D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4907','G001B008T3O08D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4908','G001B008T3O08D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4909','G001B008T3O08D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-491','G001B001T4O08D0002N0000','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4910','G001B008T3O08D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4911','G001B008T3O08D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4912','G001B008T3O08D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4913','G001B008T3O08D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4914','G001B008T3O08D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4915','G001B008T3O08D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4916','G001B008T3O08D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4917','G001B008T3O08D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4918','G001B008T3O08D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4919','G001B008T3O08D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-492','G001B001T4O08D0002N0001','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4920','G001B008T3O08D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-روسىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4921','G001B008T3O09D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4922','G001B008T3O09D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4923','G001B008T3O09D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4924','G001B008T3O09D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4925','G001B008T3O09D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4926','G001B008T3O09D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4927','G001B008T3O09D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4928','G001B008T3O09D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4929','G001B008T3O09D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-493','G001B001T4O08D0002N0002','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4930','G001B008T3O09D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4931','G001B008T3O09D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4932','G001B008T3O09D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4933','G001B008T3O09D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4934','G001B008T3O09D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4935','G001B008T3O09D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4936','G001B008T3O09D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4937','G001B008T3O09D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4938','G001B008T3O09D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4939','G001B008T3O09D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-494','G001B001T4O08D0002N0003','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4940','G001B008T3O09D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-اوكرانىا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4941','G001B008T3O10D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4942','G001B008T3O10D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4943','G001B008T3O10D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4944','G001B008T3O10D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4945','G001B008T3O10D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4946','G001B008T3O10D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4947','G001B008T3O10D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4948','G001B008T3O10D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4949','G001B008T3O10D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-495','G001B001T4O08D0002N0004','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4950','G001B008T3O10D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4951','G001B008T3O10D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4952','G001B008T3O10D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4953','G001B008T3O10D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4954','G001B008T3O10D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4955','G001B008T3O10D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4956','G001B008T3O10D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4957','G001B008T3O10D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4958','G001B008T3O10D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4959','G001B008T3O10D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-496','G001B001T4O08D0002N0005','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4960','G001B008T3O10D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-إنجلترا-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4961','G001B008T3O11D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4962','G001B008T3O11D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4963','G001B008T3O11D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4964','G001B008T3O11D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4965','G001B008T3O11D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4966','G001B008T3O11D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4967','G001B008T3O11D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4968','G001B008T3O11D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4969','G001B008T3O11D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-497','G001B001T4O08D0002N0006','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4970','G001B008T3O11D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4971','G001B008T3O11D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4972','G001B008T3O11D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4973','G001B008T3O11D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4974','G001B008T3O11D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4975','G001B008T3O11D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4976','G001B008T3O11D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4977','G001B008T3O11D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4978','G001B008T3O11D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4979','G001B008T3O11D0002N0008','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-498','G001B001T4O08D0002N0007','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4980','G001B008T3O11D0002N0009','ASTM - D2466&D3311(Sch40)TM-40-مصر-Ø0.5\"/0.75\"-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0002','G001','B008','T3','O11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4981','G001B008T3O12D0001N0000','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4982','G001B008T3O12D0001N0001','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4983','G001B008T3O12D0001N0002','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4984','G001B008T3O12D0001N0003','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4985','G001B008T3O12D0001N0004','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4986','G001B008T3O12D0001N0005','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4987','G001B008T3O12D0001N0006','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4988','G001B008T3O12D0001N0007','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4989','G001B008T3O12D0001N0008','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-499','G001B001T4O08D0002N0008','ASTM - D2466&D3311(Sch40)TTU-80-روسىا-Ø0.5\"/0.75\"-سيكوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0008','D0002','G001','B001','T4','O08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4990','G001B008T3O12D0001N0009','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5 mm-كوع استانلس سملس 316',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0009','D0001','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4991','G001B008T3O12D0002N0000','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5\"/0.75\"-كوع',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0000','D0002','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4992','G001B008T3O12D0002N0001','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5\"/0.75\"-مسلوب مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0001','D0002','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4993','G001B008T3O12D0002N0002','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5\"/0.75\"-مسلوب لا مركزى',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0002','D0002','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4994','G001B008T3O12D0002N0003','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5\"/0.75\"-كاب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0003','D0002','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4995','G001B008T3O12D0002N0004','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5\"/0.75\"-تية',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0004','D0002','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4996','G001B008T3O12D0002N0005','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5\"/0.75\"-تية مسلوب',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0005','D0002','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4997','G001B008T3O12D0002N0006','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5\"/0.75\"-جلبة',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0006','D0002','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('I-4998','G001B008T3O12D0002N0007','ASTM - D2466&D3311(Sch40)TM-40-السعودىة-Ø0.5\"/0.75\"-ثرودوليت',1,1,'2024-10-30 22:18:00','N','Y',2,0.00,0,'N0007','D0002','G001','B008','T3','O12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ITEMS_LIST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEMS_STRUCTURE`
--

DROP TABLE IF EXISTS `ITEMS_STRUCTURE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEMS_STRUCTURE` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `ass_code` varchar(20) DEFAULT NULL,
  `item_code` varchar(20) NOT NULL,
  `qty_in_ass` decimal(10,3) DEFAULT '1.000',
  `unit_id` int(11) DEFAULT NULL,
  `register_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`seq`,`item_code`),
  KEY `fk_ITEMS_STRUCTURE_UNITS1_idx` (`unit_id`),
  KEY `fk_ITEMS_STRUCTURE_ITEMS_LIST1_idx` (`ass_code`),
  KEY `fk_ITEMS_STRUCTURE_ITEMS_LIST2_idx` (`item_code`),
  CONSTRAINT `fk_ITEMS_STRUCTURE_ITEMS_LIST1` FOREIGN KEY (`ass_code`) REFERENCES `ITEMS_LIST` (`item_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEMS_STRUCTURE_ITEMS_LIST2` FOREIGN KEY (`item_code`) REFERENCES `ITEMS_LIST` (`item_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEMS_STRUCTURE_UNITS1` FOREIGN KEY (`unit_id`) REFERENCES `UNITS` (`unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEMS_STRUCTURE`
--

LOCK TABLES `ITEMS_STRUCTURE` WRITE;
/*!40000 ALTER TABLE `ITEMS_STRUCTURE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ITEMS_STRUCTURE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEM_CATEGORIES`
--

DROP TABLE IF EXISTS `ITEM_CATEGORIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEM_CATEGORIES` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(45) DEFAULT NULL,
  `register_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `active` varchar(2) DEFAULT 'Y',
  `is_ass` varchar(2) DEFAULT 'N',
  `prnt_cat_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  KEY `fk_ITEM_CATEGORIES_ITEM_CATEGORIES1_idx` (`prnt_cat_id`),
  CONSTRAINT `fk_ITEM_CATEGORIES_ITEM_CATEGORIES1` FOREIGN KEY (`prnt_cat_id`) REFERENCES `ITEM_CATEGORIES` (`cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEM_CATEGORIES`
--

LOCK TABLES `ITEM_CATEGORIES` WRITE;
/*!40000 ALTER TABLE `ITEM_CATEGORIES` DISABLE KEYS */;
INSERT INTO `ITEM_CATEGORIES` VALUES (1,'Raw Material','2023-05-19 04:40:07',NULL,'N',NULL),(2,'Semi Finished','2023-05-20 11:19:19',NULL,'N',NULL),(3,'Finished','2023-07-22 18:07:44',NULL,'N',NULL),(12,'sss','2023-08-13 22:04:44','Y','N',NULL),(13,'wwww','2023-08-16 23:28:10','Y','N',NULL);
/*!40000 ALTER TABLE `ITEM_CATEGORIES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEM_CATEGORY_TYPES`
--

DROP TABLE IF EXISTS `ITEM_CATEGORY_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEM_CATEGORY_TYPES` (
  `cat_id` int(11) NOT NULL,
  `item_type_id` int(11) NOT NULL,
  PRIMARY KEY (`cat_id`,`item_type_id`),
  KEY `fk_ITEM_CATEGORY_TYPES_ITEM_CATEGORIES1_idx` (`cat_id`),
  KEY `fk_ITEM_CATEGORY_TYPES_ITEM_TYPES1_idx` (`item_type_id`),
  CONSTRAINT `fk_ITEM_CATEGORY_TYPES_ITEM_CATEGORIES1` FOREIGN KEY (`cat_id`) REFERENCES `ITEM_CATEGORIES` (`cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEM_CATEGORY_TYPES_ITEM_TYPES1` FOREIGN KEY (`item_type_id`) REFERENCES `ITEM_TYPES` (`item_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEM_CATEGORY_TYPES`
--

LOCK TABLES `ITEM_CATEGORY_TYPES` WRITE;
/*!40000 ALTER TABLE `ITEM_CATEGORY_TYPES` DISABLE KEYS */;
INSERT INTO `ITEM_CATEGORY_TYPES` VALUES (1,1),(1,2),(12,3),(12,4),(12,5),(13,1),(13,2);
/*!40000 ALTER TABLE `ITEM_CATEGORY_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEM_TYPES`
--

DROP TABLE IF EXISTS `ITEM_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEM_TYPES` (
  `item_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`item_type_id`),
  UNIQUE KEY `id_UNIQUE` (`item_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEM_TYPES`
--

LOCK TABLES `ITEM_TYPES` WRITE;
/*!40000 ALTER TABLE `ITEM_TYPES` DISABLE KEYS */;
INSERT INTO `ITEM_TYPES` VALUES (1,'Raw Materials'),(2,'Semi Finished'),(3,'Finished'),(4,'Maintenance'),(5,'Consumables');
/*!40000 ALTER TABLE `ITEM_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEM_VARIABLES`
--

DROP TABLE IF EXISTS `ITEM_VARIABLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEM_VARIABLES` (
  `var_code` varchar(5) NOT NULL,
  `var_name` varchar(100) DEFAULT NULL,
  `col_name_in_items` varchar(100) DEFAULT NULL,
  `ordr` int(11) DEFAULT NULL,
  PRIMARY KEY (`var_code`),
  UNIQUE KEY `data_length_UNIQUE` (`ordr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEM_VARIABLES`
--

LOCK TABLES `ITEM_VARIABLES` WRITE;
/*!40000 ALTER TABLE `ITEM_VARIABLES` DISABLE KEYS */;
INSERT INTO `ITEM_VARIABLES` VALUES ('A','str_var_1','Name',11),('B','str_var_2','Diamater',8),('C','str_var_3','Specs',1),('D','str_var_4','Brand',2),('E','str_var_5','Table',3),('F','str_var_6','Origin',4),('G','str_var_7','Angel',13),('H','str_var_8','Length',7),('I','str_var_9','Width',12),('J','str_var_10','Height',9),('K','str_var_11','Thickness',10),('L','str_var_12','Density',5),('M','str_var_13','Color',6),('N','str_var_14','Power',14),('O','str_var_15',NULL,15),('P','str_var_16',NULL,16),('Q','str_var_17',NULL,17),('R','str_var_18','Models',18),('S','str_var_19','Sub-Models',19),('T','str_var_20','Sub-sub-Models',20);
/*!40000 ALTER TABLE `ITEM_VARIABLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEM_VARIABLES_TEST`
--

DROP TABLE IF EXISTS `ITEM_VARIABLES_TEST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEM_VARIABLES_TEST` (
  `item_code` varchar(100) NOT NULL,
  `item_name` varchar(300) DEFAULT NULL,
  `str_var_1` varchar(20) DEFAULT NULL,
  `str_var_2` varchar(20) DEFAULT NULL,
  `str_var_3` varchar(20) DEFAULT NULL,
  `str_var_4` varchar(20) DEFAULT NULL,
  `str_var_5` varchar(20) DEFAULT NULL,
  `str_var_6` varchar(20) DEFAULT NULL,
  `str_var_7` varchar(20) DEFAULT NULL,
  `str_var_8` varchar(20) DEFAULT NULL,
  `str_var_9` varchar(20) DEFAULT NULL,
  `str_var_10` varchar(20) DEFAULT NULL,
  `str_var_11` varchar(20) DEFAULT NULL,
  `str_var_12` varchar(20) DEFAULT NULL,
  `str_var_13` varchar(20) DEFAULT NULL,
  `str_var_14` varchar(20) DEFAULT NULL,
  `str_var_15` varchar(20) DEFAULT NULL,
  `str_var_16` varchar(20) DEFAULT NULL,
  `str_var_17` varchar(20) DEFAULT NULL,
  `str_var_18` varchar(20) DEFAULT NULL,
  `str_var_19` varchar(20) DEFAULT NULL,
  `str_var_20` varchar(20) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `org_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEM_VARIABLES_TEST`
--

LOCK TABLES `ITEM_VARIABLES_TEST` WRITE;
/*!40000 ALTER TABLE `ITEM_VARIABLES_TEST` DISABLE KEYS */;
/*!40000 ALTER TABLE `ITEM_VARIABLES_TEST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEM_VARIABLE_VALUES`
--

DROP TABLE IF EXISTS `ITEM_VARIABLE_VALUES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEM_VARIABLE_VALUES` (
  `var_val_code` varchar(5) NOT NULL,
  `var_val_value` varchar(100) DEFAULT NULL,
  `var_code` varchar(5) NOT NULL,
  `org_code` int(11) DEFAULT NULL,
  `cartizian_applied` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`var_val_code`),
  KEY `fk_ITEM_VARIANT_VALUES_ITEM_VARIANTS1_idx` (`var_code`),
  KEY `fk_ITEM_VARIANT_VALUES_ORGANIZATIONS1_idx` (`org_code`),
  CONSTRAINT `fk_ITEM_VARIANT_VALUES_ITEM_VARIANTS1` FOREIGN KEY (`var_code`) REFERENCES `ITEM_VARIABLES` (`var_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEM_VARIANT_VALUES_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEM_VARIABLE_VALUES`
--

LOCK TABLES `ITEM_VARIABLE_VALUES` WRITE;
/*!40000 ALTER TABLE `ITEM_VARIABLE_VALUES` DISABLE KEYS */;
INSERT INTO `ITEM_VARIABLE_VALUES` VALUES ('B001','TTU','D',1,'Y'),('B002','GM','D',1,'Y'),('B003','HM','D',1,'Y'),('B004','Benkan','D',1,'Y'),('B005','OMR','D',1,'Y'),('B006','PANTECH','D',1,'Y'),('B007','BIS','D',1,'Y'),('B008','TM','D',1,'Y'),('B009','SIAM','D',1,'Y'),('B010','انفت','D',1,'Y'),('B011','shell pipe','D',1,'Y'),('B012','inter pipe','D',1,'Y'),('B013','TSP','D',1,'Y'),('B014','SHIELD','D',1,'Y'),('B015','LINDA','D',1,'Y'),('B016','SSP','D',1,'Y'),('B017','JASCO','D',1,'Y'),('B018','انكو استيل','D',1,'Y'),('B019','Maksal','D',1,'Y'),('B020','NWM','D',1,'Y'),('B021','مصر الحجاز','D',1,'Y'),('B022','مصر النور','D',1,'Y'),('B023','نايسكو','D',1,'Y'),('B024','حبيش','D',1,'Y'),('B025','وادى دجلة','D',1,'Y'),('B026','كرين','D',1,'Y'),('B027','انزو','D',1,'Y'),('B028','هانويل','D',1,'Y'),('B029','دانفوس','D',1,'Y'),('B030','كيدز','D',1,'Y'),('B031','هاترسى','D',1,'Y'),('B032','TIS','D',1,'Y'),('B033','IVR','D',1,'Y'),('B034','NIBCO','D',1,'Y'),('B035','OVEN TROP','D',1,'Y'),('B036','GENEBRE','D',1,'Y'),('B037','جلوبال','D',1,'Y'),('B038','بروكو','D',1,'Y'),('B039','HELS','D',1,'Y'),('B040','فاكتولىك','D',1,'Y'),('B041','ايزوكام','D',1,'Y'),('B042','كيمكو','D',1,'Y'),('B043','روكال','D',1,'Y'),('B044','جلاس روك','D',1,'Y'),('B045','K.FLEX','D',1,'Y'),('B046','ارما سيل','D',1,'Y'),('B047','AFS','D',1,'Y'),('B048','ايكو فريش','D',1,'Y'),('B049','اسكامى','D',1,'Y'),('B050','KATKO','D',1,'Y'),('B051','KET','D',1,'Y'),('B052','KEM','D',1,'Y'),('B053','ليجراند','D',1,'Y'),('B054','مارلين جرلين','D',1,'Y'),('B055','شنيدر','D',1,'Y'),('B056','هاجر','D',1,'Y'),('B057','وستينج هاوس','D',1,'Y'),('B058','شنايدر','D',1,'Y'),('B059','اوكى','D',1,'Y'),('B060','DUSS','D',1,'Y'),('B061','ميتابو','D',1,'Y'),('B062','بوش','D',1,'Y'),('B063','كراون','D',1,'Y'),('B064','وش','D',1,'Y'),('B065','تمساح','D',1,'Y'),('B066','Carrier','D',1,'Y'),('B067','Midea','D',1,'Y'),('B068','Lede','D',1,'Y'),('B069','فاكتوليك','D',1,'Y'),('C01','Black','M',1,'N'),('C02','Galvenated','M',1,'N'),('C03','White','M',1,'N'),('C04','Red','M',1,'N'),('C05','Green','M',1,'N'),('C06','Yellow','M',1,'N'),('C07','Brown','M',1,'N'),('C08','Silver','M',1,'N'),('C09','Gray','M',1,'N'),('C10','Golden','M',1,'N'),('C11','Zinc','M',1,'N'),('D0001','Ø0.5 mm','B',1,'Y'),('D0002','Ø0.5\"/0.75\"','B',1,'Y'),('D0003','Ø0.5\"/1.25\"','B',1,'N'),('D0004','Ø0.5\"/1.5\"','B',1,'N'),('D0005','Ø0.5\"/1\"','B',1,'N'),('D0006','Ø0.5\"/2\"','B',1,'N'),('D0007','Ø0.5\"/40 mm','B',1,'N'),('D0008','Ø0.5\"/50 mm','B',1,'N'),('D0009','Ø0.5\"/63 mm','B',1,'N'),('D0010','Ø0.5\"','B',1,'N'),('D0011','Ø0.75 mm','B',1,'N'),('D0012','Ø0.75\"/0.5\"','B',1,'N'),('D0013','Ø0.75\"/1.25\"','B',1,'N'),('D0014','Ø0.75\"/1.5\"','B',1,'N'),('D0015','Ø0.75\"/1\"','B',1,'N'),('D0016','Ø0.75\"/2\"','B',1,'N'),('D0017','Ø0.75\"/40 mm','B',1,'N'),('D0018','Ø0.75\"/50 mm','B',1,'N'),('D0019','Ø0.75\"/63 mm','B',1,'N'),('D0020','Ø0.75\"','B',1,'N'),('D0021','Ø1 cm','B',1,'N'),('D0022','Ø1 mm','B',1,'N'),('D0023','Ø1 mm*3 mm','B',1,'N'),('D0024','Ø1 mm*4 mm','B',1,'N'),('D0025','Ø1 mm*6 mm','B',1,'N'),('D0026','Ø1,1/8\"','B',1,'N'),('D0027','Ø1,3/8\"','B',1,'N'),('D0028','Ø1,5/8\"','B',1,'N'),('D0029','Ø1.1/2\"','B',1,'N'),('D0030','Ø1.1/4\"','B',1,'N'),('D0031','Ø1.1/4\" / 1\"','B',1,'N'),('D0032','Ø1.1/8\"','B',1,'N'),('D0033','Ø1.1/8\"/1/2\"','B',1,'N'),('D0034','Ø1.1/8\"/3/4\"','B',1,'N'),('D0035','Ø1.1/8\"/5/8\"','B',1,'N'),('D0036','Ø1.1/8\"/7/8\"','B',1,'N'),('D0037','Ø1.25\"/0.5\"','B',1,'N'),('D0038','Ø1.25\"/0.75\"','B',1,'N'),('D0039','Ø1.25\"/1.5\"','B',1,'N'),('D0040','Ø1.25\"/1\"','B',1,'N'),('D0041','Ø1.25\"/2\"','B',1,'N'),('D0042','Ø1.25\"/40 mm','B',1,'N'),('D0043','Ø1.25\"/50 mm','B',1,'N'),('D0044','Ø1.25\"/63 mm','B',1,'N'),('D0045','Ø1.25\"','B',1,'N'),('D0046','Ø1.25\"/1\"','B',1,'N'),('D0047','Ø1.25m*1.4m*0.7 mm','B',1,'N'),('D0048','Ø1.25m*1.5m*0.7 mm','B',1,'N'),('D0049','Ø1.25m*1.6m*0.7 mm','B',1,'N'),('D0050','Ø1.25m*1.95m*0.7 mm','B',1,'N'),('D0051','Ø1.25m*2.4m*0.7 mm','B',1,'N'),('D0052','Ø1.25m*2.55m*0.7 mm','B',1,'N'),('D0053','Ø1.25m*2.65m*0.7 mm','B',1,'N'),('D0054','Ø1.25m*6m*0.5 mm','B',1,'N'),('D0055','Ø1.2m*2m*2.9 mm','B',1,'N'),('D0056','Ø1.2m','B',1,'N'),('D0057','Ø1.3 cm','B',1,'N'),('D0058','Ø1.3/8\"','B',1,'N'),('D0059','Ø1.3/8\"/1.1/8\"','B',1,'N'),('D0060','Ø1.3/8\"/5/8\"','B',1,'N'),('D0061','Ø1.3/8\"/7/8\"','B',1,'N'),('D0063','Ø1.5 cm*5 mm','B',1,'N'),('D0064','Ø1.5 cm','B',1,'N'),('D0065','Ø1.5 mm','B',1,'N'),('D0066','Ø1.5\"/0.75\"','B',1,'N'),('D0067','Ø1.5\"/1.25\"','B',1,'N'),('D0068','Ø1.5\"/1\"','B',1,'N'),('D0069','Ø1.5\"/2\"','B',1,'N'),('D0070','Ø1.5\"/50 mm','B',1,'N'),('D0071','Ø1.5\"/63 mm','B',1,'N'),('D0072','Ø1.5\"','B',1,'N'),('D0073','Ø1.5/8\"','B',1,'N'),('D0074','Ø1.5/8\"/1.1/8\"','B',1,'N'),('D0075','Ø1.5/8\"/1.3/8\"','B',1,'N'),('D0076','Ø1.5m','B',1,'N'),('D0077','Ø1.6 cm','B',1,'N'),('D0078','Ø1\"/0.5\"','B',1,'N'),('D0079','Ø1\"/0.75\"','B',1,'N'),('D0080','Ø1\"/1.25\"','B',1,'N'),('D0081','Ø1\"/1.5\"','B',1,'N'),('D0082','Ø1\"/2\"','B',1,'N'),('D0083','Ø1\"/40 mm','B',1,'N'),('D0084','Ø1\"/50 mm','B',1,'N'),('D0085','Ø1\"/63 mm','B',1,'N'),('D0086','Ø1\"','B',1,'N'),('D0087','Ø1\" / 3/4\"','B',1,'N'),('D0088','Ø1\" / 5/8\"','B',1,'N'),('D0089','Ø1\"/1/2\"','B',1,'N'),('D0090','Ø1\"/3/4\"','B',1,'N'),('D0091','Ø1\"/5/8\"','B',1,'N'),('D0092','Ø1\"/7/8\"','B',1,'N'),('D0093','Ø1/2\"*8 cm','B',1,'N'),('D0094','Ø1/2\"','B',1,'N'),('D0095','Ø1/2\" / 1/4\"','B',1,'N'),('D0096','Ø1/2\" / 3/8\"','B',1,'N'),('D0097','Ø1/2\" /5/8\"','B',1,'N'),('D0098','Ø1/2\"/1/4\"','B',1,'N'),('D0099','Ø1/2\"/3/8\"','B',1,'N'),('d01','70-80Kg/m3','L',1,'N'),('D0100','Ø1/2\"/5/8\"','B',1,'N'),('D0101','Ø1/4\"','B',1,'N'),('D0102','Ø1/8\"','B',1,'N'),('D0103','Ø1/8\" / 1/4\"','B',1,'N'),('D0104','Ø10 cm','B',1,'N'),('D0105','Ø10 mm','B',1,'N'),('D0107','Ø10 cm*1.25 mm','B',1,'N'),('D0109','Ø10 cm*10 cm*1 mm','B',1,'N'),('D0110','Ø10 cm*10 cm*1.5 mm','B',1,'N'),('D0111','Ø10 cm*10 cm*10 mm','B',1,'N'),('D0112','Ø10 cm*10 cm*15 mm','B',1,'N'),('D0113','Ø10 cm*10 cm*2 mm','B',1,'N'),('D0114','Ø10 cm*10 cm*20 mm','B',1,'N'),('D0115','Ø10 cm*10 cm*3 mm','B',1,'N'),('D0116','Ø10 cm*10 cm*4 mm','B',1,'N'),('D0117','Ø10 cm*10 cm*5 mm','B',1,'N'),('D0118','Ø10 cm*10 cm*6 mm','B',1,'N'),('D0119','Ø10 cm*10 cm','B',1,'N'),('D0120','Ø10 cm*11 cm','B',1,'N'),('D0121','Ø10 cm*5 cm*1 mm','B',1,'N'),('D0122','Ø10 cm*5 cm*1.5 mm','B',1,'N'),('D0123','Ø10 cm*5 cm*3 mm','B',1,'N'),('D0124','Ø10 cm*5 cm*5.5 mm','B',1,'N'),('D0125','Ø10 cm*5 cm','B',1,'N'),('D0126','Ø10 cm*5 mm','B',1,'N'),('D0129','Ø10 cm/10 cm*10 cm*1.5 mm','B',1,'N'),('D0130','Ø10 cm/10 cm*5 cm*1.5 mm','B',1,'N'),('D0131','Ø10 cm/5 cm*5 cm*1.5 mm','B',1,'N'),('D0132','Ø10 cm','B',1,'N'),('D0134','Ø10 mm*10 cm','B',1,'N'),('D0135','Ø10 mm*12 cm','B',1,'N'),('D0136','Ø10 mm*13 cm','B',1,'N'),('D0137','Ø10 mm*14 cm','B',1,'N'),('D0138','Ø10 mm*16 cm','B',1,'N'),('D0139','Ø10 mm*2.5 cm','B',1,'N'),('D0141','Ø10 mm*3 cm','B',1,'N'),('D0143','Ø10 mm*4 cm','B',1,'N'),('D0145','Ø10 mm*5 cm','B',1,'N'),('D0147','Ø10 mm*6 cm','B',1,'N'),('D0149','Ø10 mm*7 cm','B',1,'N'),('D0150','Ø10 mm*8 cm','B',1,'N'),('D0151','Ø10 mm*9.5 cm','B',1,'N'),('D0152','Ø10 mm','B',1,'N'),('D0153','Ø10 mm*10 mm','B',1,'N'),('D0154','Ø10 mm*12 mm','B',1,'N'),('D0155','Ø10 mm*14 mm','B',1,'N'),('D0156','Ø10 mm*16 mm','B',1,'N'),('D0157','Ø10 mm*6 mm','B',1,'N'),('D0158','Ø10 mm*8 mm','B',1,'N'),('D0159','Ø10 mm/11 mm','B',1,'N'),('D0160','Ø10 mm/12 mm','B',1,'N'),('D0161','Ø10\"/0.5\"','B',1,'N'),('D0162','Ø10\"/0.75\"','B',1,'N'),('D0163','Ø10\"/1.25\"','B',1,'N'),('D0164','Ø10\"/1.5\"','B',1,'N'),('D0165','Ø10\"/1\"','B',1,'N'),('D0166','Ø10\"/2.5\"','B',1,'N'),('D0167','Ø10\"/2\"','B',1,'N'),('D0168','Ø10\"/3\"','B',1,'N'),('D0169','Ø10\"/4\"','B',1,'N'),('D0170','Ø10\"/5\"','B',1,'N'),('D0171','Ø10\"/6\"','B',1,'N'),('D0172','Ø10\"/8\"','B',1,'N'),('D0173','Ø10\"','B',1,'N'),('D0174','Ø10\"/3\"','B',1,'N'),('D0175','Ø10\"/4\"','B',1,'N'),('D0176','Ø10\"/6\"','B',1,'N'),('D0177','Ø10\"/8\"','B',1,'N'),('D0178','Ø10*0.6 mm','B',1,'N'),('D0179','Ø10/10/5/5 cm','B',1,'N'),('D0180','Ø10/20/10/5 cm','B',1,'N'),('D0181','Ø10/20/5/5 cm','B',1,'N'),('D0182','Ø10/30/35/5 cm','B',1,'N'),('D0183','Ø10/5/5/5 cm','B',1,'N'),('D0184','Ø10/50/30/5 cm','B',1,'N'),('D0185','Ø100 cm*1.5 mm','B',1,'N'),('D0186','Ø100 cm*10 cm*1.5 mm','B',1,'N'),('D0187','Ø100 cm*10 cm*10 mm','B',1,'N'),('D0188','Ø100 cm*10 cm','B',1,'N'),('D0189','Ø100 cm*100 cm*10 mm','B',1,'N'),('D0190','Ø100 cm*5 cm*2 mm','B',1,'N'),('D0191','Ø100 cm*5 cm','B',1,'N'),('D0192','Ø100 cm*80 cm','B',1,'N'),('D0193','Ø100 cm/80 cm*10 cm*1.5 mm','B',1,'N'),('D0194','Ø100 cm','B',1,'N'),('D0195','Ø100 mm','B',1,'N'),('D0196','Ø100*0.6 mm','B',1,'N'),('D0197','Ø1000 mm','B',1,'N'),('D0198','Ø10m','B',1,'N'),('D0199','Ø10','B',1,'N'),('d02','96Kg/m3','L',1,'N'),('D0200','Ø11 cm','B',1,'N'),('D0201','Ø11 cm','B',1,'N'),('D0202','Ø11 mm','B',1,'N'),('D0203','Ø110 cm*36 cm*6 mm','B',1,'N'),('D0204','Ø110 mm','B',1,'N'),('D0205','Ø110 mm/16 mm','B',1,'N'),('D0206','Ø110 mm/20 mm','B',1,'N'),('D0207','Ø110 mm/25 mm','B',1,'N'),('D0208','Ø110 mm/32 mm','B',1,'N'),('D0209','Ø110 mm/40 mm','B',1,'N'),('D0210','Ø110 mm/50 mm','B',1,'N'),('D0211','Ø110 mm/63 mm','B',1,'N'),('D0212','Ø110 mm/75 mm','B',1,'N'),('D0213','Ø110 mm/90 mm','B',1,'N'),('D0214','Ø111 mm','B',1,'N'),('D0215','Ø114 mm','B',1,'N'),('D0216','Ø12 cm','B',1,'N'),('D0217','Ø12 mm*10 cm','B',1,'N'),('D0218','Ø12 mm*12 cm','B',1,'N'),('D0219','Ø12 mm*13 cm','B',1,'N'),('D0220','Ø12 mm*14 cm','B',1,'N'),('D0221','Ø12 mm*15 cm','B',1,'N'),('D0222','Ø12 mm*16 cm','B',1,'N'),('D0223','Ø12 mm*18 cm','B',1,'N'),('D0224','Ø12 mm*3 cm','B',1,'N'),('D0225','Ø12 mm*4 cm','B',1,'N'),('D0226','Ø12 mm*5 cm','B',1,'N'),('D0227','Ø12 mm*6 cm','B',1,'N'),('D0228','Ø12 mm*7 cm','B',1,'N'),('D0229','Ø12 mm*7.5 cm','B',1,'N'),('D0230','Ø12 mm*8 cm','B',1,'N'),('D0231','Ø12 mm','B',1,'N'),('D0232','Ø12 cm*12 cm*4 mm','B',1,'N'),('D0233','Ø12 cm*12 cm*8 mm','B',1,'N'),('D0234','Ø12 cm*14 cm','B',1,'N'),('D0235','Ø12 cm*6 cm*5 mm','B',1,'N'),('D0236','Ø12 mm*10 cm','B',1,'N'),('D0237','Ø12 mm*11.6 cm','B',1,'N'),('D0238','Ø12 mm*12 cm','B',1,'N'),('D0239','Ø12 mm*14 cm','B',1,'N'),('D0240','Ø12 mm*15 cm','B',1,'N'),('D0241','Ø12 mm*16 cm','B',1,'N'),('D0247','Ø12 mm*8 cm','B',1,'N'),('D0248','Ø12 mm','B',1,'N'),('D0249','Ø12 mm/13 mm','B',1,'N'),('D0250','Ø12 mm/32 mm','B',1,'N'),('D0251','Ø12.5 cm*12.5 cm*3 mm','B',1,'N'),('D0252','Ø12\"/0.5\"','B',1,'N'),('D0253','Ø12\"/0.75\"','B',1,'N'),('D0254','Ø12\"/1.25\"','B',1,'N'),('D0255','Ø12\"/1.5\"','B',1,'N'),('D0256','Ø12\"/1\"','B',1,'N'),('D0257','Ø12\"/10\"','B',1,'N'),('D0258','Ø12\"/2.5\"','B',1,'N'),('D0259','Ø12\"/2\"','B',1,'N'),('D0260','Ø12\"/3\"','B',1,'N'),('D0261','Ø12\"/4\"','B',1,'N'),('D0262','Ø12\"/5\"','B',1,'N'),('D0263','Ø12\"/6\"','B',1,'N'),('D0264','Ø12\"/8\"','B',1,'N'),('D0265','Ø12\"','B',1,'N'),('D0266','Ø12*1 mm','B',1,'N'),('D0267','Ø12*1.5 mm','B',1,'N'),('D0268','Ø120 cm','B',1,'N'),('D0269','Ø120 mm','B',1,'N'),('D0270','Ø120 mm*10 mm','B',1,'N'),('D0271','Ø120 mm*12 mm','B',1,'N'),('D0272','Ø120 mm*14 mm','B',1,'N'),('D0273','Ø120 mm*16 mm','B',1,'N'),('D0274','Ø120 mm*20 mm','B',1,'N'),('D0275','Ø120 mm*6 mm','B',1,'N'),('D0276','Ø120 mm*8 mm','B',1,'N'),('D0277','Ø1200 mm','B',1,'N'),('D0278','Ø125 mm/110 mm','B',1,'N'),('D0279','Ø125 mm/90 mm','B',1,'N'),('D0280','Ø125 mm','B',1,'N'),('D0281','Ø125 mm/110 mm','B',1,'N'),('D0282','Ø125 mm/16 mm','B',1,'N'),('D0283','Ø125 mm/20 mm','B',1,'N'),('D0284','Ø125 mm/25 mm','B',1,'N'),('D0285','Ø125 mm/32 mm','B',1,'N'),('D0286','Ø125 mm/40 mm','B',1,'N'),('D0287','Ø125 mm/50 mm','B',1,'N'),('D0288','Ø125 mm/63 mm','B',1,'N'),('D0289','Ø125 mm/75 mm','B',1,'N'),('D0290','Ø125 mm/90 mm','B',1,'N'),('D0291','Ø13 cm','B',1,'N'),('D0292','Ø13 mm','B',1,'N'),('D0293','Ø13 mm/14 mm','B',1,'N'),('D0294','Ø13 mm/17 mm','B',1,'N'),('D0295','Ø13.5 mm','B',1,'N'),('D0296','Ø14 cm','B',1,'N'),('D0297','Ø14 mm*10 cm','B',1,'N'),('D0298','Ø14 mm*11 cm','B',1,'N'),('D0299','Ø14 mm*12 cm','B',1,'N'),('d03','16Kg/m3','L',1,'N'),('D0300','Ø14 mm*14 cm','B',1,'N'),('D0301','Ø14 mm*15 cm','B',1,'N'),('D0302','Ø14 mm*16 cm','B',1,'N'),('D0303','Ø14 mm*18 cm','B',1,'N'),('D0304','Ø14 mm*20 cm','B',1,'N'),('D0305','Ø14 mm*4 cm','B',1,'N'),('D0306','Ø14 mm*5 cm','B',1,'N'),('D0307','Ø14 mm*6 cm','B',1,'N'),('D0308','Ø14 mm*7 cm','B',1,'N'),('D0309','Ø14 mm*8 cm','B',1,'N'),('D0310','Ø14 mm','B',1,'N'),('D0311','Ø14 cm*3.5 cm*6 mm','B',1,'N'),('D0314','Ø14 mm*10 cm','B',1,'N'),('D0315','Ø14 mm*11.6 cm','B',1,'N'),('D0316','Ø14 mm*12 cm','B',1,'N'),('D0317','Ø14 mm*14 cm','B',1,'N'),('D0318','Ø14 mm*15 cm','B',1,'N'),('D0319','Ø14 mm*16 cm','B',1,'N'),('D0325','Ø14 mm*8 cm','B',1,'N'),('D0326','Ø14 mm','B',1,'N'),('D0327','Ø14 mm/15 mm','B',1,'N'),('D0328','Ø14\"/0.5\"','B',1,'N'),('D0329','Ø14\"/0.75\"','B',1,'N'),('D0330','Ø14\"/1.25\"','B',1,'N'),('D0331','Ø14\"/1.5\"','B',1,'N'),('D0332','Ø14\"/1\"','B',1,'N'),('D0333','Ø14\"/10\"','B',1,'N'),('D0334','Ø14\"/12\"','B',1,'N'),('D0335','Ø14\"/2.5\"','B',1,'N'),('D0336','Ø14\"/2\"','B',1,'N'),('D0337','Ø14\"/3\"','B',1,'N'),('D0338','Ø14\"/4\"','B',1,'N'),('D0339','Ø14\"/5\"','B',1,'N'),('D0340','Ø14\"/6\"','B',1,'N'),('D0341','Ø14\"/8\"','B',1,'N'),('D0342','Ø14\"','B',1,'N'),('D0343','Ø140 cm*70 cm*3 mm','B',1,'N'),('D0344','Ø140 mm/110 mm','B',1,'N'),('D0345','Ø140 mm/125 mm','B',1,'N'),('D0346','Ø140 mm','B',1,'N'),('D0347','Ø140 mm/110 mm','B',1,'N'),('D0348','Ø140 mm/125 mm','B',1,'N'),('D0349','Ø140 mm/16 mm','B',1,'N'),('D0350','Ø140 mm/20 mm','B',1,'N'),('D0351','Ø140 mm/25 mm','B',1,'N'),('D0352','Ø140 mm/32 mm','B',1,'N'),('D0353','Ø140 mm/40 mm','B',1,'N'),('D0354','Ø140 mm/50 mm','B',1,'N'),('D0355','Ø140 mm/63 mm','B',1,'N'),('D0356','Ø140 mm/75 mm','B',1,'N'),('D0357','Ø140 mm/90 mm','B',1,'N'),('D0358','Ø1400 mm','B',1,'N'),('D0359','Ø15 cm','B',1,'N'),('D0360','Ø15 cm*1.25 mm','B',1,'N'),('D0361','Ø15 cm*10 cm*2 mm','B',1,'N'),('D0362','Ø15 cm*10 cm*3 mm','B',1,'N'),('D0363','Ø15 cm*10 cm*8 mm','B',1,'N'),('D0364','Ø15 cm*10 cm','B',1,'N'),('D0365','Ø15 cm*15 cm*2 mm','B',1,'N'),('D0366','Ø15 cm*15 cm*3 mm','B',1,'N'),('D0367','Ø15 cm*15 cm*4 mm','B',1,'N'),('D0368','Ø15 cm*15 cm*5 mm','B',1,'N'),('D0369','Ø15 cm*15 cm*5.5 mm','B',1,'N'),('D0370','Ø15 cm*15 cm*6 mm','B',1,'N'),('D0371','Ø15 cm*15 cm*8 mm','B',1,'N'),('D0372','Ø15 cm*5 cm*1.5 mm','B',1,'N'),('D0373','Ø15 cm*5 cm*3 mm','B',1,'N'),('D0374','Ø15 cm*5 cm','B',1,'N'),('D0375','Ø15 cm/10 cm*10 cm*1.5 mm','B',1,'N'),('D0376','Ø15 cm/5 cm*10 cm*1.5 mm','B',1,'N'),('D0377','Ø15 cm','B',1,'N'),('D0378','Ø15 mm','B',1,'N'),('D0379','Ø15 mm/16 mm','B',1,'N'),('D0380','Ø15\"','B',1,'N'),('D0381','Ø15*0.6 mm','B',1,'N'),('D0382','Ø15/15/30/5 cm','B',1,'N'),('D0383','Ø15/20/30/5 cm','B',1,'N'),('D0384','Ø15/20/35/5 cm','B',1,'N'),('D0385','Ø15/30/40/5 cm','B',1,'N'),('D0386','Ø15/45/45/5 cm','B',1,'N'),('D0387','Ø150 cm*100 cm*10 mm','B',1,'N'),('D0388','Ø150 mm','B',1,'N'),('D0389','Ø150 mm*10 mm','B',1,'N'),('D0390','Ø150 mm*12 mm','B',1,'N'),('D0391','Ø150 mm*14 mm','B',1,'N'),('D0392','Ø150 mm*16 mm','B',1,'N'),('D0393','Ø150 mm*20 mm','B',1,'N'),('D0394','Ø150 mm*6 mm','B',1,'N'),('D0395','Ø150 mm*8 mm','B',1,'N'),('D0396','Ø150*0.6 mm','B',1,'N'),('D0397','Ø16 cm','B',1,'N'),('D0398','Ø16 mm*10 cm','B',1,'N'),('D0399','Ø16 mm*12 cm','B',1,'N'),('d04','24Kg/m3','L',1,'N'),('D0400','Ø16 mm*14 cm','B',1,'N'),('D0401','Ø16 mm*3 cm','B',1,'N'),('D0402','Ø16 mm*4 cm','B',1,'N'),('D0403','Ø16 mm*4.5 cm','B',1,'N'),('D0404','Ø16 mm*5 cm','B',1,'N'),('D0405','Ø16 mm*6 cm','B',1,'N'),('D0406','Ø16 mm*7 cm','B',1,'N'),('D0407','Ø16 mm*8 cm','B',1,'N'),('D0408','Ø16 mm','B',1,'N'),('D0410','Ø16 mm*10 cm','B',1,'N'),('D0411','Ø16 mm*12 cm','B',1,'N'),('D0412','Ø16 mm*14 cm','B',1,'N'),('D0413','Ø16 mm*15 cm','B',1,'N'),('D0414','Ø16 mm*16 cm','B',1,'N'),('D0415','Ø16 mm*17 cm','B',1,'N'),('D0416','Ø16 mm*18 cm','B',1,'N'),('D0417','Ø16 mm*20 cm','B',1,'N'),('D0418','Ø16 mm*22 cm','B',1,'N'),('D0419','Ø16 mm*24 cm','B',1,'N'),('D0420','Ø16 mm*25 cm','B',1,'N'),('D0426','Ø16 mm*8 cm','B',1,'N'),('D0427','Ø16 mm','B',1,'N'),('D0428','Ø16 mm*10 mm','B',1,'N'),('D0429','Ø16 mm*12 mm','B',1,'N'),('D0430','Ø16 mm*14 mm','B',1,'N'),('D0431','Ø16 mm*16 mm','B',1,'N'),('D0432','Ø16 mm*20 mm','B',1,'N'),('D0433','Ø16 mm*6 mm','B',1,'N'),('D0434','Ø16 mm*8 mm','B',1,'N'),('D0435','Ø16 mm/17 mm','B',1,'N'),('D0436','Ø16 mm/18 mm','B',1,'N'),('D0437','Ø16\"/0.5\"','B',1,'N'),('D0438','Ø16\"/0.75\"','B',1,'N'),('D0439','Ø16\"/1.25\"','B',1,'N'),('D0440','Ø16\"/1.5\"','B',1,'N'),('D0441','Ø16\"/1\"','B',1,'N'),('D0442','Ø16\"/10\"','B',1,'N'),('D0443','Ø16\"/12\"','B',1,'N'),('D0444','Ø16\"/14\"','B',1,'N'),('D0445','Ø16\"/2.5\"','B',1,'N'),('D0446','Ø16\"/2\"','B',1,'N'),('D0447','Ø16\"/3\"','B',1,'N'),('D0448','Ø16\"/4\"','B',1,'N'),('D0449','Ø16\"/5\"','B',1,'N'),('D0450','Ø16\"/6\"','B',1,'N'),('D0451','Ø16\"/8\"','B',1,'N'),('D0452','Ø16\"','B',1,'N'),('D0453','Ø160 mm/125 mm','B',1,'N'),('D0454','Ø160 mm/140 mm','B',1,'N'),('D0455','Ø160 mm/75 mm','B',1,'N'),('D0456','Ø160 mm/90 mm','B',1,'N'),('D0457','Ø160 mm','B',1,'N'),('D0458','Ø160 mm/110 mm','B',1,'N'),('D0459','Ø160 mm/125 mm','B',1,'N'),('D0460','Ø160 mm/140 mm','B',1,'N'),('D0461','Ø160 mm/16 mm','B',1,'N'),('D0462','Ø160 mm/20 mm','B',1,'N'),('D0463','Ø160 mm/25 mm','B',1,'N'),('D0464','Ø160 mm/32 mm','B',1,'N'),('D0465','Ø160 mm/40 mm','B',1,'N'),('D0466','Ø160 mm/50 mm','B',1,'N'),('D0467','Ø160 mm/63 mm','B',1,'N'),('D0468','Ø160 mm/75 mm','B',1,'N'),('D0469','Ø160 mm/90 mm','B',1,'N'),('D0470','Ø1600 mm','B',1,'N'),('D0472','Ø17 mm','B',1,'N'),('D0473','Ø18 cm','B',1,'N'),('D0474','Ø18 mm*10 cm','B',1,'N'),('D0475','Ø18 mm*12 cm','B',1,'N'),('D0476','Ø18 mm*14 cm','B',1,'N'),('D0477','Ø18 mm*15 cm','B',1,'N'),('D0478','Ø18 mm*16 cm','B',1,'N'),('D0479','Ø18 mm*5 cm','B',1,'N'),('D0480','Ø18 mm*6 cm','B',1,'N'),('D0481','Ø18 mm*7 cm','B',1,'N'),('D0482','Ø18 mm*8 cm','B',1,'N'),('D0483','Ø18 mm*9 cm','B',1,'N'),('D0484','Ø18 mm','B',1,'N'),('D0485','Ø18 cm*18 cm*8 mm','B',1,'N'),('D0486','Ø18 mm*10 cm','B',1,'N'),('D0487','Ø18 mm*12 cm','B',1,'N'),('D0488','Ø18 mm*14 cm','B',1,'N'),('D0489','Ø18 mm*16 cm','B',1,'N'),('D0490','Ø18 mm*18 cm','B',1,'N'),('D0491','Ø18 mm*20 cm','B',1,'N'),('D0492','Ø18 mm*21 cm','B',1,'N'),('D0493','Ø18 mm*22 cm','B',1,'N'),('D0494','Ø18 mm*24 cm','B',1,'N'),('D0495','Ø18 mm*25 cm','B',1,'N'),('d05','10Kg/m3','L',1,'N'),('D0501','Ø18 mm*8 cm','B',1,'N'),('D0502','Ø18 mm','B',1,'N'),('D0503','Ø18 mm/19 mm','B',1,'N'),('D0504','Ø18\"/0.5\"','B',1,'N'),('D0505','Ø18\"/0.75\"','B',1,'N'),('D0506','Ø18\"/1.25\"','B',1,'N'),('D0507','Ø18\"/1.5\"','B',1,'N'),('D0508','Ø18\"/1\"','B',1,'N'),('D0509','Ø18\"/10\"','B',1,'N'),('D0510','Ø18\"/12\"','B',1,'N'),('D0511','Ø18\"/14\"','B',1,'N'),('D0512','Ø18\"/16\"','B',1,'N'),('D0513','Ø18\"/2.5\"','B',1,'N'),('D0514','Ø18\"/2\"','B',1,'N'),('D0515','Ø18\"/3\"','B',1,'N'),('D0516','Ø18\"/4\"','B',1,'N'),('D0517','Ø18\"/5\"','B',1,'N'),('D0518','Ø18\"/6\"','B',1,'N'),('D0519','Ø18\"/8\"','B',1,'N'),('D0520','Ø18\"','B',1,'N'),('D0521','Ø180 mm','B',1,'N'),('D0522','Ø180 mm/110 mm','B',1,'N'),('D0523','Ø180 mm/125 mm','B',1,'N'),('D0524','Ø180 mm/140 mm','B',1,'N'),('D0525','Ø180 mm/16 mm','B',1,'N'),('D0526','Ø180 mm/160 mm','B',1,'N'),('D0527','Ø180 mm/20 mm','B',1,'N'),('D0528','Ø180 mm/25 mm','B',1,'N'),('D0529','Ø180 mm/32 mm','B',1,'N'),('D0530','Ø180 mm/40 mm','B',1,'N'),('D0531','Ø180 mm/50 mm','B',1,'N'),('D0532','Ø180 mm/63 mm','B',1,'N'),('D0533','Ø180 mm/75 mm','B',1,'N'),('D0534','Ø180 mm/90 mm','B',1,'N'),('D0535','Ø1800 mm','B',1,'N'),('D0536','Ø185 mm','B',1,'N'),('D0537','Ø185 mm*10 mm','B',1,'N'),('D0538','Ø185 mm*12 mm','B',1,'N'),('D0539','Ø185 mm*14 mm','B',1,'N'),('D0540','Ø185 mm*16 mm','B',1,'N'),('D0541','Ø185 mm*20 mm','B',1,'N'),('D0542','Ø185 mm*6 mm','B',1,'N'),('D0543','Ø185 mm*8 mm','B',1,'N'),('D0544','Ø19 mm','B',1,'N'),('D0545','Ø19 mm/21 mm','B',1,'N'),('D0546','Ø1m*1m*2.9 mm','B',1,'N'),('D0547','Ø1m*2m*2.9 mm','B',1,'N'),('D0548','Ø1m*6m*0.5 mm','B',1,'N'),('D0549','Ø1m*7.5m*0.5 mm','B',1,'N'),('D0550','Ø2 cm*0.5 mm','B',1,'N'),('D0551','Ø2 cm*10 mm','B',1,'N'),('D0552','Ø2 cm*2 cm*2 mm','B',1,'N'),('D0553','Ø2 cm*2.5 cm','B',1,'N'),('D0554','Ø2 cm*5 mm','B',1,'N'),('D0555','Ø2 cm','B',1,'N'),('D0556','Ø2 mm','B',1,'N'),('D0557','Ø2 mm*10 mm','B',1,'N'),('D0558','Ø2 mm*5 mm','B',1,'N'),('D0559','Ø2 mm*6 mm','B',1,'N'),('D0560','Ø2 mm*8 mm','B',1,'N'),('D0561','Ø2,1/8\"','B',1,'N'),('D0562','Ø2,5/8\"','B',1,'N'),('D0563','Ø2.1/2\"','B',1,'N'),('D0564','Ø2.1/8\"','B',1,'N'),('D0565','Ø2.1/8\"/1.5/8\"','B',1,'N'),('D0566','Ø2.10m','B',1,'N'),('D0567','Ø2.4.m','B',1,'N'),('D0568','Ø2.5 cm','B',1,'N'),('D0570','Ø2.5 cm*2.5 cm*1.5 mm','B',1,'N'),('D0571','Ø2.5 cm*5 mm','B',1,'N'),('D0572','Ø2.5 cm','B',1,'N'),('D0573','Ø2.5 mm','B',1,'N'),('D0574','Ø2.5 mm*6 mm','B',1,'N'),('D0575','Ø2.5 mm*8 mm','B',1,'N'),('D0576','Ø2.5\"/0.5\"','B',1,'N'),('D0577','Ø2.5\"/0.75\"','B',1,'N'),('D0578','Ø2.5\"/1.25\"','B',1,'N'),('D0579','Ø2.5\"/1.5\"','B',1,'N'),('D0580','Ø2.5\"/1\"','B',1,'N'),('D0581','Ø2.5\"/110 mm','B',1,'N'),('D0582','Ø2.5\"/2\"','B',1,'N'),('D0583','Ø2.5\"/75 mm','B',1,'N'),('D0584','Ø2.5\"/90 mm','B',1,'N'),('D0585','Ø2.5\"','B',1,'N'),('D0586','Ø2.5\"/1.25\"','B',1,'N'),('D0587','Ø2.5\"/1.5\"','B',1,'N'),('D0588','Ø2.5\"/1\"','B',1,'N'),('D0589','Ø2.5\"/2\"','B',1,'N'),('D0590','Ø2.5/8\"','B',1,'N'),('D0591','Ø2.5/8\"/2.1/8\"','B',1,'N'),('D0592','Ø2.5/8\"/2.5/8\"','B',1,'N'),('D0593','Ø2.5m*1.25m*2 mm','B',1,'N'),('D0594','Ø2.5m','B',1,'N'),('D0595','Ø2.86m','B',1,'N'),('D0596','Ø2\"/0.5\"','B',1,'N'),('D0597','Ø2\"/0.75\"','B',1,'N'),('D0598','Ø2\"/1.25\"','B',1,'N'),('D0599','Ø2\"/1.5\"','B',1,'N'),('d06','40Kg/m3','L',1,'N'),('D0600','Ø2\"/1\"','B',1,'N'),('D0601','Ø2\"/2.5\"','B',1,'N'),('D0602','Ø2\"/63 mm','B',1,'N'),('D0603','Ø2\"/90 mm','B',1,'N'),('D0604','Ø2\"','B',1,'N'),('D0605','Ø2*1 mm','B',1,'N'),('D0606','Ø2*1.5 mm','B',1,'N'),('D0607','Ø2*10 mm','B',1,'N'),('D0608','Ø2*16 mm','B',1,'N'),('D0609','Ø2*2 mm','B',1,'N'),('D0610','Ø2*2.5 mm','B',1,'N'),('D0611','Ø2*3 mm','B',1,'N'),('D0612','Ø2*4 mm','B',1,'N'),('D0613','Ø20 cm','B',1,'N'),('D0614','Ø20 mm*10 cm','B',1,'N'),('D0615','Ø20 mm*12 cm','B',1,'N'),('D0616','Ø20 mm*14 cm','B',1,'N'),('D0617','Ø20 mm*15 cm','B',1,'N'),('D0618','Ø20 mm*16 cm','B',1,'N'),('D0619','Ø20 mm*18 cm','B',1,'N'),('D0620','Ø20 mm*4 cm','B',1,'N'),('D0621','Ø20 mm*5 cm','B',1,'N'),('D0622','Ø20 mm*6 cm','B',1,'N'),('D0623','Ø20 mm*7 cm','B',1,'N'),('D0624','Ø20 mm*8 cm','B',1,'N'),('D0625','Ø20 mm','B',1,'N'),('D0626','Ø20 cm*0.5 mm','B',1,'N'),('D0627','Ø20 cm*1.25 mm','B',1,'N'),('D0628','Ø20 cm*10 cm*1 mm','B',1,'N'),('D0629','Ø20 cm*10 cm*1.5 mm','B',1,'N'),('D0630','Ø20 cm*10 cm*6 mm','B',1,'N'),('D0631','Ø20 cm*10 cm','B',1,'N'),('D0632','Ø20 cm*12 cm*4 mm','B',1,'N'),('D0633','Ø20 cm*15 cm*1.5 mm','B',1,'N'),('D0634','Ø20 cm*20 cm*10 mm','B',1,'N'),('D0635','Ø20 cm*20 cm*11 mm','B',1,'N'),('D0636','Ø20 cm*20 cm*18 mm','B',1,'N'),('D0637','Ø20 cm*20 cm*3 mm','B',1,'N'),('D0638','Ø20 cm*20 cm*4 mm','B',1,'N'),('D0639','Ø20 cm*20 cm*5 mm','B',1,'N'),('D0640','Ø20 cm*20 cm*5.5 mm','B',1,'N'),('D0641','Ø20 cm*20 cm*6 mm','B',1,'N'),('D0643','Ø20 cm*5 cm*1.5 mm','B',1,'N'),('D0644','Ø20 cm*5 cm','B',1,'N'),('D0645','Ø20 cm*7 cm*2 mm','B',1,'N'),('D0646','Ø20 cm/10 cm*10 cm*1.5 mm','B',1,'N'),('D0647','Ø20 cm/15 cm*10 cm*1.5 mm','B',1,'N'),('D0648','Ø20 cm/15 cm*5 cm*1.5 mm','B',1,'N'),('D0649','Ø20 cm','B',1,'N'),('D0651','Ø20 mm*10 cm','B',1,'N'),('D0652','Ø20 mm*12 cm','B',1,'N'),('D0653','Ø20 mm*14 cm','B',1,'N'),('D0654','Ø20 mm*16 cm','B',1,'N'),('D0655','Ø20 mm*18 cm','B',1,'N'),('D0656','Ø20 mm*20 cm','B',1,'N'),('D0657','Ø20 mm*21 cm','B',1,'N'),('D0658','Ø20 mm*22 cm','B',1,'N'),('D0659','Ø20 mm*24 cm','B',1,'N'),('D0660','Ø20 mm*25 cm','B',1,'N'),('D0666','Ø20 mm*8 cm','B',1,'N'),('D0667','Ø20 mm','B',1,'N'),('D0668','Ø20 mm/0.5\"','B',1,'N'),('D0669','Ø20 mm/16 mm','B',1,'N'),('D0670','Ø20 mm/22 mm','B',1,'N'),('D0671','Ø20.5 cm*13 cm*8 mm','B',1,'N'),('D0672','Ø20\"/0.5\"','B',1,'N'),('D0673','Ø20\"/0.75\"','B',1,'N'),('D0674','Ø20\"/1.25\"','B',1,'N'),('D0675','Ø20\"/1.5\"','B',1,'N'),('D0676','Ø20\"/1\"','B',1,'N'),('D0677','Ø20\"/10\"','B',1,'N'),('D0678','Ø20\"/12\"','B',1,'N'),('D0679','Ø20\"/14\"','B',1,'N'),('D0680','Ø20\"/16\"','B',1,'N'),('D0681','Ø20\"/18\"','B',1,'N'),('D0682','Ø20\"/2.5\"','B',1,'N'),('D0683','Ø20\"/2\"','B',1,'N'),('D0684','Ø20\"/3\"','B',1,'N'),('D0685','Ø20\"/4\"','B',1,'N'),('D0686','Ø20\"/5\"','B',1,'N'),('D0687','Ø20\"/6\"','B',1,'N'),('D0688','Ø20\"/8\"','B',1,'N'),('D0689','Ø20\"','B',1,'N'),('D0690','Ø20*0.6 mm','B',1,'N'),('D0691','Ø20/10/5/5 cm','B',1,'N'),('D0692','Ø20/15/30/5 cm','B',1,'N'),('D0693','Ø20/15/5/5 cm','B',1,'N'),('D0694','Ø20/25/45/5 cm','B',1,'N'),('D0695','Ø20/30/10/5 cm','B',1,'N'),('D0696','Ø20/40/55/10 cm','B',1,'N'),('D0697','Ø20/5/25/5 cm','B',1,'N'),('D0698','Ø200 cm*30 cm*30 mm','B',1,'N'),('D0699','Ø200 cm*50 cm*8 mm','B',1,'N'),('d07','50Kg/m3','L',1,'N'),('D0700','Ø200 mm/110 mm','B',1,'N'),('D0701','Ø200 mm/140 mm','B',1,'N'),('D0702','Ø200 mm/160 mm','B',1,'N'),('D0703','Ø200 mm/75 mm','B',1,'N'),('D0704','Ø200 mm/90 mm','B',1,'N'),('D0705','Ø200 mm','B',1,'N'),('D0706','Ø200 mm/110 mm','B',1,'N'),('D0707','Ø200 mm/125 mm','B',1,'N'),('D0708','Ø200 mm/140 mm','B',1,'N'),('D0709','Ø200 mm/16 mm','B',1,'N'),('D0710','Ø200 mm/160 mm','B',1,'N'),('D0711','Ø200 mm/180 mm','B',1,'N'),('D0712','Ø200 mm/20 mm','B',1,'N'),('D0713','Ø200 mm/25 mm','B',1,'N'),('D0714','Ø200 mm/32 mm','B',1,'N'),('D0715','Ø200 mm/40 mm','B',1,'N'),('D0716','Ø200 mm/50 mm','B',1,'N'),('D0717','Ø200 mm/63 mm','B',1,'N'),('D0718','Ø200 mm/75 mm','B',1,'N'),('D0719','Ø200 mm/90 mm','B',1,'N'),('D0720','Ø200*0.6 mm','B',1,'N'),('D0721','Ø2000 mm','B',1,'N'),('D0722','Ø20m','B',1,'N'),('D0723','Ø21 mm','B',1,'N'),('D0724','Ø21 mm/23 mm','B',1,'N'),('D0725','Ø22 cm','B',1,'N'),('D0726','Ø22 mm* 10 cm','B',1,'N'),('D0727','Ø22 mm* 12 cm','B',1,'N'),('D0728','Ø22 mm* 14 cm','B',1,'N'),('D0729','Ø22 mm* 16 cm','B',1,'N'),('D0730','Ø22 mm* 18 cm','B',1,'N'),('D0731','Ø22 mm* 20 cm','B',1,'N'),('D0732','Ø22 mm* 6 cm','B',1,'N'),('D0733','Ø22 mm* 8 cm','B',1,'N'),('D0734','Ø22 mm*5 cm','B',1,'N'),('D0735','Ø22 mm','B',1,'N'),('D0736','Ø22 cm*22 cm*8 mm','B',1,'N'),('D0737','Ø22 mm','B',1,'N'),('D0738','Ø22 mm/23 mm','B',1,'N'),('D0739','Ø22.8 cm*22.8 cm*10 mm','B',1,'N'),('D0740','Ø22\"','B',1,'N'),('D0741','Ø225 mm/110 mm','B',1,'N'),('D0742','Ø225 mm/140 mm','B',1,'N'),('D0743','Ø225 mm/160 mm','B',1,'N'),('D0744','Ø225 mm/200 mm','B',1,'N'),('D0745','Ø225 mm/75 mm','B',1,'N'),('D0746','Ø225 mm/90 mm','B',1,'N'),('D0747','Ø225 mm','B',1,'N'),('D0748','Ø225 mm/110 mm','B',1,'N'),('D0749','Ø225 mm/125 mm','B',1,'N'),('D0750','Ø225 mm/140 mm','B',1,'N'),('D0751','Ø225 mm/16 mm','B',1,'N'),('D0752','Ø225 mm/160 mm','B',1,'N'),('D0753','Ø225 mm/180 mm','B',1,'N'),('D0754','Ø225 mm/20 mm','B',1,'N'),('D0755','Ø225 mm/200 mm','B',1,'N'),('D0756','Ø225 mm/25 mm','B',1,'N'),('D0757','Ø225 mm/32 mm','B',1,'N'),('D0758','Ø225 mm/40 mm','B',1,'N'),('D0759','Ø225 mm/50 mm','B',1,'N'),('D0760','Ø225 mm/63 mm','B',1,'N'),('D0761','Ø225 mm/75 mm','B',1,'N'),('D0762','Ø225 mm/90 mm','B',1,'N'),('D0763','Ø2250 mm','B',1,'N'),('D0764','Ø23 cm*23 cm*10 mm','B',1,'N'),('D0765','Ø23 mm','B',1,'N'),('D0766','Ø24 cm','B',1,'N'),('D0767','Ø24 mm* 10 cm','B',1,'N'),('D0768','Ø24 mm* 12 cm','B',1,'N'),('D0769','Ø24 mm* 14 cm','B',1,'N'),('D0770','Ø24 mm* 15 cm','B',1,'N'),('D0771','Ø24 mm* 16 cm','B',1,'N'),('D0772','Ø24 mm* 17 cm','B',1,'N'),('D0773','Ø24 mm* 18 cm','B',1,'N'),('D0774','Ø24 mm* 20 cm','B',1,'N'),('D0775','Ø24 mm* 4 cm','B',1,'N'),('D0776','Ø24 mm* 5 cm','B',1,'N'),('D0777','Ø24 mm* 6 cm','B',1,'N'),('D0778','Ø24 mm* 7 cm','B',1,'N'),('D0779','Ø24 mm* 8 cm','B',1,'N'),('D0780','Ø24 mm','B',1,'N'),('D0781','Ø24 cm*20 cm*10 mm','B',1,'N'),('D0782','Ø24 cm*20 cm*20 mm','B',1,'N'),('D0783','Ø24 mm','B',1,'N'),('D0784','Ø24 mm/25 mm','B',1,'N'),('D0785','Ø24 mm/26 mm','B',1,'N'),('D0786','Ø24 mm/27 mm','B',1,'N'),('D0787','Ø24.5 cm*20.5 cm*8 mm','B',1,'N'),('D0788','Ø24\"/0.5\"','B',1,'N'),('D0789','Ø24\"/0.75\"','B',1,'N'),('D0790','Ø24\"/1.25\"','B',1,'N'),('D0791','Ø24\"/1.5\"','B',1,'N'),('D0792','Ø24\"/1\"','B',1,'N'),('D0793','Ø24\"/10\"','B',1,'N'),('D0794','Ø24\"/12\"','B',1,'N'),('D0795','Ø24\"/14\"','B',1,'N'),('D0796','Ø24\"/16\"','B',1,'N'),('D0797','Ø24\"/18\"','B',1,'N'),('D0798','Ø24\"/2.5\"','B',1,'N'),('D0799','Ø24\"/2\"','B',1,'N'),('d08','70Kg/m3','L',1,'N'),('D0800','Ø24\"/20\"','B',1,'N'),('D0801','Ø24\"/3\"','B',1,'N'),('D0802','Ø24\"/4\"','B',1,'N'),('D0803','Ø24\"/5\"','B',1,'N'),('D0804','Ø24\"/6\"','B',1,'N'),('D0805','Ø24\"/8\"','B',1,'N'),('D0806','Ø24\"','B',1,'N'),('D0807','Ø240 cm*90 cm*3 mm','B',1,'N'),('D0808','Ø240 mm','B',1,'N'),('D0809','Ø240 mm*10 mm','B',1,'N'),('D0810','Ø240 mm*12 mm','B',1,'N'),('D0811','Ø240 mm*14 mm','B',1,'N'),('D0812','Ø240 mm*16 mm','B',1,'N'),('D0813','Ø240 mm*20 mm','B',1,'N'),('D0814','Ø240 mm*6 mm','B',1,'N'),('D0815','Ø240 mm*8 mm','B',1,'N'),('D0816','Ø25 cm*1.25 mm','B',1,'N'),('D0817','Ø25 cm*10 cm*1.5 mm','B',1,'N'),('D0818','Ø25 cm*10 cm','B',1,'N'),('D0819','Ø25 cm*12.5 cm*16 mm','B',1,'N'),('D0820','Ø25 cm*12.5 cm*4 mm','B',1,'N'),('D0821','Ø25 cm*20 cm*6 mm','B',1,'N'),('D0822','Ø25 cm*20 cm*8 mm','B',1,'N'),('D0823','Ø25 cm*25 cm*11 mm','B',1,'N'),('D0824','Ø25 cm*25 cm*16 mm','B',1,'N'),('D0825','Ø25 cm*25 cm*3 mm','B',1,'N'),('D0826','Ø25 cm*25 cm*4 mm','B',1,'N'),('D0827','Ø25 cm*25 cm*5 mm','B',1,'N'),('D0828','Ø25 cm*25 cm*8 mm','B',1,'N'),('D0829','Ø25 cm*25 cm*9 mm','B',1,'N'),('D0830','Ø25 cm*4 cm*4 mm','B',1,'N'),('D0831','Ø25 cm*4 cm*5 mm','B',1,'N'),('D0832','Ø25 cm*5 cm*1.5 mm','B',1,'N'),('D0833','Ø25 cm*5 cm','B',1,'N'),('D0834','Ø25 cm/10 cm*5 cm*1.5 mm','B',1,'N'),('D0835','Ø25 cm/5 cm*5 cm*1.5 mm','B',1,'N'),('D0836','Ø25 cm','B',1,'N'),('D0838','Ø25 mm','B',1,'N'),('D0839','Ø25 mm*10 mm','B',1,'N'),('D0840','Ø25 mm*12 mm','B',1,'N'),('D0841','Ø25 mm*14 mm','B',1,'N'),('D0842','Ø25 mm*16 mm','B',1,'N'),('D0843','Ø25 mm*20 mm','B',1,'N'),('D0844','Ø25 mm*6 mm','B',1,'N'),('D0845','Ø25 mm*8 mm','B',1,'N'),('D0846','Ø25 mm/0.5\"','B',1,'N'),('D0847','Ø25 mm/0.75\"','B',1,'N'),('D0848','Ø25 mm/16 mm','B',1,'N'),('D0849','Ø25 mm/20 mm','B',1,'N'),('D0850','Ø25 mm/28 mm','B',1,'N'),('D0851','Ø25*0.6 mm','B',1,'N'),('D0852','Ø25/15/5/5 cm','B',1,'N'),('D0853','Ø25/25/5/5 cm','B',1,'N'),('D0854','Ø25/25/50/5 cm','B',1,'N'),('D0855','Ø250 mm/110 mm','B',1,'N'),('D0856','Ø250 mm/140 mm','B',1,'N'),('D0857','Ø250 mm/160 mm','B',1,'N'),('D0858','Ø250 mm/200 mm','B',1,'N'),('D0859','Ø250 mm/225 mm','B',1,'N'),('D0860','Ø250 mm','B',1,'N'),('D0861','Ø250 mm/110 mm','B',1,'N'),('D0862','Ø250 mm/125 mm','B',1,'N'),('D0863','Ø250 mm/140 mm','B',1,'N'),('D0864','Ø250 mm/16 mm','B',1,'N'),('D0865','Ø250 mm/160 mm','B',1,'N'),('D0866','Ø250 mm/180 mm','B',1,'N'),('D0867','Ø250 mm/20 mm','B',1,'N'),('D0868','Ø250 mm/200 mm','B',1,'N'),('D0869','Ø250 mm/225 mm','B',1,'N'),('D0870','Ø250 mm/25 mm','B',1,'N'),('D0871','Ø250 mm/32 mm','B',1,'N'),('D0872','Ø250 mm/40 mm','B',1,'N'),('D0873','Ø250 mm/50 mm','B',1,'N'),('D0874','Ø250 mm/63 mm','B',1,'N'),('D0875','Ø250 mm/75 mm','B',1,'N'),('D0876','Ø250 mm/90 mm','B',1,'N'),('D0877','Ø250*0.6 mm','B',1,'N'),('D0878','Ø2500 mm','B',1,'N'),('D0879','Ø26 cm','B',1,'N'),('D0880','Ø26 mm','B',1,'N'),('D0881','Ø26 mm/28 mm','B',1,'N'),('D0882','Ø27 cm','B',1,'N'),('D0883','Ø27 mm* 5 cm','B',1,'N'),('D0884','Ø27 mm* 6 cm','B',1,'N'),('D0885','Ø27 mm* 7 cm','B',1,'N'),('D0886','Ø27 mm','B',1,'N'),('D0887','Ø27 mm/29 mm','B',1,'N'),('D0888','Ø28 cm','B',1,'N'),('D0889','Ø28 mm','B',1,'N'),('D0890','Ø28 mm/30 mm','B',1,'N'),('D0891','Ø280 mm','B',1,'N'),('D0892','Ø29 mm','B',1,'N'),('D0893','Ø2m*1.25m*0.7 mm','B',1,'N'),('D0894','Ø2m*1.5m*3 mm','B',1,'N'),('D0895','Ø2m*1m*1 mm','B',1,'N'),('D0896','Ø2m*1m*1.25 mm','B',1,'N'),('D0897','Ø2m*1m*2 mm','B',1,'N'),('D0898','Ø2m*1m*3 mm','B',1,'N'),('D0899','Ø2m*1m*4 mm','B',1,'N'),('d09','100Kg/m3','L',1,'N'),('D0900','Ø2m*1m*5 mm','B',1,'N'),('D0901','Ø2m','B',1,'N'),('D0902','Ø3 cm','B',1,'N'),('D0903','Ø3 cm*10 mm','B',1,'N'),('D0905','Ø3 cm*3 cm*2 mm','B',1,'N'),('D0906','Ø3 cm*3 cm*2.5 mm','B',1,'N'),('D0907','Ø3 cm*4.5 cm','B',1,'N'),('D0908','Ø3 cm*5 mm','B',1,'N'),('D0909','Ø3 cm','B',1,'N'),('D0910','Ø3 mm','B',1,'N'),('D0911','Ø3 mm*10 mm','B',1,'N'),('D0912','Ø3 mm*3 mm','B',1,'N'),('D0913','Ø3 mm*4 mm','B',1,'N'),('D0914','Ø3 mm*6 mm','B',1,'N'),('D0915','Ø3 mm*8 mm','B',1,'N'),('D0916','Ø3,1/8\"','B',1,'N'),('D0917','Ø3,5/8\"','B',1,'N'),('D0918','Ø3.1/8\"','B',1,'N'),('D0919','Ø3.1/8\"/1.1/8\"','B',1,'N'),('D0920','Ø3.16m','B',1,'N'),('D0921','Ø3.2m','B',1,'N'),('D0922','Ø3.5 cm','B',1,'N'),('D0923','Ø3.5 cm','B',1,'N'),('D0924','Ø3\"/0.5\"','B',1,'N'),('D0925','Ø3\"/0.75\"','B',1,'N'),('D0926','Ø3\"/1.25\"','B',1,'N'),('D0927','Ø3\"/1.5\"','B',1,'N'),('D0928','Ø3\"/1\"','B',1,'N'),('D0929','Ø3\"/110 mm','B',1,'N'),('D0930','Ø3\"/2.5\"','B',1,'N'),('D0931','Ø3\"/2\"','B',1,'N'),('D0932','Ø3\"/90 mm','B',1,'N'),('D0933','Ø3\"','B',1,'N'),('D0934','Ø3\"/1.25\"','B',1,'N'),('D0935','Ø3\"/1.5\"','B',1,'N'),('D0936','Ø3\"/1\"','B',1,'N'),('D0937','Ø3\"/2.5\"','B',1,'N'),('D0938','Ø3\"/2\"','B',1,'N'),('D0939','Ø3*0.6 mm','B',1,'N'),('D0940','Ø3*1 mm','B',1,'N'),('D0941','Ø3*1.5 mm','B',1,'N'),('D0942','Ø3*10 mm','B',1,'N'),('D0943','Ø3*120 mm','B',1,'N'),('D0944','Ø3*120+ 70 mm','B',1,'N'),('D0945','Ø3*150 mm','B',1,'N'),('D0946','Ø3*16 mm','B',1,'N'),('D0947','Ø3*185 mm','B',1,'N'),('D0948','Ø3*185+ 95 mm','B',1,'N'),('D0949','Ø3*2 mm','B',1,'N'),('D0950','Ø3*2.5 mm','B',1,'N'),('D0951','Ø3*240 mm','B',1,'N'),('D0952','Ø3*240+ 120 mm','B',1,'N'),('D0953','Ø3*3 mm','B',1,'N'),('D0954','Ø3*300 mm','B',1,'N'),('D0955','Ø3*300+ 150 mm','B',1,'N'),('D0956','Ø3*4 mm','B',1,'N'),('D0957','Ø3*50 mm','B',1,'N'),('D0958','Ø3*50+ 25 mm','B',1,'N'),('D0959','Ø3*70 mm','B',1,'N'),('D0960','Ø3*70+ 35 mm','B',1,'N'),('D0961','Ø3*95 mm','B',1,'N'),('D0962','Ø3*95+ 50 mm','B',1,'N'),('D0963','Ø3/16\"','B',1,'N'),('D0964','Ø3/4\"*11.43 cm','B',1,'N'),('D0965','Ø3/4\"*12.5 cm','B',1,'N'),('D0966','Ø3/4\"*12.7 cm','B',1,'N'),('D0967','Ø3/4\"*18 cm','B',1,'N'),('D0968','Ø3/4\"*20 cm','B',1,'N'),('D0969','Ø3/4\"','B',1,'N'),('D0970','Ø3/4\" / 1/2\"','B',1,'N'),('D0971','Ø3/4\" / 5/8\"','B',1,'N'),('D0972','Ø3/4\"/1/2\"','B',1,'N'),('D0973','Ø3/4\"/3/8\"','B',1,'N'),('D0974','Ø3/4\"/5/8\"','B',1,'N'),('D0975','Ø3/8\"','B',1,'N'),('D0976','Ø3/8\" / 1/4\"','B',1,'N'),('D0977','Ø30 cm','B',1,'N'),('D0978','Ø30 cm*1.25 mm','B',1,'N'),('D0979','Ø30 cm*10 cm*1 mm','B',1,'N'),('D0980','Ø30 cm*10 cm*1.5 mm','B',1,'N'),('D0981','Ø30 cm*10 cm*5 mm','B',1,'N'),('D0982','Ø30 cm*10 cm','B',1,'N'),('D0983','Ø30 cm*14 cm*5 mm','B',1,'N'),('D0984','Ø30 cm*20 cm*10 mm','B',1,'N'),('D0985','Ø30 cm*20 cm*16 mm','B',1,'N'),('D0986','Ø30 cm*25 cm*10 mm','B',1,'N'),('D0987','Ø30 cm*25 cm*14 mm','B',1,'N'),('D0988','Ø30 cm*25 cm*6 mm','B',1,'N'),('D0989','Ø30 cm*30 cm*10 mm','B',1,'N'),('D0990','Ø30 cm*30 cm*12 mm','B',1,'N'),('D0991','Ø30 cm*30 cm*15 mm','B',1,'N'),('D0992','Ø30 cm*30 cm*5 mm','B',1,'N'),('D0993','Ø30 cm*30 cm*6 mm','B',1,'N'),('D0994','Ø30 cm*5 cm*1.5 mm','B',1,'N'),('D0995','Ø30 cm*5 cm*2 mm','B',1,'N'),('D0996','Ø30 cm*5 cm','B',1,'N'),('D0997','Ø30 cm/10 cm*5 cm*1.5 mm','B',1,'N'),('D0998','Ø30 cm/15 cm*10 cm*1.5 mm','B',1,'N'),('D0999','Ø30 cm/15 cm*5 cm*1.5 mm','B',1,'N'),('d10','48Kg/m3','L',1,'N'),('D1000','Ø30 cm/20 cm*10 cm*1.5 mm','B',1,'N'),('D1001','Ø30 cm/20 cm*5 cm*1.5 mm','B',1,'N'),('D1002','Ø30 cm','B',1,'N'),('D1003','Ø30 mm','B',1,'N'),('D1004','Ø30 mm/32 mm','B',1,'N'),('D1005','Ø30*0.6 mm','B',1,'N'),('D1006','Ø30/45/45/5 cm','B',1,'N'),('D1007','Ø30/65/35/5 cm','B',1,'N'),('D1008','Ø300 mm','B',1,'N'),('D1009','Ø300 mm*10 mm','B',1,'N'),('D1010','Ø300 mm*12 mm','B',1,'N'),('D1011','Ø300 mm*14 mm','B',1,'N'),('D1012','Ø300 mm*16 mm','B',1,'N'),('D1013','Ø300 mm*20 mm','B',1,'N'),('D1014','Ø300 mm*22 mm','B',1,'N'),('D1015','Ø300 mm*24 mm','B',1,'N'),('D1016','Ø300 mm*6 mm','B',1,'N'),('D1017','Ø300 mm*8 mm','B',1,'N'),('D1018','Ø30m','B',1,'N'),('D1019','Ø315 mm','B',1,'N'),('D1020','Ø315 mm/110 mm','B',1,'N'),('D1021','Ø315 mm/125 mm','B',1,'N'),('D1022','Ø315 mm/140 mm','B',1,'N'),('D1023','Ø315 mm/16 mm','B',1,'N'),('D1024','Ø315 mm/160 mm','B',1,'N'),('D1025','Ø315 mm/180 mm','B',1,'N'),('D1026','Ø315 mm/20 mm','B',1,'N'),('D1027','Ø315 mm/200 mm','B',1,'N'),('D1028','Ø315 mm/225 mm','B',1,'N'),('D1029','Ø315 mm/25 mm','B',1,'N'),('D1030','Ø315 mm/250 mm','B',1,'N'),('D1031','Ø315 mm/32 mm','B',1,'N'),('D1032','Ø315 mm/40 mm','B',1,'N'),('D1033','Ø315 mm/50 mm','B',1,'N'),('D1034','Ø315 mm/63 mm','B',1,'N'),('D1035','Ø315 mm/75 mm','B',1,'N'),('D1036','Ø315 mm/90 mm','B',1,'N'),('D1037','Ø32 cm*10 cm*7 mm','B',1,'N'),('D1038','Ø32 cm*20 cm*6 mm','B',1,'N'),('D1039','Ø32 cm','B',1,'N'),('D1041','Ø32 mm','B',1,'N'),('D1042','Ø32 mm/0.5\"','B',1,'N'),('D1043','Ø32 mm/0.75\"','B',1,'N'),('D1044','Ø32 mm/16 mm','B',1,'N'),('D1045','Ø32 mm/20 mm','B',1,'N'),('D1046','Ø32 mm/25 mm','B',1,'N'),('D1047','Ø33 cm','B',1,'N'),('D1048','Ø33 mm','B',1,'N'),('D1049','Ø34 cm','B',1,'N'),('D1050','Ø34 mm','B',1,'N'),('D1051','Ø35 cm*1.25 mm','B',1,'N'),('D1052','Ø35 cm*10 cm*1.5 mm','B',1,'N'),('D1053','Ø35 cm*10 cm','B',1,'N'),('D1054','Ø35 cm*15 cm*1.5 mm','B',1,'N'),('D1055','Ø35 cm*15 cm*10 mm','B',1,'N'),('D1056','Ø35 cm*20 cm*6 mm','B',1,'N'),('D1057','Ø35 cm*25 cm*6 mm','B',1,'N'),('D1058','Ø35 cm*35 cm*10 mm','B',1,'N'),('D1059','Ø35 cm*35 cm*6 mm','B',1,'N'),('D1060','Ø35 cm*35 cm*8 mm','B',1,'N'),('D1061','Ø35 cm*5 cm*1.5 mm','B',1,'N'),('D1062','Ø35 cm*5 cm','B',1,'N'),('D1063','Ø35 cm/15 cm*5 cm*1.5 mm','B',1,'N'),('D1064','Ø35 cm/30 cm*5 cm*1.5 mm','B',1,'N'),('D1065','Ø35 cm','B',1,'N'),('D1066','Ø35 mm','B',1,'N'),('D1067','Ø35 mm*10 mm','B',1,'N'),('D1068','Ø35 mm*12 mm','B',1,'N'),('D1069','Ø35 mm*14 mm','B',1,'N'),('D1070','Ø35 mm*16 mm','B',1,'N'),('D1071','Ø35 mm*20 mm','B',1,'N'),('D1072','Ø35 mm*6 mm','B',1,'N'),('D1073','Ø35 mm*8 mm','B',1,'N'),('D1074','Ø355 mm/315 mm','B',1,'N'),('D1075','Ø355 mm','B',1,'N'),('D1076','Ø355 mm/110 mm','B',1,'N'),('D1077','Ø355 mm/125 mm','B',1,'N'),('D1078','Ø355 mm/140 mm','B',1,'N'),('D1079','Ø355 mm/16 mm','B',1,'N'),('D1080','Ø355 mm/160 mm','B',1,'N'),('D1081','Ø355 mm/180 mm','B',1,'N'),('D1082','Ø355 mm/20 mm','B',1,'N'),('D1083','Ø355 mm/200 mm','B',1,'N'),('D1084','Ø355 mm/225 mm','B',1,'N'),('D1085','Ø355 mm/25 mm','B',1,'N'),('D1086','Ø355 mm/250 mm','B',1,'N'),('D1087','Ø355 mm/280 mm','B',1,'N'),('D1088','Ø355 mm/315 mm','B',1,'N'),('D1089','Ø355 mm/32 mm','B',1,'N'),('D1090','Ø355 mm/40 mm','B',1,'N'),('D1091','Ø355 mm/50 mm','B',1,'N'),('D1092','Ø355 mm/63 mm','B',1,'N'),('D1093','Ø355 mm/75 mm','B',1,'N'),('D1094','Ø355 mm/90 mm','B',1,'N'),('D1095','Ø36 cm','B',1,'N'),('D1096','Ø36 cm*46 cm','B',1,'N'),('D1097','Ø36 mm','B',1,'N'),('D1098','Ø36 mm/41 mm','B',1,'N'),('D1099','Ø36\"','B',1,'N'),('d11','32Kg/m3','L',1,'N'),('D1100','Ø37 cm','B',1,'N'),('D1101','Ø38 cm*10 cm*7 mm','B',1,'N'),('D1102','Ø38 cm*18 cm*7 mm','B',1,'N'),('D1103','Ø38 cm','B',1,'N'),('D1104','Ø38 mm','B',1,'N'),('D1105','Ø3m*1.5m*3 mm','B',1,'N'),('D1106','Ø3m*1.5m*4 mm','B',1,'N'),('D1107','Ø3m*1m*4 mm','B',1,'N'),('D1108','Ø3m','B',1,'N'),('D1109','Ø4 cm','B',1,'N'),('D1110','Ø4 cm*2 cm*2 mm','B',1,'N'),('D1112','Ø4 cm*4 cm*2 mm','B',1,'N'),('D1113','Ø4 cm*4 cm*2.3 mm','B',1,'N'),('D1114','Ø4 cm*4 cm*3 mm','B',1,'N'),('D1115','Ø4 cm*4 cm*3.9 mm','B',1,'N'),('D1116','Ø4 cm*6 cm','B',1,'N'),('D1117','Ø4 cm','B',1,'N'),('D1118','Ø4 mm','B',1,'N'),('D1119','Ø4 mm*10 mm','B',1,'N'),('D1120','Ø4 mm*4 mm','B',1,'N'),('D1121','Ø4 mm*6 mm','B',1,'N'),('D1122','Ø4 mm*8 mm','B',1,'N'),('D1123','Ø4,1/8\"','B',1,'N'),('D1124','Ø4.1m','B',1,'N'),('D1125','Ø4.2m','B',1,'N'),('D1126','Ø4.4m','B',1,'N'),('D1127','Ø4.5 cm','B',1,'N'),('D1128','Ø4.5 cm','B',1,'N'),('D1129','Ø4\"/0.5\"','B',1,'N'),('D1130','Ø4\"/0.75\"','B',1,'N'),('D1131','Ø4\"/1.25\"','B',1,'N'),('D1132','Ø4\"/1.5\"','B',1,'N'),('D1133','Ø4\"/1\"','B',1,'N'),('D1134','Ø4\"/110 mm','B',1,'N'),('D1135','Ø4\"/2.5\"','B',1,'N'),('D1136','Ø4\"/2\"','B',1,'N'),('D1137','Ø4\"/3\"','B',1,'N'),('D1138','Ø4\"','B',1,'N'),('D1139','Ø4\"/1.25\"','B',1,'N'),('D1140','Ø4\"/1.5\"','B',1,'N'),('D1141','Ø4\"/1\"','B',1,'N'),('D1142','Ø4\"/2.5\"','B',1,'N'),('D1143','Ø4\"/2\"','B',1,'N'),('D1144','Ø4\"/3\"','B',1,'N'),('D1145','Ø4*0.6 mm','B',1,'N'),('D1146','Ø4*1 mm','B',1,'N'),('D1147','Ø4*1.5 mm','B',1,'N'),('D1148','Ø4*10 mm','B',1,'N'),('D1149','Ø4*16 mm','B',1,'N'),('D1150','Ø4*2 mm','B',1,'N'),('D1151','Ø4*2.5 mm','B',1,'N'),('D1152','Ø4*25 mm','B',1,'N'),('D1153','Ø4*3 mm','B',1,'N'),('D1154','Ø4*35 mm','B',1,'N'),('D1155','Ø4*4 mm','B',1,'N'),('D1156','Ø4*6 mm','B',1,'N'),('D1157','Ø4/1\"','B',1,'N'),('D1158','Ø4/3\"','B',1,'N'),('D1159','Ø40 cm*1.25 mm','B',1,'N'),('D1160','Ø40 cm*10 cm*1.5 mm','B',1,'N'),('D1161','Ø40 cm*10 cm','B',1,'N'),('D1162','Ø40 cm*20 cm*6 mm','B',1,'N'),('D1163','Ø40 cm*40 cm*10 mm','B',1,'N'),('D1164','Ø40 cm*5 cm*1.5 mm','B',1,'N'),('D1165','Ø40 cm*5 cm*2 mm','B',1,'N'),('D1166','Ø40 cm*5 cm','B',1,'N'),('D1167','Ø40 cm*50 cm','B',1,'N'),('D1168','Ø40 cm/10 cm*5 cm*1.5 mm','B',1,'N'),('D1169','Ø40 cm/25 cm*5 cm*1.5 mm','B',1,'N'),('D1170','Ø40 cm/30 cm*10 cm*1.5 mm','B',1,'N'),('D1171','Ø40 cm/30 cm*5 cm*1.5 mm','B',1,'N'),('D1172','Ø40 cm','B',1,'N'),('D1174','Ø40 mm','B',1,'N'),('D1175','Ø40 mm','B',1,'N'),('D1176','Ø40 mm/0.5\"','B',1,'N'),('D1177','Ø40 mm/0.75\"','B',1,'N'),('D1178','Ø40 mm/16 mm','B',1,'N'),('D1179','Ø40 mm/20 mm','B',1,'N'),('D1180','Ø40 mm/25 mm','B',1,'N'),('D1181','Ø40 mm/32 mm','B',1,'N'),('D1182','Ø40*0.6 mm','B',1,'N'),('D1183','Ø400 mm/355 mm','B',1,'N'),('D1184','Ø400 mm','B',1,'N'),('D1185','Ø400 mm/110 mm','B',1,'N'),('D1186','Ø400 mm/125 mm','B',1,'N'),('D1187','Ø400 mm/140 mm','B',1,'N'),('D1188','Ø400 mm/16 mm','B',1,'N'),('D1189','Ø400 mm/160 mm','B',1,'N'),('D1190','Ø400 mm/180 mm','B',1,'N'),('D1191','Ø400 mm/20 mm','B',1,'N'),('D1192','Ø400 mm/200 mm','B',1,'N'),('D1193','Ø400 mm/225 mm','B',1,'N'),('D1194','Ø400 mm/25 mm','B',1,'N'),('D1195','Ø400 mm/250 mm','B',1,'N'),('D1196','Ø400 mm/280 mm','B',1,'N'),('D1197','Ø400 mm/315 mm','B',1,'N'),('D1198','Ø400 mm/32 mm','B',1,'N'),('D1199','Ø400 mm/355 mm','B',1,'N'),('d12','200Kg/m3','L',1,'N'),('D1200','Ø400 mm/40 mm','B',1,'N'),('D1201','Ø400 mm/50 mm','B',1,'N'),('D1202','Ø400 mm/63 mm','B',1,'N'),('D1203','Ø400 mm/75 mm','B',1,'N'),('D1204','Ø400 mm/90 mm','B',1,'N'),('D1205','Ø40m','B',1,'N'),('D1206','Ø41 cm*41 cm*10 mm','B',1,'N'),('D1207','Ø41 mm','B',1,'N'),('D1208','Ø42 mm','B',1,'N'),('D1209','Ø43 mm','B',1,'N'),('D1210','Ø45 cm*1.25 mm','B',1,'N'),('D1211','Ø45 cm*10 cm*1.5 mm','B',1,'N'),('D1212','Ø45 cm*10 cm','B',1,'N'),('D1213','Ø45 cm*15 cm*1.5 mm','B',1,'N'),('D1214','Ø45 cm*15 cm*10 mm','B',1,'N'),('D1215','Ø45 cm*25 cm*10 mm','B',1,'N'),('D1216','Ø45 cm*5 cm*1.5 mm','B',1,'N'),('D1217','Ø45 cm*5 cm','B',1,'N'),('D1218','Ø45 cm/40 cm*5 cm*1.5 mm','B',1,'N'),('D1219','Ø45 cm','B',1,'N'),('D1220','Ø45 mm','B',1,'N'),('D1221','Ø45/5/35/5 cm','B',1,'N'),('D1222','Ø450 mm','B',1,'N'),('D1223','Ø450 mm/110 mm','B',1,'N'),('D1224','Ø450 mm/125 mm','B',1,'N'),('D1225','Ø450 mm/140 mm','B',1,'N'),('D1226','Ø450 mm/16 mm','B',1,'N'),('D1227','Ø450 mm/160 mm','B',1,'N'),('D1228','Ø450 mm/180 mm','B',1,'N'),('D1229','Ø450 mm/20 mm','B',1,'N'),('D1230','Ø450 mm/200 mm','B',1,'N'),('D1231','Ø450 mm/225 mm','B',1,'N'),('D1232','Ø450 mm/25 mm','B',1,'N'),('D1233','Ø450 mm/250 mm','B',1,'N'),('D1234','Ø450 mm/280 mm','B',1,'N'),('D1235','Ø450 mm/315 mm','B',1,'N'),('D1236','Ø450 mm/32 mm','B',1,'N'),('D1237','Ø450 mm/355 mm','B',1,'N'),('D1238','Ø450 mm/40 mm','B',1,'N'),('D1239','Ø450 mm/400 mm','B',1,'N'),('D1240','Ø450 mm/450 mm','B',1,'N'),('D1241','Ø450 mm/50 mm','B',1,'N'),('D1242','Ø450 mm/500 mm','B',1,'N'),('D1243','Ø450 mm/63 mm','B',1,'N'),('D1244','Ø450 mm/75 mm','B',1,'N'),('D1245','Ø450 mm/90 mm','B',1,'N'),('D1246','Ø46 mm','B',1,'N'),('D1247','Ø48 mm','B',1,'N'),('D1248','Ø48\"','B',1,'N'),('D1249','Ø5 cm','B',1,'N'),('D1250','Ø5 cm*1 cm','B',1,'N'),('D1251','Ø5 cm*1.25 mm','B',1,'N'),('D1252','Ø5 cm*10 cm','B',1,'N'),('D1253','Ø5 cm*2.5 cm','B',1,'N'),('D1254','Ø5 cm*5 cm*1 mm','B',1,'N'),('D1255','Ø5 cm*5 cm*1.5 mm','B',1,'N'),('D1256','Ø5 cm*5 cm*3 mm','B',1,'N'),('D1257','Ø5 cm*5 cm*3.5 mm','B',1,'N'),('D1258','Ø5 cm*5 cm','B',1,'N'),('D1259','Ø5 cm*5 mm','B',1,'N'),('D1260','Ø5 cm*8 cm','B',1,'N'),('D1261','Ø5 cm','B',1,'N'),('D1262','Ø5 mm','B',1,'N'),('D1263','Ø5.10m','B',1,'N'),('D1264','Ø5.5 cm','B',1,'N'),('D1265','Ø5\"/0.5\"','B',1,'N'),('D1266','Ø5\"/0.75\"','B',1,'N'),('D1267','Ø5\"/1.25\"','B',1,'N'),('D1268','Ø5\"/1.5\"','B',1,'N'),('D1269','Ø5\"/1\"','B',1,'N'),('D1270','Ø5\"/2.5\"','B',1,'N'),('D1271','Ø5\"/2\"','B',1,'N'),('D1272','Ø5\"/3\"','B',1,'N'),('D1273','Ø5\"/4\"','B',1,'N'),('D1274','Ø5\"','B',1,'N'),('D1275','Ø5*0.6 mm','B',1,'N'),('D1276','Ø5*1 mm','B',1,'N'),('D1277','Ø5*1.5 mm','B',1,'N'),('D1278','Ø5/10/5/5 cm','B',1,'N'),('D1279','Ø5/16\"','B',1,'N'),('D1280','Ø5/20/15/5 cm','B',1,'N'),('D1281','Ø5/30/30/5 cm','B',1,'N'),('D1282','Ø5/35/35/5 cm','B',1,'N'),('D1283','Ø5/40/40/5 cm','B',1,'N'),('D1284','Ø5/5/10/5 cm','B',1,'N'),('D1285','Ø5/5/5/5 cm','B',1,'N'),('D1286','Ø5/50/50/5 cm','B',1,'N'),('D1287','Ø5/8\"*11.5 cm','B',1,'N'),('D1288','Ø5/8\"*14 cm','B',1,'N'),('D1289','Ø5/8\"*4m','B',1,'N'),('D1290','Ø5/8\"*8 cm','B',1,'N'),('D1291','Ø5/8\"*8.5 cm','B',1,'N'),('D1292','Ø5/8\"*9 cm','B',1,'N'),('D1293','Ø5/8\"*9.5 cm','B',1,'N'),('D1294','Ø5/8\"','B',1,'N'),('D1295','Ø5/8\" / 1/2\"','B',1,'N'),('D1296','Ø5/8\" / 1/4\"','B',1,'N'),('D1297','Ø5/8\" /3/8\"','B',1,'N'),('D1298','Ø5/8\"/1/2\"','B',1,'N'),('D1299','Ø5/8\"/3/8\"','B',1,'N'),('D1300','Ø50 cm*1.25 mm','B',1,'N'),('D1301','Ø50 cm*1.5 mm','B',1,'N'),('D1302','Ø50 cm*10 cm*0.8 mm','B',1,'N'),('D1303','Ø50 cm*10 cm*2 mm','B',1,'N'),('D1304','Ø50 cm*10 cm','B',1,'N'),('D1305','Ø50 cm*12 cm*1.5 mm','B',1,'N'),('D1306','Ø50 cm*15 cm*0.8 mm','B',1,'N'),('D1307','Ø50 cm*20 cm*18 mm','B',1,'N'),('D1308','Ø50 cm*5 cm*2 mm','B',1,'N'),('D1309','Ø50 cm*5 cm','B',1,'N'),('D1310','Ø50 cm*50 cm*8 mm','B',1,'N'),('D1311','Ø50 cm*75 cm','B',1,'N'),('D1312','Ø50 cm/30 cm*10 cm*1.5 mm','B',1,'N'),('D1313','Ø50 cm/30 cm*5 cm*1.5 mm','B',1,'N'),('D1314','Ø50 cm/40 cm*10 cm*1.5 mm','B',1,'N'),('D1315','Ø50 cm/40 cm*5 cm*2 mm','B',1,'N'),('D1316','Ø50 cm/45 cm*5 cm*1.5 mm','B',1,'N'),('D1317','Ø50 cm','B',1,'N'),('D1318','Ø50 mm/25 mm','B',1,'N'),('D1319','Ø50 mm','B',1,'N'),('D1320','Ø50 mm','B',1,'N'),('D1321','Ø50 mm*10 mm','B',1,'N'),('D1322','Ø50 mm*12 mm','B',1,'N'),('D1323','Ø50 mm*14 mm','B',1,'N'),('D1324','Ø50 mm*16 mm','B',1,'N'),('D1325','Ø50 mm*20 mm','B',1,'N'),('D1326','Ø50 mm*6 mm','B',1,'N'),('D1327','Ø50 mm*8 mm','B',1,'N'),('D1328','Ø50 mm/0.5\"','B',1,'N'),('D1329','Ø50 mm/0.75\"','B',1,'N'),('D1330','Ø50 mm/16 mm','B',1,'N'),('D1331','Ø50 mm/20 mm','B',1,'N'),('D1332','Ø50 mm/25 mm','B',1,'N'),('D1333','Ø50 mm/32 mm','B',1,'N'),('D1334','Ø50 mm/40 mm','B',1,'N'),('D1335','Ø50 mm/55 mm','B',1,'N'),('D1336','Ø50*0.6 mm','B',1,'N'),('D1337','Ø50/10/35/5 cm','B',1,'N'),('D1338','Ø50/10/40/5 cm','B',1,'N'),('D1339','Ø50/50/5/5 cm','B',1,'N'),('D1340','Ø50/50/50/5 cm','B',1,'N'),('D1341','Ø500 mm','B',1,'N'),('D1342','Ø500 mm/110 mm','B',1,'N'),('D1343','Ø500 mm/125 mm','B',1,'N'),('D1344','Ø500 mm/140 mm','B',1,'N'),('D1345','Ø500 mm/16 mm','B',1,'N'),('D1346','Ø500 mm/160 mm','B',1,'N'),('D1347','Ø500 mm/180 mm','B',1,'N'),('D1348','Ø500 mm/20 mm','B',1,'N'),('D1349','Ø500 mm/200 mm','B',1,'N'),('D1350','Ø500 mm/225 mm','B',1,'N'),('D1351','Ø500 mm/25 mm','B',1,'N'),('D1352','Ø500 mm/250 mm','B',1,'N'),('D1353','Ø500 mm/280 mm','B',1,'N'),('D1354','Ø500 mm/315 mm','B',1,'N'),('D1355','Ø500 mm/32 mm','B',1,'N'),('D1356','Ø500 mm/355 mm','B',1,'N'),('D1357','Ø500 mm/40 mm','B',1,'N'),('D1358','Ø500 mm/400 mm','B',1,'N'),('D1359','Ø500 mm/450 mm','B',1,'N'),('D1360','Ø500 mm/50 mm','B',1,'N'),('D1361','Ø500 mm/500 mm','B',1,'N'),('D1362','Ø500 mm/63 mm','B',1,'N'),('D1363','Ø500 mm/75 mm','B',1,'N'),('D1364','Ø500 mm/90 mm','B',1,'N'),('D1365','Ø50m','B',1,'N'),('D1366','Ø51 mm','B',1,'N'),('D1367','Ø52 mm','B',1,'N'),('D1368','Ø54 cm','B',1,'N'),('D1369','Ø54 mm','B',1,'N'),('D1370','Ø54.6 cm*54.6 cm*10 mm','B',1,'N'),('D1371','Ø55 cm*1.25 mm','B',1,'N'),('D1372','Ø55 cm*10 cm','B',1,'N'),('D1373','Ø55 cm*5 cm*2 mm','B',1,'N'),('D1374','Ø55 cm*5 cm','B',1,'N'),('D1375','Ø55 cm','B',1,'N'),('D1376','Ø560 mm','B',1,'N'),('D1377','Ø560 mm/110 mm','B',1,'N'),('D1378','Ø560 mm/125 mm','B',1,'N'),('D1379','Ø560 mm/140 mm','B',1,'N'),('D1380','Ø560 mm/16 mm','B',1,'N'),('D1381','Ø560 mm/160 mm','B',1,'N'),('D1382','Ø560 mm/180 mm','B',1,'N'),('D1383','Ø560 mm/20 mm','B',1,'N'),('D1384','Ø560 mm/200 mm','B',1,'N'),('D1385','Ø560 mm/225 mm','B',1,'N'),('D1386','Ø560 mm/25 mm','B',1,'N'),('D1387','Ø560 mm/250 mm','B',1,'N'),('D1388','Ø560 mm/280 mm','B',1,'N'),('D1389','Ø560 mm/315 mm','B',1,'N'),('D1390','Ø560 mm/32 mm','B',1,'N'),('D1391','Ø560 mm/355 mm','B',1,'N'),('D1392','Ø560 mm/40 mm','B',1,'N'),('D1393','Ø560 mm/400 mm','B',1,'N'),('D1394','Ø560 mm/450 mm','B',1,'N'),('D1395','Ø560 mm/50 mm','B',1,'N'),('D1396','Ø560 mm/500 mm','B',1,'N'),('D1397','Ø560 mm/63 mm','B',1,'N'),('D1398','Ø560 mm/75 mm','B',1,'N'),('D1399','Ø560 mm/90 mm','B',1,'N'),('D1400','Ø57 mm','B',1,'N'),('D1401','Ø5m*30 cm*10 mm','B',1,'N'),('D1402','Ø5m','B',1,'N'),('D1403','Ø6 cm','B',1,'N'),('D1404','Ø6 mm','B',1,'N'),('D1406','Ø6 cm*1 cm','B',1,'N'),('D1407','Ø6 cm*10 cm','B',1,'N'),('D1408','Ø6 cm*11 cm','B',1,'N'),('D1411','Ø6 cm*4 cm*3 mm','B',1,'N'),('D1413','Ø6 cm*6 mm','B',1,'N'),('D1414','Ø6 cm*9 cm','B',1,'N'),('D1415','Ø6 cm*9.5 cm','B',1,'N'),('D1416','Ø6 cm','B',1,'N'),('D1417','Ø6 mm*10 cm','B',1,'N'),('D1418','Ø6 mm*12 cm','B',1,'N'),('D1419','Ø6 mm*14 cm','B',1,'N'),('D1420','Ø6 mm*15 cm','B',1,'N'),('D1421','Ø6 mm*16 cm','B',1,'N'),('D1422','Ø6 mm*18 cm','B',1,'N'),('D1423','Ø6 mm*2 cm','B',1,'N'),('D1424','Ø6 mm*2.5 cm','B',1,'N'),('D1425','Ø6 mm*20 cm','B',1,'N'),('D1427','Ø6 mm*3 cm','B',1,'N'),('D1429','Ø6 mm*4 cm','B',1,'N'),('D1431','Ø6 mm*5 cm','B',1,'N'),('D1433','Ø6 mm*6 cm','B',1,'N'),('D1435','Ø6 mm*8 cm','B',1,'N'),('D1436','Ø6 mm','B',1,'N'),('D1437','Ø6 mm*10 mm','B',1,'N'),('D1438','Ø6 mm*12 mm','B',1,'N'),('D1439','Ø6 mm*14 mm','B',1,'N'),('D1440','Ø6 mm*16 mm','B',1,'N'),('D1441','Ø6 mm*4 mm','B',1,'N'),('D1442','Ø6 mm*6 mm','B',1,'N'),('D1443','Ø6 mm*8 mm','B',1,'N'),('D1444','Ø6 mm/7 mm','B',1,'N'),('D1445','Ø6 mm/8 mm','B',1,'N'),('D1446','Ø6.4 cm','B',1,'N'),('D1447','Ø6.5 cm','B',1,'N'),('D1448','Ø6.6 cm','B',1,'N'),('D1449','Ø6\"/0.5\"','B',1,'N'),('D1450','Ø6\"/0.75\"','B',1,'N'),('D1451','Ø6\"/1.25\"','B',1,'N'),('D1452','Ø6\"/1.5\"','B',1,'N'),('D1453','Ø6\"/1\"','B',1,'N'),('D1454','Ø6\"/2.5\"','B',1,'N'),('D1455','Ø6\"/2\"','B',1,'N'),('D1456','Ø6\"/3\"','B',1,'N'),('D1457','Ø6\"/4\"','B',1,'N'),('D1458','Ø6\"/5\"','B',1,'N'),('D1459','Ø6\"','B',1,'N'),('D1460','Ø6\"/1.25\"','B',1,'N'),('D1461','Ø6\"/1.5\"','B',1,'N'),('D1462','Ø6\"/1\"','B',1,'N'),('D1463','Ø6\"/2.5\"','B',1,'N'),('D1464','Ø6\"/2\"','B',1,'N'),('D1465','Ø6\"/3\"','B',1,'N'),('D1466','Ø6\"/4\"','B',1,'N'),('D1467','Ø6*2 mm','B',1,'N'),('D1468','Ø6*3 mm','B',1,'N'),('D1469','Ø6*4 mm','B',1,'N'),('D1470','Ø60 cm*1.25 mm','B',1,'N'),('D1471','Ø60 cm*1.5 mm','B',1,'N'),('D1472','Ø60 cm*10 cm*2 mm','B',1,'N'),('D1473','Ø60 cm*10 cm','B',1,'N'),('D1474','Ø60 cm*12 cm*2 mm','B',1,'N'),('D1475','Ø60 cm*5 cm*1.5 mm','B',1,'N'),('D1476','Ø60 cm*5 cm','B',1,'N'),('D1477','Ø60 cm*60 cm','B',1,'N'),('D1478','Ø60 cm/30 cm*10 cm*1.5 mm','B',1,'N'),('D1479','Ø60 cm/50 cm*10 cm*1.5 mm','B',1,'N'),('D1480','Ø60 cm','B',1,'N'),('D1481','Ø60 mm','B',1,'N'),('D1482','Ø63 mm','B',1,'N'),('D1483','Ø63 mm','B',1,'N'),('D1484','Ø63 mm/0.5\"','B',1,'N'),('D1485','Ø63 mm/0.75\"','B',1,'N'),('D1486','Ø63 mm/16 mm','B',1,'N'),('D1487','Ø63 mm/20 mm','B',1,'N'),('D1488','Ø63 mm/25 mm','B',1,'N'),('D1489','Ø63 mm/32 mm','B',1,'N'),('D1490','Ø63 mm/40 mm','B',1,'N'),('D1491','Ø63 mm/50 mm','B',1,'N'),('D1492','Ø630 mm','B',1,'N'),('D1493','Ø630 mm/110 mm','B',1,'N'),('D1494','Ø630 mm/125 mm','B',1,'N'),('D1495','Ø630 mm/140 mm','B',1,'N'),('D1496','Ø630 mm/16 mm','B',1,'N'),('D1497','Ø630 mm/160 mm','B',1,'N'),('D1498','Ø630 mm/180 mm','B',1,'N'),('D1499','Ø630 mm/20 mm','B',1,'N'),('D1500','Ø630 mm/200 mm','B',1,'N'),('D1501','Ø630 mm/225 mm','B',1,'N'),('D1502','Ø630 mm/25 mm','B',1,'N'),('D1503','Ø630 mm/250 mm','B',1,'N'),('D1504','Ø630 mm/280 mm','B',1,'N'),('D1505','Ø630 mm/315 mm','B',1,'N'),('D1506','Ø630 mm/32 mm','B',1,'N'),('D1507','Ø630 mm/355 mm','B',1,'N'),('D1508','Ø630 mm/40 mm','B',1,'N'),('D1509','Ø630 mm/400 mm','B',1,'N'),('D1510','Ø630 mm/450 mm','B',1,'N'),('D1511','Ø630 mm/50 mm','B',1,'N'),('D1512','Ø630 mm/500 mm','B',1,'N'),('D1513','Ø630 mm/560 mm','B',1,'N'),('D1514','Ø630 mm/63 mm','B',1,'N'),('D1515','Ø630 mm/75 mm','B',1,'N'),('D1516','Ø630 mm/90 mm','B',1,'N'),('D1517','Ø64 cm*30 cm*10 mm','B',1,'N'),('D1518','Ø64 mm','B',1,'N'),('D1519','Ø65 cm*1.25 mm','B',1,'N'),('D1520','Ø65 cm*10 cm*2 mm','B',1,'N'),('D1521','Ø65 cm*5 cm*1.5 mm','B',1,'N'),('D1522','Ø65 cm/20 cm*5 cm*1.5 mm','B',1,'N'),('D1523','Ø65 cm','B',1,'N'),('D1524','Ø65 mm','B',1,'N'),('D1525','Ø65/100/35/5 cm','B',1,'N'),('D1526','Ø65/65/5/5 cm','B',1,'N'),('D1527','Ø67 cm','B',1,'N'),('D1528','Ø67 mm','B',1,'N'),('D1529','Ø6m*1.25m*3 mm','B',1,'N'),('D1530','Ø6m*1.5m*5 mm','B',1,'N'),('D1531','Ø6m','B',1,'N'),('D1532','Ø7 cm','B',1,'N'),('D1534','Ø7 cm*12 cm','B',1,'N'),('D1537','Ø7 cm*7 cm*4 mm','B',1,'N'),('D1538','Ø7 cm','B',1,'N'),('D1539','Ø7 mm','B',1,'N'),('D1540','Ø7.5 cm','B',1,'N'),('D1541','Ø7.5 cm*11.5 cm','B',1,'N'),('D1543','Ø7.5 cm*6.5 cm','B',1,'N'),('D1544','Ø7.5 cm*7.5 cm','B',1,'N'),('D1545','Ø7.5m','B',1,'N'),('D1546','Ø7\"','B',1,'N'),('D1547','Ø7*1 mm','B',1,'N'),('D1548','Ø7*1.5 mm','B',1,'N'),('D1549','Ø7/8\"*12.7 cm','B',1,'N'),('D1550','Ø7/8\"*17.88 cm','B',1,'N'),('D1551','Ø7/8\"','B',1,'N'),('D1552','Ø7/8\"/1/2\"','B',1,'N'),('D1553','Ø7/8\"/3/4\"','B',1,'N'),('D1554','Ø7/8\"/5/8\"','B',1,'N'),('D1555','Ø70 cm*1.25 mm','B',1,'N'),('D1556','Ø70 cm*10 cm*2 mm','B',1,'N'),('D1557','Ø70 cm*12 cm*2 mm','B',1,'N'),('D1558','Ø70 cm*15 cm*1.5 mm','B',1,'N'),('D1559','Ø70 cm*5 cm*2 mm','B',1,'N'),('D1560','Ø70 cm*70 cm*6 mm','B',1,'N'),('D1561','Ø70 cm*70 cm*8 mm','B',1,'N'),('D1562','Ø70 cm/50 cm*5 cm*1.5 mm','B',1,'N'),('D1563','Ø70 cm/60 cm*5 cm*1.5 mm','B',1,'N'),('D1564','Ø70 cm','B',1,'N'),('D1565','Ø70 mm','B',1,'N'),('D1566','Ø70 mm*10 mm','B',1,'N'),('D1567','Ø70 mm*12 mm','B',1,'N'),('D1568','Ø70 mm*14 mm','B',1,'N'),('D1569','Ø70 mm*16 mm','B',1,'N'),('D1570','Ø70 mm*20 mm','B',1,'N'),('D1571','Ø70 mm*6 mm','B',1,'N'),('D1572','Ø70 mm*8 mm','B',1,'N'),('D1573','Ø70/50/5/5 cm','B',1,'N'),('D1574','Ø70/70/40/5 cm','B',1,'N'),('D1575','Ø71.2 cm*71.2 cm*10 mm','B',1,'N'),('D1576','Ø710 mm','B',1,'N'),('D1577','Ø73 mm','B',1,'N'),('D1578','Ø75 cm*5 cm*2 mm','B',1,'N'),('D1579','Ø75 mm','B',1,'N'),('D1580','Ø75 mm/0.5\"','B',1,'N'),('D1581','Ø75 mm/0.75\"','B',1,'N'),('D1582','Ø75 mm/16 mm','B',1,'N'),('D1583','Ø75 mm/20 mm','B',1,'N'),('D1584','Ø75 mm/25 mm','B',1,'N'),('D1585','Ø75 mm/32 mm','B',1,'N'),('D1586','Ø75 mm/40 mm','B',1,'N'),('D1587','Ø75 mm/50 mm','B',1,'N'),('D1588','Ø75 mm/63 mm','B',1,'N'),('D1589','Ø8 cm','B',1,'N'),('D1590','Ø8 mm','B',1,'N'),('D1593','Ø8 cm*4 cm*2 mm','B',1,'N'),('D1594','Ø8 cm*4 cm*4 mm','B',1,'N'),('D1595','Ø8 cm*5 cm*1.5 mm','B',1,'N'),('D1599','Ø8 cm','B',1,'N'),('D1600','Ø8 mm*1.5 cm','B',1,'N'),('D1601','Ø8 mm*10 cm','B',1,'N'),('D1602','Ø8 mm*12 cm','B',1,'N'),('D1603','Ø8 mm*14 cm','B',1,'N'),('D1604','Ø8 mm*2 cm','B',1,'N'),('D1605','Ø8 mm*2.5 cm','B',1,'N'),('D1607','Ø8 mm*3 cm','B',1,'N'),('D1609','Ø8 mm*4 cm','B',1,'N'),('D1611','Ø8 mm*5 cm','B',1,'N'),('D1613','Ø8 mm*6 cm','B',1,'N'),('D1615','Ø8 mm*7 cm','B',1,'N'),('D1616','Ø8 mm*8 cm','B',1,'N'),('D1617','Ø8 mm','B',1,'N'),('D1618','Ø8 mm/9 mm','B',1,'N'),('D1619','Ø8\"/0.5\"','B',1,'N'),('D1620','Ø8\"/0.75\"','B',1,'N'),('D1621','Ø8\"/1.25\"','B',1,'N'),('D1622','Ø8\"/1.5\"','B',1,'N'),('D1623','Ø8\"/1\"','B',1,'N'),('D1624','Ø8\"/2.5\"','B',1,'N'),('D1625','Ø8\"/2\"','B',1,'N'),('D1626','Ø8\"/3\"','B',1,'N'),('D1627','Ø8\"/4\"','B',1,'N'),('D1628','Ø8\"/5\"','B',1,'N'),('D1629','Ø8\"/6\"','B',1,'N'),('D1630','Ø8\"','B',1,'N'),('D1631','Ø8\"/2.5\"','B',1,'N'),('D1632','Ø8\"/3\"','B',1,'N'),('D1633','Ø8\"/6\"','B',1,'N'),('D1634','Ø8/3\"/16 mm','B',1,'N'),('D1635','Ø8/3\"','B',1,'N'),('D1636','Ø8/5\"','B',1,'N'),('D1637','Ø80 cm*1.25 mm','B',1,'N'),('D1638','Ø80 cm*1.5 mm','B',1,'N'),('D1639','Ø80 cm*10 cm*1.5 mm','B',1,'N'),('D1640','Ø80 cm*10 cm','B',1,'N'),('D1641','Ø80 cm*12 cm*2 mm','B',1,'N'),('D1642','Ø80 cm*5 cm*2 mm','B',1,'N'),('D1643','Ø80 cm*5 cm','B',1,'N'),('D1644','Ø80 cm*80 cm','B',1,'N'),('D1645','Ø80 cm/40 cm*10 cm*1.5 mm','B',1,'N'),('D1646','Ø80 cm/50 cm*10 cm*1.5 mm','B',1,'N'),('D1647','Ø80 cm/50 cm*5 cm*2 mm','B',1,'N'),('D1648','Ø80 cm','B',1,'N'),('D1649','Ø80 mm','B',1,'N'),('D1650','Ø800 mm','B',1,'N'),('D1651','Ø80m','B',1,'N'),('D1652','Ø81.2 cm*81.2 cm*10 mm','B',1,'N'),('D1653','Ø83 mm','B',1,'N'),('D1654','Ø85 cm*5 cm*1.5 mm','B',1,'N'),('D1655','Ø88 mm','B',1,'N'),('D1656','Ø8m','B',1,'N'),('D1657','Ø9 cm','B',1,'N'),('D1658','Ø9 cm*3.5 cm*6 mm','B',1,'N'),('D1659','Ø9 cm*9 cm*3 mm','B',1,'N'),('D1660','Ø9 cm','B',1,'N'),('D1661','Ø9 mm','B',1,'N'),('D1662','Ø9.5 cm*14.5 cm','B',1,'N'),('D1663','Ø9\"','B',1,'N'),('D1664','Ø90 cm*1.25 mm','B',1,'N'),('D1665','Ø90 cm*10 cm*1.5 mm','B',1,'N'),('D1666','Ø90 cm*5 cm*2 mm','B',1,'N'),('D1667','Ø90 cm','B',1,'N'),('D1668','Ø90 mm/40 mm','B',1,'N'),('D1669','Ø90 mm','B',1,'N'),('D1670','Ø90 mm/0.5\"','B',1,'N'),('D1671','Ø90 mm/0.75\"','B',1,'N'),('D1672','Ø90 mm/16 mm','B',1,'N'),('D1673','Ø90 mm/20 mm','B',1,'N'),('D1674','Ø90 mm/25 mm','B',1,'N'),('D1675','Ø90 mm/32 mm','B',1,'N'),('D1676','Ø90 mm/40 mm','B',1,'N'),('D1677','Ø90 mm/50 mm','B',1,'N'),('D1678','Ø90 mm/63 mm','B',1,'N'),('D1679','Ø90 mm/75 mm','B',1,'N'),('D1680','Ø900 mm','B',1,'N'),('D1681','Ø92 mm','B',1,'N'),('D1682','Ø95 cm*36 cm*6 mm','B',1,'N'),('D1683','Ø95 mm','B',1,'N'),('D1684','Ø95 mm*10 mm','B',1,'N'),('D1685','Ø95 mm*12 mm','B',1,'N'),('D1686','Ø95 mm*14 mm','B',1,'N'),('D1687','Ø95 mm*16 mm','B',1,'N'),('D1688','Ø95 mm*20 mm','B',1,'N'),('D1689','Ø95 mm*6 mm','B',1,'N'),('D1690','Ø95 mm*8 mm','B',1,'N'),('G001','ASTM - D2466&D3311(Sch40)','C',1,'Y'),('G002','SYSTEM (DWV) نظام 110','C',1,'Y'),('G003','ASTM B280','C',1,'N'),('G004','DIN 8062-8061','C',1,'N'),('G005','ASTM D 1785(SCH40)','C',1,'N'),('G006','ASTM D 2241)','C',1,'N'),('G007','نظام 110','C',1,'N'),('G008','PE100 DIN8074&8075','C',1,'N'),('G009','خفيف','C',1,'N'),('G010','ثقيل','C',1,'N'),('G011','وسط','C',1,'N'),('G012','كابلات الضغط المنخفض','C',1,'N'),('G013','كابلات الضغط المتوسط جهد 12/20','C',1,'N'),('G014','كابلات الضغط المتوسط جهد 18/30','C',1,'N'),('G015','ANSI SLIP ON CLASS150','C',1,'N'),('G016','DIN SLIP ON CLASS150','C',1,'N'),('G017','ANSI WN','C',1,'N'),('G018','DIN WN','C',1,'N'),('G019','ANSI CLASS150','C',1,'N'),('G020','SLIP ON EN1092','C',1,'N'),('G021','1amp.','C',1,'N'),('G022','2amp.','C',1,'N'),('G023','4amp.','C',1,'N'),('G024','6amp.','C',1,'N'),('G025','10amp.','C',1,'N'),('G026','12amp.','C',1,'N'),('G027','14amp.','C',1,'N'),('G028','16amp.','C',1,'N'),('G029','20amp.','C',1,'N'),('G030','24amp.','C',1,'N'),('G031','30amp.','C',1,'N'),('G032','32amp.','C',1,'N'),('G033','25amp.','C',1,'N'),('G034','40amp.','C',1,'N'),('G035','63amp.','C',1,'N'),('G036','80amp.','C',1,'N'),('G037','100amp.','C',1,'N'),('G038','125amp.','C',1,'N'),('G039','160amp.','C',1,'N'),('G040','200amp.','C',1,'N'),('G041','225amp.','C',1,'N'),('G042','250amp.','C',1,'N'),('G043','300amp.','C',1,'N'),('G044','315amp.','C',1,'N'),('G045','350amp.','C',1,'N'),('G046','400amp.','C',1,'N'),('G047','NSX100F3P25A','C',1,'N'),('G048','NSX100F3P40A','C',1,'N'),('G049','NSX100F3P63A','C',1,'N'),('G050','NSX100F3P80A','C',1,'N'),('G051','NSX160F3P160A','C',1,'N'),('G052','NSX250F3P250A','C',1,'N'),('G053','NSX250F40A','C',1,'N'),('G054','NSX630F3P630A','C',1,'N'),('G055','NSX200B3P100A','C',1,'N'),('G056','NSX100BTM100A','C',1,'N'),('G057','EZ250N3P125A','C',1,'N'),('G058','EZ250N3P160A','C',1,'N'),('G059','NS80HM3P80A','C',1,'N'),('G060','NT3N250A','C',1,'N'),('G061','3amp.','C',1,'N'),('G062','45amp.','C',1,'N'),('G063','120amp.','C',1,'N'),('G064','GVAD10001','C',1,'N'),('G065','GVA50','C',1,'N'),('G066','GV2ME40','C',1,'N'),('G067','GV2ME20','C',1,'N'),('G068','GV2ME06','C',1,'N'),('G069','GV2MG08','C',1,'N'),('G070','GV2M5','C',1,'N'),('G071','GV2M16','C',1,'N'),('G072','GV2M14','C',1,'N'),('G073','GV2M11','C',1,'N'),('G074','GV2M10','C',1,'N'),('G075','GV2M07','C',1,'N'),('G076','GV2ME32','C',1,'N'),('G077','GV2ME22','C',1,'N'),('G078','3S-FS-VDD-428100','C',1,'N'),('G079','3S-FS-G00-4266','C',1,'N'),('G080','STPCATE6A','C',1,'N'),('G081','MCC-11','C',1,'N'),('G082','LCP-BE-HCP-001','C',1,'N'),('G083','LCP-ET2-HCP-001','C',1,'N'),('G084','EMCC-1','C',1,'N'),('G085','MCC-3','C',1,'N'),('G086','EMCC-2','C',1,'N'),('G087','LCP-11','C',1,'N'),('G088','LCP-BS-HCP-001','C',1,'N'),('G089','MCC-1','C',1,'N'),('G090','DOX-1024DSR','C',1,'N'),('G091','MMX-2003-12NDS','C',1,'N'),('G092','MR-2602R','C',1,'N'),('G093','MR2900','C',1,'N'),('G094','MRI-M500M','C',1,'N'),('G095','MRI-M500S','C',1,'N'),('G096','UB-1024DS','C',1,'N'),('G097','سوبر','C',1,'N'),('G098','7','C',1,'N'),('G099','10','C',1,'N'),('G100','17','C',1,'N'),('G101','23','C',1,'N'),('G102','2.7كجم','C',1,'N'),('G103','3.8كجم','C',1,'N'),('G104','10كجم','C',1,'N'),('G105','19كجم','C',1,'N'),('G106','50كجم','C',1,'N'),('G107','PILOT QD','C',1,'N'),('G108','بطانة الكيد','C',1,'N'),('G109','131','C',1,'N'),('G110','100S','C',1,'N'),('G111','101','C',1,'N'),('G112','120','C',1,'N'),('G113','129','C',1,'N'),('G114','133','C',1,'N'),('G115','151','C',1,'N'),('G116','165','C',1,'N'),('G117','110','C',1,'N'),('G118','152','C',1,'N'),('G119','برايمكس 131','C',1,'N'),('G120','N11/151','C',1,'N'),('G121','BT 205','C',1,'N'),('G122','CLT 301','C',1,'N'),('G123','22310','C',1,'N'),('G124','C-101','C',1,'N'),('G125','C-102','C',1,'N'),('G126','C-110','C',1,'N'),('G127','C-122','C',1,'N'),('G128','C-18','C',1,'N'),('G129','C-1810','C',1,'N'),('G130','C-2010','C',1,'N'),('G131','C-241','C',1,'N'),('G132','CR-26','C',1,'N'),('G133','MICRO-1','C',1,'N'),('G134','MICRO-2','C',1,'N'),('G135','Protec-10','C',1,'N'),('G136','Trac109','C',1,'N'),('G137','12 فولت','C',1,'N'),('G138','18 فولت','C',1,'N'),('G139','استنباط (بلحة)','C',1,'N'),('G140','ناحيتين','C',1,'N'),('G141','ناحية واحدة','C',1,'N'),('G142','1كجم','C',1,'N'),('G143','1.5كجم','C',1,'N'),('G144','2كجم','C',1,'N'),('G145','3كجم','C',1,'N'),('G146','5كجم','C',1,'N'),('G147','200جم','C',1,'N'),('G148','300جم','C',1,'N'),('G149','500جم','C',1,'N'),('G150','1طن','C',1,'N'),('G151','2طن','C',1,'N'),('G152','3كطن','C',1,'N'),('G153','5طن','C',1,'N'),('G154','3طن','C',1,'N'),('G155','6طن','C',1,'N'),('G156','10طن','C',1,'N'),('G157','15طن','C',1,'N'),('G158','كور','C',1,'N'),('G159','برشام','C',1,'N'),('G160','ترقيم استانلس','C',1,'N'),('G161','تغليف كارنيهات','C',1,'N'),('G162','تغليف ورق A4','C',1,'N'),('G163','باب','C',1,'N'),('G164','جروف','C',1,'N'),('G165','حزام وير','C',1,'N'),('G166','قلاووظ 0.5\"/2\"','C',1,'N'),('G167','قلاووظ 0.5\"/3\"','C',1,'N'),('G168','قلاووظ 4\"','C',1,'N'),('G169','كلبس شنبر','C',1,'N'),('G170','لحام بالديزل','C',1,'N'),('G171','لحام كهرباء 220 فولت','C',1,'N'),('G172','لحام كهرباء380 فولت','C',1,'N'),('G173','لحام كهرباء 220 فولت محمولة','C',1,'N'),('G174','لحام بروبلين','C',1,'N'),('G175','شحن فريون','C',1,'N'),('G176','بيبة','C',1,'N'),('G177','توسيع مواسير نحاس','C',1,'N'),('G178','خراطيم عداد شحن','C',1,'N'),('G179','فلير 4/3\"','C',1,'N'),('G180','فلير 8/7\"','C',1,'N'),('G181','كرابة مواسير نحاس','C',1,'N'),('G182','لقمة رباط مسدسة','C',1,'N'),('G183','مفتاح الانكية','C',1,'N'),('G184','مفتاح الانكية نجمه','C',1,'N'),('G185','مفتاح بلدى','C',1,'N'),('G186','مفتاح بلدى مشرشر','C',1,'N'),('G187','مفكات دق','C',1,'N'),('G188','مفكات','C',1,'N'),('G189','مشط ماكينة قلاووظ 1\":2\"','C',1,'N'),('G190','مشط ماكينة قلاووظ 0.75\":2\"','C',1,'N'),('G191','مشط ماكينة قلاووظ 0.5\":0.75\"','C',1,'N'),('G192','مشط ماكينة قلاووظ 2.5\":3\"','C',1,'N'),('G193','مربيطة لماكينة القلاووظ 2\"/2.5\"','C',1,'N'),('G194','عجل كمبروسور','C',1,'N'),('G195','كابلات مشرشر 760مم','C',1,'N'),('G196','صاج عجوز','C',1,'N'),('G197','صاج عدل','C',1,'N'),('G198','صاج سوستة','C',1,'N'),('G199','حديد مسلح','C',1,'N'),('G200','صاج 1م زهر تركى','C',1,'N'),('G201','استلين','C',1,'N'),('G202','نيتروجين','C',1,'N'),('G203','اكسجين','C',1,'N'),('G204','غاز بوتجاز','C',1,'N'),('G205','عادة','C',1,'N'),('G206','بنسة غراب (جاز)','C',1,'N'),('G207','امبير','C',1,'N'),('G208','ترامل','C',1,'N'),('G209','ترامل نجمه','C',1,'N'),('G210','تيل','C',1,'N'),('G211','كلابة','C',1,'N'),('G212','لحام','C',1,'N'),('G213','ماس ارضى','C',1,'N'),('G214','شداد','C',1,'N'),('G215','زرجينة 2 رجل 4\"','C',1,'N'),('G216','زرجينة 2 رجل 8\"','C',1,'N'),('G217','زرجينة 3 رجل 4\"','C',1,'N'),('G218','زرجينة 3 رجل 6\"','C',1,'N'),('G219','زرجينة 3 رجل 8\"','C',1,'N'),('G220','زرجينة 3 رجل 9\"','C',1,'N'),('G221','زرجينة 3 رجل 10\"','C',1,'N'),('G222','زرجينة 0.75\" ردشة','C',1,'N'),('G223','زرجينة عداد شحن','C',1,'N'),('G224','قطعية','C',1,'N'),('G225','ديسك تقطيع المونيوم','C',1,'N'),('G226','مراسير فلير صغيرة','C',1,'N'),('G227','1.8/1\":2\"يدوى','C',1,'N'),('G228','0.5\":2\"يدوى','C',1,'N'),('G229','صاج','C',1,'N'),('G230','مواسير نحاس','C',1,'N'),('G231','1.8/1\"','C',1,'N'),('G232','1.8/5\"','C',1,'N'),('G233','2.8/5\"','C',1,'N'),('G234','اركيت حدادى','C',1,'N'),('G235','اركيت خشابى','C',1,'N'),('G236','سكينة قطعية مواسير نحاس','C',1,'N'),('G237','قطر معدن','C',1,'N'),('G238','سكينة ماكينة قلاووظ','C',1,'N'),('G239','تعويض 0.75\"','C',1,'N'),('G240','تعوبض 5.5\" حصان','C',1,'N'),('G241','غسيل','C',1,'N'),('G242','زيت','C',1,'N'),('G243','جاز','C',1,'N'),('G244','تعقيم','C',1,'N'),('G245','فاكيوم 4/1 حصان','C',1,'N'),('G246','فاكيوم 2/1 حصان','C',1,'N'),('G247','فاكيوم 1 حصان','C',1,'N'),('G248','كبس يدوى','C',1,'N'),('G249','كبس 3 حصان','C',1,'N'),('G250','مياة 1 حصان','C',1,'N'),('G251','ماكينة دخان','C',1,'N'),('G252','طلمبة كيماوى','C',1,'N'),('G253','سقالة كاوتش','C',1,'N'),('G254','سقالة تيفلون 160مم بفرامل','C',1,'N'),('G255','سقالة تيفلون 160مم بدون فرامل','C',1,'N'),('G256','سقالة SGP بفرامل','C',1,'N'),('G257','براويطة','C',1,'N'),('G258','اركت بالقاعده','C',1,'N'),('G259','شحن فريون R22','C',1,'N'),('G260','شحن فريون R134','C',1,'N'),('G261','شحن فريون R220','C',1,'N'),('G262','شحن فريون R407','C',1,'N'),('G263','شحن فريون R410','C',1,'N'),('G264','هواء','C',1,'N'),('G265','عدم رجوع اسطوانات','C',1,'N'),('G266','تست شحن','C',1,'N'),('G267','بلانكو','C',1,'N'),('G268','تحميل اسطوانات','C',1,'N'),('G269','تحميل صاج','C',1,'N'),('G270','تصنيع حديد','C',1,'N'),('G271','هيدروليك (فورت كلفت)','C',1,'N'),('G272','عدة بلاستيك','C',1,'N'),('G273','عدة جلد','C',1,'N'),('G274','عدة صاج','C',1,'N'),('G275','لاب توب','C',1,'N'),('G276','بيتومين','C',1,'N'),('G277','كباية تركب على صاروخ','C',1,'N'),('G278','يدوى','C',1,'N'),('G279','امان','C',1,'N'),('G280','شداد بالماكينة','C',1,'N'),('G281','كمبيوتر','C',1,'N'),('G282','وير 2 طن','C',1,'N'),('G283','وير 4.75 طن','C',1,'N'),('G284','وير 6.5 طن','C',1,'N'),('G285','وير 12 طن','C',1,'N'),('G286','وير صغير','C',1,'N'),('G287','وير كبير','C',1,'N'),('G288','المونيوم','C',1,'N'),('G289','حدادى','C',1,'N'),('G290','ديل فار','C',1,'N'),('G291','تسخين (كيت)','C',1,'N'),('G292','سيلكون','C',1,'N'),('G293','طلمبة غسيل','C',1,'N'),('G294','كمبروسور هواء','C',1,'N'),('G295','صغير','C',1,'N'),('G296','كبير','C',1,'N'),('G297','210نيوتن','C',1,'N'),('G298','500نيوتن','C',1,'N'),('G299','صليبة','C',1,'N'),('G300','عجوز عادة','C',1,'N'),('G301','عجوز صليبة','C',1,'N'),('G302','روزتة','C',1,'N'),('G303','تست','C',1,'N'),('G304','سنارة','C',1,'N'),('G305','اركت يدوى','C',1,'N'),('G306','اركت كهربائى','C',1,'N'),('G307','خشابى','C',1,'N'),('G308','مولد كهرباء','C',1,'N'),('G309','45ك اتوس','C',1,'N'),('G310','50ك اتوس','C',1,'N'),('G311','60ك اتوس','C',1,'N'),('G312','5ك مارش ملفات نحاس بنزين','C',1,'N'),('G313','10\"طول 5متر حمولة 10 طن','C',1,'N'),('G314','5\"طول 4متر حمولة 5 طن','C',1,'N'),('G315','8\"طول 10متر حمولة 8 طن','C',1,'N'),('G316','طول 2 متر حمولة 2 طن','C',1,'N'),('G317','طول 4 متر حمولة 4 طن','C',1,'N'),('G318','53KHC T12DN-708F','C',1,'N'),('G319','53KHC T18DN-708F','C',1,'N'),('G320','53KHC T24DN-708F','C',1,'N'),('G321','53QHCT12DN-708F','C',1,'N'),('G322','53QHCT18DN-708F','C',1,'N'),('G323','53QHC T24DN-708F','C',1,'N'),('G324','53QHC T30DN-708F','C',1,'N'),('G325','53QHC T36DN-708F','C',1,'N'),('G326','53KHC T12N-708F','C',1,'N'),('G327','53KHC T18N-708F','C',1,'N'),('G328','53KHC T24N-708F','C',1,'N'),('G329','53QHC T12N-708F','C',1,'N'),('G330','53QHC T18N-708F','C',1,'N'),('G331','53QHC T24N-708F','C',1,'N'),('G332','53QHE T30N-708F','C',1,'N'),('G333','53QHE T36N-708F','C',1,'N'),('G334','53QFL T18N-708','C',1,'N'),('G335','53QFL T24N-708','C',1,'N'),('G336','53QFL T30N-708','C',1,'N'),('G337','53QFL T36N-708','C',1,'N'),('G338','53QDM T12N-718A6','C',1,'N'),('G339','53QDM T18N-718A6','C',1,'N'),('G340','53QDM T24N-718A6','C',1,'N'),('G341','53QDM T30N-718A6','C',1,'N'),('G342','53QDM T36N-718A6','C',1,'N'),('G343','53QDM T42N-718A6','C',1,'N'),('G344','53QDM T48N-718A6','C',1,'N'),('G345','53QDM T60N-718A6','C',1,'N'),('G346','53QDM T18DN-718A6','C',1,'N'),('G347','53QDM T24DN-718A6','C',1,'N'),('G348','53QDM T36DN-718A6','C',1,'N'),('G349','53QDH T48DN-518 TG','C',1,'N'),('G350','53QDH T60DN-518 TG','C',1,'N'),('G351','53QCD T36DN-708','C',1,'N'),('G352','53QCD T48DN-508','C',1,'N'),('G353','53QFJ T36DN-708','C',1,'N'),('G354','53FGD T60DN-508','C',1,'N'),('G355','53QFJ T36N-708','C',1,'N'),('G356','53KFM T60N-508','C',1,'N'),('G357','MSC1T-12CR-DN-F','C',1,'N'),('G358','MSC1T-18CR-DN-F','C',1,'N'),('G359','MSC1T-24CR-DN-F','C',1,'N'),('G360','MSC1T-12HR-DN-F','C',1,'N'),('G361','MSC1T-18HR-DN-F','C',1,'N'),('G362','MSC1T-24HR-DN-F','C',1,'N'),('G363','MISABT-30HRDNF-Q8','C',1,'N'),('G364','MISABT-36HRDNF-Q8','C',1,'N'),('G365','MSC1T-12CR-N','C',1,'N'),('G366','MSC1T-18CR-N','C',1,'N'),('G367','MSC1T-24CR-N','C',1,'N'),('G368','MSC1T-12HR-NF','C',1,'N'),('G369','MSC1T-18HR-NF','C',1,'N'),('G370','MSC1T-24HR-NF','C',1,'N'),('G371','MISF1T-30HR-NF','C',1,'N'),('G372','MISF1T-36HR-NF','C',1,'N'),('G373','MSZ1T-18HR-N','C',1,'N'),('G374','MSZ1T-24HR-N','C',1,'N'),('G375','MSZ1T-30HR-N','C',1,'N'),('G376','MSZ1T-36HR-N','C',1,'N'),('G377','M1FPAT-36HRN-Q8','C',1,'N'),('G378','2جم','C',1,'N'),('G379','6كجم','C',1,'N'),('G380','7كجم','C',1,'N'),('G381','12كجم','C',1,'N'),('H01','3 mm','J',1,'N'),('H02','8 mm','J',1,'N'),('H03','10 mm','J',1,'N'),('H04','20 mm','J',1,'N'),('H05','30 mm','J',1,'N'),('H06','1.5 mm','J',1,'N'),('H07','4 mm','J',1,'N'),('H08','11.5 cm','J',1,'N'),('H09','11 cm','J',1,'N'),('H10','16 cm','J',1,'N'),('H11','10 cm','J',1,'N'),('H12','14 cm','J',1,'N'),('H13','7 cm','J',1,'N'),('H14','15 cm','J',1,'N'),('H15','8 cm','J',1,'N'),('H16','7.5 cm','J',1,'N'),('H17','5 cm','J',1,'N'),('H18','4.5 cm','J',1,'N'),('H19','22 cm','J',1,'N'),('H20','20 cm','J',1,'N'),('H21','21 cm','J',1,'N'),('H22','30 cm','J',1,'N'),('H23','40 cm','J',1,'N'),('H24','80 cm','J',1,'N'),('H25','50 cm','J',1,'N'),('H26','60 cm','J',1,'N'),('H27','85 cm','J',1,'N'),('H28','25 cm','J',1,'N'),('H29','23.5 cm','J',1,'N'),('H30','23 cm','J',1,'N'),('H31','30.5 cm','J',1,'N'),('H32','20 cm','J',1,'N'),('H33','28 cm','J',1,'N'),('H34','30 cm','J',1,'N'),('L01','7.5 cm','H',1,'N'),('L02','75 cm','H',1,'N'),('L03','50 cm','H',1,'N'),('L04','46 cm','H',1,'N'),('L05','40 cm','H',1,'N'),('L06','30 cm','H',1,'N'),('L07','64 cm','H',1,'N'),('L08','45 cm','H',1,'N'),('L09','1 m','H',1,'N'),('L10','1.2 m','H',1,'N'),('L11','31 cm','H',1,'N'),('L12','11 cm','H',1,'N'),('L13','20 cm','H',1,'N'),('L14','18 cm','H',1,'N'),('L15','14 cm','H',1,'N'),('L16','15 cm','H',1,'N'),('L17','5 cm','H',1,'N'),('L18','7 cm','H',1,'N'),('L19','30 cm','H',1,'N'),('L20','19 cm','H',1,'N'),('L21','10 cm','H',1,'N'),('L22','35 cm','H',1,'N'),('L23','16 cm','H',1,'N'),('L24','9 cm','H',1,'N'),('L25','8 cm','H',1,'N'),('L26','24 cm','H',1,'N'),('L27','12 cm','H',1,'N'),('L28','38 cm','H',1,'N'),('L29','40 cm','H',1,'N'),('L30','60 cm','H',1,'N'),('L31','19.5 cm','H',1,'N'),('L32','76 cm','H',1,'N'),('L33','100 cm','H',1,'N'),('L34','120 cm','H',1,'N'),('L35','130 cm','H',1,'N'),('L36','140 cm','H',1,'N'),('L37','160 cm','H',1,'N'),('L38','190 cm','H',1,'N'),('L39','180 cm','H',1,'N'),('L40','200 cm','H',1,'N'),('L41','220 cm','H',1,'N'),('L42','270 cm','H',1,'N'),('L43','240 cm','H',1,'N'),('L44','262 cm','H',1,'N'),('L45','335 cm','H',1,'N'),('L46','375 cm','H',1,'N'),('L47','400 cm','H',1,'N'),('L48','435 cm','H',1,'N'),('L49','440 cm','H',1,'N'),('L50','610 cm','H',1,'N'),('L51','760 cm','H',1,'N'),('L52','835 cm','H',1,'N'),('L53','25 cm','H',1,'N'),('L54','36 cm','H',1,'N'),('L55','50 cm','H',1,'N'),('L56','70 cm','H',1,'N'),('L57','80 cm','H',1,'N'),('L58','90 cm','H',1,'N'),('L59','110 cm','H',1,'N'),('L60','165 cm','H',1,'N'),('L61','170 cm','H',1,'N'),('L62','160 cm','H',1,'N'),('L63','130 cm','H',1,'N'),('L64','80 cm','H',1,'N'),('N0000','???','A',1,'Y'),('N0001','مسلوب مركزى','A',1,'Y'),('N0002','مسلوب لا مركزى','A',1,'N'),('N0003','كاب','A',1,'N'),('N0004','تية','A',1,'N'),('N0005','تية مسلوب','A',1,'N'),('N0006','جلبة','A',1,'N'),('N0007','ثرودوليت','A',1,'N'),('N0008','سيكوليت','A',1,'N'),('N0009','كوع استانلس سملس 316','A',1,'N'),('N0010','مسلوب مركزى استانلس 316','A',1,'N'),('N0011','كاب سملس استانلس 316','A',1,'N'),('N0012','تية سملس استانلس 316','A',1,'N'),('N0013','تية مسلوب سملس استانلس 316','A',1,'N'),('N0014','جلبة سملس استانلس 316','A',1,'N'),('N0015','كوع استانلس سملس 304','A',1,'N'),('N0016','مسلوب مركزى استانلس 304','A',1,'N'),('N0017','كاب سملس استانلس 304','A',1,'N'),('N0018','تية سملس استانلس 304','A',1,'N'),('N0019','تية مسلوب سملس استانلس 304','A',1,'N'),('N0020','جلبة سملس استانلس 304','A',1,'N'),('N0021','كوع سملس استانلس 304','A',1,'N'),('N0022','مسلوب مركزى سملس استانلس 304','A',1,'N'),('N0023','كوع لحام طولى استانلس 316','A',1,'N'),('N0024','كوع لحام طولى سملس 316','A',1,'N'),('N0025','مسلوب مركزى لحام طولى استانلس 316','A',1,'N'),('N0026','كاب لحام طولى استانلس 316','A',1,'N'),('N0027','تية لحام طولى استانلس 316','A',1,'N'),('N0028','تية مسلوب لحام طولى استانلس 316','A',1,'N'),('N0029','جلبة لحام طولى استانلس 316','A',1,'N'),('N0030','كوع لحام طولى استانلس 304','A',1,'N'),('N0031','مسلوب مركزى لحام طولى استانلس 304','A',1,'N'),('N0032','كاب لحام طولى استانلس 304','A',1,'N'),('N0033','تية لحام طولى استانلس 304','A',1,'N'),('N0034','تية مسلوب لحام طولى استانلس 304','A',1,'N'),('N0035','جلبة لحام طولى استانلس 304','A',1,'N'),('N0036','كوع مسلوب','A',1,'N'),('N0037','جلبة مسلوبة','A',1,'N'),('N0038','نبل','A',1,'N'),('N0039','لاكور تجميع','A',1,'N'),('N0040','طبة','A',1,'N'),('N0041','طبة كاب','A',1,'N'),('N0042','بوش','A',1,'N'),('N0043','تية صليبة','A',1,'N'),('N0044','كوع مجلفن','A',1,'N'),('N0045','كوع مسلوب مجلفن','A',1,'N'),('N0046','تية مجلفن','A',1,'N'),('N0047','تية مسلوب مجلفن','A',1,'N'),('N0048','جلبة مجلفنة','A',1,'N'),('N0049','جلبة مسلوبة مجلفنة','A',1,'N'),('N0050','لاكور تجميع مجلفن','A',1,'N'),('N0051','طبة مجلفنة','A',1,'N'),('N0052','طبة كاب مجلفنة','A',1,'N'),('N0053','كوع بلاستيك ابيض','A',1,'N'),('N0054','كوع بلاستيك ابيض بباب','A',1,'N'),('N0055','تية بلاستيك ابيض','A',1,'N'),('N0056','تية بلاستيك ابيض بباب','A',1,'N'),('N0057','تية بلاستيك ابيض مسلوب','A',1,'N'),('N0058','تية بلاستيك ابيض مسلوب بباب','A',1,'N'),('N0059','تية بلاستيك ابيض صليبة','A',1,'N'),('N0060','تية بلاستيك ابيض مسلوب مزدوج','A',1,'N'),('N0061','هواية بلاستيك ابيض','A',1,'N'),('N0062','جلبة بلاستيك ابيض','A',1,'N'),('N0063','جلبة بلاستيك ابيض مسلوبة','A',1,'N'),('N0064','بوش بلاستيك ابيض','A',1,'N'),('N0065','طبة تسليك بلاستيك ابيض','A',1,'N'),('N0066','طبة كاب بلاستيك ابيض','A',1,'N'),('N0067','بيبة بلاستيك ابيض','A',1,'N'),('N0068','جلبة بلاستيك ابيض صليبة','A',1,'N'),('N0069','طبة كاب بلاستيك ابيض 75 مم','A',1,'N'),('N0070','سيفون بباب بلاستيك ابيض','A',1,'N'),('N0071','كوع بلاستيك ابيض بسن داخلى','A',1,'N'),('N0072','كوع بلاستيك رمادى','A',1,'N'),('N0073','تية بلاستيك رمادى','A',1,'N'),('N0074','جلبة بلاستيك رمادى','A',1,'N'),('N0075','طبة كاب بلاستيك رمادى','A',1,'N'),('N0076','بردة بلاستيك رمادى','A',1,'N'),('N0077','لاكور تجميع بلاستيك رمادى','A',1,'N'),('N0078','جلة مسلوبة بلاستيك رمادى','A',1,'N'),('N0079','بوش بلاستيك رمادى','A',1,'N'),('N0080','نبل بلاستيك رمادى','A',1,'N'),('N0081','كوع بلاستيك لصق/قلاووظ داخلى رمادى','A',1,'N'),('N0082','تية بلاستيك لصق/قلاووظ داخلى رمادى','A',1,'N'),('N0083','جلبة بلاستيك لصق/قلاووظ داخلى رمادى','A',1,'N'),('N0084','لاكور تجميع قلاووظ رمادى','A',1,'N'),('N0085','جلبة بلاستيك قلاووظ داخلى رمادى/ لصق رمادى','A',1,'N'),('N0086','جلبة بلاستيك لصق/قلاووظ خارجى رمادى','A',1,'N'),('N0087','جلبة بلاستيك لصق/قلاووظ سن داخلى رمادى','A',1,'N'),('N0088','جلبة بلاستيك لصق/قلاووظ سن خارجى رمادى','A',1,'N'),('N0089','كوع بلاستيك قلاووظ داخلى رمادى','A',1,'N'),('N0090','تية بلاستيك قلاووظ داخلى رمادى','A',1,'N'),('N0091','جلبة بلاستيك قلاووظ داخلى رمادى','A',1,'N'),('N0092','كاب بلاستيك قلاووظ داخلى رمادى','A',1,'N'),('N0093','جلبة بلاستيك قلاووظ داخلى / قلاووظ خارجى رمادى','A',1,'N'),('N0094','جلبة مسلوبة بلاستيك قلاووظ داخلى رمادى','A',1,'N'),('N0095','كوع بلاستيك ضغط رمادى','A',1,'N'),('N0096','تية بلاستيك ضغط رمادى','A',1,'N'),('N0097','جلبة بلاستيك ضغط رمادى','A',1,'N'),('N0098','جلبة مسلوبة بلاستيك ضغط رمادى','A',1,'N'),('N0099','تية مسلوبة بلاستيك ضغط رمادى','A',1,'N'),('N0100','بوش بلاستيك ضغط رمادى','A',1,'N'),('N0101','طبة بلاستيك ضغط رمادى','A',1,'N'),('N0102','بردة بلاستيك ضغط رمادى','A',1,'N'),('N0103','لاكور تجميع بلاستيك ضغط رمادى','A',1,'N'),('N0104','تية صليبة بلاستيك ضغط رمادى','A',1,'N'),('N0105','تية Y بلاستيك ضغط رمادى','A',1,'N'),('N0106','كوع صرف بجوان رمادى','A',1,'N'),('N0107','افيز سباكة (قطعتين)','A',1,'N'),('N0108','افيز سباكة (قطعتين) بجوان','A',1,'N'),('N0109','بردة بلاستيك بولى بروبلين','A',1,'N'),('N0110','تية بلاستيك بولى بروبلين','A',1,'N'),('N0111','تية (مشترك) بلاستيك مسلوب بولى بروبلين','A',1,'N'),('N0112','تية بلاستيك بسن بولى بروبلين','A',1,'N'),('N0113','جلبة بلاستيك بولى بروبلين','A',1,'N'),('N0114','جلبة بلاستيك بسن داخلى بولى بروبلين','A',1,'N'),('N0115','جلبة بلاستيك بسن خارجى بولى بروبلين','A',1,'N'),('N0116','جلبة بلاستيك مسلوبة بولى بروبلين','A',1,'N'),('N0117','طبة اختبار بلاستيك بولى بروبلين','A',1,'N'),('N0118','طبة كاب بلاستيك بولى بروبلين','A',1,'N'),('N0119','كرانك بلاستيك بولى بروبلين','A',1,'N'),('N0120','كوع بلاستيك بولى بروبلين','A',1,'N'),('N0121','لاكور تجميع بلاستيك بسن بولى بروبلين','A',1,'N'),('N0122','بردة بلاستيك بولى ايثلين (PN10)','A',1,'N'),('N0123','بردة بلاستيك بولى ايثلين (PN16)','A',1,'N'),('N0124','بردة بلاستيك بولى ايثلين (PN20)','A',1,'N'),('N0125','تية بلاستيك بولى ايثلين (PN10)','A',1,'N'),('N0126','تية بلاستيك بولى ايثلين (PN16)','A',1,'N'),('N0127','تية بلاستيك بولى ايثلين (PN20)','A',1,'N'),('N0128','تية بلاستيك مسلوب بولى ايثلين (PN10)','A',1,'N'),('N0129','تية بلاستيك مسلوب بولى ايثلين (PN16)','A',1,'N'),('N0130','تية بلاستيك مسلوب بولى ايثلين (PN20)','A',1,'N'),('N0131','جلبة بلاستيك بولى ايثلين (PN10)','A',1,'N'),('N0132','جلبة بلاستيك بولى ايثلين (PN16)','A',1,'N'),('N0133','جلبة بلاستيك بولى ايثلين (PN20)','A',1,'N'),('N0134','جلبة بلاستيك مسلوب بولى ايثلين (PN10)','A',1,'N'),('N0135','جلبة بلاستيك مسلوب بولى ايثلين (PN16)','A',1,'N'),('N0136','جلبة بلاستيك مسلوب بولى ايثلين (PN20)','A',1,'N'),('N0137','كوع بلاستيك بولى ايثلين (PN10)','A',1,'N'),('N0138','كوع بلاستيك بولى ايثلين (PN16)','A',1,'N'),('N0139','كوع بلاستيك بولى ايثلين (PN20)','A',1,'N'),('N0140','سملس','A',1,'N'),('N0141','لحام طولى ERW','A',1,'N'),('N0142','لحام طولى اسود','A',1,'N'),('N0143','لحام طولى مجلفن','A',1,'N'),('N0144','سملس استانلس 304','A',1,'N'),('N0145','سملس استانلس 316','A',1,'N'),('N0146','نحاس هارد TYPE K','A',1,'N'),('N0147','نحاس هارد TYPE L','A',1,'N'),('N0148','نحاس هارد TYPE M','A',1,'N'),('N0149','نحاس سوفت','A',1,'N'),('N0150','صرف بجوان رمادى 4 بار','A',1,'N'),('N0151','صرف بجوان رمادى 6 بار','A',1,'N'),('N0152','صرف بجوان رمادى 10بار','A',1,'N'),('N0153','صرف بجوان رمادى 16بار','A',1,'N'),('N0154','صرف بجوان رمادى 2 بار','A',1,'N'),('N0155','صرف بجوان رمادى 10 بار','A',1,'N'),('N0156','صرف بجوان رمادى 16 بار','A',1,'N'),('N0157','صرف بجوان رمادى 2.5 بار','A',1,'N'),('N0158','مواسيرUPVC أبيض','A',1,'N'),('N0159','بولى بروبلين','A',1,'N'),('N0160','بولى بروبلين مدعمة بالفيبر جلاس','A',1,'N'),('N0161','بولى ايثلين (SDR 51 PN 3.2 bar)','A',1,'N'),('N0162','بولى ايثلين (SDR 41 PN 4 bar)','A',1,'N'),('N0163','بولى ايثلين (SDR33 PN 5 bar)','A',1,'N'),('N0164','بولى ايثلين (SDR 26 PN 6 bar)','A',1,'N'),('N0165','بولى ايثلين (SDR 22 PN 7.6 bar)','A',1,'N'),('N0166','بولى ايثلين (SDR 21 PN 8 bar)','A',1,'N'),('N0167','بولى ايثلين (SDR 17.6 PN 9.6 bar)','A',1,'N'),('N0168','بولى ايثلين (SDR 17 PN 10 bar)','A',1,'N'),('N0169','بولى ايثلين (SDR 13.6 PN 12.5 bar)','A',1,'N'),('N0170','بولى ايثلين (SDR 11 PN 16 bar)','A',1,'N'),('N0171','بولى ايثلين (SDR 9 PN 20 bar)','A',1,'N'),('N0172','بولى ايثلين (SDR 7.4 PN 25 bar)','A',1,'N'),('N0173','بولى ايثلين (SDR 6 PN 32 bar)','A',1,'N'),('N0174','بولى ايثلين (SDR 5 PN 40 bar)','A',1,'N'),('N0175','بولى ايثلين (SDR 33 PN 5 bar)','A',1,'N'),('N0176','بولى ايثلين (SDR26 PN 6 bar)','A',1,'N'),('N0177','كهرباء صلب','A',1,'N'),('N0178','كهرباء بلاستيك','A',1,'N'),('N0179','محبس سكينه','A',1,'N'),('N0180','محبس اتزان','A',1,'N'),('N0181','محبس فراشة','A',1,'N'),('N0182','محبس عدم رجوع','A',1,'N'),('N0183','محبس كورة','A',1,'N'),('N0184','محبس كورة بولى بروبلين 1 لاكور','A',1,'N'),('N0185','محبس كورة بولى بروبلين 2 لاكور','A',1,'N'),('N0186','مصفاة','A',1,'N'),('N0187','وصلة مرنة','A',1,'N'),('N0188','وصلة مرنة بلاكور','A',1,'N'),('N0189','وصلة استانلس معزولة','A',1,'N'),('N0190','وصلة مرنة لرشاش حريق','A',1,'N'),('N0191','عمود لتثبيت الوصلات المرنة','A',1,'N'),('N0192','عمود تحكم ببلتات للوصلات المرنة','A',1,'N'),('N0193','كابل نحاس ترمو','A',1,'N'),('N0194','كابل نحاس ترمو XLPE','A',1,'N'),('N0195','كابل نحاس مسلح','A',1,'N'),('N0196','كابل نحاس مسلح XLPE','A',1,'N'),('N0197','كابل المونيوم ترمو','A',1,'N'),('N0198','كابل المونيوم ترمو XLPE','A',1,'N'),('N0199','كابل المونيوم مسلح','A',1,'N'),('N0200','كابل المونيوم مسلح XLPE','A',1,'N'),('N0201','كابل نحاس ترموXLPE','A',1,'N'),('N0202','كابل المونيوم ترموXLPE','A',1,'N'),('N0203','كابل نحاس مجدول','A',1,'N'),('N0204','كابل نحاس مصمت','A',1,'N'),('N0205','كابل نحاس شعر','A',1,'N'),('N0206','سلك نحاس مجدول','A',1,'N'),('N0207','سلك نحاس شعر','A',1,'N'),('N0208','سلك نحاس المونيوم','A',1,'N'),('N0209','كابل نحاس شعر كنترول','A',1,'N'),('N0210','كابل تليفون ترمو','A',1,'N'),('N0211','كابل انذار حريق بالشيلد','A',1,'N'),('N0212','كابل انذار حريق بدون شيلد','A',1,'N'),('N0213','CAT 5 كابل داتا','A',1,'N'),('N0214','CAT 6 كابل داتا','A',1,'N'),('N0215','CAT 7 كابل داتا','A',1,'N'),('N0216','مواسير صوف زجاجى','A',1,'N'),('N0217','لفات صوف زجاجى بالالومنيوم','A',1,'N'),('N0218','لفات صوف زجاجى بدون الومنيوم','A',1,'N'),('N0219','لفات صوف صخرى بلالومنيوم','A',1,'N'),('N0220','لفات صوف صخرى بالسلك الشبك','A',1,'N'),('N0221','الواح صوف زجاجى بالالومنيوم','A',1,'N'),('N0222','الواح صوف صخرى','A',1,'N'),('N0223','لفات ارم فليكس بدون لاصق','A',1,'N'),('N0224','لفات ارم فليكس لاصق','A',1,'N'),('N0225','لفات ارم فليكس بدون لاصق بطبقةAG المونيوم','A',1,'N'),('N0226','لفات ارم فليكس لاصق بطبقة AG المونيوم','A',1,'N'),('N0227','فليكسبل داكت غير معزول','A',1,'N'),('N0228','فليكسبل داكت معزول','A',1,'N'),('N0229','شرائط فضى سادة','A',1,'N'),('N0230','شرائط فضى مسلح','A',1,'N'),('N0231','شرائط شفاف','A',1,'N'),('N0232','انابيب داكت سيلر رمادى مضاد للبكتريا( سيلكون)','A',1,'N'),('N0233','انابيب داكت سيلر ابيض مضاد للبكتريا( سيلكون)','A',1,'N'),('N0234','انابيب داكت سيلر شفاف مضاد للبكتريا( سيلكون)','A',1,'N'),('N0235','بستلة فوستر لاصق','A',1,'N'),('N0236','بستلة فوستر 60-85','A',1,'N'),('N0237','بستلة فوستر 30-36','A',1,'N'),('N0238','مسمار تثبيت عزل بالوردة (استيك بن)','A',1,'N'),('N0239','جاسكت','A',1,'N'),('N0240','شنبر بلاستيك','A',1,'N'),('N0241','شنبر استانلس','A',1,'N'),('N0242','كلبس استانلس','A',1,'N'),('N0243','كنفز بارد 4.5+7+4.5 سم','A',1,'N'),('N0244','كنفز بارد 7+10+7 سم','A',1,'N'),('N0245','كنفز حرارى 4.5+7+4.5 سم','A',1,'N'),('N0246','كنفز حرارى 7+10+7 سم','A',1,'N'),('N0247','سيخ ترمسيون طول 2متر','A',1,'N'),('N0248','سيخ ترمسيون طول 3متر','A',1,'N'),('N0249','سيخ ترمسيون استانلس طول 2متر','A',1,'N'),('N0250','سيخ ترمسيون مسمط طول 6متر','A',1,'N'),('N0251','مسمار صلب','A',1,'N'),('N0252','مسمار صلب استانلس','A',1,'N'),('N0253','مسمار صلب نصف قلاووظ','A',1,'N'),('N0254','مسمار استانلس','A',1,'N'),('N0255','مسمار سن بنطة رأس مسدس','A',1,'N'),('N0256','مسمار تراى','A',1,'N'),('N0257','مسمار سن بنطة رأس مسدس بالكاوتش','A',1,'N'),('N0258','مسمار تك سن بنطة بوردة منة فية','A',1,'N'),('N0259','مسمار تك سن بنطة استانلس بوردة منة فية','A',1,'N'),('N0260','مسمار خشابى','A',1,'N'),('N0261','مسمار برمة','A',1,'N'),('N0262','مسمار سن صاج','A',1,'N'),('N0263','مسمار جاويط B7 وصامولتين 2H','A',1,'N'),('N0264','مسمار فيشر','A',1,'N'),('N0265','مسمار فيشر حرف L','A',1,'N'),('N0266','مسمار فيشر حلقة','A',1,'N'),('N0267','صامولة','A',1,'N'),('N0268','صامولة استانلس','A',1,'N'),('N0269','صامولة كلبس','A',1,'N'),('N0270','صامولة 2H','A',1,'N'),('N0271','وردة','A',1,'N'),('N0272','وردة سوستة (مشقوقة)','A',1,'N'),('N0273','وردة مشرشرة','A',1,'N'),('N0274','وردة استانلس','A',1,'N'),('N0275','جانش','A',1,'N'),('N0276','اكمن','A',1,'N'),('N0277','اكمن يركب فى الطوب (فراشة)','A',1,'N'),('N0278','انكور','A',1,'N'),('N0279','جلبة وصل ترمسيون','A',1,'N'),('N0280','فيشر بلاستيك','A',1,'N'),('N0281','فيشر فراشة','A',1,'N'),('N0282','افيز هنجر','A',1,'N'),('N0283','افيز هنجر رجل طويلة','A',1,'N'),('N0284','افيز حرف U بولت على ماسورة','A',1,'N'),('N0285','افيز حرف U بولت على كرسى خشب سمك 8مم','A',1,'N'),('N0286','افيز حرف U بولت على كرسى خشب سمك 10مم','A',1,'N'),('N0287','افيز كولية','A',1,'N'),('N0288','A11','A',1,'N'),('N0289','A23','A',1,'N'),('N0290','A26','A',1,'N'),('N0291','A27','A',1,'N'),('N0292','A28','A',1,'N'),('N0293','A28.5','A',1,'N'),('N0294','A29','A',1,'N'),('N0295','A29.5','A',1,'N'),('N0296','A30','A',1,'N'),('N0297','A31','A',1,'N'),('N0298','A32','A',1,'N'),('N0299','A33','A',1,'N'),('N0300','A33.5','A',1,'N'),('N0301','A34','A',1,'N'),('N0302','A35','A',1,'N'),('N0303','A36','A',1,'N'),('N0304','A37','A',1,'N'),('N0305','A37.5','A',1,'N'),('N0306','A38','A',1,'N'),('N0307','A38.5','A',1,'N'),('N0308','A39','A',1,'N'),('N0309','A40','A',1,'N'),('N0310','A41','A',1,'N'),('N0311','A41.5','A',1,'N'),('N0312','A42','A',1,'N'),('N0313','A42.5','A',1,'N'),('N0314','A43','A',1,'N'),('N0315','A43.5','A',1,'N'),('N0316','A44','A',1,'N'),('N0317','A45','A',1,'N'),('N0318','A46','A',1,'N'),('N0319','A46.5','A',1,'N'),('N0320','A47','A',1,'N'),('N0321','A48','A',1,'N'),('N0322','A49','A',1,'N'),('N0323','A50','A',1,'N'),('N0324','A51','A',1,'N'),('N0325','A52','A',1,'N'),('N0326','A53','A',1,'N'),('N0327','A54','A',1,'N'),('N0328','A55','A',1,'N'),('N0329','A56','A',1,'N'),('N0330','A57','A',1,'N'),('N0331','A58','A',1,'N'),('N0332','A59','A',1,'N'),('N0333','A60','A',1,'N'),('N0334','A61','A',1,'N'),('N0335','A62','A',1,'N'),('N0336','A63','A',1,'N'),('N0337','A64','A',1,'N'),('N0338','A65','A',1,'N'),('N0339','A66','A',1,'N'),('N0340','A67','A',1,'N'),('N0341','A68','A',1,'N'),('N0342','A69','A',1,'N'),('N0343','A70','A',1,'N'),('N0344','A71','A',1,'N'),('N0345','A72','A',1,'N'),('N0346','A73','A',1,'N'),('N0347','A74','A',1,'N'),('N0348','A75','A',1,'N'),('N0349','A76','A',1,'N'),('N0350','A77','A',1,'N'),('N0351','A78','A',1,'N'),('N0352','A79','A',1,'N'),('N0353','A80','A',1,'N'),('N0354','A81','A',1,'N'),('N0355','A82','A',1,'N'),('N0356','A83','A',1,'N'),('N0357','A84','A',1,'N'),('N0358','A85','A',1,'N'),('N0359','A86','A',1,'N'),('N0360','A87','A',1,'N'),('N0361','A88','A',1,'N'),('N0362','A89','A',1,'N'),('N0363','A90','A',1,'N'),('N0364','A91','A',1,'N'),('N0365','A92','A',1,'N'),('N0366','A93','A',1,'N'),('N0367','A94','A',1,'N'),('N0368','A95','A',1,'N'),('N0369','A96','A',1,'N'),('N0370','A97','A',1,'N'),('N0371','A98','A',1,'N'),('N0372','A99','A',1,'N'),('N0373','A100','A',1,'N'),('N0374','A101','A',1,'N'),('N0375','A102','A',1,'N'),('N0376','A103','A',1,'N'),('N0377','A104','A',1,'N'),('N0378','A105','A',1,'N'),('N0379','A106','A',1,'N'),('N0380','A107','A',1,'N'),('N0381','A108','A',1,'N'),('N0382','A109','A',1,'N'),('N0383','A110','A',1,'N'),('N0384','A111','A',1,'N'),('N0385','A112','A',1,'N'),('N0386','A113','A',1,'N'),('N0387','A114','A',1,'N'),('N0388','A115','A',1,'N'),('N0389','A116','A',1,'N'),('N0390','A117','A',1,'N'),('N0391','A118','A',1,'N'),('N0392','A119','A',1,'N'),('N0393','A120','A',1,'N'),('N0394','A121','A',1,'N'),('N0395','A122','A',1,'N'),('N0396','A123','A',1,'N'),('N0397','A124','A',1,'N'),('N0398','A125','A',1,'N'),('N0399','A126','A',1,'N'),('N0400','A127','A',1,'N'),('N0401','A415','A',1,'N'),('N0402','A1020','A',1,'N'),('N0403','AX24','A',1,'N'),('N0404','AX26','A',1,'N'),('N0405','AX36','A',1,'N'),('N0406','A13X','A',1,'N'),('N0407','AX51','A',1,'N'),('N0408','B17','A',1,'N'),('N0409','B22','A',1,'N'),('N0410','B24','A',1,'N'),('N0411','B27','A',1,'N'),('N0412','B28','A',1,'N'),('N0413','B29','A',1,'N'),('N0414','B30','A',1,'N'),('N0415','B31','A',1,'N'),('N0416','B32','A',1,'N'),('N0417','B33','A',1,'N'),('N0418','B33.5','A',1,'N'),('N0419','B34','A',1,'N'),('N0420','B35','A',1,'N'),('N0421','B36','A',1,'N'),('N0422','B37','A',1,'N'),('N0423','B37.5','A',1,'N'),('N0424','B38','A',1,'N'),('N0425','B38.5','A',1,'N'),('N0426','B39','A',1,'N'),('N0427','B40','A',1,'N'),('N0428','B40.5','A',1,'N'),('N0429','B41','A',1,'N'),('N0430','B42','A',1,'N'),('N0431','B43','A',1,'N'),('N0432','B44','A',1,'N'),('N0433','B45','A',1,'N'),('N0434','B46','A',1,'N'),('N0435','B46.5','A',1,'N'),('N0436','B47','A',1,'N'),('N0437','B48','A',1,'N'),('N0438','B49','A',1,'N'),('N0439','B50','A',1,'N'),('N0440','B51','A',1,'N'),('N0441','B52','A',1,'N'),('N0442','B53','A',1,'N'),('N0443','B54','A',1,'N'),('N0444','B55','A',1,'N'),('N0445','B56','A',1,'N'),('N0446','B57','A',1,'N'),('N0447','B58','A',1,'N'),('N0448','B59','A',1,'N'),('N0449','B60','A',1,'N'),('N0450','B61','A',1,'N'),('N0451','B62','A',1,'N'),('N0452','B63','A',1,'N'),('N0453','B64','A',1,'N'),('N0454','B65','A',1,'N'),('N0455','B66','A',1,'N'),('N0456','B67','A',1,'N'),('N0457','B68','A',1,'N'),('N0458','B69','A',1,'N'),('N0459','B70','A',1,'N'),('N0460','B71','A',1,'N'),('N0461','B72','A',1,'N'),('N0462','B73','A',1,'N'),('N0463','B74','A',1,'N'),('N0464','B75','A',1,'N'),('N0465','B76','A',1,'N'),('N0466','B77','A',1,'N'),('N0467','B78','A',1,'N'),('N0468','B79','A',1,'N'),('N0469','B80','A',1,'N'),('N0470','B81','A',1,'N'),('N0471','B82','A',1,'N'),('N0472','B83','A',1,'N'),('N0473','B84','A',1,'N'),('N0474','B85','A',1,'N'),('N0475','B86','A',1,'N'),('N0476','B87','A',1,'N'),('N0477','B88','A',1,'N'),('N0478','B89','A',1,'N'),('N0479','B90','A',1,'N'),('N0480','B91','A',1,'N'),('N0481','B92','A',1,'N'),('N0482','B93','A',1,'N'),('N0483','B94','A',1,'N'),('N0484','B95','A',1,'N'),('N0485','B96','A',1,'N'),('N0486','B97','A',1,'N'),('N0487','B98','A',1,'N'),('N0488','B99','A',1,'N'),('N0489','B100','A',1,'N'),('N0490','B101','A',1,'N'),('N0491','B102','A',1,'N'),('N0492','B103','A',1,'N'),('N0493','B104','A',1,'N'),('N0494','B105','A',1,'N'),('N0495','B106','A',1,'N'),('N0496','B107','A',1,'N'),('N0497','B108','A',1,'N'),('N0498','B109','A',1,'N'),('N0499','B110','A',1,'N'),('N0500','B111','A',1,'N'),('N0501','B112','A',1,'N'),('N0502','B113','A',1,'N'),('N0503','B114','A',1,'N'),('N0504','B115','A',1,'N'),('N0505','B116','A',1,'N'),('N0506','B117','A',1,'N'),('N0507','B118','A',1,'N'),('N0508','B119','A',1,'N'),('N0509','B120','A',1,'N'),('N0510','B121','A',1,'N'),('N0511','B122','A',1,'N'),('N0512','B123','A',1,'N'),('N0513','B124','A',1,'N'),('N0514','B125','A',1,'N'),('N0515','B126','A',1,'N'),('N0516','B127','A',1,'N'),('N0517','B128','A',1,'N'),('N0518','B129','A',1,'N'),('N0519','B130','A',1,'N'),('N0520','B131','A',1,'N'),('N0521','B132','A',1,'N'),('N0522','B133','A',1,'N'),('N0523','B134','A',1,'N'),('N0524','B135','A',1,'N'),('N0525','B136','A',1,'N'),('N0526','B137','A',1,'N'),('N0527','B138','A',1,'N'),('N0528','B139','A',1,'N'),('N0529','B140','A',1,'N'),('N0530','B141','A',1,'N'),('N0531','B142','A',1,'N'),('N0532','B143','A',1,'N'),('N0533','B144','A',1,'N'),('N0534','B145','A',1,'N'),('N0535','B146','A',1,'N'),('N0536','B147','A',1,'N'),('N0537','B148','A',1,'N'),('N0538','B149','A',1,'N'),('N0539','B150','A',1,'N'),('N0540','B151','A',1,'N'),('N0541','B152','A',1,'N'),('N0542','B153','A',1,'N'),('N0543','B154','A',1,'N'),('N0544','B155','A',1,'N'),('N0545','B156','A',1,'N'),('N0546','B157','A',1,'N'),('N0547','B158','A',1,'N'),('N0548','B159','A',1,'N'),('N0549','B160','A',1,'N'),('N0550','B161','A',1,'N'),('N0551','B162','A',1,'N'),('N0552','B163','A',1,'N'),('N0553','B164','A',1,'N'),('N0554','BS6','A',1,'N'),('N0555','BX650','A',1,'N'),('N0556','BX686','A',1,'N'),('N0557','BX750','A',1,'N'),('N0558','BX55','A',1,'N'),('N0559','B17X3910','A',1,'N'),('N0560','BZ46','A',1,'N'),('N0561','B4284','A',1,'N'),('N0562','B56 مشرشر','A',1,'N'),('N0563','B100 مشرشر','A',1,'N'),('N0564','C13','A',1,'N'),('N0565','C40','A',1,'N'),('N0566','C41','A',1,'N'),('N0567','C42','A',1,'N'),('N0568','C43','A',1,'N'),('N0569','C44','A',1,'N'),('N0570','C45','A',1,'N'),('N0571','C46','A',1,'N'),('N0572','C47','A',1,'N'),('N0573','C49','A',1,'N'),('N0574','C48','A',1,'N'),('N0575','C50','A',1,'N'),('N0576','C51','A',1,'N'),('N0577','C52','A',1,'N'),('N0578','C53','A',1,'N'),('N0579','C54','A',1,'N'),('N0580','C55','A',1,'N'),('N0581','C56','A',1,'N'),('N0582','C57','A',1,'N'),('N0583','C58','A',1,'N'),('N0584','C59','A',1,'N'),('N0585','C60','A',1,'N'),('N0586','C61','A',1,'N'),('N0587','C62','A',1,'N'),('N0588','C63','A',1,'N'),('N0589','C64','A',1,'N'),('N0590','C65','A',1,'N'),('N0591','C66','A',1,'N'),('N0592','C67','A',1,'N'),('N0593','C68','A',1,'N'),('N0594','C69','A',1,'N'),('N0595','C70','A',1,'N'),('N0596','C71','A',1,'N'),('N0597','C72','A',1,'N'),('N0598','C73','A',1,'N'),('N0599','C74','A',1,'N'),('N0600','C75','A',1,'N'),('N0601','C76','A',1,'N'),('N0602','C77','A',1,'N'),('N0603','C78','A',1,'N'),('N0604','C79','A',1,'N'),('N0605','C80','A',1,'N'),('N0606','C81','A',1,'N'),('N0607','C82','A',1,'N'),('N0608','C83','A',1,'N'),('N0609','C84','A',1,'N'),('N0610','C85','A',1,'N'),('N0611','C86','A',1,'N'),('N0612','C87','A',1,'N'),('N0613','C88','A',1,'N'),('N0614','C89','A',1,'N'),('N0615','C90','A',1,'N'),('N0616','C91','A',1,'N'),('N0617','C92','A',1,'N'),('N0618','C93','A',1,'N'),('N0619','C94','A',1,'N'),('N0620','C95','A',1,'N'),('N0621','C96','A',1,'N'),('N0622','C97','A',1,'N'),('N0623','C98','A',1,'N'),('N0624','C99','A',1,'N'),('N0625','C100','A',1,'N'),('N0626','C101','A',1,'N'),('N0627','C102','A',1,'N'),('N0628','C103','A',1,'N'),('N0629','C104','A',1,'N'),('N0630','C105','A',1,'N'),('N0631','C106','A',1,'N'),('N0632','C107','A',1,'N'),('N0633','C108','A',1,'N'),('N0634','C109','A',1,'N'),('N0635','C110','A',1,'N'),('N0636','C111','A',1,'N'),('N0637','C112','A',1,'N'),('N0638','C113','A',1,'N'),('N0639','C114','A',1,'N'),('N0640','C115','A',1,'N'),('N0641','C116','A',1,'N'),('N0642','C117','A',1,'N'),('N0643','C118','A',1,'N'),('N0644','C119','A',1,'N'),('N0645','C120','A',1,'N'),('N0646','C121','A',1,'N'),('N0647','C122','A',1,'N'),('N0648','C123','A',1,'N'),('N0649','C124','A',1,'N'),('N0650','C125','A',1,'N'),('N0651','C126','A',1,'N'),('N0652','C127','A',1,'N'),('N0653','C128','A',1,'N'),('N0654','C129','A',1,'N'),('N0655','C130','A',1,'N'),('N0656','C131','A',1,'N'),('N0657','C132','A',1,'N'),('N0658','C133','A',1,'N'),('N0659','C134','A',1,'N'),('N0660','C135','A',1,'N'),('N0661','C136','A',1,'N'),('N0662','C137','A',1,'N'),('N0663','C105 مشرشر','A',1,'N'),('N0664','SPZ62','A',1,'N'),('N0665','SPZ1287','A',1,'N'),('N0666','SPZ962','A',1,'N'),('N0667','SPA3550','A',1,'N'),('N0668','SPB1700','A',1,'N'),('N0669','SPB3150','A',1,'N'),('N0670','SPZ927','A',1,'N'),('N0671','SPZ850','A',1,'N'),('N0672','SPA1400','A',1,'N'),('N0673','SPA1432','A',1,'N'),('N0674','SPA1457','A',1,'N'),('N0675','SPA1482','A',1,'N'),('N0676','SPA1507','A',1,'N'),('N0677','SPA1532','A',1,'N'),('N0678','SPA1557','A',1,'N'),('N0679','SPA2032','A',1,'N'),('N0680','SPA3032','A',1,'N'),('N0681','SPA3250','A',1,'N'),('N0682','SPZ1037','A',1,'N'),('N0683','SPZ1120','A',1,'N'),('N0684','SPZ1180','A',1,'N'),('N0685','SPZ1320','A',1,'N'),('N0686','SPZ1250','A',1,'N'),('N0687','SPZ1562','A',1,'N'),('N0688','SPZ1587','A',1,'N'),('N0689','SPZ1662','A',1,'N'),('N0690','SPZ1700','A',1,'N'),('N0691','SPZ2030','A',1,'N'),('N0692','SPZ812','A',1,'N'),('N0693','SPZ837','A',1,'N'),('N0694','SPZ950','A',1,'N'),('N0695','SPZ987','A',1,'N'),('N0696','Z45.5','A',1,'N'),('N0697','SPZ925','A',1,'N'),('N0698','SPZ1462','A',1,'N'),('N0699','SPZ48','A',1,'N'),('N0700','SPZ1212','A',1,'N'),('N0701','SPZ46','A',1,'N'),('N0702','SPZ44','A',1,'N'),('N0703','SPZ4000','A',1,'N'),('N0704','SPZ1687','A',1,'N'),('N0705','SPZ45','A',1,'N'),('N0706','SPZ1900','A',1,'N'),('N0707','SPA950','A',1,'N'),('N0708','SPB1250','A',1,'N'),('N0709','SPZ937','A',1,'N'),('N0710','SPZ1457','A',1,'N'),('N0711','SPA1250','A',1,'N'),('N0712','SPZ1262','A',1,'N'),('N0713','SPZ1187','A',1,'N'),('N0714','SPZ1077','A',1,'N'),('N0715','Z32','A',1,'N'),('N0716','Z39','A',1,'N'),('N0717','Z40','A',1,'N'),('N0718','Z44','A',1,'N'),('N0719','Z45','A',1,'N'),('N0720','Z48','A',1,'N'),('N0721','Z54','A',1,'N'),('N0722','Z57','A',1,'N'),('N0723','11B*118','A',1,'N'),('N0724','9.5*1325','A',1,'N'),('N0725','13*1250','A',1,'N'),('N0726','13*1750','A',1,'N'),('N0727','13*1075','A',1,'N'),('N0728','12.5*800','A',1,'N'),('N0729','95*1400','A',1,'N'),('N0730','17*1400','A',1,'N'),('N0731','13*1400','A',1,'N'),('N0732','13*1175','A',1,'N'),('N0733','13*1050','A',1,'N'),('N0734','13*1225','A',1,'N'),('N0735','9.5*100','A',1,'N'),('N0736','9.5*900','A',1,'N'),('N0737','4.5*900','A',1,'N'),('N0738','13*1000','A',1,'N'),('N0739','13*1100','A',1,'N'),('N0740','9.5*1110','A',1,'N'),('N0741','13*650','A',1,'N'),('N0742','13*850','A',1,'N'),('N0743','13*1060','A',1,'N'),('N0744','13*725 مشرشر','A',1,'N'),('N0745','13*775 مشرشر','A',1,'N'),('N0746','13*1070','A',1,'N'),('N0747','17*1025','A',1,'N'),('N0748','13*1300','A',1,'N'),('N0749','17*1725','A',1,'N'),('N0750','9*1175','A',1,'N'),('N0751','9.5*750 مشرشر','A',1,'N'),('N0752','HYM350','A',1,'N'),('N0753','2983 مشرشر','A',1,'N'),('N0754','1432','A',1,'N'),('N0755','925','A',1,'N'),('N0756','9.75','A',1,'N'),('N0757','جوان كاوتش','A',1,'N'),('N0758','جوان كاوتش 2 تيلة','A',1,'N'),('N0759','جوان كاوتش 2 تيلة عريض','A',1,'N'),('N0760','جوان جرانجريت','A',1,'N'),('N0761','جوان جرانجريت عريض','A',1,'N'),('N0762','جوان جرانجريت مسلح','A',1,'N'),('N0763','جوان جرانجريت مسلح عريض','A',1,'N'),('N0764','جوان سبير وند PN10','A',1,'N'),('N0765','جوان سبير وند PN16','A',1,'N'),('N0766','جوان سبير وند PN20','A',1,'N'),('N0767','جوان سبير وند PN40','A',1,'N'),('N0768','جوان داى اليكتريك','A',1,'N'),('N0769','جوان جلد','A',1,'N'),('N0770','جوان تيفلون','A',1,'N'),('N0771','جوان ارتيلون','A',1,'N'),('N0772','جوان ماسورة صرف','A',1,'N'),('N0773','كاوتش معرج','A',1,'N'),('N0774','لوح كاوتش','A',1,'N'),('N0775','لوح جرانجريت','A',1,'N'),('N0776','جوان حرف U كاوتش','A',1,'N'),('N0777','جلبة رولمان بلى H2305','A',1,'N'),('N0778','جلبة رولمان بلى H2307','A',1,'N'),('N0779','جلبة رولمان بلى H2310','A',1,'N'),('N0780','رولمان بلي 6005ZZ','A',1,'N'),('N0781','رولمان بلي 6313ZZ/C3','A',1,'N'),('N0782','رولمان بلي NACHI6005ZZ','A',1,'N'),('N0783','رولمان بلي NSK 6203','A',1,'N'),('N0784','رولمان بلي NSK 6205','A',1,'N'),('N0785','رولمان بلي NSK 6207','A',1,'N'),('N0786','رولمان بلي SIXF6209ZZ03','A',1,'N'),('N0787','رولمان بلي SKF 3206','A',1,'N'),('N0788','رولمان بلي SKF 5307','A',1,'N'),('N0789','رولمان بلي SKF 6202','A',1,'N'),('N0790','رولمان بلي SKF 6203','A',1,'N'),('N0791','رولمان بلي SKF 6204','A',1,'N'),('N0792','رولمان بلي SKF 6205','A',1,'N'),('N0793','رولمان بلي SKF 6206','A',1,'N'),('N0794','رولمان بلي SKF 6206 ZZ C3','A',1,'N'),('N0795','رولمان بلي SKF 6207','A',1,'N'),('N0796','رولمان بلي SKF 6208','A',1,'N'),('N0797','رولمان بلي SKF 6213','A',1,'N'),('N0798','رولمان بلي SKF 6303','A',1,'N'),('N0799','رولمان بلي SKF 6306','A',1,'N'),('N0800','رولمان بلي SKF 6307','A',1,'N'),('N0801','رولمان بلي SKF 630822C3','A',1,'N'),('N0802','رولمان بلي SKF 6309','A',1,'N'),('N0803','رولمان بلي SKF 6311','A',1,'N'),('N0804','رولمان بلي SKF 6313','A',1,'N'),('N0805','رولمان بلي SKF204ER','A',1,'N'),('N0806','رولمان بلي VRB6207','A',1,'N'),('N0807','رولمان بلي 6306ZZ C3FAG','A',1,'N'),('N0808','رولمان بلي FAC6209ZZ','A',1,'N'),('N0809','رولمان بلي FAG SIXF6209ZZC3','A',1,'N'),('N0810','رولمان بلي FAG3307ZZ','A',1,'N'),('N0811','رولمان بلي FAG6203ZZ','A',1,'N'),('N0812','رولمان بلي FAG6204ZZ','A',1,'N'),('N0813','رولمان بلي FAG6205ZZ','A',1,'N'),('N0814','رولمان بلي FAG6206ZZ','A',1,'N'),('N0815','رولمان بلي FAG6208ZZ','A',1,'N'),('N0816','رولمان بلي FAG6211ZZ','A',1,'N'),('N0817','رولمان بلي FAG6307ZZ','A',1,'N'),('N0818','رولمان بلي FAG6309ZZ','A',1,'N'),('N0819','رولمان بلي FAG6311ZZ','A',1,'N'),('N0820','رولمان بلي SA204','A',1,'N'),('N0821','رولمان بلي SA205','A',1,'N'),('N0822','رولمان بلي SA207','A',1,'N'),('N0823','رولمان بلى 186001','A',1,'N'),('N0824','رولمان بلى 186002','A',1,'N'),('N0825','رولمان بلى 186571','A',1,'N'),('N0826','رولمان بلى 186572','A',1,'N'),('N0827','رولمان بلي 205 مم','A',1,'N'),('N0828','رولمان بلي 2052 بالكاوتش','A',1,'N'),('N0829','رولمان بلي 25 مم','A',1,'N'),('N0830','رولمان بلى 2Z 6210','A',1,'N'),('N0831','رولمان بلي 3307BTVHC3 FAG','A',1,'N'),('N0832','رولمان بلي 6037','A',1,'N'),('N0833','رولمان بلي 6201','A',1,'N'),('N0834','رولمان بلى 6202-2/C3','A',1,'N'),('N0835','رولمان بلى 6206-2/C3','A',1,'N'),('N0836','رولمان بلى 6208 ZZ','A',1,'N'),('N0837','رولمان بلى 6311 ZZ','A',1,'N'),('N0838','رولمان بلي ASAHI KH205','A',1,'N'),('N0839','رولمان بلي DK24CA727FLANGE','A',1,'N'),('N0840','رولمان بلي FAG 6317C3','A',1,'N'),('N0841','رولمان بلى FAG 6305 ZZ','A',1,'N'),('N0842','رولمان بلى FAG 6306 ZZ','A',1,'N'),('N0843','رولمان بلى FAG 6308 ZZ','A',1,'N'),('N0844','رولمان بلى FAG 6309 ZZ','A',1,'N'),('N0845','رولمان بلى FAG 6312 ZZ','A',1,'N'),('N0846','رولمان بلى FAG 6313 ZZ','A',1,'N'),('N0847','رولمان بلي FAG ZRS 6310','A',1,'N'),('N0848','رولمان بلي FAG ZRS 6311','A',1,'N'),('N0849','رولمان بلي GN111KRRB','A',1,'N'),('N0850','رولمان بلي NM2309ECML/C3','A',1,'N'),('N0851','رولمان بلي NPP-BC - INA','A',1,'N'),('N0852','رولمان بلى SA 206','A',1,'N'),('N0853','رولمان بلي SA205NSK','A',1,'N'),('N0854','رولمان بلى SKF 6080','A',1,'N'),('N0855','رولمان بلى SkF 6209','A',1,'N'),('N0856','رولمان بلى skf 6211','A',1,'N'),('N0857','رولمان بلى SKF 6308','A',1,'N'),('N0858','رولمان بلى UC 207','A',1,'N'),('N0859','رولمان بلى UC 210','A',1,'N'),('N0860','رولمان بلى UK 205','A',1,'N'),('N0861','رولمان بلى UK 207','A',1,'N'),('N0862','رولمان بلي UK 207','A',1,'N'),('N0863','رولمان بلى UK 210','A',1,'N'),('N0864','رولمان بلي UK206','A',1,'N'),('N0865','رولمان بلي الماني 16208 SKF','A',1,'N'),('N0866','رولمان بلي بالاكس لوحدة دي اكس 240','A',1,'N'),('N0867','رولمان بلي بالكرسي NSK P204','A',1,'N'),('N0868','رولمان بليKOYO6204ZZ','A',1,'N'),('N0869','رومان بلي FYHSA205','A',1,'N'),('N0870','قاعدة رولمان بلي SA207','A',1,'N'),('N0871','كرس رولمان بلي P206','A',1,'N'),('N0872','كرس بالبلية 205SNR','A',1,'N'),('N0873','كرس بالبلية 206SNR','A',1,'N'),('N0874','كرس بالبلية 212SNR','A',1,'N'),('N0875','كرس بالبلية VPLE119BA64A','A',1,'N'),('N0876','كرسى بلاور بالبلية ASE06','A',1,'N'),('N0877','كرسي رولمان بلي P205','A',1,'N'),('N0878','كرسي رولمان بلي SK204','A',1,'N'),('N0879','فلانشة حديد عامية (طبة)','A',1,'N'),('N0880','فلانشة حديد','A',1,'N'),('N0881','فلانشة حديد يابانى استاندر','A',1,'N'),('N0882','فلانشة استانلس 316','A',1,'N'),('N0883','ترامل وصل','A',1,'N'),('N0884','ترامل كلبس','A',1,'N'),('N0885','ترامل شوكة','A',1,'N'),('N0886','ترامل ماسورة','A',1,'N'),('N0887','ترامل ماسورة دابل','A',1,'N'),('N0888','ترامل بنز','A',1,'N'),('N0889','ترامل سوكيت','A',1,'N'),('N0890','ترامل حلقة','A',1,'N'),('N0891','ترامل نهاية خط','A',1,'N'),('N0892','كوسة نحاس','A',1,'N'),('N0893','كوسةالمونيوم','A',1,'N'),('N0894','سرفيل المونيوم','A',1,'N'),('N0895','روزتة بسكوته','A',1,'N'),('N0896','روزتة عيون','A',1,'N'),('N0897','روزتة ماتور مسمار 8مم عدد 6 مسمار','A',1,'N'),('N0898','روزتة ماتور مسمار 6مم عدد 6 مسمار','A',1,'N'),('N0899','روزتة ماتور مسمار 6مم عدد 12 مسمار','A',1,'N'),('N0900','روزتة ماتور مسمار 6مم عدد 5 مسمار','A',1,'N'),('N0901','روزتة ماتور مسمار 10مم عدد 6 مسمار','A',1,'N'),('N0902','روزتة ماتور مسمار 4مم عدد 6 مسمار','A',1,'N'),('N0903','جلبة ماسورة كهرباء بلاستيك','A',1,'N'),('N0904','لاكور بواط على ماسورة كهرباء بلاستيك','A',1,'N'),('N0905','لاكور بواط على فليكسبل كهرباء بلاستيك','A',1,'N'),('N0906','جلبة ماسورة كهرباء صلب','A',1,'N'),('N0907','لاكور بواط على ماسورة كهرباء صلب','A',1,'N'),('N0908','لاكور بواط على فليكسبل كهرباء صلب','A',1,'N'),('N0909','كوع كهرباء بلاستيك','A',1,'N'),('N0910','كوع كهرباء صلب','A',1,'N'),('N0911','بواط كهرباء بلاستيك','A',1,'N'),('N0912','بواط كهرباء بلاستيك ووتر بروف','A',1,'N'),('N0913','بواط كهرباء بلاستيك دائرى حرف L','A',1,'N'),('N0914','بواط كهرباء بلاستيك دائرى 3مخرج حرف T','A',1,'N'),('N0915','بواط كهرباء بلاستيك دائرى حرف Y','A',1,'N'),('N0916','بواط كهرباء بلاستيك دائرى حرف U','A',1,'N'),('N0917','بواط كهرباء بلاستيك دائرى 6 سم 1 مخرج','A',1,'N'),('N0918','بواط كهرباء بلاستيك دائرى 6 سم 2 مخرج','A',1,'N'),('N0919','بواط كهرباء بلاستيك دائرى 6 سم 3 مخرج','A',1,'N'),('N0920','بواط كهرباء بلاستيك دائرى 6 سم 4 مخرج','A',1,'N'),('N0921','بواط كهرباء بلاستيك دائرى 6 سم مانع للمياة','A',1,'N'),('N0922','بواط كهرباء بلاستيك دائرى 7 سم مانع للمياة','A',1,'N'),('N0923','بواط كهرباء بلاستيك دائرى 7.5 سم مانع للمياة','A',1,'N'),('N0924','بواط كهرباء بلاستيك دائرى 8 سم مانع للمياة','A',1,'N'),('N0925','بواط كهرباء بلاستيك دائرى 9 سم مانع للمياة','A',1,'N'),('N0926','بواط كهرباء صاج','A',1,'N'),('N0927','بواط كهرباء صاج بالأرث','A',1,'N'),('N0928','فليكسبل حرارى','A',1,'N'),('N0929','فليكسبل معدن','A',1,'N'),('N0930','فليكسبل معدن معزول','A',1,'N'),('N0931','لاكور فليكسبل','A',1,'N'),('N0932','لاكور فليكسبل معدن','A',1,'N'),('N0933','لفة خراطيم بلاستيك','A',1,'N'),('N0934','افيز صلب (كورشية)','A',1,'N'),('N0935','افيز بلاستيك (كورشية) بدون قاعدة','A',1,'N'),('N0936','افيز بلاستيك (كورشية) بالقاعدة','A',1,'N'),('N0937','قاعدة افيز بلاستيك (كورشية)','A',1,'N'),('N0938','قاعدة بارة (زناتور)','A',1,'N'),('N0939','حزام بلاستيك','A',1,'N'),('N0940','حزام معدن','A',1,'N'),('N0941','جلاند نحاس','A',1,'N'),('N0942','جلاند نحاس S','A',1,'N'),('N0943','جلاند نحاس PG','A',1,'N'),('N0944','جلاند نحاس L','A',1,'N'),('N0945','جلاند نحاس M','A',1,'N'),('N0946','جلاند نحاس بالشيرود','A',1,'N'),('N0947','جلاند نحاس بالشيرود مسلح','A',1,'N'),('N0948','جلاند بلاستيك PG','A',1,'N'),('N0949','جلاند بلاستيك M','A',1,'N'),('N0950','جلاند استانلس PG','A',1,'N'),('N0951','فيوز','A',1,'N'),('N0952','ريكم','A',1,'N'),('N0953','ريكم ايرث','A',1,'N'),('N0954','مفتاح فصل على الحمل بلاستيك 2 بول','A',1,'N'),('N0955','مفتاح فصل على الحمل معدن 2 بول','A',1,'N'),('N0956','مفتاح فصل على الحمل معدن ضد الانفجار 2 بول','A',1,'N'),('N0957','مفتاح فصل على الحمل بلاستيك 3 بول','A',1,'N'),('N0958','مفتاح فصل على الحمل معدن 3 بول','A',1,'N'),('N0959','مفتاح فصل على الحمل معدن ضد الانفجار 3 بول','A',1,'N'),('N0960','مفتاح فصل على الحمل بلاستيك 4 بول','A',1,'N'),('N0961','مفتاح فصل على الحمل معدن 4 بول','A',1,'N'),('N0962','مفتاح فصل على الحمل معدن ضد الانفجار 4 بول','A',1,'N'),('N0963','مفتاح فصل على الحمل بلاستيك 6 بول','A',1,'N'),('N0964','مفتاح فصل على الحمل معدن 6 بول','A',1,'N'),('N0965','مفتاح فصل على الحمل معدن ضد الانفجار 6 بول','A',1,'N'),('N0966','قاطع 3 بول','A',1,'N'),('N0967','مفتاح احادى','A',1,'N'),('N0968','مفتاح ثنائى','A',1,'N'),('N0969','مفتاح ثلاثى','A',1,'N'),('N0970','مفتاح GV','A',1,'N'),('N0971','تراى بلاستيك مسمط','A',1,'N'),('N0972','تراى بلاستيك مفتوح','A',1,'N'),('N0973','كلبس مواسير كهرباء','A',1,'N'),('N0974','علبة ماجيك','A',1,'N'),('N0975','علبة ماجيك مجوز أفقى','A',1,'N'),('N0976','علبة ماجيك مجوز رأسى','A',1,'N'),('N0977','علبة مفتاح مفرد مانع للمياة','A',1,'N'),('N0978','علبة مفتاح مزدوج مانع للمياة','A',1,'N'),('N0979','علبة مفتاح لقمة مزدوجة باللقمة مانع للمياة','A',1,'N'),('N0980','علبة مفتاح سوكت شيكة مانع للمياة','A',1,'N'),('N0981','علبة مفتاح كهرباء بلاستيك احادى','A',1,'N'),('N0982','علبة مفتاح كهرباء بلاستيك 2خط','A',1,'N'),('N0983','علبة مفتاح كهرباء بلاستيك 3خط','A',1,'N'),('N0984','علبة مفتاح كهرباء بلاستيك 6خط','A',1,'N'),('N0985','علبة مفتاح مانعه للمياة','A',1,'N'),('N0986','علبة ليجراند 8فتحة ارضى','A',1,'N'),('N0987','علبة ليجراند 6فتحة ارضى','A',1,'N'),('N0988','علبة كابل داتا MK','A',1,'N'),('N0989','علبة داخل الحائط 2فتحة','A',1,'N'),('N0990','علبة داخل الحائط 4فتحة','A',1,'N'),('N0991','علبة داخل الحائط 6فتحة','A',1,'N'),('N0992','علبة بارزة 2 خط','A',1,'N'),('N0993','علبة ارضى 12 خط معدن','A',1,'N'),('N0994','علبة 3فتحة مستطيلة','A',1,'N'),('N0995','علبة 4فتحة مستطيلة','A',1,'N'),('N0996','علبة صاج بمفتاح سيلكتور يورك','A',1,'N'),('N0997','علبة تليميكانيك 2 فتحة','A',1,'N'),('N0998','بريزة حمراء','A',1,'N'),('N0999','بريزة داخل الحائط 2 فتحة','A',1,'N'),('n1','90°','G',1,'N'),('N1000','بريزة شوكة','A',1,'N'),('N1001','بريزة شوكة بريق ابيض','A',1,'N'),('N1002','بريزة ليجراند','A',1,'N'),('N1003','بريزة ليجراند مانع للمياة','A',1,'N'),('N1004','بريزة مانع للمياة داخل الحائط','A',1,'N'),('N1005','بريزة مجوفة شنيدر','A',1,'N'),('N1006','بريزة معلومات 8 خرم','A',1,'N'),('N1007','بريزة نت بريق','A',1,'N'),('N1008','بريزة نت شنيدر','A',1,'N'),('N1009','بريزة برتقالى','A',1,'N'),('N1010','بريزة شوكة ابيض T&J','A',1,'N'),('N1011','بريزة الرضى 3 بول','A',1,'N'),('N1012','بريزة الرضى 5 بول','A',1,'N'),('N1013','بريزة بريق ابيض','A',1,'N'),('N1014','بريز بلفارى','A',1,'N'),('N1015','بريزة تليفون 4 طرف','A',1,'N'),('N1016','فيشة كهرباء','A',1,'N'),('N1017','قاعدة حزام','A',1,'N'),('N1018','لقمة تليفون','A',1,'N'),('N1019','لقمة مفتاح سكة واحدة','A',1,'N'),('N1020','لقمة مفتاح سكتين','A',1,'N'),('N1021','لقمة نت','A',1,'N'),('N1022','مساطر كهرباء','A',1,'N'),('N1023','مسطرة مفتاح كهرباء','A',1,'N'),('N1024','مفتاح تليفون ابيض T&J','A',1,'N'),('N1025','مفتاح نت ابيض T&J','A',1,'N'),('N1026','مفتاح OF/ON','A',1,'N'),('N1027','مفتاح مولدن 100A /18ك وات','A',1,'N'),('N1028','مفتاح مروحة سرعات','A',1,'N'),('N1029','مفتاح كويل شنيدر','A',1,'N'),('N1030','مفتاح فيوز خزف 63 A','A',1,'N'),('N1031','مفتاح فيوز ثلاثى 10 A','A',1,'N'),('N1032','مفتاح فيوز 2 A','A',1,'N'),('N1033','مفتاح تشغيل ماكينة قلاووظ','A',1,'N'),('N1034','مفتاح بيتشينو خارج الحائط','A',1,'N'),('N1035','مفتاح مزدوج مانع للمياه','A',1,'N'),('N1036','مفتاح مانع للمياة 10 A','A',1,'N'),('N1037','مفتاح نت ليجراند ابيض','A',1,'N'),('N1038','مفتاح تليفون ليجراند ابيض','A',1,'N'),('N1039','مفتاح ديفاتير 10 A','A',1,'N'),('N1040','مفتاح جوس لبواط','A',1,'N'),('N1041','مفتاح بريق ابيض','A',1,'N'),('N1042','سدادة 1 فتحة','A',1,'N'),('N1043','سدادة كاوتش للوحات','A',1,'N'),('N1044','مفتاح سيلكتور 2 وضع','A',1,'N'),('N1045','مفتاح سيلكتور 3 وضع','A',1,'N'),('N1046','مفتاح سيلكتور 4 وضع','A',1,'N'),('N1047','مفتاح طوارىء','A',1,'N'),('N1048','مفتاح سرعات يورك','A',1,'N'),('N1049','مفتاح بامينج','A',1,'N'),('N1050','مفتاح ستارت','A',1,'N'),('N1051','وش مفتاح بريزة 1 فتحة','A',1,'N'),('N1052','وش مربع ابيض 1 فتحة','A',1,'N'),('N1053','وش مربع ابيض 2 فتحة','A',1,'N'),('N1054','وش مانع مياة 3 فتحة','A',1,'N'),('N1055','وش اسبوت ذهبى','A',1,'N'),('N1056','وش اسبوت ابيض','A',1,'N'),('N1057','وش اسود 3 فتحة','A',1,'N'),('N1058','وش شنايدر','A',1,'N'),('N1059','وش 4 فتحة','A',1,'N'),('N1060','وش 6 فتحة','A',1,'N'),('N1061','وش 1 فتحة مستطيل','A',1,'N'),('N1062','وش 2 فتحة مستطيل','A',1,'N'),('N1063','وش 3 فتحة مستطيل','A',1,'N'),('N1064','وش 3 فتحة مغنسيوم','A',1,'N'),('N1065','شاسية 2 فتحة مربع','A',1,'N'),('N1066','شاسية 3 فتحة','A',1,'N'),('N1067','شاسية 4 فتحة','A',1,'N'),('N1068','شاسية 6 فتحة','A',1,'N'),('N1069','شاسية شنيدر','A',1,'N'),('N1070','شاسية كهرباء بالوش','A',1,'N'),('N1071','شاسية سولت بيتشينو','A',1,'N'),('N1072','كشاف انارة شوارع 100وات','A',1,'N'),('N1073','كشاف ببواط 20 وات','A',1,'N'),('N1074','كشاف تراك مرن الحركة LIT-1100','A',1,'N'),('N1075','كشاف تراك معلق LIT-1600','A',1,'N'),('N1076','كشاف رأس','A',1,'N'),('N1077','كشاف سبوت لايت 6وات مضاد للمياة LIT-2500','A',1,'N'),('N1078','كشاف سبوت لايت بعدسة متحركة 9 وات مضاد للمياة LIT-2510','A',1,'N'),('N1079','كشاف سبوت لايت ثنائى LIT-5220','A',1,'N'),('N1080','كشاف سويدى','A',1,'N'),('N1081','كشاف عين بقرة','A',1,'N'),('N1082','كشاف كهرباء نصف كيلو','A',1,'N'),('N1083','كشاف كهرباء واحد كيلو','A',1,'N'),('N1084','كشاف كهرباء 1 لمبة','A',1,'N'),('N1085','كشاف كهرباء 2 لمبة','A',1,'N'),('N1086','كشاف ليد بروفيل 113سم LIT-SYSL55','A',1,'N'),('N1087','كشاف ليد مضاد للعوامل الجوية بطول 120سم LIT-7210','A',1,'N'),('N1088','كشاف ليد','A',1,'N'),('N1089','كشاف هاى باى تورس 400ميتال هاليد','A',1,'N'),('N1090','كشاف هايدرا الكترونى','A',1,'N'),('N1091','اسبوت ليد مربع ابيض 6 وات','A',1,'N'),('N1092','اسبوت ليد بريق مربع مصنفر ابيض','A',1,'N'),('N1093','راك','A',1,'N'),('N1094','باتش بانل بالمشتملات','A',1,'N'),('N1095','باتش كورد','A',1,'N'),('N1096','لمبة ليد 32وات','A',1,'N'),('N1097','لمبة ليد 42وات','A',1,'N'),('N1098','لمبة ليد 60وات','A',1,'N'),('n2','45°','G',1,'N'),('O01','تايلاند','F',1,'Y'),('O02','الصين','F',1,'Y'),('O03','اتحاد اوربى','F',1,'Y'),('O04','فيتنام','F',1,'Y'),('O05','ايطالىا','F',1,'Y'),('O06','ماليزيا','F',1,'Y'),('O07','تايوان','F',1,'Y'),('O08','روسىا','F',1,'Y'),('O09','اوكرانىا','F',1,'Y'),('O10','إنجلترا','F',1,'Y'),('O11','مصر','F',1,'Y'),('O12','السعودىة','F',1,'Y'),('O13','جنوب افريقيا','F',1,'Y'),('O14','كورىا','F',1,'Y'),('O15','المانىا','F',1,'Y'),('O16','اسبانىا','F',1,'Y'),('O17','تركىا','F',1,'Y'),('P01','1.5 hp','N',1,'N'),('P02','2.25 hp','N',1,'N'),('P03','3 hp','N',1,'N'),('P04','4 hp','N',1,'N'),('P05','5 hp','N',1,'N'),('P06','5.25 hp','N',1,'N'),('P07','6 hp','N',1,'N'),('P08','7.5 hp','N',1,'N'),('t001','3mm','K',1,'N'),('t002','4mm','K',1,'N'),('t003','6mm','K',1,'N'),('t004','5mm','K',1,'N'),('t005','7mm','K',1,'N'),('t006','8mm','K',1,'N'),('t007','10mm','K',1,'N'),('t008','9mm','K',1,'N'),('t009','11mm','K',1,'N'),('t010','12mm','K',1,'N'),('t011','13mm','K',1,'N'),('t012','14mm','K',1,'N'),('t013','15mm','K',1,'N'),('t014','16mm','K',1,'N'),('t015','18mm','K',1,'N'),('t016','20mm','K',1,'N'),('t017','17mm','K',1,'N'),('t018','19mm','K',1,'N'),('t019','24mm','K',1,'N'),('t020','28mm','K',1,'N'),('t021','1.5mm','K',1,'N'),('t023','25mm','K',1,'N'),('t024','40mm','K',1,'N'),('t025','50mm','K',1,'N'),('t026','60mm','K',1,'N'),('t027','65mm','K',1,'N'),('t028','3mmØ','K',1,'N'),('t029','6mmØ','K',1,'N'),('T1','10','E',1,'N'),('T2','20','E',1,'N'),('T3','40','E',1,'Y'),('T4','80','E',1,'Y'),('W001','10m','I',1,'N'),('W002','5mm','I',1,'N'),('W003','1/2mm','I',1,'N');
/*!40000 ALTER TABLE `ITEM_VARIABLE_VALUES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JOBS`
--

DROP TABLE IF EXISTS `JOBS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `JOBS` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name_en` varchar(100) NOT NULL,
  `job_name_ar` varchar(100) NOT NULL,
  `org_code` int(11) NOT NULL,
  PRIMARY KEY (`job_id`),
  KEY `fk_JOBS_ORGANIZATIONS1_idx` (`org_code`),
  CONSTRAINT `fk_JOBS_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JOBS`
--

LOCK TABLES `JOBS` WRITE;
/*!40000 ALTER TABLE `JOBS` DISABLE KEYS */;
INSERT INTO `JOBS` VALUES (3,'SSSSS','Testttttt',0),(4,'شششش','ششششش',0),(5,'Technician','Technician',0),(6,'Test','Test',0),(7,'Test1','Test1',0);
/*!40000 ALTER TABLE `JOBS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MNF_PROCESSES`
--

DROP TABLE IF EXISTS `MNF_PROCESSES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MNF_PROCESSES` (
  `mnf_prcs_id` varchar(8) NOT NULL,
  `mnf_prcs_name` varchar(200) NOT NULL,
  `has_action` varchar(2) DEFAULT 'N',
  `is_complex` varchar(2) DEFAULT 'N',
  `active` varchar(2) DEFAULT 'Y',
  `org_code` int(11) NOT NULL,
  PRIMARY KEY (`mnf_prcs_id`),
  KEY `fk_MANUFACTURING_PROCESSES_ORGANIZATIONS1_idx` (`org_code`),
  CONSTRAINT `fk_MANUFACTURING_PROCESSES_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MNF_PROCESSES`
--

LOCK TABLES `MNF_PROCESSES` WRITE;
/*!40000 ALTER TABLE `MNF_PROCESSES` DISABLE KEYS */;
INSERT INTO `MNF_PROCESSES` VALUES ('mnf0000','Process 000','N','N','Y',2),('mnf0001','Process 001','Y','N','N',2),('mnf0002','Process 002','Y','N','N',2),('mnf0003','Process 003','N','N','N',2);
/*!40000 ALTER TABLE `MNF_PROCESSES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MNF_PROCESS_INPUT_HR`
--

DROP TABLE IF EXISTS `MNF_PROCESS_INPUT_HR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MNF_PROCESS_INPUT_HR` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `mnf_prcs_id` varchar(8) NOT NULL,
  `job_id` int(11) NOT NULL,
  `duration` decimal(6,2) NOT NULL,
  `time_unit` varchar(2) NOT NULL,
  PRIMARY KEY (`seq`,`mnf_prcs_id`,`job_id`),
  KEY `fk_MANUFACTURE_PROCESS_INPUT_HR_JOBS1_idx` (`job_id`),
  KEY `fk_MANUFACTURE_PROCESS_INPUT_HR_MANUFACTURING_PROCESSES1_idx` (`mnf_prcs_id`),
  CONSTRAINT `fk_MANUFACTURE_PROCESS_INPUT_HR_JOBS1` FOREIGN KEY (`job_id`) REFERENCES `JOBS` (`job_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANUFACTURE_PROCESS_INPUT_HR_MANUFACTURING_PROCESSES1` FOREIGN KEY (`mnf_prcs_id`) REFERENCES `MNF_PROCESSES` (`mnf_prcs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MNF_PROCESS_INPUT_HR`
--

LOCK TABLES `MNF_PROCESS_INPUT_HR` WRITE;
/*!40000 ALTER TABLE `MNF_PROCESS_INPUT_HR` DISABLE KEYS */;
/*!40000 ALTER TABLE `MNF_PROCESS_INPUT_HR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MNF_PROCESS_INPUT_ITEMS`
--

DROP TABLE IF EXISTS `MNF_PROCESS_INPUT_ITEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MNF_PROCESS_INPUT_ITEMS` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `mnf_prcs_id` varchar(8) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `qty` decimal(9,2) NOT NULL,
  PRIMARY KEY (`seq`,`mnf_prcs_id`,`item_code`),
  KEY `fk_MANUFACTURE_PROCESS_INPUT_ITEMS_MANUFACTURING_PROCESSES1_idx` (`mnf_prcs_id`),
  KEY `fk_MANUFACTURE_PROCESS_INPUT_ITEMS_UNITS1_idx` (`unit_id`),
  KEY `fk_MANUFACTURE_PROCESS_INPUT_ITEMS_ITEMS_LIST1_idx` (`item_code`),
  CONSTRAINT `fk_MANUFACTURE_PROCESS_INPUT_ITEMS_ITEMS_LIST1` FOREIGN KEY (`item_code`) REFERENCES `ITEMS_LIST` (`item_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANUFACTURE_PROCESS_INPUT_ITEMS_MANUFACTURING_PROCESSES1` FOREIGN KEY (`mnf_prcs_id`) REFERENCES `MNF_PROCESSES` (`mnf_prcs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANUFACTURE_PROCESS_INPUT_ITEMS_UNITS1` FOREIGN KEY (`unit_id`) REFERENCES `UNITS` (`unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MNF_PROCESS_INPUT_ITEMS`
--

LOCK TABLES `MNF_PROCESS_INPUT_ITEMS` WRITE;
/*!40000 ALTER TABLE `MNF_PROCESS_INPUT_ITEMS` DISABLE KEYS */;
INSERT INTO `MNF_PROCESS_INPUT_ITEMS` VALUES (1,'mnf0000','I-10007',2,2.00);
/*!40000 ALTER TABLE `MNF_PROCESS_INPUT_ITEMS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MNF_PROCESS_OTHER_COSTS`
--

DROP TABLE IF EXISTS `MNF_PROCESS_OTHER_COSTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MNF_PROCESS_OTHER_COSTS` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `mnf_prcs_id` varchar(8) NOT NULL,
  `value` decimal(9,2) NOT NULL,
  `time_unit` varchar(2) NOT NULL,
  `curr_code` varchar(5) NOT NULL,
  PRIMARY KEY (`seq`,`mnf_prcs_id`),
  KEY `fk_MANUFACTURE_PROCESS_OTHER_COSTS_MANUFACTURING_PROCESSES1_idx` (`mnf_prcs_id`),
  KEY `fk_MANUFACTURE_PROCESS_OTHER_COSTS_CURRENCIES1_idx` (`curr_code`),
  CONSTRAINT `fk_MANUFACTURE_PROCESS_OTHER_COSTS_CURRENCIES1` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANUFACTURE_PROCESS_OTHER_COSTS_MANUFACTURING_PROCESSES1` FOREIGN KEY (`mnf_prcs_id`) REFERENCES `MNF_PROCESSES` (`mnf_prcs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MNF_PROCESS_OTHER_COSTS`
--

LOCK TABLES `MNF_PROCESS_OTHER_COSTS` WRITE;
/*!40000 ALTER TABLE `MNF_PROCESS_OTHER_COSTS` DISABLE KEYS */;
/*!40000 ALTER TABLE `MNF_PROCESS_OTHER_COSTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MNF_PROCESS_OUTPUT_ITEMS`
--

DROP TABLE IF EXISTS `MNF_PROCESS_OUTPUT_ITEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MNF_PROCESS_OUTPUT_ITEMS` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `mnf_prcs_id` varchar(8) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `qty` decimal(9,2) NOT NULL,
  PRIMARY KEY (`seq`,`mnf_prcs_id`,`item_code`),
  KEY `fk_MANUFACTURE_PROCESS_OUTPUT_UNITS1_idx` (`unit_id`),
  KEY `fk_MANUFACTURE_PROCESS_OUTPUT_MANUFACTURING_PROCESSES1` (`mnf_prcs_id`),
  KEY `fk_MANUFACTURE_PROCESS_OUTPUT_ITEMS_LIST1_idx` (`item_code`),
  CONSTRAINT `fk_MANUFACTURE_PROCESS_OUTPUT_ITEMS_LIST1` FOREIGN KEY (`item_code`) REFERENCES `ITEMS_LIST` (`item_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANUFACTURE_PROCESS_OUTPUT_MANUFACTURING_PROCESSES1` FOREIGN KEY (`mnf_prcs_id`) REFERENCES `MNF_PROCESSES` (`mnf_prcs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANUFACTURE_PROCESS_OUTPUT_UNITS1` FOREIGN KEY (`unit_id`) REFERENCES `UNITS` (`unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MNF_PROCESS_OUTPUT_ITEMS`
--

LOCK TABLES `MNF_PROCESS_OUTPUT_ITEMS` WRITE;
/*!40000 ALTER TABLE `MNF_PROCESS_OUTPUT_ITEMS` DISABLE KEYS */;
INSERT INTO `MNF_PROCESS_OUTPUT_ITEMS` VALUES (1,'mnf0000','I-10001',2,1.00),(2,'mnf0000','I-10002',4,2.00);
/*!40000 ALTER TABLE `MNF_PROCESS_OUTPUT_ITEMS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MNF_PROCESS_STRUCTURE`
--

DROP TABLE IF EXISTS `MNF_PROCESS_STRUCTURE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MNF_PROCESS_STRUCTURE` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `mnf_prcs_id` varchar(8) NOT NULL,
  `prnt_mnf_prcs_id1` varchar(8) DEFAULT NULL,
  `active` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`seq`,`mnf_prcs_id`),
  KEY `fk_MANUFACTURE_PROCESS_STRUCTURE_MANUFACTURING_PROCESSES1_idx` (`mnf_prcs_id`),
  KEY `fk_MANUFACTURE_PROCESS_STRUCTURE_MANUFACTURING_PROCESSES2_idx` (`prnt_mnf_prcs_id1`),
  CONSTRAINT `fk_MANUFACTURE_PROCESS_STRUCTURE_MANUFACTURING_PROCESSES1` FOREIGN KEY (`mnf_prcs_id`) REFERENCES `MNF_PROCESSES` (`mnf_prcs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANUFACTURE_PROCESS_STRUCTURE_MANUFACTURING_PROCESSES2` FOREIGN KEY (`prnt_mnf_prcs_id1`) REFERENCES `MNF_PROCESSES` (`mnf_prcs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MNF_PROCESS_STRUCTURE`
--

LOCK TABLES `MNF_PROCESS_STRUCTURE` WRITE;
/*!40000 ALTER TABLE `MNF_PROCESS_STRUCTURE` DISABLE KEYS */;
INSERT INTO `MNF_PROCESS_STRUCTURE` VALUES (5,'mnf0000',NULL,NULL),(8,'mnf0001','mnf0000',NULL),(9,'mnf0003','mnf0000',NULL),(10,'mnf0001',NULL,NULL);
/*!40000 ALTER TABLE `MNF_PROCESS_STRUCTURE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORGANIZATIONS`
--

DROP TABLE IF EXISTS `ORGANIZATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORGANIZATIONS` (
  `org_code` int(11) NOT NULL,
  `en_org_name` varchar(100) NOT NULL,
  `ar_org_name` varchar(100) NOT NULL,
  `prnt_org_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`org_code`),
  KEY `fk_ORGANIZATIONS_ORGANIZATIONS1_idx` (`prnt_org_code`),
  CONSTRAINT `fk_ORGANIZATIONS_ORGANIZATIONS1` FOREIGN KEY (`prnt_org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORGANIZATIONS`
--

LOCK TABLES `ORGANIZATIONS` WRITE;
/*!40000 ALTER TABLE `ORGANIZATIONS` DISABLE KEYS */;
INSERT INTO `ORGANIZATIONS` VALUES (0,'home','إليكون',NULL),(1,'Zamzam','زمزم',0),(2,'Elecon','إليكون',0),(3,'Elecon Services','إليكون للخدمات',0),(11,'Finanace','المالية',1),(12,'Account Payables','?????? ??????',11),(13,'Stores','???????',11);
/*!40000 ALTER TABLE `ORGANIZATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORG_USERS`
--

DROP TABLE IF EXISTS `ORG_USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORG_USERS` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(13) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `pswrd` varchar(128) DEFAULT NULL,
  `otp` varchar(128) DEFAULT NULL,
  `frm_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORG_USERS`
--

LOCK TABLES `ORG_USERS` WRITE;
/*!40000 ALTER TABLE `ORG_USERS` DISABLE KEYS */;
INSERT INTO `ORG_USERS` VALUES (0,'Mostafa','Moawad','mostafa.moawad@elecon-eg.com','0100000000','','123456','KKtTpfixw7Y77ReoPzvejr5DySLLxCv7OWt0CAdBBYRk5JOkVXIwPoXy8zJzN26jTDG6InGQmfDh7Ng83QP00l5nfzyRRidTnc3TBzAb3qg2rQtUvroGMVfid4PlgoVU','2023-04-21 08:08:19',NULL),(1,'Mohamed','Moawad','mo.moawad@gmail.com','0120000000','','123456','cJ8w20nqn1ZlyQkSfzsZH0EBTZajNIyqHOziwOJSQLTrUsbn9LrCD2qijs2hmpiJmU8wIMM0c2lAQJpqGEZN9bWQLvxuurzwlKkg4K4HdbQKrFPa4iwyjA96ZLVAP2iE','2023-04-21 08:08:19','2023-05-01 00:00:00'),(1692157844,'TTT','TTTT','TTT@yopmail.com',NULL,NULL,'123456','pLiOSBi3VpIf4gfuhCAmv02HkRuPreEuJBl143wrBVVxubKlyKmijrCjDPyqDYQSFcaUKUhpKbdn8Hoxwf7YiV2BHXIR3GVoz1vYJvDL9JsOYa76JrlQGxIJK4nUdBMD','2023-08-16 00:00:00',NULL),(1692160899,'XXX','XXX','XXX@yopmail.com',NULL,NULL,'123456',NULL,'2023-08-16 00:00:00',NULL),(1699283370,'yyy','yyy','yyy@yopmail.com',NULL,NULL,NULL,NULL,'2023-11-06 00:00:00',NULL);
/*!40000 ALTER TABLE `ORG_USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PERMISSIONS`
--

DROP TABLE IF EXISTS `PERMISSIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PERMISSIONS` (
  `fncn_id` varchar(5) NOT NULL,
  `role_group_id` int(11) NOT NULL,
  `system_id` varchar(3) NOT NULL,
  PRIMARY KEY (`role_group_id`,`system_id`,`fncn_id`),
  KEY `fk_PRIVILEGES_SYSTEM_FNCTNS1_idx` (`fncn_id`),
  KEY `fk_PERMISSIONS_ROLES1_idx` (`role_group_id`,`system_id`),
  CONSTRAINT `fk_PERMISSIONS_ROLES1` FOREIGN KEY (`role_group_id`, `system_id`) REFERENCES `ROLES` (`role_group_id`, `system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRIVILEGES_SYSTEM_FNCTNS1` FOREIGN KEY (`fncn_id`) REFERENCES `SYSTEM_FNCTNS` (`fncn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PERMISSIONS`
--

LOCK TABLES `PERMISSIONS` WRITE;
/*!40000 ALTER TABLE `PERMISSIONS` DISABLE KEYS */;
INSERT INTO `PERMISSIONS` VALUES ('ACS01',0,'ACS'),('ACS02',0,'ACS'),('ACS03',0,'ACS'),('ACS04',0,'ACS'),('ACS05',0,'ACS'),('ACS06',0,'ACS'),('ACS07',0,'ACS'),('ACS08',0,'ACS'),('ADM01',0,'ADM'),('ADM02',0,'ADM'),('APY01',0,'APY'),('APY02',0,'APY'),('ARC01',0,'ARC'),('ARC02',0,'ARC'),('GL001',0,'GL'),('GL002',0,'GL'),('GL003',0,'GL'),('GL004',0,'GL'),('GL005',0,'GL'),('GL006',0,'GL'),('GL007',0,'GL'),('GL008',0,'GL'),('HCM01',0,'HCM'),('HCM02',0,'HCM'),('HCM03',0,'HCM'),('HCM04',0,'HCM'),('HCM05',0,'HCM'),('INV01',0,'INV'),('INV02',0,'INV'),('INV03',0,'INV'),('INV04',0,'INV'),('INV05',0,'INV'),('INV06',0,'INV'),('INV07',0,'INV'),('MNF01',0,'MNF'),('MNF02',0,'MNF'),('MNF03',0,'MNF'),('PRM01',0,'PRM'),('PRM02',0,'PRM'),('PRM03',0,'PRM'),('PRM04',0,'PRM'),('PRM05',0,'PRM'),('PRM06',0,'PRM'),('PRM07',0,'PRM'),('PTC01',0,'PTC'),('PTC02',0,'PTC'),('PTC03',0,'PTC'),('PUR01',0,'PUR'),('PUR02',0,'PUR'),('PUR03',0,'PUR'),('PUR04',0,'PUR'),('PUR05',0,'PUR'),('PUR06',0,'PUR'),('PUR07',0,'PUR'),('PUR08',0,'PUR'),('PUR09',0,'PUR'),('SLS01',0,'SLS'),('SLS02',0,'SLS'),('SLS03',0,'SLS'),('SLS04',0,'SLS'),('SLS05',0,'SLS'),('SLS06',0,'SLS'),('SLS07',0,'SLS'),('ACS01',1,'ACS'),('ACS02',1,'ACS'),('ACS03',1,'ACS'),('ACS04',1,'ACS'),('ACS05',1,'ACS'),('ACS06',1,'ACS'),('ACS07',1,'ACS'),('ACS08',1,'ACS'),('ADM01',1,'ADM'),('ADM02',1,'ADM'),('APY01',1,'APY'),('APY02',1,'APY'),('ARC01',1,'ARC'),('ARC02',1,'ARC'),('ASS01',1,'ASS'),('ASS02',1,'ASS'),('ASS03',1,'ASS'),('GL001',1,'GL'),('GL002',1,'GL'),('GL003',1,'GL'),('GL004',1,'GL'),('GL005',1,'GL'),('GL006',1,'GL'),('GL007',1,'GL'),('GL008',1,'GL'),('HCM01',1,'HCM'),('HCM02',1,'HCM'),('HCM03',1,'HCM'),('HCM04',1,'HCM'),('HCM05',1,'HCM'),('INV01',1,'INV'),('INV02',1,'INV'),('INV03',1,'INV'),('INV04',1,'INV'),('INV05',1,'INV'),('INV06',1,'INV'),('INV07',1,'INV'),('MNF01',1,'MNF'),('MNF02',1,'MNF'),('MNF03',1,'MNF'),('PTC01',1,'PTC'),('PTC02',1,'PTC'),('PTC03',1,'PTC'),('PUR01',1,'PUR'),('PUR02',1,'PUR'),('PUR03',1,'PUR'),('PUR04',1,'PUR'),('PUR05',1,'PUR'),('PUR06',1,'PUR'),('PUR07',1,'PUR'),('PUR08',1,'PUR'),('PUR09',1,'PUR'),('SLS01',1,'SLS'),('SLS02',1,'SLS'),('SLS03',1,'SLS'),('SLS04',1,'SLS'),('SLS05',1,'SLS'),('SLS06',1,'SLS'),('SLS07',1,'SLS'),('ACS01',1691319193,'ACS'),('ACS06',1691319193,'ACS'),('ADM01',1691319193,'ADM'),('ADM02',1691319193,'ADM'),('SLS06',1691319193,'SLS'),('INV03',1697664172,'INV');
/*!40000 ALTER TABLE `PERMISSIONS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`localhost`*/ /*!50003 TRIGGER `Elecon`.`PERMISSIONS_AFTER_INSERT` AFTER INSERT ON `PERMISSIONS` FOR EACH ROW
BEGIN
-- Insert into USER_ROLES Master Table
insert into USER_ROLES (role_group_id,system_id,user_id)
select new.role_group_id,new.system_id, user_id
from USER_ROLES_MASTER where role_group_id = new.role_group_id
and new.system_id not in(select system_id from USER_ROLES 
where USER_ROLES.user_id = USER_ROLES_MASTER.user_id
and USER_ROLES.role_group_id = USER_ROLES_MASTER.role_group_id);

-- Insert into USER_PERMISSIONS Table
insert into USER_PERMISSIONS (role_group_id,system_id,fncn_id,user_id)
select new.role_group_id,new.system_id,new.fncn_id,user_id  
from USER_ROLES_MASTER where role_group_id = new.role_group_id
and concat(new.system_id,new.fncn_id) not in(select concat(system_id,fncn_id) from USER_PERMISSIONS 
where USER_PERMISSIONS.user_id = USER_ROLES_MASTER.user_id
and USER_PERMISSIONS.role_group_id = USER_ROLES_MASTER.role_group_id
and USER_PERMISSIONS.fncn_id = new.fncn_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`localhost`*/ /*!50003 TRIGGER `Elecon`.`PERMISSIONS_BEFORE_DELETE`
BEFORE DELETE ON `Elecon`.`PERMISSIONS`
FOR EACH ROW
BEGIN
delete from USER_PERMISSIONS 
	where fncn_id = old.fncn_id 
    and system_id = old.system_id
    and role_group_id = old.role_group_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PROJECTS_MAST`
--

DROP TABLE IF EXISTS `PROJECTS_MAST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROJECTS_MAST` (
  `proj_id` int(11) NOT NULL AUTO_INCREMENT,
  `proj_code` varchar(45) NOT NULL,
  `proj_name` varchar(200) DEFAULT NULL,
  `cust_id` int(11) NOT NULL,
  `selected` varchar(2) DEFAULT NULL,
  `version_no` int(11) NOT NULL,
  `proj_dt` datetime DEFAULT NULL,
  `overhead_perc` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`proj_id`,`version_no`),
  KEY `fk_PROJECTS_MAST_CUSTOMERS1_idx` (`cust_id`),
  CONSTRAINT `fk_PROJECTS_MAST_CUSTOMERS1` FOREIGN KEY (`cust_id`) REFERENCES `CUSTOMERS` (`cust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROJECTS_MAST`
--

LOCK TABLES `PROJECTS_MAST` WRITE;
/*!40000 ALTER TABLE `PROJECTS_MAST` DISABLE KEYS */;
INSERT INTO `PROJECTS_MAST` VALUES (1,'P001','Project One One One One One One One One One One',4,NULL,0,'2024-07-01 00:00:00',10.00),(1,'P001','Project One One One One One One One One One One',4,'',1,'2024-07-01 00:00:00',0.00),(1,'P001','Project One One One One One One One One One One',4,'',2,'2024-07-01 00:00:00',22.00),(2,'P002','School',2,NULL,0,'2024-12-03 00:00:00',10.00),(3,'P003','Project Three Three Three Three Three ',3,NULL,0,'2024-12-01 00:00:00',NULL);
/*!40000 ALTER TABLE `PROJECTS_MAST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROJECT_SECTIONS`
--

DROP TABLE IF EXISTS `PROJECT_SECTIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROJECT_SECTIONS` (
  `proj_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL AUTO_INCREMENT,
  `section_name` varchar(2000) DEFAULT NULL,
  `section_code` varchar(45) NOT NULL,
  `prnt_section_id` int(11) DEFAULT NULL,
  `version_no` int(11) NOT NULL,
  `qty` decimal(7,2) DEFAULT '1.00',
  `specific_perc` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`section_id`),
  UNIQUE KEY `proj_grp_code_UNIQUE` (`section_code`),
  KEY `fk_PROJECT_SECTION_PROJECT_SECTION1_idx` (`prnt_section_id`),
  KEY `fk_PROJECT_SECTION_PROJECTS_MAST1_idx` (`proj_id`,`version_no`),
  CONSTRAINT `fk_PROJECT_SECTION_PROJECTS_MAST1` FOREIGN KEY (`proj_id`, `version_no`) REFERENCES `PROJECTS_MAST` (`proj_id`, `version_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECT_SECTION_PROJECT_SECTION1` FOREIGN KEY (`prnt_section_id`) REFERENCES `PROJECT_SECTIONS` (`section_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1735989070 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROJECT_SECTIONS`
--

LOCK TABLES `PROJECT_SECTIONS` WRITE;
/*!40000 ALTER TABLE `PROJECT_SECTIONS` DISABLE KEYS */;
INSERT INTO `PROJECT_SECTIONS` VALUES (1,1038,'chiller','sec1',NULL,0,3.00,0.00),(1,1039,'Section 1-1','sec1-1',1038,0,2.25,0.00),(1,1040,'Test for Mostafa','sec1-2',1038,0,1.00,0.00),(1,1042,'rrrrr','sec1-3',1038,0,2.00,0.00),(1,1043,'ooooo','iii',NULL,0,2.00,10.00),(1,1046,'Test','iii-1',1043,0,2.00,0.00),(1,1047,'aaaaa','aaa',NULL,0,1.00,0.00),(1,1048,'version 1-section1','ver.1',NULL,1,1.00,5.00),(1,1049,'ver2_sec1 ver2_sec1 ver2_sec1','ver2_sec1',NULL,2,2.00,0.00),(1,1050,'ver1-1','ver1-1',NULL,1,2.00,5.00),(1,1052,'AAA','AA',NULL,1,1.00,4.00),(1,1734773716,'secAA-1','secAA-1',1052,1,1.00,0.00),(2,1735473122,'Electrical','s_1',NULL,0,0.00,0.00),(2,1735477055,'HVAC','s_2',NULL,0,1.00,0.00),(2,1735477070,'Fire Fighting','s_3',NULL,0,2.00,5.00),(2,1735477184,'Basement','s_31',1735477070,0,2.00,0.00),(2,1735723557,'S4444444444444444444','s4',NULL,0,1.00,0.00),(2,1735742158,'s3222222222222222222222222','s32',1735477070,0,1.00,0.00),(2,1735742279,'s41111111111111111111111111','s41',1735723557,0,1.00,0.00),(2,1735749380,'s4444444444444444444444444','s44',1735723557,0,1.00,0.00),(2,1735986095,'s11','s11',1735473122,0,0.00,0.00),(1,1735988628,'AA1','AA1',1052,1,2.00,0.00),(3,1735989069,'sec1','sec1-1000',NULL,0,1.00,0.00);
/*!40000 ALTER TABLE `PROJECT_SECTIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROJECT_SECTION_ITEMS`
--

DROP TABLE IF EXISTS `PROJECT_SECTION_ITEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROJECT_SECTION_ITEMS` (
  `section_id` int(11) NOT NULL,
  `section_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_code` varchar(100) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `foreign_unit_cost` decimal(12,3) DEFAULT NULL,
  `supp_discount_perc` decimal(5,2) DEFAULT '0.00',
  `customs_perc` decimal(7,5) DEFAULT '0.00000',
  `prnt_section_item_id` int(11) DEFAULT NULL,
  `curr_code` varchar(5) DEFAULT NULL,
  `customer_disc` decimal(3,0) DEFAULT NULL,
  `sales_tax_perc` decimal(5,2) DEFAULT '0.00',
  `local_unit_cost` decimal(12,3) DEFAULT NULL,
  `subsection_or_item` varchar(2) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `qty` decimal(7,2) DEFAULT NULL,
  `unit_cost` decimal(12,3) DEFAULT '0.000',
  `total_cost` decimal(12,3) DEFAULT NULL,
  PRIMARY KEY (`section_item_id`),
  KEY `fk_PROJECT_SECTION_ITEMS_ITEMS_LIST1_idx` (`item_code`),
  KEY `fk_PROJECT_SECTION_ITEMS_PROJECT_SECTION_ITEMS1_idx` (`prnt_section_item_id`),
  KEY `fk_PROJECT_SECTION_ITEMS_CURRENCIES1_idx` (`curr_code`),
  KEY `fk_PROJECT_SECTION_ITEMS_PROJECT_SECTIONS1_idx` (`section_id`),
  KEY `fk_PROJECT_SECTION_ITEMS_UNITS1_idx` (`unit_id`),
  CONSTRAINT `fk_PROJECT_SECTION_ITEMS_CURRENCIES1` FOREIGN KEY (`curr_code`) REFERENCES `CURRENCIES` (`curr_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECT_SECTION_ITEMS_ITEMS_LIST1` FOREIGN KEY (`item_code`) REFERENCES `ITEMS_LIST` (`item_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECT_SECTION_ITEMS_PROJECT_SECTIONS1` FOREIGN KEY (`section_id`) REFERENCES `PROJECT_SECTIONS` (`section_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECT_SECTION_ITEMS_PROJECT_SECTION_ITEMS1` FOREIGN KEY (`prnt_section_item_id`) REFERENCES `PROJECT_SECTION_ITEMS` (`section_item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECT_SECTION_ITEMS_UNITS1` FOREIGN KEY (`unit_id`) REFERENCES `UNITS` (`unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1735988670 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROJECT_SECTION_ITEMS`
--

LOCK TABLES `PROJECT_SECTION_ITEMS` WRITE;
/*!40000 ALTER TABLE `PROJECT_SECTION_ITEMS` DISABLE KEYS */;
INSERT INTO `PROJECT_SECTION_ITEMS` VALUES (1039,1732972811,'I-10',NULL,NULL,10.00,2.50000,NULL,'EGP',0,3.00,95.018,'I',1,10.00,100.000,950.180),(1039,1732976487,'I-10008',NULL,NULL,0.02,0.00000,NULL,'EGP',0,3.00,57.668,'I',4,6.00,56.000,288.340),(1039,1732976872,NULL,'AAAAAAAAAAAA',NULL,0.03,0.00000,NULL,'AED',0,2.10,110.235,'S',2,12.00,108.000,1322.820),(1040,1732988437,NULL,'BBBBBBBBBBBBBB',NULL,0.00,1.00000,NULL,'RON',0,0.00,121.200,'S',3,2.30,120.000,NULL),(1039,1733627768,'I-10005',NULL,NULL,1.50,2.30000,NULL,'THB',0,1.20,78.521,'I',4,10.00,77.000,785.210),(1042,1733854388,NULL,'XXXXXXXXXXXXX',NULL,0.00,0.00000,NULL,'BHD',0,0.00,500.000,'S',2,5.00,500.000,2500.000),(1047,1733854426,'I-100',NULL,NULL,10.00,20.00000,NULL,'EGP',0,30.00,292.032,'I',6,25.00,208.000,7300.800),(1046,1733922606,'I-10004',NULL,NULL,1.00,2.00000,NULL,'EGP',0,3.00,15.601,'I',4,50.00,15.000,780.050),(1047,1733955005,NULL,'SSSS',NULL,0.00,0.00000,NULL,'BND',0,0.00,0.000,'S',4,2.00,0.000,0.000),(1047,1734001414,'I-10006',NULL,NULL,1.00,2.00000,1733955005,'EGP',0,3.00,156.014,'I',1,2.00,150.000,312.028),(1047,1734001557,NULL,'DDDDDDDDDDD',NULL,1.00,2.00000,1733955005,'THB',0,3.00,127.932,'S',2,1.00,123.000,127.932),(1048,1734542353,'I-10',NULL,NULL,1.50,2.50000,NULL,'EGP',0,3.50,47.023,'I',1,5.00,45.000,235.115),(1048,1734542640,NULL,'Version 1111111111111111',NULL,4.50,5.00000,NULL,'XOF',0,16.00,116.319,'S',2,12.00,100.000,1395.828),(1049,1734717493,'I-100',NULL,NULL,1.00,2.00000,NULL,'BND',0,3.00,52.005,'I',5,2.00,50.000,104.010),(1048,1734721719,NULL,'Version 11111100000000000',NULL,1.00,2.00000,NULL,'BOB',0,3.00,104.009,'S',4,10.00,100.000,1040.090),(1050,1734723196,NULL,'ver1-1',NULL,1.00,2.00000,NULL,'XOF',0,5.00,212.058,'S',4,1.00,200.000,212.058),(1734773716,1734773758,NULL,'secAA-1_G1',NULL,0.00,0.00000,NULL,'BHD',0,0.00,10.000,'S',3,1.00,10.000,10.000),(1050,1734793308,NULL,NULL,NULL,0.00,0.00000,NULL,NULL,0,0.00,0.000,'S',NULL,0.00,0.000,0.000),(1047,1734799712,NULL,'WWWwwwww',NULL,0.00,0.00000,NULL,'BWP',0,0.00,0.000,'S',4,1.00,0.000,0.000),(1050,1734827268,NULL,NULL,NULL,0.00,0.00000,NULL,NULL,0,0.00,0.000,'S',NULL,0.00,0.000,0.000),(1049,1735376835,'I-10000',NULL,NULL,1.50,0.20000,NULL,'EGP',0,0.30,14.849,'I',1,2.00,15.000,29.698),(1735477184,1735477424,'I-1',NULL,NULL,0.00,0.00000,NULL,'EGP',0,0.00,0.000,'I',NULL,1.00,0.000,0.000),(1735477184,1735477897,NULL,'Text Text ',NULL,0.00,0.00000,1735477424,'EGP',0,0.00,20.000,'S',4,2.00,20.000,40.000),(1735477184,1735477958,NULL,'Main Text',NULL,1.00,2.00000,NULL,'EGP',0,3.00,260.024,'S',NULL,5.00,250.000,1300.120),(1735477184,1735478136,NULL,'Second Main Text\n',NULL,0.00,0.00000,NULL,NULL,0,0.00,0.000,'S',NULL,0.00,0.000,0.000),(1735477184,1735478165,'I-10001',NULL,NULL,0.00,0.00000,NULL,'EGP',0,0.00,400.000,'I',4,1.00,400.000,400.000),(1735477055,1735741016,NULL,'sssssssssssssssss',NULL,0.00,0.00000,NULL,'EGP',0,0.00,100.000,'S',3,10.00,100.000,1000.000),(1735742158,1735742185,NULL,'wwwwwwwwwww',NULL,0.00,0.00000,NULL,'EGP',0,0.00,500.000,'S',NULL,1.00,500.000,500.000),(1735742279,1735742379,NULL,'sssssssssssssssssssssssssss',NULL,0.00,0.00000,NULL,'EGP',0,0.00,150.000,'S',3,3.00,150.000,450.000),(1735749380,1735749420,NULL,'S44444444444444444444444444444444',NULL,0.00,0.00000,NULL,'EGP',0,0.00,50.000,'S',NULL,5.00,50.000,250.000),(1735988628,1735988669,'I-10001',NULL,NULL,1.00,2.00000,NULL,'EGP',0,3.00,5.200,'I',4,2.00,5.000,10.400);
/*!40000 ALTER TABLE `PROJECT_SECTION_ITEMS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`localhost`*/ /*!50003 TRIGGER `Elecon`.`PROJECT_SECTION_ITEMS_BEFORE_INSERT` BEFORE INSERT ON `PROJECT_SECTION_ITEMS` FOR EACH ROW
BEGIN
set new.local_unit_cost = ((new.unit_cost-(new.unit_cost*new.supp_discount_perc/100))*(1+(new.customs_perc/100)))*(1+(new.sales_tax_perc/100));
 set new.total_cost = new.local_unit_cost * new.qty;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`localhost`*/ /*!50003 TRIGGER `Elecon`.`PROJECT_SECTION_ITEMS_BEFORE_UPDATE` BEFORE UPDATE ON `PROJECT_SECTION_ITEMS` FOR EACH ROW
BEGIN
set new.local_unit_cost = ((new.unit_cost-(new.unit_cost*new.supp_discount_perc/100))*(1+(new.customs_perc/100)))*(1+(new.sales_tax_perc/100));
 set new.total_cost = new.local_unit_cost * new.qty;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PUR_TRANS_TYPES`
--

DROP TABLE IF EXISTS `PUR_TRANS_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PUR_TRANS_TYPES` (
  `pur_trans_type_code` int(11) NOT NULL AUTO_INCREMENT,
  `pur_trans_name_a` varchar(200) DEFAULT NULL,
  `pur_trans_name_e` varchar(200) DEFAULT NULL,
  `pur_trans_type` varchar(2) DEFAULT NULL,
  `active` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`pur_trans_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PUR_TRANS_TYPES`
--

LOCK TABLES `PUR_TRANS_TYPES` WRITE;
/*!40000 ALTER TABLE `PUR_TRANS_TYPES` DISABLE KEYS */;
/*!40000 ALTER TABLE `PUR_TRANS_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ROLES`
--

DROP TABLE IF EXISTS `ROLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ROLES` (
  `role_group_id` int(11) NOT NULL,
  `system_id` varchar(3) NOT NULL,
  PRIMARY KEY (`role_group_id`,`system_id`),
  KEY `fk_ROLE_SYSTEMS_ROLES1_idx` (`role_group_id`),
  KEY `fk_ROLE_SYSTEMS_SYSTEMS1_idx` (`system_id`),
  CONSTRAINT `fk_ROLE_SYSTEMS_ROLES1` FOREIGN KEY (`role_group_id`) REFERENCES `ROLE_MASTER` (`role_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ROLE_SYSTEMS_SYSTEMS1` FOREIGN KEY (`system_id`) REFERENCES `SYSTEMS` (`system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ROLES`
--

LOCK TABLES `ROLES` WRITE;
/*!40000 ALTER TABLE `ROLES` DISABLE KEYS */;
INSERT INTO `ROLES` VALUES (0,'ACS'),(0,'ADM'),(0,'APY'),(0,'ARC'),(0,'CRM'),(0,'DSH'),(0,'GL'),(0,'HCM'),(0,'INV'),(0,'MNF'),(0,'PRM'),(0,'PTC'),(0,'PUR'),(0,'SLS'),(0,'TOC'),(1,'ACS'),(1,'ADM'),(1,'APY'),(1,'ARC'),(1,'ASS'),(1,'CRM'),(1,'DSH'),(1,'GL'),(1,'HCM'),(1,'INV'),(1,'MNF'),(1,'PTC'),(1,'PUR'),(1,'SLS'),(1691319193,'ACS'),(1691319193,'ADM'),(1691319193,'SLS'),(1697664172,'INV');
/*!40000 ALTER TABLE `ROLES` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'PIPES_AS_CONCAT' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`%`*/ /*!50003 TRIGGER `Elecon`.`ROLES_BEFORE_DELETE`
BEFORE DELETE ON `Elecon`.`ROLES`
FOR EACH ROW
BEGIN
delete from USER_ROLES
WHERE system_id = old.system_id and role_group_id = old.role_group_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ROLE_MASTER`
--

DROP TABLE IF EXISTS `ROLE_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ROLE_MASTER` (
  `role_group_id` int(11) NOT NULL,
  `en_role_group_name` varchar(100) NOT NULL,
  `ar_role_group_name` varchar(100) NOT NULL,
  `pre_defined` varchar(2) DEFAULT 'N',
  PRIMARY KEY (`role_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ROLE_MASTER`
--

LOCK TABLES `ROLE_MASTER` WRITE;
/*!40000 ALTER TABLE `ROLE_MASTER` DISABLE KEYS */;
INSERT INTO `ROLE_MASTER` VALUES (0,'ERP Owner','مالك النظام','Y'),(1,'ERP Owner1','مالك النظام 1','Y'),(1691319193,'Fayed Role','Fayed Role','N'),(1697664172,'Fayed Role 1','Fayed Role 1','N');
/*!40000 ALTER TABLE `ROLE_MASTER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STORES`
--

DROP TABLE IF EXISTS `STORES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STORES` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(200) NOT NULL,
  `register_dt` datetime DEFAULT NULL,
  `st_cat_id` int(11) DEFAULT NULL,
  `org_code` int(11) NOT NULL,
  PRIMARY KEY (`store_id`),
  KEY `fk_table1_STORE_CATEGORIES1_idx` (`st_cat_id`),
  KEY `fk_STORES_ORGANIZATIONS1_idx` (`org_code`),
  CONSTRAINT `fk_STORES_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_STORE_CATEGORIES1` FOREIGN KEY (`st_cat_id`) REFERENCES `STORE_CATEGORIES` (`st_cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STORES`
--

LOCK TABLES `STORES` WRITE;
/*!40000 ALTER TABLE `STORES` DISABLE KEYS */;
INSERT INTO `STORES` VALUES (9,'Finished Goods','2023-10-08 07:42:43',NULL,2),(10,'Semi Finished','2023-12-08 07:42:43',NULL,1);
/*!40000 ALTER TABLE `STORES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STORE_CATEGORIES`
--

DROP TABLE IF EXISTS `STORE_CATEGORIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STORE_CATEGORIES` (
  `st_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `st_cat_name` varchar(100) NOT NULL,
  `register_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `active` varchar(2) DEFAULT 'Y',
  PRIMARY KEY (`st_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STORE_CATEGORIES`
--

LOCK TABLES `STORE_CATEGORIES` WRITE;
/*!40000 ALTER TABLE `STORE_CATEGORIES` DISABLE KEYS */;
INSERT INTO `STORE_CATEGORIES` VALUES (1,'tttt','2023-10-07 11:39:59','Y'),(2,'xxxx','2023-10-07 11:42:07','N'),(3,'ZZZZZ','2023-10-07 15:07:48','N'),(4,'qqq','2023-10-07 15:09:04','N'),(5,'rrrrrrrrrrrrrrrrrr','2023-10-07 19:07:57','N');
/*!40000 ALTER TABLE `STORE_CATEGORIES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STORE_ITEM_CATEGORIES`
--

DROP TABLE IF EXISTS `STORE_ITEM_CATEGORIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STORE_ITEM_CATEGORIES` (
  `store_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `active` varchar(2) DEFAULT 'N',
  PRIMARY KEY (`store_id`,`cat_id`),
  KEY `fk_STORE_ITEM_CATEGORIES_ITEM_CATEGORIES1_idx` (`cat_id`),
  CONSTRAINT `fk_STORE_ITEM_CATEGORIES_ITEM_CATEGORIES1` FOREIGN KEY (`cat_id`) REFERENCES `ITEM_CATEGORIES` (`cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_STORE_ITEM_CATEGORIES_STORES1` FOREIGN KEY (`store_id`) REFERENCES `STORES` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STORE_ITEM_CATEGORIES`
--

LOCK TABLES `STORE_ITEM_CATEGORIES` WRITE;
/*!40000 ALTER TABLE `STORE_ITEM_CATEGORIES` DISABLE KEYS */;
INSERT INTO `STORE_ITEM_CATEGORIES` VALUES (9,1,'Y'),(9,2,'Y'),(9,3,'N'),(9,13,'N');
/*!40000 ALTER TABLE `STORE_ITEM_CATEGORIES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ST_TRANS_TYPES`
--

DROP TABLE IF EXISTS `ST_TRANS_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ST_TRANS_TYPES` (
  `st_trans_type_code` int(11) NOT NULL AUTO_INCREMENT,
  `st_trans_name_a` varchar(200) DEFAULT NULL,
  `st_trans_name_e` varchar(200) DEFAULT NULL,
  `st_trans_type` varchar(2) NOT NULL,
  `active` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`st_trans_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ST_TRANS_TYPES`
--

LOCK TABLES `ST_TRANS_TYPES` WRITE;
/*!40000 ALTER TABLE `ST_TRANS_TYPES` DISABLE KEYS */;
/*!40000 ALTER TABLE `ST_TRANS_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUPPLIERS`
--

DROP TABLE IF EXISTS `SUPPLIERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUPPLIERS` (
  `supp_id` int(11) NOT NULL AUTO_INCREMENT,
  `supp_name` varchar(100) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `segel_no` varchar(45) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `supp_type` varchar(2) DEFAULT NULL,
  `supp_category` varchar(2) DEFAULT NULL,
  `org_code` int(11) NOT NULL,
  PRIMARY KEY (`supp_id`),
  KEY `fk_SUPPLIERS_ORGANIZATIONS2_idx` (`org_code`),
  CONSTRAINT `fk_SUPPLIERS_ORGANIZATIONS2` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUPPLIERS`
--

LOCK TABLES `SUPPLIERS` WRITE;
/*!40000 ALTER TABLE `SUPPLIERS` DISABLE KEYS */;
INSERT INTO `SUPPLIERS` VALUES (1,'Supplier One','Egypt, Doki - Giza','0121000000, 011100000,01510000000','qweasd14785','Mohamed Moawad','wwwwwwwwwwwwww','zzzzzzzzzzzzzzzzzzzzzzzzzz','I','SE',2),(2,'Supplier Elecon',NULL,'LLLLLLLLLLLLL',NULL,NULL,'xxxx@xxxx.xxxx','www.yyyy-zzz.xxx','E','S',2),(3,'WWWWWWWWWW','WWWWWWWWWW','WWWWWWWWWW','wwwwwwwwwwwww','wwwwwwwwwwwww','aaaaaaaaa','aaaaaaaaaaaaaaaaaaa','E','E',1);
/*!40000 ALTER TABLE `SUPPLIERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUPPLIER_DELIVER_ITEM_CATS`
--

DROP TABLE IF EXISTS `SUPPLIER_DELIVER_ITEM_CATS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUPPLIER_DELIVER_ITEM_CATS` (
  `cat_id` int(11) NOT NULL,
  `supp_id` int(11) NOT NULL,
  `active` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`cat_id`,`supp_id`),
  KEY `fk_SUPPLIER_DELIVER_ITEM_CATS_ITEM_CATEGORIES1_idx` (`cat_id`),
  KEY `fk_SUPPLIER_DELIVER_ITEM_CATS_SUPPLIERS1` (`supp_id`),
  CONSTRAINT `fk_SUPPLIER_DELIVER_ITEM_CATS_ITEM_CATEGORIES1` FOREIGN KEY (`cat_id`) REFERENCES `ITEM_CATEGORIES` (`cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_SUPPLIER_DELIVER_ITEM_CATS_SUPPLIERS1` FOREIGN KEY (`supp_id`) REFERENCES `SUPPLIERS` (`supp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUPPLIER_DELIVER_ITEM_CATS`
--

LOCK TABLES `SUPPLIER_DELIVER_ITEM_CATS` WRITE;
/*!40000 ALTER TABLE `SUPPLIER_DELIVER_ITEM_CATS` DISABLE KEYS */;
INSERT INTO `SUPPLIER_DELIVER_ITEM_CATS` VALUES (1,1,'Y'),(2,1,'N'),(12,2,'N'),(13,2,'Y');
/*!40000 ALTER TABLE `SUPPLIER_DELIVER_ITEM_CATS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SYSTEMS`
--

DROP TABLE IF EXISTS `SYSTEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SYSTEMS` (
  `system_id` varchar(3) NOT NULL,
  `ar_system_name` varchar(100) NOT NULL,
  `en_system_name` varchar(100) NOT NULL,
  `en_system_desc` varchar(2000) DEFAULT NULL,
  `ar_system_desc` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`system_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SYSTEMS`
--

LOCK TABLES `SYSTEMS` WRITE;
/*!40000 ALTER TABLE `SYSTEMS` DISABLE KEYS */;
INSERT INTO `SYSTEMS` VALUES ('ACS','البيانات المركزية','ERP Central Data','XXXX',NULL),('ADM','إدارة نظام تخطيط الموارد','ERP System Administration','YYYY',NULL),('APY','حسابات الموردين','Account Payables',NULL,NULL),('ARC','حسابات العملاء','Account Recievables',NULL,NULL),('ASS','اﻷصول','Assets',NULL,NULL),('CRM','خدمة العملاء','CRM',NULL,NULL),('DSH','لوحة السيطرة','DashBoard',NULL,NULL),('GL','الحسابات العامة','General Ledger',NULL,NULL),('HCM','شئون العاملين','Human Resources',NULL,NULL),('INV','المخازن','Inventory',NULL,NULL),('MNF','التصنيع','Manufacturing',NULL,NULL),('PRM','إدارة المشاريع','Project Managment',NULL,NULL),('PTC','العهد المالية','Petty Cash',NULL,NULL),('PUR','المشتريات','Purchasing',NULL,NULL),('SLS','المبيعات','Sales',NULL,NULL),('TOC','المكتب الفني','Technical Office',NULL,NULL);
/*!40000 ALTER TABLE `SYSTEMS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SYSTEM_FNCTNS`
--

DROP TABLE IF EXISTS `SYSTEM_FNCTNS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SYSTEM_FNCTNS` (
  `fncn_id` varchar(5) NOT NULL,
  `en_fncn_name` varchar(200) NOT NULL,
  `ar_fncn_name` varchar(200) NOT NULL,
  `system_id` varchar(3) NOT NULL,
  `en_fncn_desc` varchar(2000) DEFAULT NULL,
  `ar_fncn_desc` varchar(2000) DEFAULT NULL,
  `tf_link` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`fncn_id`),
  KEY `fk_SUB_SYSTEMS_SYSTEMS_idx` (`system_id`),
  CONSTRAINT `fk_SUB_SYSTEMS_SYSTEMS` FOREIGN KEY (`system_id`) REFERENCES `SYSTEMS` (`system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SYSTEM_FNCTNS`
--

LOCK TABLES `SYSTEM_FNCTNS` WRITE;
/*!40000 ALTER TABLE `SYSTEM_FNCTNS` DISABLE KEYS */;
INSERT INTO `SYSTEM_FNCTNS` VALUES ('ACS01','Measurment Units','وحدات القياس','ACS',NULL,'','/WEB-INF/units/units-transform-TF.xml#units-transform-TF'),('ACS02','Currencies','العملات','ACS',NULL,'','/WEB-INF/currencies/currencies-TF.xml#currencies-TF'),('ACS03','Items Categories','فئات الأصناف','ACS',NULL,'','/WEB-INF/itemCategories/itemCategories-TF.xml#itemCategories-TF'),('ACS04','Material Cataloge','كتالوج المواد','ACS',NULL,NULL,'/WEB-INF/items/items-TF.xml#items-TF'),('ACS05','Stores Categories','فئات المخازن','ACS',NULL,'','/WEB-INF/storeCategories/storeCategories-TF.xml#storeCategories-TF'),('ACS06','Organization Structure','هيكل الشركة','ACS',NULL,NULL,'/WEB-INF/organizations/organizations-TF.xml#organizations-TF'),('ACS07','Items Variables Structure','بناء متغيرات الأصناف','ACS',NULL,NULL,'/WEB-INF/itemVariablesStructure/items_variables_structure-TF.xml#items_variables_structure-TF'),('ACS08','General Account Chart','الشجرة المحاسبية العامة','ACS',NULL,NULL,'/WEB-INF/gl_gen_acc_chart/gl_gen_acc_chart-TF.xml#gl_gen_acc_chart-TF'),('ADM01','ERP Roles & Functions','صلاحيات ووظائف النظام','ADM',NULL,'','/WEB-INF/ErpAdmin/stndrd-role-perms-TF.xml#stndrd-role-perms-TF'),('ADM02','ERP Users ','مستخدمي النظام','ADM',NULL,'','/WEB-INF/ErpAdmin/users-TF.xml#users-TF'),('APY01','Suppliers Invoices','فواتير الموردين','APY',NULL,NULL,NULL),('APY02','Supplier Invoices Payment','سداد فواتير الموردين','APY',NULL,NULL,NULL),('ARC01','Customers Invoices','فواتير العملاء','ARC',NULL,NULL,NULL),('ARC02','Customers Invoices Collection','تحصيل فواتير العملاء','ARC',NULL,NULL,NULL),('ASS01','Setup Data','البيانات التمهيدية','ASS',NULL,NULL,'/WEB-INF/setupData/setupData-TF.xml#setupData-TF'),('ASS02','Transaction Types','أنواع الحركات','ASS',NULL,NULL,'/WEB-INF/transTypes/transTypes-TF.xml#transTypes-TF'),('ASS03','Assets Basic Data','بيانات الأصول','ASS',NULL,NULL,'/WEB-INF/assets_basic_data/assets_basic_data-TF.xml#assets_basic_data-TF'),('ASS04','Assets Transactions','حركات اﻷصول','ASS','','','/WEB-INF/AssetTransactions/AssetTransactions-TF.xml#AssetTransactions-TF'),('GL001','GL Transaction Types','أنواع الحركات المالية','GL',NULL,NULL,'/WEB-INF/gl_trans_types/gl_trans_types-TF.xml#gl_trans_types-TF'),('GL002','GL Account Types','أنواع الحسابات','GL',NULL,NULL,'/WEB-INF/gl_acc_types/gl_acc_types-TF.xml#gl_acc_types-TF'),('GL003','GL Account Chart','الشجرة المحاسبية','GL',NULL,NULL,'/WEB-INF/gl_org_acc_chart/gl_org_acc_chart-TF.xml#gl_org_acc_chart-TF'),('GL004','GL Helping Accounts','a','GL',NULL,NULL,NULL),('GL005','Cost Centers','مراكز التكلفة','GL',NULL,NULL,'/WEB-INF/gl_org_cost_centers/gl_org_cost_centers-TF.xml#gl_org_cost_centers-TF'),('GL006','GL Daily Journals','القيود اليومية','GL',NULL,NULL,'/WEB-INF/gl_documents/RO-gl_documents-TF.xml#RO-gl_documents-TF'),('GL007','GL Posting','a','GL',NULL,NULL,NULL),('GL008','Financial Periods','الفترات المالية','GL','','','/WEB-INF/gl_financial_years/gl_financial_years-TF.xml#gl_financial_years-TF'),('HCM01','Human Resources Setup','تهيئة نظام العاملين','HCM',NULL,NULL,NULL),('HCM02','Employees Basic Data','بيانات الموظفين الرئيسية','HCM',NULL,NULL,'/WEB-INF/employees/employees-TF.xml#employees-TF'),('HCM03','Jobs','الوظائـــف','HCM',NULL,NULL,'/WEB-INF/jobs/jobs-TF.xml#jobs-TF'),('HCM04','Emplyees Payslip Creation','إنشاء كشف قبض الموظفين','HCM',NULL,NULL,NULL),('HCM05','Employees Attendance Sheet','كشف الحضور والإنصراف للموظفين','HCM',NULL,NULL,NULL),('INV01','Inventory Trans Types','أنواع حركات المخزون','INV',NULL,NULL,NULL),('INV02','Items Definitions','تعريف الأصناف','INV',NULL,NULL,NULL),('INV03','Stores Definitions','تعريف المخازن','INV',NULL,NULL,'/WEB-INF/stores/store-TF.xml#store-TF'),('INV04','Inventory Openning Balance','الأرصدة الإفتتاحية للمخازن','INV',NULL,NULL,NULL),('INV05','Inventory Transactions','الحركات المخزنية','INV',NULL,NULL,NULL),('INV06','Store Inventory','جرد مخزن','INV',NULL,NULL,NULL),('INV07','Inventory Corrections','تصحيح المخزون','INV',NULL,NULL,NULL),('MNF01','Manufacturing Basic Data','البيانات الاساسية للتصنيع','MNF',NULL,NULL,'/WEB-INF/Mnf-Process-basic-Data/mnf_process_basic_data-TF.xml#mnf_process_basic_data-TF'),('MNF02','Manufacturing Processes Structure','الهيكل البنائي لعمليات التصنيع','MNF',NULL,NULL,NULL),('MNF03','Manufacturing Job Orders','أوامر الشغل','MNF',NULL,NULL,NULL),('PRM01','Projects Tendering','مناقصات المشاريع','PRM',NULL,NULL,NULL),('PRM02','Project Pricing','تسعير المشروع','PRM',NULL,NULL,'/WEB-INF/projects/projects-TF.xml#projects-TF'),('PRM03','Project offers & acceptance','عروض المشروع وموافقاته','PRM',NULL,NULL,NULL),('PRM04','Project items & actions Study','دراسة أعمال وأصناف المشروع','PRM',NULL,NULL,NULL),('PRM05','Project BOM','حصر كميات المشروع','PRM',NULL,NULL,NULL),('PRM06','Clientsssss','العمـــلاء','PRM',NULL,NULL,'/WEB-INF/clients/clients-TF.xml#clients-TF'),('PRM07','Project Extracts','مستخلصات المشروع','PRM',NULL,NULL,NULL),('PTC01','Petty Cash Trans Types','أنواع حركات العهد المالية','PTC',NULL,NULL,NULL),('PTC02','Petty Cash Creation','إنشاء العهد المالية','PTC',NULL,NULL,NULL),('PTC03','Petty Cash Transactions','حركات العهد المالية','PTC',NULL,NULL,NULL),('PUR01','Purchasing Trans Types','أنواع حركات المشتريات','PUR',NULL,NULL,NULL),('PUR02','Suppliers Data','بيانات الموردين','PUR',NULL,NULL,'/WEB-INF/suppliers/suppliers-TF.xml#suppliers-TF'),('PUR03','Purchasing Periodical Quatations','عروض الموردين الثابتة','PUR',NULL,NULL,NULL),('PUR04','Purchasing Material Requests','طلبات شراء المواد','PUR',NULL,NULL,NULL),('PUR05','RFQ','طلب عرض سعر من مورد','PUR',NULL,NULL,NULL),('PUR06','Receiving Suppliers Quotations','تسجيل عروض الأسعار لمورد','PUR',NULL,NULL,NULL),('PUR07','Evaluate Suppliers Quotations','تقييم عروض الأسعار','PUR',NULL,NULL,NULL),('PUR08','Purchasing Orders','أوامر الشراء','PUR',NULL,NULL,NULL),('PUR09','Purchasing Invoices','فواتير المشتريات','PUR',NULL,NULL,NULL),('SLS01','Sales Transactions Types','أنواع حركات المبيعات','SLS',NULL,NULL,NULL),('SLS02','Customers Types','أنواع العملاء','SLS',NULL,NULL,NULL),('SLS03','Sales Discounts Categories','شرائح الخصومات','SLS',NULL,NULL,NULL),('SLS04','Sales Taxes Categories','شرائح الضرائب','SLS',NULL,NULL,NULL),('SLS05','Sales Commissions','شرائح العمولات','SLS',NULL,NULL,NULL),('SLS06','Customers Data','بيانات العملاء','SLS',NULL,NULL,'/WEB-INF/SLS/customers/customers-TF.xml#customers-TF'),('SLS07','Sales Transactions','حركات البيع','SLS',NULL,NULL,NULL);
/*!40000 ALTER TABLE `SYSTEM_FNCTNS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SYSTEM_PARAMETERS`
--

DROP TABLE IF EXISTS `SYSTEM_PARAMETERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SYSTEM_PARAMETERS` (
  `id` int(11) NOT NULL,
  `smtp_host` varchar(100) DEFAULT NULL,
  `smtp_port` varchar(100) DEFAULT NULL,
  `admin_usrname` varchar(100) DEFAULT NULL,
  `admin_pswrd` varchar(100) DEFAULT NULL,
  `verify_email_url` varchar(200) DEFAULT NULL,
  `file_server_path` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SYSTEM_PARAMETERS`
--

LOCK TABLES `SYSTEM_PARAMETERS` WRITE;
/*!40000 ALTER TABLE `SYSTEM_PARAMETERS` DISABLE KEYS */;
INSERT INTO `SYSTEM_PARAMETERS` VALUES (1,'mail.elecon-eg.com','587','adminerp@elecon-eg.com','M.fayedERP2023','http://127.0.0.1:7101/AalM/erp/adf.task-flow?adf.tfId=verify-reset-pswrd-TF&adf.tfDoc=/WEB-INF/verify-reset-pswrd-TF.xml&pOtp=','/home/mfayed/FERB/');
/*!40000 ALTER TABLE `SYSTEM_PARAMETERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UNITS`
--

DROP TABLE IF EXISTS `UNITS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UNITS` (
  `unit_id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(100) NOT NULL,
  `register_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `active` varchar(2) DEFAULT 'Y',
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UNITS`
--

LOCK TABLES `UNITS` WRITE;
/*!40000 ALTER TABLE `UNITS` DISABLE KEYS */;
INSERT INTO `UNITS` VALUES (1,'Millimeter','2023-07-24 20:32:35','Y'),(2,'Centimeter','2023-07-24 20:32:47','Y'),(3,'Meter','2023-07-31 20:12:06','Y'),(4,'each - ??????','2023-08-06 15:58:20','Y'),(5,'??????? - Inch','2023-08-06 16:18:56','Y'),(6,'sssssss','2023-08-16 23:27:40','Y');
/*!40000 ALTER TABLE `UNITS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UNITS_TRANSFORM`
--

DROP TABLE IF EXISTS `UNITS_TRANSFORM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UNITS_TRANSFORM` (
  `from_unit_id` int(11) NOT NULL,
  `to_unit_id` int(11) NOT NULL,
  `multiply_by` decimal(15,5) DEFAULT NULL,
  `register_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `active` varchar(2) DEFAULT 'Y',
  PRIMARY KEY (`from_unit_id`,`to_unit_id`),
  UNIQUE KEY `UNIQUE_COMPOSITE_KEY` (`from_unit_id`,`to_unit_id`),
  KEY `fk_UNITS_TRANSFORM_UNITS2_idx` (`to_unit_id`),
  KEY `fk_UNITS_TRANSFORM_UNITS1_idx` (`from_unit_id`),
  CONSTRAINT `fk_UNITS_TRANSFORM_UNITS1` FOREIGN KEY (`from_unit_id`) REFERENCES `UNITS` (`unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_UNITS_TRANSFORM_UNITS2` FOREIGN KEY (`to_unit_id`) REFERENCES `UNITS` (`unit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UNITS_TRANSFORM`
--

LOCK TABLES `UNITS_TRANSFORM` WRITE;
/*!40000 ALTER TABLE `UNITS_TRANSFORM` DISABLE KEYS */;
INSERT INTO `UNITS_TRANSFORM` VALUES (1,2,0.01000,'2023-09-29 17:03:44','Y'),(2,1,10.00000,'2023-09-29 17:03:18','Y'),(2,3,0.01000,'2023-09-30 05:25:33','Y'),(3,2,100.00000,'2023-09-30 05:25:14','Y');
/*!40000 ALTER TABLE `UNITS_TRANSFORM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONTROL_ORGS`
--

DROP TABLE IF EXISTS `USER_CONTROL_ORGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_CONTROL_ORGS` (
  `user_id` int(11) NOT NULL,
  `org_code` int(11) NOT NULL,
  PRIMARY KEY (`org_code`,`user_id`),
  KEY `fk_USERS_CONTROL_ORGS_ORG_USERS1_idx` (`user_id`),
  KEY `fk_USERS_CONTROL_ORGS_ORGANIZATIONS1_idx` (`org_code`),
  CONSTRAINT `fk_USERS_CONTROL_ORGS_ORGANIZATIONS1` FOREIGN KEY (`org_code`) REFERENCES `ORGANIZATIONS` (`org_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USERS_CONTROL_ORGS_ORG_USERS1` FOREIGN KEY (`user_id`) REFERENCES `ORG_USERS` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONTROL_ORGS`
--

LOCK TABLES `USER_CONTROL_ORGS` WRITE;
/*!40000 ALTER TABLE `USER_CONTROL_ORGS` DISABLE KEYS */;
INSERT INTO `USER_CONTROL_ORGS` VALUES (0,2),(1,1),(1692157844,1),(1692160899,2),(1699283370,2);
/*!40000 ALTER TABLE `USER_CONTROL_ORGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_PERMISSIONS`
--

DROP TABLE IF EXISTS `USER_PERMISSIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_PERMISSIONS` (
  `fncn_id` varchar(5) NOT NULL,
  `system_id` varchar(3) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_group_id` int(11) NOT NULL,
  PRIMARY KEY (`fncn_id`,`system_id`,`user_id`,`role_group_id`),
  KEY `fk_USER_PERMISSIONS_SYSTEM_FNCTNS1_idx` (`fncn_id`),
  KEY `fk_USER_PERMISSIONS_USER_ROLES1_idx` (`system_id`,`user_id`,`role_group_id`),
  CONSTRAINT `fk_USER_PERMISSIONS_SYSTEM_FNCTNS1` FOREIGN KEY (`fncn_id`) REFERENCES `SYSTEM_FNCTNS` (`fncn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_PERMISSIONS_USER_ROLES1` FOREIGN KEY (`system_id`, `user_id`, `role_group_id`) REFERENCES `USER_ROLES` (`system_id`, `user_id`, `role_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_PERMISSIONS`
--

LOCK TABLES `USER_PERMISSIONS` WRITE;
/*!40000 ALTER TABLE `USER_PERMISSIONS` DISABLE KEYS */;
INSERT INTO `USER_PERMISSIONS` VALUES ('ACS01','ACS',0,0),('ACS01','ACS',1,1),('ACS01','ACS',1692160899,1691319193),('ACS01','ACS',1699283370,1691319193),('ACS02','ACS',0,0),('ACS02','ACS',1,1),('ACS03','ACS',0,0),('ACS03','ACS',1,1),('ACS04','ACS',0,0),('ACS04','ACS',1,1),('ACS05','ACS',0,0),('ACS05','ACS',1,1),('ACS06','ACS',0,0),('ACS06','ACS',1,1),('ACS06','ACS',1692160899,1691319193),('ACS06','ACS',1699283370,1691319193),('ACS07','ACS',0,0),('ACS07','ACS',1,1),('ACS08','ACS',0,0),('ACS08','ACS',1,1),('ADM01','ADM',0,0),('ADM01','ADM',1,1),('ADM01','ADM',1692160899,1691319193),('ADM01','ADM',1699283370,1691319193),('ADM02','ADM',0,0),('ADM02','ADM',1,1),('ADM02','ADM',1692160899,1691319193),('ADM02','ADM',1699283370,1691319193),('APY01','APY',0,0),('APY01','APY',1,1),('APY02','APY',0,0),('APY02','APY',1,1),('ARC01','ARC',0,0),('ARC01','ARC',1,1),('ARC02','ARC',0,0),('ARC02','ARC',1,1),('ASS01','ASS',1,1),('ASS02','ASS',1,1),('ASS03','ASS',1,1),('GL001','GL',0,0),('GL001','GL',1,1),('GL002','GL',0,0),('GL002','GL',1,1),('GL003','GL',0,0),('GL003','GL',1,1),('GL004','GL',0,0),('GL004','GL',1,1),('GL005','GL',0,0),('GL005','GL',1,1),('GL006','GL',0,0),('GL006','GL',1,1),('GL007','GL',0,0),('GL007','GL',1,1),('GL008','GL',0,0),('GL008','GL',1,1),('HCM01','HCM',0,0),('HCM01','HCM',1,1),('HCM02','HCM',0,0),('HCM02','HCM',1,1),('HCM03','HCM',0,0),('HCM03','HCM',1,1),('HCM04','HCM',0,0),('HCM04','HCM',1,1),('HCM05','HCM',0,0),('HCM05','HCM',1,1),('INV01','INV',0,0),('INV01','INV',1,1),('INV02','INV',0,0),('INV02','INV',1,1),('INV03','INV',0,0),('INV03','INV',1,1),('INV03','INV',1692157844,1697664172),('INV04','INV',0,0),('INV04','INV',1,1),('INV05','INV',0,0),('INV05','INV',1,1),('INV06','INV',0,0),('INV06','INV',1,1),('INV07','INV',0,0),('INV07','INV',1,1),('MNF01','MNF',1,1),('MNF02','MNF',1,1),('MNF03','MNF',1,1),('PRM01','PRM',0,0),('PRM02','PRM',0,0),('PRM03','PRM',0,0),('PRM04','PRM',0,0),('PRM05','PRM',0,0),('PRM06','PRM',0,0),('PRM07','PRM',0,0),('PTC01','PTC',0,0),('PTC01','PTC',1,1),('PTC02','PTC',0,0),('PTC02','PTC',1,1),('PTC03','PTC',0,0),('PTC03','PTC',1,1),('PUR01','PUR',0,0),('PUR01','PUR',1,1),('PUR02','PUR',0,0),('PUR02','PUR',1,1),('PUR03','PUR',0,0),('PUR03','PUR',1,1),('PUR04','PUR',0,0),('PUR04','PUR',1,1),('PUR05','PUR',0,0),('PUR05','PUR',1,1),('PUR06','PUR',0,0),('PUR06','PUR',1,1),('PUR07','PUR',0,0),('PUR07','PUR',1,1),('PUR08','PUR',0,0),('PUR08','PUR',1,1),('PUR09','PUR',0,0),('PUR09','PUR',1,1),('SLS01','SLS',1,1),('SLS02','SLS',1,1),('SLS03','SLS',1,1),('SLS04','SLS',1,1),('SLS05','SLS',1,1),('SLS06','SLS',1,1),('SLS06','SLS',1692160899,1691319193),('SLS06','SLS',1699283370,1691319193),('SLS07','SLS',1,1);
/*!40000 ALTER TABLE `USER_PERMISSIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ROLES`
--

DROP TABLE IF EXISTS `USER_ROLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ROLES` (
  `system_id` varchar(3) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_group_id` int(11) NOT NULL,
  PRIMARY KEY (`system_id`,`user_id`,`role_group_id`),
  KEY `fk_USER_ROLES_SYSTEMS1_idx` (`system_id`),
  KEY `fk_USER_ROLES_USER_ROLES_MASTER1_idx` (`user_id`,`role_group_id`),
  CONSTRAINT `fk_USER_ROLES_SYSTEMS1` FOREIGN KEY (`system_id`) REFERENCES `SYSTEMS` (`system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_ROLES_USER_ROLES_MASTER1` FOREIGN KEY (`user_id`, `role_group_id`) REFERENCES `USER_ROLES_MASTER` (`user_id`, `role_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ROLES`
--

LOCK TABLES `USER_ROLES` WRITE;
/*!40000 ALTER TABLE `USER_ROLES` DISABLE KEYS */;
INSERT INTO `USER_ROLES` VALUES ('ACS',0,0),('ADM',0,0),('APY',0,0),('ARC',0,0),('CRM',0,0),('DSH',0,0),('GL',0,0),('HCM',0,0),('INV',0,0),('PRM',0,0),('PTC',0,0),('PUR',0,0),('TOC',0,0),('ACS',1,1),('ADM',1,1),('APY',1,1),('ARC',1,1),('ASS',1,1),('CRM',1,1),('DSH',1,1),('GL',1,1),('HCM',1,1),('INV',1,1),('MNF',1,1),('PTC',1,1),('PUR',1,1),('SLS',1,1),('INV',1692157844,1697664172),('ACS',1692160899,1691319193),('ADM',1692160899,1691319193),('SLS',1692160899,1691319193),('ACS',1699283370,1691319193),('ADM',1699283370,1691319193),('SLS',1699283370,1691319193);
/*!40000 ALTER TABLE `USER_ROLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ROLES_MASTER`
--

DROP TABLE IF EXISTS `USER_ROLES_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ROLES_MASTER` (
  `user_id` int(11) NOT NULL,
  `role_group_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_group_id`),
  KEY `fk_USER_ROLES_MASTER_ROLE_MASTER1_idx` (`role_group_id`),
  CONSTRAINT `fk_USER_ROLES_MASTER_ORG_USERS1` FOREIGN KEY (`user_id`) REFERENCES `ORG_USERS` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_ROLES_MASTER_ROLE_MASTER1` FOREIGN KEY (`role_group_id`) REFERENCES `ROLE_MASTER` (`role_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ROLES_MASTER`
--

LOCK TABLES `USER_ROLES_MASTER` WRITE;
/*!40000 ALTER TABLE `USER_ROLES_MASTER` DISABLE KEYS */;
INSERT INTO `USER_ROLES_MASTER` VALUES (0,0),(1,1),(1692160899,1691319193),(1699283370,1691319193),(1692157844,1697664172);
/*!40000 ALTER TABLE `USER_ROLES_MASTER` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`localhost`*/ /*!50003 TRIGGER `Elecon`.`USER_ROLES_MASTER_AFTER_INSERT`
AFTER INSERT ON `Elecon`.`USER_ROLES_MASTER`
FOR EACH ROW
BEGIN
	-- insert systems granted to role, to user
insert into Elecon.USER_ROLES (system_id,user_id, role_group_id)
	select system_id, new.user_id,new.role_group_id FROM Elecon.ROLES
    WHERE role_group_id = new.role_group_id;
-- insert granted system functions to user
insert into Elecon.USER_PERMISSIONS (fncn_id, system_id,user_id, role_group_id)
	select fncn_id , system_id,new.user_id, new.role_group_id from Elecon.PERMISSIONS
    where role_group_id = new.role_group_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`elecon`@`localhost`*/ /*!50003 TRIGGER `Elecon`.`USER_ROLES_MASTER_BEFORE_DELETE`
BEFORE DELETE ON `Elecon`.`USER_ROLES_MASTER`
FOR EACH ROW
BEGIN
delete from USER_PERMISSIONS 
	where user_id = old.user_id
    and role_group_id = old.role_group_id;
delete from USER_ROLES
	WHERE user_id = old.user_id
    and role_group_id = old.role_group_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'Elecon'
--

--
-- Dumping routines for database 'Elecon'
--
/*!50003 DROP PROCEDURE IF EXISTS `create_gl_assistance_from_tables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`elecon`@`localhost` PROCEDURE `create_gl_assistance_from_tables`(vAccCode int,vTblName varchar(100),vOrgCode int)
BEGIN
if (vTblName='HR1') THEN -- EMPLOYEES
insert into GL_ACC_ASSISTANCES (`ass_code`, `ass_name`, `acc_code`,`active`,`org_code`,`gl_ass_tbl_id`)
	select concat(vAccCode,'-',emp_id), emp_name, vAccCode, 'Y',vOrgCode,vTblName
		from EMPLOYEES WHERE concat(vAccCode,'-',emp_id) not in 
			(select ass_code from GL_ACC_ASSISTANCES
				where acc_code = vAccCode);
                
elseif(vTblName='CL1') then -- CUSTOMERS
insert into GL_ACC_ASSISTANCES (`ass_code`, `ass_name`, `acc_code`,`active`,`org_code`,`gl_ass_tbl_id`)
	select concat(vAccCode,'-',cust_id), cust_name, vAccCode, 'Y',vOrgCode,vTblName
		from CUSTOMERS WHERE concat(vAccCode,'-',cust_id) not in 
			(select ass_code from GL_ACC_ASSISTANCES
				where acc_code = vAccCode);
                
elseif(vTblName='SP1') then -- SUPPLIERS
insert into GL_ACC_ASSISTANCES (`ass_code`, `ass_name`, `acc_code`,`active`,`org_code`,`gl_ass_tbl_id`)
	select concat(vAccCode,'-',supp_id), supp_name, vAccCode, 'Y',vOrgCode,vTblName
		from SUPPLIERS WHERE concat(vAccCode,'-',supp_id) not in 
			(select ass_code from GL_ACC_ASSISTANCES
				where acc_code = vAccCode);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_items_from_item_variables_test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`elecon`@`localhost` PROCEDURE `create_items_from_item_variables_test`()
BEGIN
INSERT INTO ITEMS_LIST
(item_indx, item_code,item_name,cat_id,unit_id,register_dt,is_assmbly,active,org_code,order_limit,sales_profit_perc,
str_var_1,
str_var_2,
str_var_3,
str_var_4,
str_var_5,
str_var_6,
str_var_7,
str_var_8,
str_var_9,
str_var_10,
str_var_11,
str_var_12,
str_var_13,
str_var_14,
str_var_15,
str_var_16,
str_var_17,
str_var_18,
str_var_19,
str_var_20)
SELECT ITEM_VARIABLES_TEST.item_code,  concat('I-',  @a:= @a+1 ),ITEM_VARIABLES_TEST.item_name,ITEM_VARIABLES_TEST.cat_id,ITEM_VARIABLES_TEST.unit_id
,current_timestamp(),'N','Y',ITEM_VARIABLES_TEST.org_code,0.0,0,
    ITEM_VARIABLES_TEST.str_var_1,
    ITEM_VARIABLES_TEST.str_var_2,
    ITEM_VARIABLES_TEST.str_var_3,
    ITEM_VARIABLES_TEST.str_var_4,
    ITEM_VARIABLES_TEST.str_var_5,
    ITEM_VARIABLES_TEST.str_var_6,
    ITEM_VARIABLES_TEST.str_var_7,
    ITEM_VARIABLES_TEST.str_var_8,
    ITEM_VARIABLES_TEST.str_var_9,
    ITEM_VARIABLES_TEST.str_var_10,
    ITEM_VARIABLES_TEST.str_var_11,
    ITEM_VARIABLES_TEST.str_var_12,
    ITEM_VARIABLES_TEST.str_var_13,
    ITEM_VARIABLES_TEST.str_var_14,
    ITEM_VARIABLES_TEST.str_var_15,
    ITEM_VARIABLES_TEST.str_var_16,
    ITEM_VARIABLES_TEST.str_var_17,
    ITEM_VARIABLES_TEST.str_var_18,
    ITEM_VARIABLES_TEST.str_var_19,
    ITEM_VARIABLES_TEST.str_var_20
FROM ITEM_VARIABLES_TEST ,(SELECT @a:= (SELECT ifnull(max(cast(substring(item_code,3) AS UNSIGNED)),0) from ITEMS_LIST)) AS a
where ITEM_VARIABLES_TEST.item_code not in (select item_indx from ITEMS_LIST);
delete FROM ITEM_VARIABLES_TEST;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_items_from_variables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`elecon`@`localhost` PROCEDURE `create_items_from_variables`(IN vCatId varchar (10),in vUnitId varchar(50), IN vOrgCode int(11))
BEGIN
delete from ITEM_VARIABLES_TEST;
insert into ITEM_VARIABLES_TEST
select concat(ifnull(x1.var_val_code,'')
, ifnull(x2.var_val_code,'')
, ifnull(x3.var_val_code,'')
, ifnull(x4.var_val_code,'')
, ifnull(x5.var_val_code,'')
, ifnull(x6.var_val_code,'')
, ifnull(x7.var_val_code,'')
, ifnull(x8.var_val_code,'')
, ifnull(x9.var_val_code,'')
, ifnull(x10.var_val_code,'')
, ifnull(x11.var_val_code,'')
, ifnull(x12.var_val_code,'')
, ifnull(x13.var_val_code,'')
, ifnull(x14.var_val_code,'')
, ifnull(x15.var_val_code,'')
, ifnull(x16.var_val_code,'')
, ifnull(x17.var_val_code,'')
, ifnull(x18.var_val_code,'')
, ifnull(x19.var_val_code,'')
, ifnull(x20.var_val_code,'')  ) item_code,
trim(trailing '-' from
 concat(ifnull(x1.var_val_value,'')-- ,IF(x20.var_val_value IS NULL,'','-')
 , ifnull(x2.var_val_value,'') ,IF(x2.var_val_value IS NULL,'','-')
 , ifnull(x3.var_val_value,'') ,IF(x3.var_val_value IS NULL,'','-')
 , ifnull(x4.var_val_value,'') ,IF(x4.var_val_value IS NULL,'','-')
 , ifnull(x5.var_val_value,'') ,IF(x5.var_val_value IS NULL,'','-')
 , ifnull(x6.var_val_value,'') ,IF(x6.var_val_value IS NULL,'','-')
 , ifnull(x7.var_val_value,'') ,IF(x7.var_val_value IS NULL,'','-')
 , ifnull(x8.var_val_value,'') ,IF(x8.var_val_value IS NULL,'','-')
 , ifnull(x9.var_val_value,'') ,IF(x9.var_val_value IS NULL,'','-')
 , ifnull(x10.var_val_value,'') ,IF(x10.var_val_value IS NULL,'','-')
 , ifnull(x11.var_val_value,'') ,IF(x11.var_val_value IS NULL,'','-')
 , ifnull(x12.var_val_value,'') ,IF(x12.var_val_value IS NULL,'','-')
 , ifnull(x13.var_val_value,'') ,IF(x13.var_val_value IS NULL,'','-')
 , ifnull(x14.var_val_value,'') ,IF(x14.var_val_value IS NULL,'','-')
 , ifnull(x15.var_val_value,'') ,IF(x15.var_val_value IS NULL,'','-')
 , ifnull(x16.var_val_value,'') ,IF(x16.var_val_value IS NULL,'','-')
 , ifnull(x17.var_val_value,'') ,IF(x17.var_val_value IS NULL,'','-')
 , ifnull(x18.var_val_value,'') ,IF(x18.var_val_value IS NULL,'','-')
 , ifnull(x19.var_val_value,'') ,IF(x19.var_val_value IS NULL,'','-')
 ,ifnull(x20.var_val_value,'') ) ) item_name,
 case  when x1.var_code='A' then x1.var_val_code
	  when x2.var_code='A' then x2.var_val_code
      when x3.var_code='A' then x3.var_val_code
      when x4.var_code='A' then x4.var_val_code
	  when x5.var_code='A' then x5.var_val_code
      when x6.var_code='A' then x6.var_val_code
      when x7.var_code='A' then x7.var_val_code
	  when x8.var_code='A' then x8.var_val_code
      when x9.var_code='A' then x9.var_val_code
      when x10.var_code='A' then x10.var_val_code
	  when x11.var_code='A' then x11.var_val_code
      when x12.var_code='A' then x12.var_val_code
      when x13.var_code='A' then x13.var_val_code
	  when x14.var_code='A' then x14.var_val_code
      when x15.var_code='A' then x15.var_val_code
      when x16.var_code='A' then x16.var_val_code
	  when x17.var_code='A' then x17.var_val_code
      when x18.var_code='A' then x18.var_val_code
      when x19.var_code='A' then x19.var_val_code
	  when x20.var_code='A' then x20.var_val_code
      else null end as str_var_1,
      
      case  when x1.var_code='B' then x1.var_val_code
	  when x2.var_code='B' then x2.var_val_code
      when x3.var_code='B' then x3.var_val_code
      when x4.var_code='B' then x4.var_val_code
	  when x5.var_code='B' then x5.var_val_code
      when x6.var_code='B' then x6.var_val_code
      when x7.var_code='B' then x7.var_val_code
	  when x8.var_code='B' then x8.var_val_code
      when x9.var_code='B' then x9.var_val_code
      when x10.var_code='B' then x10.var_val_code
	  when x11.var_code='B' then x11.var_val_code
      when x12.var_code='B' then x12.var_val_code
      when x13.var_code='B' then x13.var_val_code
	  when x14.var_code='B' then x14.var_val_code
      when x15.var_code='B' then x15.var_val_code
      when x16.var_code='B' then x16.var_val_code
	  when x17.var_code='B' then x17.var_val_code
      when x18.var_code='B' then x18.var_val_code
      when x19.var_code='B' then x19.var_val_code
	  when x20.var_code='B' then x20.var_val_code
      else null end as str_var_2,
      
      case  when x1.var_code='C' then x1.var_val_code
	  when x2.var_code='C' then x2.var_val_code
      when x3.var_code='C' then x3.var_val_code
      when x4.var_code='C' then x4.var_val_code
	  when x5.var_code='C' then x5.var_val_code
      when x6.var_code='C' then x6.var_val_code
      when x7.var_code='C' then x7.var_val_code
	  when x8.var_code='C' then x8.var_val_code
      when x9.var_code='C' then x9.var_val_code
      when x10.var_code='C' then x10.var_val_code
	  when x11.var_code='C' then x11.var_val_code
      when x12.var_code='C' then x12.var_val_code
      when x13.var_code='C' then x13.var_val_code
	  when x14.var_code='C' then x14.var_val_code
      when x15.var_code='C' then x15.var_val_code
      when x16.var_code='C' then x16.var_val_code
	  when x17.var_code='C' then x17.var_val_code
      when x18.var_code='C' then x18.var_val_code
      when x19.var_code='C' then x19.var_val_code
	  when x20.var_code='C' then x20.var_val_code
      else null end as str_var_3,
      
      case  when x1.var_code='D' then x1.var_val_code
    when x2.var_code='D' then x2.var_val_code
    when x3.var_code='D' then x3.var_val_code
    when x4.var_code='D' then x4.var_val_code
    when x5.var_code='D' then x5.var_val_code
    when x6.var_code='D' then x6.var_val_code
    when x7.var_code='D' then x7.var_val_code
    when x8.var_code='D' then x8.var_val_code
    when x9.var_code='D' then x9.var_val_code
    when x10.var_code='D' then x10.var_val_code
    when x11.var_code='D' then x11.var_val_code
    when x12.var_code='D' then x12.var_val_code
    when x13.var_code='D' then x13.var_val_code
    when x14.var_code='D' then x14.var_val_code
    when x15.var_code='D' then x15.var_val_code
    when x16.var_code='D' then x16.var_val_code
    when x17.var_code='D' then x17.var_val_code
    when x18.var_code='D' then x18.var_val_code
    when x19.var_code='D' then x19.var_val_code
    when x20.var_code='D' then x20.var_val_code
    else null end as str_var_4,
    
    case  when x1.var_code='E' then x1.var_val_code
    when x2.var_code='E' then x2.var_val_code
    when x3.var_code='E' then x3.var_val_code
    when x4.var_code='E' then x4.var_val_code
    when x5.var_code='E' then x5.var_val_code
    when x6.var_code='E' then x6.var_val_code
    when x7.var_code='E' then x7.var_val_code
    when x8.var_code='E' then x8.var_val_code
    when x9.var_code='E' then x9.var_val_code
    when x10.var_code='E' then x10.var_val_code
    when x11.var_code='E' then x11.var_val_code
    when x12.var_code='E' then x12.var_val_code
    when x13.var_code='E' then x13.var_val_code
    when x14.var_code='E' then x14.var_val_code
    when x15.var_code='E' then x15.var_val_code
    when x16.var_code='E' then x16.var_val_code
    when x17.var_code='E' then x17.var_val_code
    when x18.var_code='E' then x18.var_val_code
    when x19.var_code='E' then x19.var_val_code
    when x20.var_code='E' then x20.var_val_code
    else null end as str_var_5,
    
    case  when x1.var_code='F' then x1.var_val_code
    when x2.var_code='F' then x2.var_val_code
    when x3.var_code='F' then x3.var_val_code
    when x4.var_code='F' then x4.var_val_code
    when x5.var_code='F' then x5.var_val_code
    when x6.var_code='F' then x6.var_val_code
    when x7.var_code='F' then x7.var_val_code
    when x8.var_code='F' then x8.var_val_code
    when x9.var_code='F' then x9.var_val_code
    when x10.var_code='F' then x10.var_val_code
    when x11.var_code='F' then x11.var_val_code
    when x12.var_code='F' then x12.var_val_code
    when x13.var_code='F' then x13.var_val_code
    when x14.var_code='F' then x14.var_val_code
    when x15.var_code='F' then x15.var_val_code
    when x16.var_code='F' then x16.var_val_code
    when x17.var_code='F' then x17.var_val_code
    when x18.var_code='F' then x18.var_val_code
    when x19.var_code='F' then x19.var_val_code
    when x20.var_code='F' then x20.var_val_code
    else null end as str_var_6,
    
    case  when x1.var_code='G' then x1.var_val_code
    when x2.var_code='G' then x2.var_val_code
    when x3.var_code='G' then x3.var_val_code
    when x4.var_code='G' then x4.var_val_code
    when x5.var_code='G' then x5.var_val_code
    when x6.var_code='G' then x6.var_val_code
    when x7.var_code='G' then x7.var_val_code
    when x8.var_code='G' then x8.var_val_code
    when x9.var_code='G' then x9.var_val_code
    when x10.var_code='G' then x10.var_val_code
    when x11.var_code='G' then x11.var_val_code
    when x12.var_code='G' then x12.var_val_code
    when x13.var_code='G' then x13.var_val_code
    when x14.var_code='G' then x14.var_val_code
    when x15.var_code='G' then x15.var_val_code
    when x16.var_code='G' then x16.var_val_code
    when x17.var_code='G' then x17.var_val_code
    when x18.var_code='G' then x18.var_val_code
    when x19.var_code='G' then x19.var_val_code
    when x20.var_code='G' then x20.var_val_code
    else null end as str_var_7,
    
    case  when x1.var_code='H' then x1.var_val_code
    when x2.var_code='H' then x2.var_val_code
    when x3.var_code='H' then x3.var_val_code
    when x4.var_code='H' then x4.var_val_code
    when x5.var_code='H' then x5.var_val_code
    when x6.var_code='H' then x6.var_val_code
    when x7.var_code='H' then x7.var_val_code
    when x8.var_code='H' then x8.var_val_code
    when x9.var_code='H' then x9.var_val_code
    when x10.var_code='H' then x10.var_val_code
    when x11.var_code='H' then x11.var_val_code
    when x12.var_code='H' then x12.var_val_code
    when x13.var_code='H' then x13.var_val_code
    when x14.var_code='H' then x14.var_val_code
    when x15.var_code='H' then x15.var_val_code
    when x16.var_code='H' then x16.var_val_code
    when x17.var_code='H' then x17.var_val_code
    when x18.var_code='H' then x18.var_val_code
    when x19.var_code='H' then x19.var_val_code
    when x20.var_code='H' then x20.var_val_code
    else null end as str_var_8,
    
    case  when x1.var_code='I' then x1.var_val_code
    when x2.var_code='I' then x2.var_val_code
    when x3.var_code='I' then x3.var_val_code
    when x4.var_code='I' then x4.var_val_code
    when x5.var_code='I' then x5.var_val_code
    when x6.var_code='I' then x6.var_val_code
    when x7.var_code='I' then x7.var_val_code
    when x8.var_code='I' then x8.var_val_code
    when x9.var_code='I' then x9.var_val_code
    when x10.var_code='I' then x10.var_val_code
    when x11.var_code='I' then x11.var_val_code
    when x12.var_code='I' then x12.var_val_code
    when x13.var_code='I' then x13.var_val_code
    when x14.var_code='I' then x14.var_val_code
    when x15.var_code='I' then x15.var_val_code
    when x16.var_code='I' then x16.var_val_code
    when x17.var_code='I' then x17.var_val_code
    when x18.var_code='I' then x18.var_val_code
    when x19.var_code='I' then x19.var_val_code
    when x20.var_code='I' then x20.var_val_code
    else null end as str_var_9,
    
    case  when x1.var_code='J' then x1.var_val_code
    when x2.var_code='J' then x2.var_val_code
    when x3.var_code='J' then x3.var_val_code
    when x4.var_code='J' then x4.var_val_code
    when x5.var_code='J' then x5.var_val_code
    when x6.var_code='J' then x6.var_val_code
    when x7.var_code='J' then x7.var_val_code
    when x8.var_code='J' then x8.var_val_code
    when x9.var_code='J' then x9.var_val_code
    when x10.var_code='J' then x10.var_val_code
    when x11.var_code='J' then x11.var_val_code
    when x12.var_code='J' then x12.var_val_code
    when x13.var_code='J' then x13.var_val_code
    when x14.var_code='J' then x14.var_val_code
    when x15.var_code='J' then x15.var_val_code
    when x16.var_code='J' then x16.var_val_code
    when x17.var_code='J' then x17.var_val_code
    when x18.var_code='J' then x18.var_val_code
    when x19.var_code='J' then x19.var_val_code
    when x20.var_code='J' then x20.var_val_code
    else null end as str_var_10,
    
    case  when x1.var_code='K' then x1.var_val_code
    when x2.var_code='K' then x2.var_val_code
    when x3.var_code='K' then x3.var_val_code
    when x4.var_code='K' then x4.var_val_code
    when x5.var_code='K' then x5.var_val_code
    when x6.var_code='K' then x6.var_val_code
    when x7.var_code='K' then x7.var_val_code
    when x8.var_code='K' then x8.var_val_code
    when x9.var_code='K' then x9.var_val_code
    when x10.var_code='K' then x10.var_val_code
    when x11.var_code='K' then x11.var_val_code
    when x12.var_code='K' then x12.var_val_code
    when x13.var_code='K' then x13.var_val_code
    when x14.var_code='K' then x14.var_val_code
    when x15.var_code='K' then x15.var_val_code
    when x16.var_code='K' then x16.var_val_code
    when x17.var_code='K' then x17.var_val_code
    when x18.var_code='K' then x18.var_val_code
    when x19.var_code='K' then x19.var_val_code
    when x20.var_code='K' then x20.var_val_code
    else null end as str_var_11,
    
    case  when x1.var_code='L' then x1.var_val_code
    when x2.var_code='L' then x2.var_val_code
    when x3.var_code='L' then x3.var_val_code
    when x4.var_code='L' then x4.var_val_code
    when x5.var_code='L' then x5.var_val_code
    when x6.var_code='L' then x6.var_val_code
    when x7.var_code='L' then x7.var_val_code
    when x8.var_code='L' then x8.var_val_code
    when x9.var_code='L' then x9.var_val_code
    when x10.var_code='L' then x10.var_val_code
    when x11.var_code='L' then x11.var_val_code
    when x12.var_code='L' then x12.var_val_code
    when x13.var_code='L' then x13.var_val_code
    when x14.var_code='L' then x14.var_val_code
    when x15.var_code='L' then x15.var_val_code
    when x16.var_code='L' then x16.var_val_code
    when x17.var_code='L' then x17.var_val_code
    when x18.var_code='L' then x18.var_val_code
    when x19.var_code='L' then x19.var_val_code
    when x20.var_code='L' then x20.var_val_code
    else null end as str_var_12,
    
    case  when x1.var_code='M' then x1.var_val_code
    when x2.var_code='M' then x2.var_val_code
    when x3.var_code='M' then x3.var_val_code
    when x4.var_code='M' then x4.var_val_code
    when x5.var_code='M' then x5.var_val_code
    when x6.var_code='M' then x6.var_val_code
    when x7.var_code='M' then x7.var_val_code
    when x8.var_code='M' then x8.var_val_code
    when x9.var_code='M' then x9.var_val_code
    when x10.var_code='M' then x10.var_val_code
    when x11.var_code='M' then x11.var_val_code
    when x12.var_code='M' then x12.var_val_code
    when x13.var_code='M' then x13.var_val_code
    when x14.var_code='M' then x14.var_val_code
    when x15.var_code='M' then x15.var_val_code
    when x16.var_code='M' then x16.var_val_code
    when x17.var_code='M' then x17.var_val_code
    when x18.var_code='M' then x18.var_val_code
    when x19.var_code='M' then x19.var_val_code
    when x20.var_code='M' then x20.var_val_code
    else null end as str_var_13,
    
    case  when x1.var_code='N' then x1.var_val_code
    when x2.var_code='N' then x2.var_val_code
    when x3.var_code='N' then x3.var_val_code
    when x4.var_code='N' then x4.var_val_code
    when x5.var_code='N' then x5.var_val_code
    when x6.var_code='N' then x6.var_val_code
    when x7.var_code='N' then x7.var_val_code
    when x8.var_code='N' then x8.var_val_code
    when x9.var_code='N' then x9.var_val_code
    when x10.var_code='N' then x10.var_val_code
    when x11.var_code='N' then x11.var_val_code
    when x12.var_code='N' then x12.var_val_code
    when x13.var_code='N' then x13.var_val_code
    when x14.var_code='N' then x14.var_val_code
    when x15.var_code='N' then x15.var_val_code
    when x16.var_code='N' then x16.var_val_code
    when x17.var_code='N' then x17.var_val_code
    when x18.var_code='N' then x18.var_val_code
    when x19.var_code='N' then x19.var_val_code
    when x20.var_code='N' then x20.var_val_code
    else null end as str_var_14,
    
    case  when x1.var_code='O' then x1.var_val_code
    when x2.var_code='O' then x2.var_val_code
    when x3.var_code='O' then x3.var_val_code
    when x4.var_code='O' then x4.var_val_code
    when x5.var_code='O' then x5.var_val_code
    when x6.var_code='O' then x6.var_val_code
    when x7.var_code='O' then x7.var_val_code
    when x8.var_code='O' then x8.var_val_code
    when x9.var_code='O' then x9.var_val_code
    when x10.var_code='O' then x10.var_val_code
    when x11.var_code='O' then x11.var_val_code
    when x12.var_code='O' then x12.var_val_code
    when x13.var_code='O' then x13.var_val_code
    when x14.var_code='O' then x14.var_val_code
    when x15.var_code='O' then x15.var_val_code
    when x16.var_code='O' then x16.var_val_code
    when x17.var_code='O' then x17.var_val_code
    when x18.var_code='O' then x18.var_val_code
    when x19.var_code='O' then x19.var_val_code
    when x20.var_code='O' then x20.var_val_code
    else null end as str_var_15,
    
    case  when x1.var_code='P' then x1.var_val_code
    when x2.var_code='P' then x2.var_val_code
    when x3.var_code='P' then x3.var_val_code
    when x4.var_code='P' then x4.var_val_code
    when x5.var_code='P' then x5.var_val_code
    when x6.var_code='P' then x6.var_val_code
    when x7.var_code='P' then x7.var_val_code
    when x8.var_code='P' then x8.var_val_code
    when x9.var_code='P' then x9.var_val_code
    when x10.var_code='P' then x10.var_val_code
    when x11.var_code='P' then x11.var_val_code
    when x12.var_code='P' then x12.var_val_code
    when x13.var_code='P' then x13.var_val_code
    when x14.var_code='P' then x14.var_val_code
    when x15.var_code='P' then x15.var_val_code
    when x16.var_code='P' then x16.var_val_code
    when x17.var_code='P' then x17.var_val_code
    when x18.var_code='P' then x18.var_val_code
    when x19.var_code='P' then x19.var_val_code
    when x20.var_code='P' then x20.var_val_code
    else null end as str_var_16,
    
    case  when x1.var_code='Q' then x1.var_val_code
    when x2.var_code='Q' then x2.var_val_code
    when x3.var_code='Q' then x3.var_val_code
    when x4.var_code='Q' then x4.var_val_code
    when x5.var_code='Q' then x5.var_val_code
    when x6.var_code='Q' then x6.var_val_code
    when x7.var_code='Q' then x7.var_val_code
    when x8.var_code='Q' then x8.var_val_code
    when x9.var_code='Q' then x9.var_val_code
    when x10.var_code='Q' then x10.var_val_code
    when x11.var_code='Q' then x11.var_val_code
    when x12.var_code='Q' then x12.var_val_code
    when x13.var_code='Q' then x13.var_val_code
    when x14.var_code='Q' then x14.var_val_code
    when x15.var_code='Q' then x15.var_val_code
    when x16.var_code='Q' then x16.var_val_code
    when x17.var_code='Q' then x17.var_val_code
    when x18.var_code='Q' then x18.var_val_code
    when x19.var_code='Q' then x19.var_val_code
    when x20.var_code='Q' then x20.var_val_code
    else null end as str_var_17,
    
    case  when x1.var_code='R' then x1.var_val_code
    when x2.var_code='R' then x2.var_val_code
    when x3.var_code='R' then x3.var_val_code
    when x4.var_code='R' then x4.var_val_code
    when x5.var_code='R' then x5.var_val_code
    when x6.var_code='R' then x6.var_val_code
    when x7.var_code='R' then x7.var_val_code
    when x8.var_code='R' then x8.var_val_code
    when x9.var_code='R' then x9.var_val_code
    when x10.var_code='R' then x10.var_val_code
    when x11.var_code='R' then x11.var_val_code
    when x12.var_code='R' then x12.var_val_code
    when x13.var_code='R' then x13.var_val_code
    when x14.var_code='R' then x14.var_val_code
    when x15.var_code='R' then x15.var_val_code
    when x16.var_code='R' then x16.var_val_code
    when x17.var_code='R' then x17.var_val_code
    when x18.var_code='R' then x18.var_val_code
    when x19.var_code='R' then x19.var_val_code
    when x20.var_code='R' then x20.var_val_code
    else null end as str_var_18,
    
    case  when x1.var_code='S' then x1.var_val_code
    when x2.var_code='S' then x2.var_val_code
    when x3.var_code='S' then x3.var_val_code
    when x4.var_code='S' then x4.var_val_code
    when x5.var_code='S' then x5.var_val_code
    when x6.var_code='S' then x6.var_val_code
    when x7.var_code='S' then x7.var_val_code
    when x8.var_code='S' then x8.var_val_code
    when x9.var_code='S' then x9.var_val_code
    when x10.var_code='S' then x10.var_val_code
    when x11.var_code='S' then x11.var_val_code
    when x12.var_code='S' then x12.var_val_code
    when x13.var_code='S' then x13.var_val_code
    when x14.var_code='S' then x14.var_val_code
    when x15.var_code='S' then x15.var_val_code
    when x16.var_code='S' then x16.var_val_code
    when x17.var_code='S' then x17.var_val_code
    when x18.var_code='S' then x18.var_val_code
    when x19.var_code='S' then x19.var_val_code
    when x20.var_code='S' then x20.var_val_code
    else null end as str_var_19,
    
    case  when x1.var_code='T' then x1.var_val_code
    when x2.var_code='T' then x2.var_val_code
    when x3.var_code='T' then x3.var_val_code
    when x4.var_code='T' then x4.var_val_code
    when x5.var_code='T' then x5.var_val_code
    when x6.var_code='T' then x6.var_val_code
    when x7.var_code='T' then x7.var_val_code
    when x8.var_code='T' then x8.var_val_code
    when x9.var_code='T' then x9.var_val_code
    when x10.var_code='T' then x10.var_val_code
    when x11.var_code='T' then x11.var_val_code
    when x12.var_code='T' then x12.var_val_code
    when x13.var_code='T' then x13.var_val_code
    when x14.var_code='T' then x14.var_val_code
    when x15.var_code='T' then x15.var_val_code
    when x16.var_code='T' then x16.var_val_code
    when x17.var_code='T' then x17.var_val_code
    when x18.var_code='T' then x18.var_val_code
    when x19.var_code='T' then x19.var_val_code
    when x20.var_code='T' then x20.var_val_code
    else null end as str_var_20, vUnitId , vCatId , vOrgCode
from 
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=1 ) x1 ,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=2 ) x2 ,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=3 ) x3 , 
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=4 ) x4  ,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=5  ) x5,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=6 ) x6,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=7) x7,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=8) x8,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=9) x9,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=10) x10,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=11 ) x11 ,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=12 ) x12 ,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=13 ) x13 , 
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=14 ) x14  ,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=15  ) x15,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=16 ) x16,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=17) x17,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=18) x18,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=19) x19,
(select a.var_val_code, a.var_code, a.var_val_value from ITEM_VARIABLE_VALUES a RIGHT OUTER JOIN ITEM_VARIABLES B ON a.var_code = B.var_code AND  a.cartizian_applied = 'Y' where ordr=20) x20;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gl_posting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`elecon`@`localhost` PROCEDURE `gl_posting`(
	 p_org_code int(11),
     p_acc_code int(11),
     p_curr_code varchar(5),
     tr_date date,
     tr_debit decimal(20,5),
     tr_credit decimal(20,5) )
gl_posting : BEGIN
  declare v_ratio decimal(15,5);
  declare tmpvar int;
  declare v_found int;
  declare v_period_no decimal(10,0);
  declare v_fin_year_code varchar(8);
  declare cur_done int default 0;
  
     -- GET PERIOD FOR TRANSACTION DATE
   BEGIN
      SELECT fin_year_code, period_no
        INTO v_fin_year_code, v_period_no
        FROM GL_FINANCIAL_YEARS
       WHERE tr_date BETWEEN start_dt AND end_dt;
       if v_fin_year_code is null or v_period_no is null
      then leave gl_posting;
     -- set msg = 'No financial year or period number defined for this data';
       end if;
   END;
   -- GET RATIO TO CONVERT TO LOCAL CURRENCY
   BEGIN
      SELECT multiply_by
        INTO v_ratio
        FROM CURRENCY_TRANSFORM
       WHERE from_curr_code = p_curr_code
         AND transform_dt = (SELECT MAX(transform_dt)
                        FROM CURRENCY_TRANSFORM
                       WHERE from_curr_code = p_curr_code);
		if v_ratio is null then set v_ratio = 1;
        end if;
   END;
   -- check if account has a record in CURRENT financial year & period
  SELECT COUNT(1)
     INTO tmpvar
     FROM `GL_ORG_ACC_BAL_PERIOD`
    WHERE org_code = p_org_code
      AND curr_code = p_curr_code
      AND acc_code = p_acc_code
      AND fin_year_code = v_fin_year_code
      AND period_no = v_period_no;
 IF tmpvar = 0
-- IF NOT, THEN CHECK THE ACCOUNT HAS A RECORD IN THE PREVIOUS YAER & PERIOD   
   THEN
      SELECT COUNT(1)
        INTO tmpvar
        FROM `GL_ORG_ACC_BAL_PERIOD`
       WHERE org_code = p_org_code
         AND (fin_year_code, period_no) IN (
                SELECT gl_financial_years.fin_year_code,
                       gl_financial_years.period_no
                  FROM `GL_FINANCIAL_YEARS` gl_financial_years
                 WHERE gl_financial_years.start_dt < tr_date)
         AND curr_code = p_curr_code
         AND acc_code = p_acc_code;
         
-- CHECK IF THE ACCOUNT HAS A RECORD IN GL_ORG_ACC_BALANCE

      SELECT COUNT(1)
        INTO v_found
        FROM GL_ORG_ACC_BALANCE
       WHERE org_code = p_org_code
         AND acc_code = p_acc_code
         AND curr_code = p_curr_code;

      IF v_found = 0
-- IF NOT, THEN CREATE NEW RECORDS FOR ACCOUNT TREE IN THE HISTORY FOR NEW MONTHS.
      THEN
         INSERT INTO GL_ORG_ACC_BALANCE (org_code, acc_code, curr_code)
      SELECT T2.org_code, T2.acc_code, p_curr_code
                   FROM ( SELECT @r AS _acc_code,
        (SELECT @r := prnt_acc_code FROM GL_ORG_ACC_CHART WHERE acc_code = _acc_code) AS prnt_acc_code,
        @l := @l + 1 AS lvl
    FROM
        (SELECT @r := p_acc_code, @l := 0) vars,
        GL_ORG_ACC_CHART h
    WHERE @r <> 0) T1
JOIN GL_ORG_ACC_CHART T2
ON T1._acc_code = T2.acc_code
                  AND acc_code NOT IN ( select xx.acc_code from (
                           SELECT goabd.acc_code
                             FROM GL_ORG_ACC_BALANCE goabd
                            WHERE goabd.org_code = p_org_code) as xx);
      END IF;
        IF tmpvar > 0
-- CREATE A NEW RECORD AND SET IT's OPEN BALANCE WITH THE CLOSED BALANCE FROM PREVIOUS CLOSED PERIOD
      THEN
	INSERT INTO GL_ORG_ACC_BAL_PERIOD
			 (org_code, acc_code, curr_code, period_no, fin_year_code,
			  open_debit, open_credit, close_debit, close_credit,
			  trans_debit, trans_credit, 
              local_open_debit, local_open_credit,
			  local_trans_debit, 
              local_trans_credit, 
              local_close_debit, 
              local_close_credit)
	SELECT org_code, acc_code,curr_code, period_no, fin_year_code,
		   close_debit, close_credit, close_debit + IFNULL(tr_debit, 0), close_credit + IFNULL(tr_credit, 0),
		   IFNULL(tr_debit, 0) + close_debit, IFNULL(tr_credit, 0) + close_credit,
		   v_ratio * close_debit, v_ratio * close_credit, 
           v_ratio * (close_debit + IFNULL(tr_debit, 0)), 
           v_ratio * (close_credit + IFNULL(tr_credit, 0)),
		   v_ratio * (close_debit + IFNULL(tr_debit, 0)), 
           v_ratio * (close_credit + IFNULL(tr_credit, 0))
	  FROM GL_ORG_ACC_BAL_PERIOD
	 WHERE (period_no, fin_year_code) IN (
			  SELECT t1.period_no, t1.fin_year_code
				FROM `GL_FINANCIAL_YEARS` t1
			   WHERE t1.start_dt =
						(SELECT MAX (t2.start_dt)
						   FROM `GL_FINANCIAL_YEARS` t2,
								`GL_ORG_ACC_BAL_PERIOD` t3
						  WHERE t2.period_no = t3.gfy_period_no
							AND t2.fin_year_code = t3.gfy_fin_year_code
							AND t2.start_dt < tr_date))
	   AND org_code = p_org_code
	   AND acc_code = p_acc_code
	   AND curr_code = p_curr_code;
       
    ELSE -- INSERT NEW RECORD FOR THE NEW PERIOD
    -- AND ADD DEBIT & CREDIT TO LEAF ONLY -- Loop
    
     insert into `GL_ORG_ACC_BAL_PERIOD`  (
org_code,acc_code,curr_code, fin_year_code, period_no,
					open_debit, open_credit,
					close_debit, 
					close_credit,
					trans_debit, 
					trans_credit,
					local_open_debit, local_open_credit,
					local_trans_debit, 
					local_trans_credit,
					local_close_debit, 
					local_close_credit)
				SELECT T2.org_code, T2.acc_code, p_curr_code, v_fin_year_code , v_period_no,
					0,0,
					IF(T2.acc_code=p_acc_code and T2.org_code=p_org_code, IFNULL(tr_debit,0),0), 
					IF(T2.acc_code=p_acc_code and T2.org_code=p_org_code, IFNULL(tr_credit, 0),0), 
					IF(T2.acc_code=p_acc_code and T2.org_code=p_org_code, IFNULL(tr_debit,0),0), 
					IF(T2.acc_code=p_acc_code and T2.org_code=p_org_code, IFNULL(tr_credit, 0),0), 
					0,0,
					IF(T2.acc_code=p_acc_code and T2.org_code=p_org_code, v_ratio * IFNULL(tr_debit, 0),0),
					IF(T2.acc_code=p_acc_code and T2.org_code=p_org_code, v_ratio * IFNULL(tr_credit, 0),0),
					IF(T2.acc_code=p_acc_code and T2.org_code=p_org_code, v_ratio * IFNULL(tr_debit, 0),0),
					IF(T2.acc_code=p_acc_code and T2.org_code=p_org_code, v_ratio * IFNULL(tr_credit, 0),0)
                   FROM ( SELECT @r AS _acc_code,
        (SELECT @r := prnt_acc_code FROM GL_ORG_ACC_CHART WHERE acc_code = _acc_code) AS prnt_acc_code,
        @l := @l + 1 AS lvl
    FROM
        (SELECT @r := p_acc_code, @l := 0) vars,
        GL_ORG_ACC_CHART h
    WHERE @r <> 0) T1
JOIN GL_ORG_ACC_CHART T2
ON T1._acc_code = T2.acc_code
                  AND acc_code NOT IN (
                           SELECT goabd.acc_code
                             FROM GL_ORG_ACC_BAL_PERIOD goabd
                            WHERE goabd.org_code = p_org_code
                              AND goabd.fin_year_code = v_fin_year_code
                              AND goabd.period_no = v_period_no
                              AND goabd.curr_code = p_curr_code);
-- UPDATE THE PARENTS OF THE ENTERED ACCOUNT CODE WITHOUT THE ACCOUNT ITSELF
  UPDATE GL_ORG_ACC_BAL_PERIOD 
         SET trans_debit = IFNULL(trans_debit, 0) + IFNULL(tr_debit, 0),
             trans_credit = IFNULL(trans_credit, 0) + IFNULL(tr_credit, 0),
             close_debit = IFNULL(close_debit, 0) + IFNULL(tr_debit, 0),
             close_credit = IFNULL(close_credit, 0) + IFNULL(tr_credit, 0),
             local_close_debit = IFNULL(local_close_debit, 0) + (IFNULL(tr_debit, 0) * v_ratio),
             local_close_credit = IFNULL(local_close_credit, 0) + (IFNULL(tr_credit, 0) * v_ratio),
             local_trans_debit = IFNULL(local_trans_debit, 0) + (IFNULL(tr_debit, 0) * v_ratio),
             local_trans_credit = IFNULL(local_trans_credit, 0) + (IFNULL(tr_credit, 0) * v_ratio)
         WHERE fin_year_code = v_fin_year_code
         AND period_no = v_period_no
         AND org_code = p_org_code
         AND curr_code = p_curr_code
         AND acc_code IN( SELECT  T2.acc_code
                   FROM ( SELECT @r AS _acc_code,
        (SELECT @r := prnt_acc_code FROM GL_ORG_ACC_CHART WHERE acc_code = _acc_code) AS prnt_acc_code,
        @l := @l + 1 AS lvl
    FROM
        (SELECT @r := p_acc_code, @l := 0) vars,
        GL_ORG_ACC_CHART h
    WHERE @r <> 0) T1
JOIN GL_ORG_ACC_CHART T2
ON T1._acc_code = T2.acc_code -- and org_code = p_org_code
		AND acc_code IN ( select xx.acc_code from (
			 SELECT  acc_code
			   FROM GL_ORG_ACC_BAL_PERIOD
			  WHERE org_code = p_org_code
				AND fin_year_code = v_fin_year_code
				AND period_no = v_period_no
				AND curr_code = p_curr_code) as xx) 
  AND acc_code <> p_acc_code );
   END IF;    
  ELSE
  -- UPDATE ALL ACCOUNT TREE INCLUDING ACCOUNT NUMBER ITSELF
  UPDATE GL_ORG_ACC_BAL_PERIOD 
         SET trans_debit = IFNULL(trans_debit, 0) + IFNULL(tr_debit, 0),
             trans_credit = IFNULL(trans_credit, 0) + IFNULL(tr_credit, 0),
             close_debit = IFNULL(close_debit, 0) + IFNULL(tr_debit, 0),
             close_credit = IFNULL(close_credit, 0) + IFNULL(tr_credit, 0),
             local_close_debit = IFNULL(local_close_debit, 0) + (IFNULL(tr_debit, 0) * v_ratio),
             local_close_credit = IFNULL(local_close_credit, 0) + (IFNULL(tr_credit, 0) * v_ratio),
             local_trans_debit = IFNULL(local_trans_debit, 0) + (IFNULL(tr_debit, 0) * v_ratio),
             local_trans_credit = IFNULL(local_trans_credit, 0) + (IFNULL(tr_credit, 0) * v_ratio)
         WHERE fin_year_code = v_fin_year_code
         AND period_no = v_period_no
         AND org_code = p_org_code
         AND curr_code = p_curr_code
         AND acc_code IN( SELECT  T2.acc_code
                   FROM ( SELECT @r AS _acc_code,
        (SELECT @r := prnt_acc_code FROM GL_ORG_ACC_CHART WHERE acc_code = _acc_code) AS prnt_acc_code,
        @l := @l + 1 AS lvl
    FROM
        (SELECT @r := p_acc_code, @l := 0) vars,
        GL_ORG_ACC_CHART h
    WHERE @r <> 0) T1
JOIN GL_ORG_ACC_CHART T2
ON T1._acc_code = T2.acc_code -- and org_code = p_org_code
		AND acc_code IN ( select xx.acc_code from (
			 SELECT acc_code
			   FROM GL_ORG_ACC_BAL_PERIOD
			  WHERE org_code = p_org_code
				AND fin_year_code = v_fin_year_code
				AND period_no = v_period_no
				AND curr_code = p_curr_code) as xx));
   END IF;
   -- UPDATE PERIODS AFTER THAT PERIOD
   BEGIN
   UPDATE `GL_ORG_ACC_BAL_PERIOD`
      SET trans_debit = IFNULL(trans_debit, 0) + IFNULL(tr_debit, 0),
          trans_credit = IFNULL(trans_credit, 0) + IFNULL(tr_credit, 0),
          close_debit = IFNULL(close_debit, 0) + IFNULL(tr_debit, 0),
          close_credit = IFNULL(close_credit, 0) + IFNULL(tr_credit, 0),
          local_close_debit = IFNULL(local_close_debit, 0)
                      + (IFNULL(tr_debit, 0) * v_ratio),
          local_close_credit =
                      IFNULL(local_close_credit, 0)
                    + (IFNULL(tr_credit, 0) * v_ratio),
          local_trans_debit = IFNULL(local_trans_debit, 0)
                      + (IFNULL(tr_debit, 0) * v_ratio),
          local_trans_credit = IFNULL(local_trans_credit, 0)
                    + (IFNULL(tr_credit, 0) * v_ratio),
          open_debit = IFNULL(open_debit, 0) + IFNULL(tr_debit, 0),
          open_credit = IFNULL(open_credit, 0) + IFNULL(tr_credit, 0),
          local_open_debit = IFNULL(local_open_debit, 0)
                       + (IFNULL(tr_debit, 0) * v_ratio),
          local_open_credit =
                       IFNULL(local_open_credit, 0)
                     + (IFNULL(tr_credit, 0) * v_ratio)
    WHERE (period_no, fin_year_code) IN (
							   SELECT period_no,
									  fin_year_code
								 FROM `GL_FINANCIAL_YEARS`
								WHERE tr_date < start_dt)
      AND org_code = p_org_code
      AND curr_code = p_curr_code
      AND acc_code IN (SELECT  T2.acc_code
                   FROM ( SELECT @r AS _acc_code,
        (SELECT @r := prnt_acc_code FROM GL_ORG_ACC_CHART WHERE acc_code = _acc_code) AS prnt_acc_code,
        @l := @l + 1 AS lvl
    FROM
        (SELECT @r := p_acc_code, @l := 0) vars,
        GL_ORG_ACC_CHART h
    WHERE @r <> 0) T1
JOIN GL_ORG_ACC_CHART T2
ON T1._acc_code = T2.acc_code -- and org_code = p_org_code
		AND acc_code IN ( select xx.acc_code from ( 
			 SELECT acc_code
			   FROM GL_ORG_ACC_BAL_PERIOD 
			  WHERE org_code = p_org_code
				AND (fin_year_code , period_no) in
                (SELECT  fin_year_code, period_no
                FROM `GL_FINANCIAL_YEARS`
                WHERE tr_date < start_dt) 
             )as xx) );
END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reverse_document` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`elecon`@`localhost` PROCEDURE `reverse_document`(in v_gl_doc_id int(11),in v_org_code int(11),
out o_gl_doc_id int(11))
BEGIN
declare v_time int;
set v_time = unix_timestamp();
INSERT INTO `GL_DOCUMENTS`
(`gl_doc_id`,
`gl_doc_name`,
`gl_doc_dt`,
`reversed_flag`,
`balance_flag`,
`post_flag`,
`org_code`,
`gl_trns_type_id`,
`origin_gl_doc_id`,
`origin_org_code`)
SELECT v_time, concat('Reversed - ',gl_doc_name), now(),'','Y','N',v_org_code,
4,v_gl_doc_id, v_org_code from GL_DOCUMENTS
WHERE gl_doc_id = v_gl_doc_id and org_code = v_org_code;
INSERT INTO `GL_JOURNALS`
(`jornal_id`,
`acc_code`,
`org_code`,
`ass_code`,
`curr_code`,`debit`,`credit`,
`local_debit`,`local_credit`,
`cost_center_code`,
`notes`,
`gl_doc_id`,
`gl_documents_org_code`)
select
`jornal_id`,
`acc_code`,
`org_code`,
`ass_code`,
`curr_code`,`credit`,`debit`,
`local_credit`,`local_debit`,
`cost_center_code`,
`notes`,
v_time,
v_org_code
from GL_JOURNALS WHERE (gl_doc_id = v_gl_doc_id and gl_documents_org_code = v_org_code);
set o_gl_doc_id = v_time;
update GL_DOCUMENTS SET `origin_gl_doc_id`= o_gl_doc_id , reversed_flag='Y' 
where (gl_doc_id = v_gl_doc_id and org_code = v_org_code);
END ;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`elecon`@`localhost` PROCEDURE `test`()
BEGIN
declare i int;
set i =1;
while i<2 do
UPDATE ITEM_VARIABLES_TEST SET str_var_i=
case when substring(str_var_1,1,2) = 'A-' then substring(str_var_1,3) 
	 when substring(str_var_2,1,2) = 'A-' then substring(str_var_2,3) 
     when substring(str_var_3,1,2) = 'A-' then substring(str_var_3,3) 
     when substring(str_var_4,1,2) = 'A-' then substring(str_var_4,3) 
else null end;
set i =1+1;
end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_original_gl_doc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`elecon`@`localhost` PROCEDURE `update_original_gl_doc`(in v_orgin_gl_doc_id int(11), in v_orgin_org_code int(11))
BEGIN
update GL_DOCUMENTS SET origin_gl_doc_id = null, origin_org_code =null, reversed_flag='N'
where gl_doc_id = v_orgin_gl_doc_id and org_code = v_orgin_org_code;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `validate_var_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`elecon`@`localhost` PROCEDURE `validate_var_value`(in v_val varchar(100), out returned_recs int(10))
BEGIN
select count(*) into returned_recs from ITEMS_LIST where item_indx like v_val;
END ;;
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

-- Dump completed on 2025-06-21 22:15:56
