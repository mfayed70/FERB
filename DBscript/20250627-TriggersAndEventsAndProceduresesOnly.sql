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

-- Dump completed on 2025-06-27 19:20:38
