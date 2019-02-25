
USE `simplesvet`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: simplesvet
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `animais`
--

DROP TABLE IF EXISTS `animais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `animais` (
  `ANI_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `ANI_NOME` varchar(100) NOT NULL,
  `ANI_SEXO` varchar(1) NOT NULL,
  `ANI_ESPECIE` varchar(1) NOT NULL,
  `ANI_CHIP` varchar(20) NOT NULL,
  `ANI_DT_NASCIMENTO` date NOT NULL,
  `ANI_DT_UPDATE` date DEFAULT NULL,
  `ANI_DT_FALECIMENTO` date DEFAULT NULL,
  `RAC_CODIGO` int(11) NOT NULL,
  `ANI_IMG` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ANI_CODIGO`),
  KEY `FK_ANIMAL_RACA` (`RAC_CODIGO`),
  CONSTRAINT `FK_ANIMAL_RACA` FOREIGN KEY (`RAC_CODIGO`) REFERENCES `racas` (`RAC_CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animais`
--

LOCK TABLES `animais` WRITE;
/*!40000 ALTER TABLE `animais` DISABLE KEYS */;
/*!40000 ALTER TABLE `animais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racas`
--

DROP TABLE IF EXISTS `racas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `racas` (
  `RAC_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `RAC_DESCRICAO` varchar(100) NOT NULL,
  `RAC_ESPECIE` tinyint(4) NOT NULL,
  `RAC_SITUACAO` varchar(3) NOT NULL DEFAULT 'ATI',
  PRIMARY KEY (`RAC_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racas`
--

LOCK TABLES `racas` WRITE;
/*!40000 ALTER TABLE `racas` DISABLE KEYS */;
INSERT INTO `racas` VALUES (2,'Retrievers (Labrador)',1,'ATI'),(3,'German Shepherd Dogs',1,'ATI'),(4,'Retrievers (Golden)',1,'ATI'),(5,'French Bulldogs',1,'ATI'),(6,'Bulldogs',1,'ATI'),(7,'Beagles',1,'ATI'),(8,'Poodles',1,'ATI'),(9,'Rottweilers',1,'ATI'),(10,'Yorkshire Terriers',1,'ATI'),(11,'Pointers (German Shorthaired)',1,'ATI'),(12,'Siamese',2,'ATI'),(13,'Persian',2,'ATI'),(14,'Maine Coon',2,'ATI'),(15,'Ragdoll',2,'ATI'),(16,'Devon Rex',2,'ATI'),(17,'Bengal',2,'ATI'),(18,'Abyssinian',2,'ATI'),(19,'Birman',2,'ATI'),(20,'Oriental Shorthair',2,'ATI'),(21,'Sphynx',2,'ATI');
/*!40000 ALTER TABLE `racas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_animais`
--

DROP TABLE IF EXISTS `vw_animais`;
/*!50001 DROP VIEW IF EXISTS `vw_animais`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_animais` AS SELECT 
 1 AS `cod`,
 1 AS `nome`,
 1 AS `sexo`,
 1 AS `especie`,
 1 AS `especie_cod`,
 1 AS `chip`,
 1 AS `dtNascimento`,
 1 AS `dtUpdate`,
 1 AS `dtFalecimento`,
 1 AS `codRaca`,
 1 AS `raca`,
 1 AS `idade`,
 1 AS `Vivo`,
 1 AS `path`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_racas`
--

DROP TABLE IF EXISTS `vw_racas`;
/*!50001 DROP VIEW IF EXISTS `vw_racas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_racas` AS SELECT 
 1 AS `cod`,
 1 AS `descricao`,
 1 AS `especie`,
 1 AS `especie_cod`,
 1 AS `situacao`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'simplesvet'
--
/*!50003 DROP FUNCTION IF EXISTS `fc_retornaIdade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fc_retornaIdade`(dtNascimento date) RETURNS int(11)
    DETERMINISTIC
BEGIN 
  DECLARE age int;
  SET age = TIMESTAMPDIFF(YEAR, now(), dtNascimento);
  RETURN age;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_animal_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_animal_insert`(
    IN  nome varchar(100),
    IN  sexo varchar(1),
    IN  especie varchar(1),
    IN chip  varchar(20),
    IN dtNascimento date,
    IN dtFalecimento date,
    IN raca_cod int
)
BEGIN
    INSERT INTO animais(ANI_NOME,ANI_SEXO,ANI_ESPECIE,ANI_CHIP,ANI_DT_NASCIMENTO,ANI_DT_FALECIMENTO,RAC_CODIGO)
    VALUES(nome,sexo,especie,chip,dtNascimento,dtFalecimento,raca_cod);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_animal_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_animal_update`(
    IN cod int,
    IN  nome varchar(100),
    IN  sexo varchar(1),
    IN  especie varchar(1),
    IN chip  varchar(20),
    IN dtNascimento date,
    IN dtFalecimento date,
    IN raca_cod int
)
BEGIN
    UPDATE animais
        SET ANI_NOME = nome
        ,ANI_SEXO = sexo
        ,ANI_ESPECIE = especie
        ,ANI_CHIP = chip
        ,ANI_DT_NASCIMENTO = dtNascimento
        ,ANI_DT_FALECIMENTO = dtFalecimento
        ,RAC_CODIGO = raca_cod
        ,ANI_DT_UPDATE = now()
        WHERE ANI_CODIGO = cod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_animais`
--

/*!50001 DROP VIEW IF EXISTS `vw_animais`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4 */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_animais` AS select `animais`.`ANI_CODIGO` AS `cod`,`animais`.`ANI_NOME` AS `nome`,(case when (`animais`.`ANI_SEXO` = 'M') then 'Macho' when (`animais`.`ANI_SEXO` = 'F') then 'Fêmea' else 'Sexo não identificado!' end) AS `sexo`,(case when (`animais`.`ANI_ESPECIE` = 1) then 'Cachorro' when (`animais`.`ANI_ESPECIE` = 2) then 'Gato' else 'Espécie não identificada!' end) AS `especie`,`animais`.`ANI_ESPECIE` AS `especie_cod`,`animais`.`ANI_CHIP` AS `chip`,date_format(`animais`.`ANI_DT_NASCIMENTO`,'%d/%m/%Y') AS `dtNascimento`,date_format(`animais`.`ANI_DT_UPDATE`,'%d/%m/%Y') AS `dtUpdate`,date_format(`animais`.`ANI_DT_FALECIMENTO`,'%d/%m/%Y') AS `dtFalecimento`,`animais`.`RAC_CODIGO` AS `codRaca`,`racas`.`RAC_DESCRICAO` AS `raca`,`fc_retornaIdade`(`animais`.`ANI_DT_NASCIMENTO`) AS `idade`,(case when (`animais`.`ANI_DT_FALECIMENTO` <= now()) then 'true' else 'false' end) AS `Vivo`,`animais`.`ANI_IMG` AS `path` from (`animais` join `racas` on((`animais`.`RAC_CODIGO` = `racas`.`RAC_CODIGO`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_racas`
--

/*!50001 DROP VIEW IF EXISTS `vw_racas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4 */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`selecao_fullstack`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_racas` AS select `racas`.`RAC_CODIGO` AS `cod`,`racas`.`RAC_DESCRICAO` AS `descricao`,(case when (`racas`.`RAC_ESPECIE` = 1) then 'Cachorro' when (`racas`.`RAC_ESPECIE` = 2) then 'Gato' else 'Espécie não identificada!' end) AS `especie`,`racas`.`RAC_ESPECIE` AS `especie_cod`,(case when (`racas`.`RAC_SITUACAO` = 'ATI') then 'Ativo' when (`racas`.`RAC_SITUACAO` = 'INA') then 'Inativo' else 'Situação não identificada!' end) AS `situacao` from `racas` */;
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

-- Dump completed on 2019-02-24 19:45:12
