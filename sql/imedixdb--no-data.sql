-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: imedixdb4
-- ------------------------------------------------------
-- Server version	8.0.22-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__center`
--

DROP TABLE IF EXISTS `__center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__center` (
  `code` varchar(5) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `cdate` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `ipaddress` varchar(20) DEFAULT NULL,
  `centertype` char(1) DEFAULT NULL,
  `ftpip` varchar(15) DEFAULT NULL,
  `ftp_uname` varchar(20) DEFAULT NULL,
  `ftp_pwd` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a13`
--

DROP TABLE IF EXISTS `a13`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a13` (
  `pat_id` char(18) NOT NULL,
  `vaccine_id` int NOT NULL,
  `site` varchar(100) DEFAULT NULL,
  `age_given` varchar(100) DEFAULT NULL,
  `code` varchar(25) DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`vaccine_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a14`
--

DROP TABLE IF EXISTS `a14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a14` (
  `pat_id` char(18) NOT NULL,
  `comp1` varchar(200) DEFAULT NULL,
  `dur1` varchar(50) DEFAULT NULL,
  `hdmy1` varchar(10) DEFAULT NULL,
  `comp2` varchar(200) DEFAULT NULL,
  `dur2` varchar(50) DEFAULT NULL,
  `hdmy2` varchar(10) DEFAULT NULL,
  `comp3` varchar(200) DEFAULT NULL,
  `dur3` varchar(50) DEFAULT NULL,
  `hdmy3` varchar(10) DEFAULT NULL,
  `rh` longtext,
  `report_link` varchar(60) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a15`
--

DROP TABLE IF EXISTS `a15`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a15` (
  `pat_id` char(18) NOT NULL,
  `what` varchar(145) DEFAULT NULL,
  `finding` varchar(145) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a16`
--

DROP TABLE IF EXISTS `a16`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a16` (
  `pat_id` char(18) NOT NULL,
  `nonodes` int DEFAULT NULL,
  `lnloc` char(10) DEFAULT NULL,
  `lnrb` char(10) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a17`
--

DROP TABLE IF EXISTS `a17`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a17` (
  `pat_id` char(18) NOT NULL,
  `proc_name` varchar(50) DEFAULT NULL,
  `study_purpose` varchar(50) DEFAULT NULL,
  `roi` varchar(50) DEFAULT NULL,
  `intervention` varchar(50) DEFAULT NULL,
  `specimen` varchar(50) DEFAULT NULL,
  `comments` longtext,
  `diagnosis` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a18`
--

DROP TABLE IF EXISTS `a18`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a18` (
  `pat_id` char(18) NOT NULL,
  `lesion` longtext,
  `feature` longtext,
  `les_color` varchar(50) DEFAULT NULL,
  `les_shape` varchar(50) DEFAULT NULL,
  `distribution` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `site` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a19`
--

DROP TABLE IF EXISTS `a19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a19` (
  `pat_id` char(18) NOT NULL,
  `effort` varchar(50) DEFAULT NULL,
  `scoliosis` varchar(10) DEFAULT NULL,
  `kyphosis` varchar(50) DEFAULT NULL,
  `flat` varchar(10) DEFAULT NULL,
  `expand` varchar(10) DEFAULT NULL,
  `shift` varchar(10) DEFAULT NULL,
  `tender` varchar(20) DEFAULT NULL,
  `note1` varchar(50) DEFAULT NULL,
  `sound1` varchar(50) DEFAULT NULL,
  `extra1` varchar(50) DEFAULT NULL,
  `vr1` varchar(50) DEFAULT NULL,
  `loc1` longtext,
  `note2` varchar(50) DEFAULT NULL,
  `sound2` varchar(50) DEFAULT NULL,
  `extra2` varchar(50) DEFAULT NULL,
  `vr2` varchar(50) DEFAULT NULL,
  `loc2` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a20`
--

DROP TABLE IF EXISTS `a20`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a20` (
  `pat_id` char(18) NOT NULL,
  `abdo` varchar(50) DEFAULT NULL,
  `veins` varchar(50) DEFAULT NULL,
  `pulsation` varchar(50) DEFAULT NULL,
  `tender_loc` varchar(50) DEFAULT NULL,
  `liver_length` varchar(50) DEFAULT NULL,
  `liver_border` varchar(50) DEFAULT NULL,
  `hepatomegaly` varchar(50) DEFAULT NULL,
  `hepa_surface` varchar(50) DEFAULT NULL,
  `hepa_tenderness` varchar(50) DEFAULT NULL,
  `spleen_length` varchar(50) DEFAULT NULL,
  `spln_tenderness` varchar(50) DEFAULT NULL,
  `splenomegaly` varchar(50) DEFAULT NULL,
  `dullness` varchar(50) DEFAULT NULL,
  `fluid` varchar(50) DEFAULT NULL,
  `bowelsound` varchar(50) DEFAULT NULL,
  `borborygami` varchar(50) DEFAULT NULL,
  `lumph_length` varchar(50) DEFAULT NULL,
  `lumph_width` varchar(50) DEFAULT NULL,
  `palpable` varchar(50) DEFAULT NULL,
  `lump` varchar(50) DEFAULT NULL,
  `palp_surface` varchar(50) DEFAULT NULL,
  `abominal` varchar(50) DEFAULT NULL,
  `cavity` varchar(50) DEFAULT NULL,
  `above` varchar(50) DEFAULT NULL,
  `below` varchar(50) DEFAULT NULL,
  `fixed` varchar(50) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `bimanual` varchar(50) DEFAULT NULL,
  `pulsatile` varchar(50) DEFAULT NULL,
  `reducible` varchar(50) DEFAULT NULL,
  `fluctuant` varchar(50) DEFAULT NULL,
  `transillumination` varchar(50) DEFAULT NULL,
  `left_kidney` varchar(50) DEFAULT NULL,
  `right_kidney` varchar(50) DEFAULT NULL,
  `gall_bladder` varchar(50) DEFAULT NULL,
  `pancreas` varchar(50) DEFAULT NULL,
  `aorta` varchar(50) DEFAULT NULL,
  `undefined` varchar(50) DEFAULT NULL,
  `lump_loc` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a21`
--

DROP TABLE IF EXISTS `a21`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a21` (
  `pat_id` char(18) NOT NULL,
  `infection_diag` varchar(50) DEFAULT NULL,
  `infection_icd` varchar(50) DEFAULT NULL,
  `infection_onset` varchar(50) DEFAULT NULL,
  `infection_duration` int DEFAULT NULL,
  `infection_hdmy` varchar(50) DEFAULT NULL,
  `infection_hos` varchar(50) DEFAULT NULL,
  `tb_exposure` varchar(50) DEFAULT NULL,
  `tb_diag` varchar(50) DEFAULT NULL,
  `tb_icd` varchar(50) DEFAULT NULL,
  `tb_onset` varchar(50) DEFAULT NULL,
  `tb_duration` int DEFAULT NULL,
  `tb_hdmy` varchar(50) DEFAULT NULL,
  `tb_hos` varchar(50) DEFAULT NULL,
  `past_diag` varchar(50) DEFAULT NULL,
  `past_icd` varchar(50) DEFAULT NULL,
  `past_onset` varchar(50) DEFAULT NULL,
  `past_duration` int DEFAULT NULL,
  `past_hdmy` varchar(50) DEFAULT NULL,
  `past_hos` varchar(50) DEFAULT NULL,
  `past_surgery` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a22`
--

DROP TABLE IF EXISTS `a22`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a22` (
  `pat_id` char(18) NOT NULL,
  `term` varchar(50) DEFAULT NULL,
  `delivery` varchar(50) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `mat_ante` varchar(50) DEFAULT NULL,
  `mat_duration` varchar(50) DEFAULT NULL,
  `mat_partum` varchar(50) DEFAULT NULL,
  `dose` varchar(50) DEFAULT NULL,
  `arv` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a23`
--

DROP TABLE IF EXISTS `a23`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a23` (
  `pat_id` char(18) NOT NULL,
  `age` varchar(15) DEFAULT NULL,
  `gross_motor` longtext,
  `gross_motor_age` varchar(15) DEFAULT NULL,
  `visual_motor` longtext,
  `visual_motor_age` varchar(15) DEFAULT NULL,
  `lang` longtext,
  `lang_age` varchar(15) DEFAULT NULL,
  `social` longtext,
  `social_age` varchar(15) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a24`
--

DROP TABLE IF EXISTS `a24`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a24` (
  `pat_id` char(18) NOT NULL,
  `education` varchar(80) DEFAULT NULL,
  `occupation` varchar(80) DEFAULT NULL,
  `income` varchar(50) DEFAULT NULL,
  `socio_class` varchar(20) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a25`
--

DROP TABLE IF EXISTS `a25`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a25` (
  `pat_id` char(18) NOT NULL,
  `emotional` varchar(10) DEFAULT NULL,
  `tbxemotional` longtext,
  `financial` varchar(10) DEFAULT NULL,
  `tbxfinancial` longtext,
  `other` varchar(10) DEFAULT NULL,
  `tbxother` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a26`
--

DROP TABLE IF EXISTS `a26`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a26` (
  `pat_id` char(18) NOT NULL,
  `support` char(5) DEFAULT NULL,
  `tbxsupport` longtext,
  `financial` char(5) DEFAULT NULL,
  `tbxfinancial` longtext,
  `emotional` char(5) DEFAULT NULL,
  `tbxemotional` longtext,
  `physical` char(5) DEFAULT NULL,
  `tbxphysical` longtext,
  `disclosure` char(5) DEFAULT NULL,
  `tbxdisclosure` longtext,
  `occupation` char(5) DEFAULT NULL,
  `tbxoccupation` longtext,
  `other` char(5) DEFAULT NULL,
  `tbxother` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a27`
--

DROP TABLE IF EXISTS `a27`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a27` (
  `pat_id` char(18) NOT NULL,
  `maternal` varchar(5) DEFAULT NULL,
  `tbxmaternal` longtext,
  `transfusion` varchar(5) DEFAULT NULL,
  `tbxtransfusion` longtext,
  `other` varchar(5) DEFAULT NULL,
  `tbxother` longtext,
  `tbxage` longtext,
  `testtype` varchar(10) DEFAULT NULL,
  `result` varchar(10) DEFAULT NULL,
  `repeatdate` varchar(50) DEFAULT NULL,
  `feeding` varchar(10) DEFAULT NULL,
  `tbxfeeding` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a28`
--

DROP TABLE IF EXISTS `a28`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a28` (
  `pat_id` char(18) NOT NULL,
  `missingdose` longtext,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a29`
--

DROP TABLE IF EXISTS `a29`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a29` (
  `pat_id` char(18) NOT NULL,
  `caregiver` longtext,
  `moth_living` char(10) DEFAULT NULL,
  `moth_hiv` char(10) DEFAULT NULL,
  `tbxmoth_health` longtext,
  `fath_living` char(10) DEFAULT NULL,
  `fath_hiv` char(10) DEFAULT NULL,
  `tbxfath_health` longtext,
  `adult` varchar(10) DEFAULT NULL,
  `sibling` varchar(10) DEFAULT NULL,
  `other` varchar(15) DEFAULT NULL,
  `sib_test` varchar(50) DEFAULT NULL,
  `tbxsibtest` longtext,
  `school` varchar(50) DEFAULT NULL,
  `bath` varchar(100) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a30`
--

DROP TABLE IF EXISTS `a30`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a30` (
  `pat_id` char(18) NOT NULL,
  `fever` char(3) DEFAULT NULL,
  `activity` char(3) DEFAULT NULL,
  `wt_loss` char(3) DEFAULT NULL,
  `app_loss` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a31`
--

DROP TABLE IF EXISTS `a31`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a31` (
  `pat_id` char(18) NOT NULL,
  `ear` char(3) DEFAULT NULL,
  `vision` char(3) DEFAULT NULL,
  `odynophagia` char(3) DEFAULT NULL,
  `thinorchea` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a32`
--

DROP TABLE IF EXISTS `a32`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a32` (
  `pat_id` char(18) NOT NULL,
  `rash` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a33`
--

DROP TABLE IF EXISTS `a33`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a33` (
  `pat_id` char(18) NOT NULL,
  `cough` char(3) DEFAULT NULL,
  `breath` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a34`
--

DROP TABLE IF EXISTS `a34`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a34` (
  `pat_id` char(18) NOT NULL,
  `chest` char(3) DEFAULT NULL,
  `breath` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a35`
--

DROP TABLE IF EXISTS `a35`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a35` (
  `pat_id` char(18) NOT NULL,
  `diarrhea` char(3) DEFAULT NULL,
  `constipation` char(3) DEFAULT NULL,
  `stools` char(3) DEFAULT NULL,
  `abdominal` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a36`
--

DROP TABLE IF EXISTS `a36`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a36` (
  `pat_id` char(18) NOT NULL,
  `growth` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a37`
--

DROP TABLE IF EXISTS `a37`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a37` (
  `pat_id` char(18) NOT NULL,
  `lumps` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a38`
--

DROP TABLE IF EXISTS `a38`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a38` (
  `pat_id` char(18) NOT NULL,
  `diff_urin` char(3) DEFAULT NULL,
  `burn_urin` char(3) DEFAULT NULL,
  `blood_urin` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a39`
--

DROP TABLE IF EXISTS `a39`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a39` (
  `pat_id` char(18) NOT NULL,
  `weakness` char(3) DEFAULT NULL,
  `fail` char(3) DEFAULT NULL,
  `numbness` char(3) DEFAULT NULL,
  `speaking` char(3) DEFAULT NULL,
  `walking` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a40`
--

DROP TABLE IF EXISTS `a40`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a40` (
  `pat_id` char(18) NOT NULL,
  `school` char(3) DEFAULT NULL,
  `withdrawn` char(3) DEFAULT NULL,
  `sad` char(3) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a41`
--

DROP TABLE IF EXISTS `a41`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a41` (
  `pat_id` char(18) NOT NULL,
  `pain` char(50) DEFAULT NULL,
  `tbxcomments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `a42`
--

DROP TABLE IF EXISTS `a42`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a42` (
  `pat_id` char(18) NOT NULL,
  `treat` varchar(250) DEFAULT NULL,
  `textarea1` varchar(250) DEFAULT NULL,
  `cotmox` varchar(250) DEFAULT NULL,
  `antituber` varchar(250) DEFAULT NULL,
  `art` varchar(250) DEFAULT NULL,
  `textarea2` varchar(250) DEFAULT NULL,
  `cd4` varchar(250) DEFAULT NULL,
  `other` varchar(250) DEFAULT NULL,
  `textarea3` varchar(250) DEFAULT NULL,
  `counsel` varchar(250) DEFAULT NULL,
  `textarea4` varchar(250) DEFAULT NULL,
  `return` varchar(250) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ai0`
--

DROP TABLE IF EXISTS `ai0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai0` (
  `pat_id` varchar(20) DEFAULT NULL,
  `opdno` varchar(20) NOT NULL,
  `test_id` varchar(30) NOT NULL,
  `studyUID` varchar(150) DEFAULT NULL,
  `test_name` varchar(30) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `reffered_by` varchar(40) DEFAULT NULL,
  `isReport` int DEFAULT NULL,
  `isNote` int DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int DEFAULT NULL,
  PRIMARY KEY (`test_id`),
  KEY `index_opdno` (`opdno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biochem_value`
--

DROP TABLE IF EXISTS `biochem_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biochem_value` (
  `biochem_value_id` decimal(10,0) NOT NULL,
  `test` varchar(45) NOT NULL,
  `quantity` decimal(5,2) NOT NULL,
  `unit` varchar(45) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bmi_boys`
--

DROP TABLE IF EXISTS `bmi_boys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bmi_boys` (
  `agemonth` int DEFAULT NULL,
  `l` double DEFAULT NULL,
  `m` double DEFAULT NULL,
  `s` double DEFAULT NULL,
  `p1` double DEFAULT NULL,
  `p3` double DEFAULT NULL,
  `p5` double DEFAULT NULL,
  `p15` double DEFAULT NULL,
  `p25` double DEFAULT NULL,
  `p50` double DEFAULT NULL,
  `p75` double DEFAULT NULL,
  `p85` double DEFAULT NULL,
  `p95` double DEFAULT NULL,
  `p97` double DEFAULT NULL,
  `p99` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bmi_girls`
--

DROP TABLE IF EXISTS `bmi_girls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bmi_girls` (
  `agemonth` int DEFAULT NULL,
  `l` double DEFAULT NULL,
  `m` double DEFAULT NULL,
  `s` double DEFAULT NULL,
  `p1` double DEFAULT NULL,
  `p3` double DEFAULT NULL,
  `p5` double DEFAULT NULL,
  `p15` double DEFAULT NULL,
  `p25` double DEFAULT NULL,
  `p50` double DEFAULT NULL,
  `p75` double DEFAULT NULL,
  `p85` double DEFAULT NULL,
  `p95` double DEFAULT NULL,
  `p97` double DEFAULT NULL,
  `p99` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `c00`
--

DROP TABLE IF EXISTS `c00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c00` (
  `pat_id` char(18) NOT NULL,
  `age` varchar(50) DEFAULT NULL,
  `prvcan` varchar(50) DEFAULT NULL,
  `canfam` varchar(50) DEFAULT NULL,
  `fibroatypia` varchar(50) DEFAULT NULL,
  `nulliparous` varchar(50) DEFAULT NULL,
  `pregnancy` varchar(50) DEFAULT NULL,
  `manarche` varchar(50) DEFAULT NULL,
  `menopause` varchar(50) DEFAULT NULL,
  `solitary` varchar(50) DEFAULT NULL,
  `unilateral` varchar(50) DEFAULT NULL,
  `solid` varchar(50) DEFAULT NULL,
  `lrregular` varchar(50) DEFAULT NULL,
  `nonmobile` varchar(50) DEFAULT NULL,
  `nontender` varchar(50) DEFAULT NULL,
  `lumpsize` varchar(50) DEFAULT NULL,
  `discharge` varchar(50) DEFAULT NULL,
  `lymphnodes` varchar(50) DEFAULT NULL,
  `skinchanges` varchar(50) DEFAULT NULL,
  `tbxothfind` varchar(50) DEFAULT NULL,
  `fnac` varchar(50) DEFAULT NULL,
  `biopsy` varchar(50) DEFAULT NULL,
  `mamography` varchar(50) DEFAULT NULL,
  `chestxray` varchar(50) DEFAULT NULL,
  `usgabdomen` varchar(50) DEFAULT NULL,
  `staging_T` longtext,
  `staging_N` longtext,
  `staging_M` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `c01`
--

DROP TABLE IF EXISTS `c01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c01` (
  `pat_id` char(18) NOT NULL,
  `age` varchar(50) DEFAULT NULL,
  `marstat` varchar(50) DEFAULT NULL,
  `occupation` varchar(50) DEFAULT NULL,
  `hesitancy` varchar(50) DEFAULT NULL,
  `urgency` varchar(50) DEFAULT NULL,
  `nocturia` varchar(50) DEFAULT NULL,
  `urine` varchar(50) DEFAULT NULL,
  `dribbling` varchar(50) DEFAULT NULL,
  `hematuria` varchar(50) DEFAULT NULL,
  `urinarytract` varchar(50) DEFAULT NULL,
  `backpelvis` varchar(50) DEFAULT NULL,
  `induration` varchar(50) DEFAULT NULL,
  `nodularity` varchar(50) DEFAULT NULL,
  `needlebiopsy` varchar(50) DEFAULT NULL,
  `urinere` varchar(50) DEFAULT NULL,
  `usgabdomen` varchar(50) DEFAULT NULL,
  `psa` varchar(50) DEFAULT NULL,
  `acid` varchar(50) DEFAULT NULL,
  `bonescan` varchar(50) DEFAULT NULL,
  `staging_T` varchar(200) DEFAULT NULL,
  `staging_N` varchar(200) DEFAULT NULL,
  `staging_M` varchar(200) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `c02`
--

DROP TABLE IF EXISTS `c02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c02` (
  `pat_id` char(18) NOT NULL,
  `age` varchar(50) DEFAULT NULL,
  `smkhis` varchar(50) DEFAULT NULL,
  `environment` varchar(50) DEFAULT NULL,
  `tbxenv_dtls` longtext,
  `voice` varchar(50) DEFAULT NULL,
  `hoarseness` varchar(50) DEFAULT NULL,
  `haemoptysis` varchar(50) DEFAULT NULL,
  `dysphagia` varchar(50) DEFAULT NULL,
  `pain` varchar(50) DEFAULT NULL,
  `lymphnodes` varchar(50) DEFAULT NULL,
  `tbxlymph_dtls` longtext,
  `respiratory` varchar(50) DEFAULT NULL,
  `otherfindings` varchar(50) DEFAULT NULL,
  `tbxother_dtls` longtext,
  `IDL` varchar(50) DEFAULT NULL,
  `tbxidl_dtls` longtext,
  `endoscopic` varchar(50) DEFAULT NULL,
  `tbxendoscop_dtls` longtext,
  `fnac` varchar(50) DEFAULT NULL,
  `tbxfnac_dtls` longtext,
  `biopsy` varchar(50) DEFAULT NULL,
  `tbxbiopsy_dtls` longtext,
  `ctscan` varchar(50) DEFAULT NULL,
  `chestxray` varchar(50) DEFAULT NULL,
  `staging_T` longtext,
  `staging_Tsup` longtext,
  `staging_Tg` longtext,
  `staging_Tsub` longtext,
  `staging_N` longtext,
  `staging_M` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `c03`
--

DROP TABLE IF EXISTS `c03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c03` (
  `pat_id` char(18) NOT NULL,
  `age` varchar(50) DEFAULT NULL,
  `smkhis` varchar(50) DEFAULT NULL,
  `smoker` varchar(50) DEFAULT NULL,
  `chvoc` varchar(50) DEFAULT NULL,
  `caugh` varchar(50) DEFAULT NULL,
  `haemoptysis` varchar(50) DEFAULT NULL,
  `dyspney` varchar(50) DEFAULT NULL,
  `chestpain` varchar(50) DEFAULT NULL,
  `necknodes` varchar(50) DEFAULT NULL,
  `respdist` varchar(50) DEFAULT NULL,
  `weightloss` varchar(50) DEFAULT NULL,
  `tbxothfind` varchar(50) DEFAULT NULL,
  `chestxray` varchar(50) DEFAULT NULL,
  `idl` varchar(50) DEFAULT NULL,
  `fnac` varchar(50) DEFAULT NULL,
  `bal` varchar(50) DEFAULT NULL,
  `sputumcyto` varchar(50) DEFAULT NULL,
  `bronchoscopy` varchar(50) DEFAULT NULL,
  `bonescan` varchar(50) DEFAULT NULL,
  `staging_T` longtext,
  `staging_N` longtext,
  `staging_M` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `c04`
--

DROP TABLE IF EXISTS `c04`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c04` (
  `pat_id` char(18) NOT NULL,
  `age` varchar(50) DEFAULT NULL,
  `diet` varchar(50) DEFAULT NULL,
  `anemia` varchar(50) DEFAULT NULL,
  `pylori` varchar(50) DEFAULT NULL,
  `weightloss` varchar(50) DEFAULT NULL,
  `anorexia` varchar(50) DEFAULT NULL,
  `satiety` varchar(50) DEFAULT NULL,
  `weakness` varchar(50) DEFAULT NULL,
  `dysphagia` varchar(50) DEFAULT NULL,
  `abdominalmass` varchar(50) DEFAULT NULL,
  `abdominalpain` varchar(50) DEFAULT NULL,
  `hematemesis` varchar(50) DEFAULT NULL,
  `virchownode` varchar(50) DEFAULT NULL,
  `irishnode` varchar(50) DEFAULT NULL,
  `josephnodule` varchar(50) DEFAULT NULL,
  `metastasis` varchar(50) DEFAULT NULL,
  `krukenbergtumor` varchar(50) DEFAULT NULL,
  `endoscopy` varchar(50) DEFAULT NULL,
  `biopsy` varchar(50) DEFAULT NULL,
  `ctabdomen` varchar(50) DEFAULT NULL,
  `ultrasono` varchar(50) DEFAULT NULL,
  `cbc` varchar(50) DEFAULT NULL,
  `lft` varchar(50) DEFAULT NULL,
  `barium` varchar(50) DEFAULT NULL,
  `xraychest` varchar(50) DEFAULT NULL,
  `staging_T` longtext,
  `staging_N` longtext,
  `staging_M` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `c05`
--

DROP TABLE IF EXISTS `c05`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c05` (
  `pat_id` char(18) NOT NULL,
  `age` varchar(50) DEFAULT NULL,
  `sexhis` varchar(50) DEFAULT NULL,
  `hpv` varchar(50) DEFAULT NULL,
  `vagdis` varchar(50) DEFAULT NULL,
  `vagbleed` varchar(50) DEFAULT NULL,
  `malodorous` varchar(50) DEFAULT NULL,
  `weightloss` varchar(50) DEFAULT NULL,
  `uropathy` varchar(50) DEFAULT NULL,
  `grayareas` varchar(50) DEFAULT NULL,
  `bleeding` varchar(50) DEFAULT NULL,
  `cevicitis` varchar(50) DEFAULT NULL,
  `mass` varchar(50) DEFAULT NULL,
  `papsmear` varchar(50) DEFAULT NULL,
  `colposcopy` varchar(50) DEFAULT NULL,
  `curettage` varchar(50) DEFAULT NULL,
  `biopsy` varchar(50) DEFAULT NULL,
  `usg` varchar(50) DEFAULT NULL,
  `xraychest` varchar(50) DEFAULT NULL,
  `staging_T` longtext,
  `staging_N` longtext,
  `staging_M` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `c06`
--

DROP TABLE IF EXISTS `c06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c06` (
  `pat_id` char(18) NOT NULL,
  `age` varchar(50) DEFAULT NULL,
  `estrogen` varchar(50) DEFAULT NULL,
  `polycystic` varchar(50) DEFAULT NULL,
  `obesity` varchar(50) DEFAULT NULL,
  `liver` varchar(50) DEFAULT NULL,
  `infertility` varchar(50) DEFAULT NULL,
  `familyhistory` varchar(50) DEFAULT NULL,
  `diabetes` varchar(50) DEFAULT NULL,
  `vagbleed` varchar(50) DEFAULT NULL,
  `menses` varchar(50) DEFAULT NULL,
  `pelvicmass` varchar(50) DEFAULT NULL,
  `papsmear` varchar(50) DEFAULT NULL,
  `curettage` varchar(50) DEFAULT NULL,
  `biopsy` varchar(50) DEFAULT NULL,
  `ultrasound` varchar(50) DEFAULT NULL,
  `xraychest` varchar(50) DEFAULT NULL,
  `staging_T` longtext,
  `staging_N` longtext,
  `staging_M` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `c08`
--

DROP TABLE IF EXISTS `c08`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c08` (
  `pat_id` char(18) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `tbxrisk` longtext,
  `tbxsymp` longtext,
  `tbxeval` longtext,
  `tbxstaging_t` longtext,
  `tbxstaging_n` longtext,
  `tbxstaging_m` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cdfour`
--

DROP TABLE IF EXISTS `cdfour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cdfour` (
  `id_cdfour` varchar(15) NOT NULL,
  `testdate` datetime NOT NULL,
  `leucocyte` decimal(5,2) DEFAULT NULL,
  `lymphocyte` decimal(10,0) DEFAULT NULL,
  `cd4_count` decimal(5,0) NOT NULL,
  `cd4_percent` decimal(4,2) DEFAULT NULL,
  `cd8_count` decimal(5,0) DEFAULT NULL,
  `poly` tinyint unsigned DEFAULT NULL,
  `lymp` tinyint unsigned DEFAULT NULL,
  `mono` tinyint unsigned DEFAULT NULL,
  `eoso` tinyint unsigned DEFAULT NULL,
  `baso` tinyint unsigned DEFAULT NULL,
  `viralload` decimal(10,0) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cdfour_range`
--

DROP TABLE IF EXISTS `cdfour_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cdfour_range` (
  `age` tinyint unsigned NOT NULL,
  `test` varchar(45) NOT NULL,
  `lower` decimal(10,0) NOT NULL,
  `upper` decimal(10,0) NOT NULL,
  `label` varchar(45) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `center`
--

DROP TABLE IF EXISTS `center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `center` (
  `code` varchar(8) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `cdate` date DEFAULT NULL,
  `expdate` varchar(1024) DEFAULT NULL,
  `visibility` varchar(1) NOT NULL DEFAULT 'Y',
  `phone` varchar(20) DEFAULT NULL,
  `ipaddress` varchar(20) DEFAULT NULL,
  `centertype` char(1) DEFAULT NULL,
  `ftpip` varchar(15) DEFAULT NULL,
  `ftp_uname` varchar(20) DEFAULT NULL,
  `ftp_pwd` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientinfo`
--

DROP TABLE IF EXISTS `clientinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientinfo` (
  `server_ip` varchar(20) NOT NULL DEFAULT '',
  `client_ip` varchar(20) NOT NULL DEFAULT '',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concent`
--

DROP TABLE IF EXISTS `concent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concent` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `entrydate` datetime DEFAULT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  `form` longblob,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confmessage`
--

DROP TABLE IF EXISTS `confmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `confmessage` (
  `postedby` varchar(50) DEFAULT NULL,
  `postedto` varchar(50) DEFAULT NULL,
  `message` text,
  `status` char(2) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confuser`
--

DROP TABLE IF EXISTS `confuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `confuser` (
  `userid` varchar(50) NOT NULL DEFAULT '',
  `patid` varchar(18) NOT NULL DEFAULT '',
  `constatus` varchar(18) DEFAULT NULL,
  `doc_regid` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`userid`,`patid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consentdocmap`
--

DROP TABLE IF EXISTS `consentdocmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consentdocmap` (
  `conid` varchar(30) NOT NULL,
  `center` varchar(8) NOT NULL,
  `type` varchar(30) NOT NULL,
  `path` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`center`,`type`,`conid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consentform`
--

DROP TABLE IF EXISTS `consentform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consentform` (
  `conid` varchar(30) NOT NULL,
  `time` datetime DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `comments` varchar(300) DEFAULT NULL,
  `path` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`conid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consentlogs`
--

DROP TABLE IF EXISTS `consentlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consentlogs` (
  `uid` varchar(30) NOT NULL,
  `time` datetime NOT NULL,
  `conid` varchar(30) NOT NULL,
  `center` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`uid`,`time`,`conid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consultrequest`
--

DROP TABLE IF EXISTS `consultrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultrequest` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pat_id` varchar(50) DEFAULT NULL,
  `centerid` varchar(50) DEFAULT NULL,
  `dept` varchar(50) DEFAULT NULL,
  `requested` varchar(1) DEFAULT 'N',
  `doc_id` varchar(100) DEFAULT NULL,
  `appoinmenttime` datetime DEFAULT NULL,
  `operator` varchar(100) DEFAULT NULL,
  `instancetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consultstrategy`
--

DROP TABLE IF EXISTS `consultstrategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultstrategy` (
  `ccode` varchar(8) NOT NULL DEFAULT 'new',
  `type` varchar(50) NOT NULL DEFAULT 'admin',
  PRIMARY KEY (`ccode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coord`
--

DROP TABLE IF EXISTS `coord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coord` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL DEFAULT '0',
  `size` decimal(18,0) DEFAULT NULL,
  `points` longtext,
  `type` char(3) DEFAULT NULL,
  `sent` char(1) DEFAULT NULL,
  `sent_to` varchar(10) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `covid19`
--

DROP TABLE IF EXISTS `covid19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `covid19` (
  `pat_id` varchar(50) NOT NULL,
  `result` longtext,
  `instancetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctx_dose`
--

DROP TABLE IF EXISTS `ctx_dose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctx_dose` (
  `range_id` smallint NOT NULL,
  `age_week` varchar(15) DEFAULT NULL,
  `formulation` varchar(50) NOT NULL,
  `dose` double DEFAULT NULL,
  `unit` char(10) DEFAULT NULL,
  `id` int NOT NULL,
  `ctx_dose_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ctx_dose_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctx_weight`
--

DROP TABLE IF EXISTS `ctx_weight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ctx_weight` (
  `range_id` smallint NOT NULL,
  `start_param` double DEFAULT NULL,
  `end_param` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d00`
--

DROP TABLE IF EXISTS `d00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d00` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxpro_diagnosis` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d01`
--

DROP TABLE IF EXISTS `d01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d01` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxfin_diagnosis` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d02`
--

DROP TABLE IF EXISTS `d02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d02` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxcomplaint` longtext,
  `tbxfindings` longtext,
  `tbxinvest` longtext,
  `tbxdiagnosis` longtext,
  `tbxtreatment` longtext,
  `tbxother_x` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d03`
--

DROP TABLE IF EXISTS `d03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d03` (
  `pat_id` char(18) NOT NULL,
  `stage` varchar(10) DEFAULT NULL,
  `diagnosis1` longtext,
  `icd1` varchar(50) DEFAULT NULL,
  `diagnosis2` longtext,
  `icd2` varchar(50) DEFAULT NULL,
  `diagnosis3` longtext,
  `icd3` varchar(50) DEFAULT NULL,
  `disposal` varchar(50) DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d04`
--

DROP TABLE IF EXISTS `d04`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d04` (
  `pat_id` char(18) NOT NULL,
  `tbxradiotherapy` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d05`
--

DROP TABLE IF EXISTS `d05`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d05` (
  `pat_id` char(18) NOT NULL,
  `tbxct_regime_i` longtext,
  `tbxdrugs_used_i` longtext,
  `cycle_i_date` varchar(10) DEFAULT NULL,
  `cycle_ii_date` varchar(10) DEFAULT NULL,
  `cycle_iii_date` varchar(10) DEFAULT NULL,
  `cycle_iv_date` varchar(10) DEFAULT NULL,
  `cycle_v_date` varchar(10) DEFAULT NULL,
  `cycle_vi_date` varchar(10) DEFAULT NULL,
  `tbxct_regime_ii` longtext,
  `tbxdrugs_used_ii` longtext,
  `cycle2_i_date` varchar(10) DEFAULT NULL,
  `cycle2_ii_date` varchar(10) DEFAULT NULL,
  `cycle2_iii_date` varchar(10) DEFAULT NULL,
  `cycle2_iv_date` varchar(10) DEFAULT NULL,
  `cycle2_v_date` varchar(10) DEFAULT NULL,
  `cycle2_vi_date` varchar(10) DEFAULT NULL,
  `tbxanyother` longtext,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d06`
--

DROP TABLE IF EXISTS `d06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d06` (
  `pat_id` char(18) NOT NULL,
  `tbxpalliative_treatment` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d07`
--

DROP TABLE IF EXISTS `d07`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d07` (
  `pat_id` char(18) NOT NULL,
  `tbxanaesthasia_itu` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d08`
--

DROP TABLE IF EXISTS `d08`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d08` (
  `pat_id` char(18) NOT NULL,
  `tbxdeath_note` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d09`
--

DROP TABLE IF EXISTS `d09`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d09` (
  `pat_id` char(18) NOT NULL,
  `tbxcomments_referral_followup` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d10`
--

DROP TABLE IF EXISTS `d10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `d10` (
  `pat_id` char(18) NOT NULL,
  `operation_no1` varchar(50) DEFAULT NULL,
  `operation_date1` varchar(50) DEFAULT NULL,
  `surgeons1` varchar(50) DEFAULT NULL,
  `tbxopretave_findings1` longtext,
  `operation_no2` varchar(50) DEFAULT NULL,
  `operation_date2` varchar(50) DEFAULT NULL,
  `surgeons2` varchar(50) DEFAULT NULL,
  `tbxopretave_findings2` longtext,
  `operation_no3` varchar(50) DEFAULT NULL,
  `operation_date3` varchar(50) DEFAULT NULL,
  `surgeons3` varchar(50) DEFAULT NULL,
  `tbxopretave_findings3` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `iddepartment` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  `center` varchar(50) NOT NULL,
  `active` tinyint DEFAULT '1',
  PRIMARY KEY (`iddepartment`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dev_milesones`
--

DROP TABLE IF EXISTS `dev_milesones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dev_milesones` (
  `age` varchar(15) DEFAULT NULL,
  `gross_motor` longtext,
  `visual_motor` longtext,
  `lang` longtext,
  `social` longtext,
  `serial_num` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dicoogle_ref`
--

DROP TABLE IF EXISTS `dicoogle_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dicoogle_ref` (
  `pat_id` varchar(20) DEFAULT NULL,
  `test_id` varchar(30) NOT NULL,
  `studyUID` varchar(150) DEFAULT NULL,
  `test_name` varchar(30) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `reffered_by` varchar(40) DEFAULT NULL,
  `isReport` int DEFAULT NULL,
  `isNote` int DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district` (
  `district_code` varchar(6) NOT NULL,
  `district_name` varchar(70) DEFAULT NULL,
  `state_code` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`district_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docbanner`
--

DROP TABLE IF EXISTS `docbanner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docbanner` (
  `rg_no` varchar(20) NOT NULL,
  `docname` varchar(100) DEFAULT NULL,
  `center` varchar(8) DEFAULT NULL,
  `path` varchar(300) DEFAULT NULL,
  `avail` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`rg_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docfee`
--

DROP TABLE IF EXISTS `docfee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docfee` (
  `uid` varchar(50) NOT NULL,
  `fee` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dose_list`
--

DROP TABLE IF EXISTS `dose_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dose_list` (
  `item_no` double NOT NULL,
  `list_id` double DEFAULT NULL,
  `dose_id` double DEFAULT NULL,
  `med_amount` tinytext,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_allergy`
--

DROP TABLE IF EXISTS `drug_allergy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_allergy` (
  `pat_id` char(18) NOT NULL,
  `drugname` varchar(45) NOT NULL,
  `allergytype` varchar(245) NOT NULL,
  `onset` datetime DEFAULT NULL,
  `drugclass` varchar(45) DEFAULT NULL,
  `route` varchar(45) NOT NULL,
  `formula` varchar(45) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_dose`
--

DROP TABLE IF EXISTS `drug_dose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_dose` (
  `drug_id` int NOT NULL,
  `dose_id` int NOT NULL,
  `formulation` longtext,
  `dose_freq` varchar(50) DEFAULT NULL,
  `reco_dose` varchar(200) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_grp`
--

DROP TABLE IF EXISTS `drug_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_grp` (
  `drug_id` int NOT NULL,
  `drug_name` varchar(250) DEFAULT NULL,
  `drug_notice` longtext,
  `drug_grpid` varchar(30) DEFAULT NULL,
  `drug_grpname` varchar(250) DEFAULT NULL,
  `followon_regimen` char(1) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drugdose_tb`
--

DROP TABLE IF EXISTS `drugdose_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drugdose_tb` (
  `drug_id` int NOT NULL,
  `dose_id` int NOT NULL,
  `formulation` varchar(50) DEFAULT NULL,
  `dose_freq` varchar(50) DEFAULT NULL,
  `rec_dose` varchar(50) DEFAULT NULL,
  `recdose_unit` varchar(200) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drugindex`
--

DROP TABLE IF EXISTS `drugindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drugindex` (
  `id_drugindex` decimal(5,0) NOT NULL,
  `drug` varchar(245) NOT NULL,
  `nick` char(3) DEFAULT NULL,
  `comment` mediumtext,
  `ischild` tinyint unsigned NOT NULL,
  `class` char(2) DEFAULT NULL,
  `minagemonth` tinyint unsigned DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `druglist`
--

DROP TABLE IF EXISTS `druglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `druglist` (
  `drug_name` varchar(100) DEFAULT NULL,
  `sl_no` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sl_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1376 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `druglistbycenter`
--

DROP TABLE IF EXISTS `druglistbycenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `druglistbycenter` (
  `drug_name` varchar(100) DEFAULT NULL,
  `ccode` varchar(8) DEFAULT NULL,
  `active` int DEFAULT '0',
  `sl_no` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sl_no`)
) ENGINE=InnoDB AUTO_INCREMENT=9641 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drugname_tb`
--

DROP TABLE IF EXISTS `drugname_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drugname_tb` (
  `drug_id` int NOT NULL,
  `drug_name` varchar(250) DEFAULT NULL,
  `drug_notice` longtext,
  `drug_grpid` varchar(30) DEFAULT NULL,
  `drug-grpname` char(250) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam` (
  `what` varchar(145) DEFAULT NULL,
  `finding` varchar(145) NOT NULL,
  `category` varchar(45) DEFAULT NULL,
  `obsncode` decimal(10,0) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=686 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_summary`
--

DROP TABLE IF EXISTS `form_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_summary` (
  `form_name` varchar(20) NOT NULL,
  `form_fields` varchar(100) DEFAULT NULL,
  `field_names` varchar(200) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forms`
--

DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forms` (
  `name` char(3) NOT NULL,
  `description` char(100) NOT NULL,
  `par_chl` char(2) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formulation`
--

DROP TABLE IF EXISTS `formulation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formulation` (
  `id_formulation` tinyint unsigned DEFAULT NULL,
  `prep` varchar(45) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ftpaccounts`
--

DROP TABLE IF EXISTS `ftpaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ftpaccounts` (
  `localip` varchar(15) NOT NULL DEFAULT '',
  `remoteip` varchar(15) NOT NULL DEFAULT '',
  `uname` varchar(20) DEFAULT NULL,
  `passwd` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`localip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genotype`
--

DROP TABLE IF EXISTS `genotype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genotype` (
  `id_mutation` tinyint unsigned DEFAULT NULL,
  `mutation` varchar(45) NOT NULL,
  `mutation_type` varchar(45) NOT NULL,
  `comment` mediumtext,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genotype_report`
--

DROP TABLE IF EXISTS `genotype_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genotype_report` (
  `id_genotype_report` decimal(10,0) NOT NULL,
  `mutation_id` tinyint unsigned NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h00`
--

DROP TABLE IF EXISTS `h00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h00` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `pain` varchar(50) DEFAULT NULL,
  `fever` varchar(50) DEFAULT NULL,
  `skin` varchar(50) CHARACTER SET big5 COLLATE big5_chinese_ci DEFAULT NULL,
  `syncope` varchar(50) DEFAULT NULL,
  `seizure` varchar(50) DEFAULT NULL,
  `dizziness` varchar(50) DEFAULT NULL,
  `visual` varchar(50) DEFAULT NULL,
  `paralysis` varchar(50) DEFAULT NULL,
  `unconscious` varchar(50) DEFAULT NULL,
  `dyspnea` varchar(50) DEFAULT NULL,
  `cough` varchar(50) DEFAULT NULL,
  `sensory` varchar(50) DEFAULT NULL,
  `cyanosis` varchar(50) DEFAULT NULL,
  `edema` varchar(50) DEFAULT NULL,
  `nausea` varchar(50) DEFAULT NULL,
  `weight` varchar(50) DEFAULT NULL,
  `diauhea` varchar(50) DEFAULT NULL,
  `gi_bleeding` varchar(50) DEFAULT NULL,
  `jaundice` varchar(50) DEFAULT NULL,
  `lymphadenopathy` varchar(50) DEFAULT NULL,
  `splenomepaly` varchar(50) DEFAULT NULL,
  `swelling` varchar(50) DEFAULT NULL,
  `ulcer` varchar(50) DEFAULT NULL,
  `sinus` varchar(50) DEFAULT NULL,
  `varicose` varchar(50) DEFAULT NULL,
  `walking` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h01`
--

DROP TABLE IF EXISTS `h01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h01` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site1` varchar(50) DEFAULT NULL,
  `time_onset1` varchar(50) DEFAULT NULL,
  `mode_onset1` varchar(50) DEFAULT NULL,
  `duration1` varchar(50) DEFAULT NULL,
  `shifting1` varchar(50) DEFAULT NULL,
  `radiation1` varchar(50) DEFAULT NULL,
  `referral1` varchar(50) DEFAULT NULL,
  `character1` varchar(50) DEFAULT NULL,
  `effect_pressure1` varchar(50) DEFAULT NULL,
  `effect_walking1` varchar(50) DEFAULT NULL,
  `jolting1` varchar(50) DEFAULT NULL,
  `breathing1` varchar(50) DEFAULT NULL,
  `micturition1` varchar(50) DEFAULT NULL,
  `worse1` varchar(50) DEFAULT NULL,
  `relieved1` varchar(50) DEFAULT NULL,
  `others1` varchar(50) DEFAULT NULL,
  `tbxgeneralimp1` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h02`
--

DROP TABLE IF EXISTS `h02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h02` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `duration2` varchar(50) DEFAULT NULL,
  `mode_onset2` varchar(50) DEFAULT NULL,
  `pain2` varchar(50) DEFAULT NULL,
  `progress_swelling2` varchar(50) DEFAULT NULL,
  `presence2` varchar(50) DEFAULT NULL,
  `secondary_change2` varchar(50) DEFAULT NULL,
  `l_weight_appetite2` varchar(50) DEFAULT NULL,
  `upper_l2` varchar(50) DEFAULT NULL,
  `upper_r2` varchar(50) DEFAULT NULL,
  `lower_l2` varchar(50) DEFAULT NULL,
  `lower_r2` varchar(50) DEFAULT NULL,
  `inspection2` varchar(50) DEFAULT NULL,
  `temperature2` varchar(50) DEFAULT NULL,
  `tenderness2` varchar(50) DEFAULT NULL,
  `size2` varchar(50) DEFAULT NULL,
  `shape_extent2` varchar(50) DEFAULT NULL,
  `surface2` varchar(50) DEFAULT NULL,
  `edge2` varchar(50) DEFAULT NULL,
  `consistency2` varchar(50) DEFAULT NULL,
  `fluctuation2` varchar(50) DEFAULT NULL,
  `fluid_thrill2` varchar(50) DEFAULT NULL,
  `translucency2` varchar(50) DEFAULT NULL,
  `impulse_coughing2` varchar(50) DEFAULT NULL,
  `reducibility2` varchar(50) DEFAULT NULL,
  `compressibility2` varchar(50) DEFAULT NULL,
  `pulsatility2` varchar(50) DEFAULT NULL,
  `fixity2` varchar(50) DEFAULT NULL,
  `r_lymph2` varchar(50) DEFAULT NULL,
  `auscultation2` varchar(50) DEFAULT NULL,
  `measurements` varchar(50) DEFAULT NULL,
  `movements2` varchar(50) DEFAULT NULL,
  `pressure2` varchar(50) DEFAULT NULL,
  `others2` varchar(50) DEFAULT NULL,
  `tbxgeneralimp2` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h03`
--

DROP TABLE IF EXISTS `h03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h03` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site3` varchar(50) DEFAULT NULL,
  `time_onset3` varchar(50) DEFAULT NULL,
  `mode_onset3` varchar(50) DEFAULT NULL,
  `duration3` varchar(50) DEFAULT NULL,
  `shifting3` varchar(50) DEFAULT NULL,
  `radiation3` varchar(50) DEFAULT NULL,
  `referral3` varchar(50) DEFAULT NULL,
  `character3` varchar(50) DEFAULT NULL,
  `effect_pressure3` varchar(50) DEFAULT NULL,
  `effect_walking3` varchar(50) DEFAULT NULL,
  `jolting3` varchar(50) DEFAULT NULL,
  `breathing3` varchar(50) DEFAULT NULL,
  `micturition3` varchar(50) DEFAULT NULL,
  `worse3` varchar(50) DEFAULT NULL,
  `relieved3` varchar(50) DEFAULT NULL,
  `others3` varchar(50) DEFAULT NULL,
  `tbxgeneralimp3` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h04`
--

DROP TABLE IF EXISTS `h04`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h04` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `similar` varchar(50) DEFAULT NULL,
  `treatment` varchar(50) DEFAULT NULL,
  `medical` varchar(50) DEFAULT NULL,
  `surgical` varchar(50) DEFAULT NULL,
  `family` varchar(50) DEFAULT NULL,
  `functional` varchar(50) DEFAULT NULL,
  `diseases` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h05`
--

DROP TABLE IF EXISTS `h05`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h05` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `occupation` varchar(50) DEFAULT NULL,
  `exposure` varchar(50) DEFAULT NULL,
  `socio` varchar(50) DEFAULT NULL,
  `infamily` varchar(50) DEFAULT NULL,
  `marital` varchar(50) DEFAULT NULL,
  `diet` varchar(50) DEFAULT NULL,
  `habit` varchar(50) DEFAULT NULL,
  `ho_exphist` varchar(50) DEFAULT NULL,
  `contracted` varchar(50) DEFAULT NULL,
  `anyother` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h06`
--

DROP TABLE IF EXISTS `h06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h06` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `bcg` varchar(50) DEFAULT NULL,
  `b_date` varchar(50) DEFAULT NULL,
  `dtp` varchar(50) DEFAULT NULL,
  `d_date` varchar(50) DEFAULT NULL,
  `dtp_a` varchar(50) DEFAULT NULL,
  `da_date` varchar(50) DEFAULT NULL,
  `dtp_b` varchar(50) DEFAULT NULL,
  `db_date` varchar(50) DEFAULT NULL,
  `dt` varchar(50) DEFAULT NULL,
  `dt_date` varchar(50) DEFAULT NULL,
  `chicken` varchar(50) DEFAULT NULL,
  `chicken_d` varchar(50) DEFAULT NULL,
  `opv_st` varchar(50) DEFAULT NULL,
  `opv_fst` varchar(50) DEFAULT NULL,
  `opv_nd` varchar(50) DEFAULT NULL,
  `opv_snd` varchar(50) DEFAULT NULL,
  `opv_rd` varchar(50) DEFAULT NULL,
  `opv_trd` varchar(50) DEFAULT NULL,
  `opv_th` varchar(50) DEFAULT NULL,
  `opv_fth` varchar(50) DEFAULT NULL,
  `opv_ft` varchar(50) DEFAULT NULL,
  `opv_fvt` varchar(50) DEFAULT NULL,
  `obstetric` varchar(50) DEFAULT NULL,
  `obste_tric` varchar(50) DEFAULT NULL,
  `obst_etric` varchar(50) DEFAULT NULL,
  `obstet_ric` varchar(50) DEFAULT NULL,
  `hbv_st` varchar(50) DEFAULT NULL,
  `hbv_fst` varchar(50) DEFAULT NULL,
  `hbv_nd` varchar(50) DEFAULT NULL,
  `hbv_snd` varchar(50) DEFAULT NULL,
  `hbv_rd` varchar(50) DEFAULT NULL,
  `hbv_trd` varchar(50) DEFAULT NULL,
  `measles` varchar(50) DEFAULT NULL,
  `measles_d` varchar(50) DEFAULT NULL,
  `mmr` varchar(50) DEFAULT NULL,
  `mmr_d` varchar(50) DEFAULT NULL,
  `hib` varchar(50) DEFAULT NULL,
  `hib_d` varchar(50) DEFAULT NULL,
  `pulse` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h07`
--

DROP TABLE IF EXISTS `h07`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h07` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `marital_status` varchar(50) DEFAULT NULL,
  `lmp` varchar(50) DEFAULT NULL,
  `ammenorrhea` varchar(50) DEFAULT NULL,
  `pain_abdomen` varchar(50) DEFAULT NULL,
  `bleeding_pv` varchar(50) DEFAULT NULL,
  `discharge_pv` varchar(50) DEFAULT NULL,
  `something_coming_down_pv` varchar(50) DEFAULT NULL,
  `dysuria` varchar(50) DEFAULT NULL,
  `backache` varchar(50) DEFAULT NULL,
  `infertility` varchar(50) DEFAULT NULL,
  `pregnancy` varchar(50) DEFAULT NULL,
  `complaints` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `associated_complaints` varchar(50) DEFAULT NULL,
  `gravida` varchar(50) DEFAULT NULL,
  `para` varchar(50) DEFAULT NULL,
  `no_of_living_issue` varchar(50) DEFAULT NULL,
  `mode_of_delivery` varchar(50) DEFAULT NULL,
  `last_childbirth` varchar(50) DEFAULT NULL,
  `no_of_abortions` varchar(50) DEFAULT NULL,
  `menarche` varchar(50) DEFAULT NULL,
  `cycle` varchar(50) DEFAULT NULL,
  `dysmenorrhoea` varchar(50) DEFAULT NULL,
  `duration_m` varchar(50) DEFAULT NULL,
  `blood_flow` varchar(50) DEFAULT NULL,
  `menopause` varchar(50) DEFAULT NULL,
  `tbxanyother` longtext,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h08`
--

DROP TABLE IF EXISTS `h08`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h08` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `time_delivery` varchar(50) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `birth_weight` varchar(50) DEFAULT NULL,
  `feeding` varchar(50) DEFAULT NULL,
  `developmental_milestones` varchar(50) DEFAULT NULL,
  `immunisation` varchar(50) DEFAULT NULL,
  `fever` varchar(50) DEFAULT NULL,
  `rash` varchar(50) DEFAULT NULL,
  `refusal_suck` varchar(50) DEFAULT NULL,
  `diarrhoea` varchar(50) DEFAULT NULL,
  `vomiting` varchar(50) DEFAULT NULL,
  `bleeding_tendency` varchar(50) DEFAULT NULL,
  `pain_abdomen` varchar(50) DEFAULT NULL,
  `respiratory_distress` varchar(50) DEFAULT NULL,
  `ho_past_illness` varchar(50) DEFAULT NULL,
  `nature` varchar(50) DEFAULT NULL,
  `severity` varchar(50) DEFAULT NULL,
  `age_occurrence` varchar(50) DEFAULT NULL,
  `tbxanyother` longtext,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h09`
--

DROP TABLE IF EXISTS `h09`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h09` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `delivery` varchar(50) DEFAULT NULL,
  `tbxchief_complaints` longtext,
  `tbxpresenting_illness` longtext,
  `tbxanyother` longtext,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h10`
--

DROP TABLE IF EXISTS `h10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h10` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `pa_ra` varchar(50) DEFAULT NULL,
  `gravida` varchar(50) DEFAULT NULL,
  `date1` varchar(50) DEFAULT NULL,
  `date2` varchar(50) DEFAULT NULL,
  `date3` varchar(50) DEFAULT NULL,
  `date4` varchar(50) DEFAULT NULL,
  `gestation1` varchar(50) DEFAULT NULL,
  `gestation2` varchar(50) DEFAULT NULL,
  `gestation3` varchar(50) DEFAULT NULL,
  `gestation4` varchar(50) DEFAULT NULL,
  `mode_of_delivery1` varchar(50) DEFAULT NULL,
  `mode_of_delivery2` varchar(50) DEFAULT NULL,
  `mode_of_delivery3` varchar(50) DEFAULT NULL,
  `mode_of_delivery4` varchar(50) DEFAULT NULL,
  `delivery_at1` varchar(50) DEFAULT NULL,
  `delivery_at2` varchar(50) DEFAULT NULL,
  `delivery_at3` varchar(50) DEFAULT NULL,
  `delivery_at4` varchar(50) DEFAULT NULL,
  `alive_dead1` varchar(50) DEFAULT NULL,
  `alive_dead2` varchar(50) DEFAULT NULL,
  `alive_dead3` varchar(50) DEFAULT NULL,
  `alive_dead4` varchar(50) DEFAULT NULL,
  `weight1` varchar(50) DEFAULT NULL,
  `weight2` varchar(50) DEFAULT NULL,
  `weight3` varchar(50) DEFAULT NULL,
  `weight4` varchar(50) DEFAULT NULL,
  `sex1` varchar(50) DEFAULT NULL,
  `sex2` varchar(50) DEFAULT NULL,
  `sex3` varchar(50) DEFAULT NULL,
  `sex4` varchar(50) DEFAULT NULL,
  `other1` varchar(50) DEFAULT NULL,
  `other2` varchar(50) DEFAULT NULL,
  `other3` varchar(50) DEFAULT NULL,
  `other4` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h11`
--

DROP TABLE IF EXISTS `h11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h11` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `edd_date` varchar(50) DEFAULT NULL,
  `antenatal_care` varchar(50) DEFAULT NULL,
  `maternal_prob` varchar(50) DEFAULT NULL,
  `other_relevant_points` varchar(50) DEFAULT NULL,
  `details_labour` varchar(50) DEFAULT NULL,
  `apgar_score` varchar(50) DEFAULT NULL,
  `at_min` varchar(50) DEFAULT NULL,
  `tb` varchar(50) DEFAULT NULL,
  `diabetes` varchar(50) DEFAULT NULL,
  `twin` varchar(50) DEFAULT NULL,
  `congenital_malformations` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h12`
--

DROP TABLE IF EXISTS `h12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h12` (
  `pat_id` char(18) NOT NULL,
  `mother_alive` varchar(50) DEFAULT NULL,
  `mother_age` varchar(50) DEFAULT NULL,
  `mother_hiv` varchar(50) DEFAULT NULL,
  `mother_io` varchar(50) DEFAULT NULL,
  `mother_haart` varchar(50) DEFAULT NULL,
  `mother_comments` longtext,
  `father_alive` varchar(50) DEFAULT NULL,
  `father_age` longtext,
  `father_hiv` varchar(50) DEFAULT NULL,
  `father_io` varchar(50) DEFAULT NULL,
  `father_haart` varchar(50) DEFAULT NULL,
  `father_comments` varchar(50) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h13`
--

DROP TABLE IF EXISTS `h13`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h13` (
  `pat_id` char(18) NOT NULL,
  `drug_name` varchar(50) DEFAULT NULL,
  `drug_class` varchar(50) DEFAULT NULL,
  `route_administration` varchar(50) DEFAULT NULL,
  `onset_drug` varchar(50) DEFAULT NULL,
  `hypersensitivity` varchar(50) DEFAULT NULL,
  `agent` varchar(50) DEFAULT NULL,
  `mode_contact` varchar(50) DEFAULT NULL,
  `onset_other` varchar(50) DEFAULT NULL,
  `nature_allergy` varchar(50) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h14`
--

DROP TABLE IF EXISTS `h14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h14` (
  `pat_id` char(18) NOT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `commonparents` varchar(50) DEFAULT NULL,
  `age_year` varchar(50) DEFAULT NULL,
  `age_month` varchar(50) DEFAULT NULL,
  `age_day` varchar(50) DEFAULT NULL,
  `is_alive` varchar(50) DEFAULT NULL,
  `tested` varchar(50) DEFAULT NULL,
  `hiv` varchar(50) DEFAULT NULL,
  `haart` varchar(50) DEFAULT NULL,
  `oi` varchar(50) DEFAULT NULL,
  `comments` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h15`
--

DROP TABLE IF EXISTS `h15`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h15` (
  `pat_id` char(18) NOT NULL,
  `ht` double DEFAULT NULL,
  `wt` double DEFAULT NULL,
  `bmi` double DEFAULT NULL,
  `hc` double DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h16`
--

DROP TABLE IF EXISTS `h16`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h16` (
  `pat_id` char(18) NOT NULL,
  `tbxcomplaint` longtext,
  `tbxfindings` longtext,
  `tbxinvest` longtext,
  `tbxdiagnosis` longtext,
  `tbxtreatment` longtext,
  `tbxasthma` longtext,
  `tbxother_x` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h18`
--

DROP TABLE IF EXISTS `h18`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h18` (
  `pat_id` char(18) NOT NULL,
  `regular` varchar(50) DEFAULT NULL,
  `irregular` varchar(50) DEFAULT NULL,
  `scanty` varchar(50) DEFAULT NULL,
  `excessive` varchar(50) DEFAULT NULL,
  `average` varchar(50) DEFAULT NULL,
  `pain` varchar(50) DEFAULT NULL,
  `discharge` varchar(50) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h19`
--

DROP TABLE IF EXISTS `h19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h19` (
  `pat_id` char(18) NOT NULL,
  `tbxpres_his` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h20`
--

DROP TABLE IF EXISTS `h20`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h20` (
  `pat_id` char(18) NOT NULL,
  `grandfather` varchar(50) DEFAULT NULL,
  `tbxgf_dtls` longtext,
  `grandmother` varchar(50) DEFAULT NULL,
  `tbxgm_dtls` longtext,
  `father` varchar(50) DEFAULT NULL,
  `tbxfat_dtls` longtext,
  `mother` varchar(50) DEFAULT NULL,
  `tbxmoth_dtls` longtext,
  `brother` varchar(50) DEFAULT NULL,
  `tbxbro_dtls` longtext,
  `sister` varchar(50) DEFAULT NULL,
  `tbxsis_dtls` longtext,
  `son` varchar(50) DEFAULT NULL,
  `tbxson_dtls` longtext,
  `daughter` varchar(50) DEFAULT NULL,
  `tbxdaut_dtls` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h21`
--

DROP TABLE IF EXISTS `h21`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h21` (
  `pat_id` char(18) NOT NULL,
  `chkbetel_nut` varchar(50) DEFAULT NULL,
  `chkcigarette` varchar(50) DEFAULT NULL,
  `chkchewing` varchar(50) DEFAULT NULL,
  `chkhormonal` varchar(50) DEFAULT NULL,
  `chkalcohol` varchar(50) DEFAULT NULL,
  `chkbidi` varchar(50) DEFAULT NULL,
  `chkgutka` varchar(50) DEFAULT NULL,
  `chksnuff` varchar(50) DEFAULT NULL,
  `chkkhaini` varchar(50) DEFAULT NULL,
  `chknone` varchar(50) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `h22`
--

DROP TABLE IF EXISTS `h22`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `h22` (
  `pat_id` char(18) NOT NULL,
  `moth_exposure` char(10) DEFAULT NULL,
  `moth_tbkind` varchar(15) DEFAULT NULL,
  `moth_diagdate` varchar(350) DEFAULT NULL,
  `moth_trtinfo` varchar(100) DEFAULT NULL,
  `fath_exposure` char(10) DEFAULT NULL,
  `fath_tbkind` varchar(15) DEFAULT NULL,
  `fath_diagdate` varchar(350) DEFAULT NULL,
  `fath_trtinfo` varchar(100) DEFAULT NULL,
  `sib_exposure` char(10) DEFAULT NULL,
  `sib_who` varchar(20) DEFAULT NULL,
  `sib_tbkind` varchar(15) DEFAULT NULL,
  `sib_diagdate` varchar(350) DEFAULT NULL,
  `sib_trtinfo` varchar(100) DEFAULT NULL,
  `oth_exposure` char(10) DEFAULT NULL,
  `oth_who` varchar(20) DEFAULT NULL,
  `oth_tbkind` varchar(15) DEFAULT NULL,
  `oth_diagdate` varchar(350) DEFAULT NULL,
  `oth_trtinfo` varchar(100) DEFAULT NULL,
  `mdr_exposure` char(10) DEFAULT NULL,
  `mdr_who` varchar(20) DEFAULT NULL,
  `mdr_tbkind` varchar(15) DEFAULT NULL,
  `mdr_diagdate` varchar(350) DEFAULT NULL,
  `mdr_trtinfo` varchar(100) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hc_boys`
--

DROP TABLE IF EXISTS `hc_boys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hc_boys` (
  `agemonth` int DEFAULT NULL,
  `l` double DEFAULT NULL,
  `m` double DEFAULT NULL,
  `s` double DEFAULT NULL,
  `sd` double DEFAULT NULL,
  `p1` double DEFAULT NULL,
  `p3` double DEFAULT NULL,
  `p5` double DEFAULT NULL,
  `p15` double DEFAULT NULL,
  `p25` double DEFAULT NULL,
  `p50` double DEFAULT NULL,
  `p75` double DEFAULT NULL,
  `p85` double DEFAULT NULL,
  `p95` double DEFAULT NULL,
  `p97` double DEFAULT NULL,
  `p99` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hc_girls`
--

DROP TABLE IF EXISTS `hc_girls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hc_girls` (
  `agemonth` int DEFAULT NULL,
  `l` double DEFAULT NULL,
  `m` double DEFAULT NULL,
  `s` double DEFAULT NULL,
  `sd` double DEFAULT NULL,
  `p1` double DEFAULT NULL,
  `p3` double DEFAULT NULL,
  `p5` double DEFAULT NULL,
  `p15` double DEFAULT NULL,
  `p25` double DEFAULT NULL,
  `p50` double DEFAULT NULL,
  `p75` double DEFAULT NULL,
  `p85` double DEFAULT NULL,
  `p95` double DEFAULT NULL,
  `p97` double DEFAULT NULL,
  `p99` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hexPathology`
--

DROP TABLE IF EXISTS `hexPathology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hexPathology` (
  `test_id` varchar(30) NOT NULL,
  `testTime` datetime DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Result` varchar(100) DEFAULT NULL,
  `pat_id` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`test_id`),
  CONSTRAINT `fk_hexPathology_1` FOREIGN KEY (`test_id`) REFERENCES `ai0` (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ht_boys`
--

DROP TABLE IF EXISTS `ht_boys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ht_boys` (
  `agemonth` double DEFAULT NULL,
  `L` double DEFAULT NULL,
  `M` double DEFAULT NULL,
  `S` double DEFAULT NULL,
  `P3` double DEFAULT NULL,
  `P5` double DEFAULT NULL,
  `P10` double DEFAULT NULL,
  `P25` double DEFAULT NULL,
  `P50` double DEFAULT NULL,
  `P75` double DEFAULT NULL,
  `P90` double DEFAULT NULL,
  `P95` double DEFAULT NULL,
  `P97` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ht_girls`
--

DROP TABLE IF EXISTS `ht_girls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ht_girls` (
  `agemonth` double DEFAULT NULL,
  `L` double DEFAULT NULL,
  `M` double DEFAULT NULL,
  `S` double DEFAULT NULL,
  `P3` double DEFAULT NULL,
  `P5` double DEFAULT NULL,
  `P10` double DEFAULT NULL,
  `P25` double DEFAULT NULL,
  `P50` double DEFAULT NULL,
  `P75` double DEFAULT NULL,
  `P90` double DEFAULT NULL,
  `P95` double DEFAULT NULL,
  `P97` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i00`
--

DROP TABLE IF EXISTS `i00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i00` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_rbc_cnt` double DEFAULT NULL,
  `f_haemoglobin` double DEFAULT NULL,
  `wbc_cnt` varchar(50) DEFAULT NULL,
  `f_neutrophils` double DEFAULT NULL,
  `f_lymphocytes` double DEFAULT NULL,
  `f_eosinophils` double DEFAULT NULL,
  `f_basophils` double DEFAULT NULL,
  `f_monoocytes` double DEFAULT NULL,
  `abnormal` varchar(50) DEFAULT NULL,
  `parasites` varchar(50) DEFAULT NULL,
  `f_platelate` double DEFAULT NULL,
  `f_fst_hour` double DEFAULT NULL,
  `f_snd_hour` double DEFAULT NULL,
  `f_mean_esr` double DEFAULT NULL,
  `bld_group` varchar(50) DEFAULT NULL,
  `rh_factor` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i02`
--

DROP TABLE IF EXISTS `i02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i02` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_platelets` double DEFAULT NULL,
  `hematocrit` varchar(50) DEFAULT NULL,
  `f_rdw` double DEFAULT NULL,
  `f_mcv` double DEFAULT NULL,
  `f_mchc` double DEFAULT NULL,
  `smear` varchar(50) DEFAULT NULL,
  `neutros` varchar(50) DEFAULT NULL,
  `neutrob` varchar(50) DEFAULT NULL,
  `mono_cyte` varchar(50) DEFAULT NULL,
  `f_packedcell` double DEFAULT NULL,
  `f_white_blood` double DEFAULT NULL,
  `f_monocyte` double DEFAULT NULL,
  `f_blast` double DEFAULT NULL,
  `f_promyclocyte` double DEFAULT NULL,
  `f_neutrophilic` double DEFAULT NULL,
  `f_metamyelocyte` double DEFAULT NULL,
  `neutro_band` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i07`
--

DROP TABLE IF EXISTS `i07`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i07` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxspecialreport` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i16`
--

DROP TABLE IF EXISTS `i16`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i16` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `hypochromia` varchar(50) DEFAULT NULL,
  `anisocytosis` varchar(50) DEFAULT NULL,
  `poikilocytosis` varchar(50) DEFAULT NULL,
  `target_cells` varchar(50) DEFAULT NULL,
  `bas_stipling` varchar(50) DEFAULT NULL,
  `cabot_ring` varchar(50) DEFAULT NULL,
  `normoblasts` varchar(50) DEFAULT NULL,
  `mal_parasite` varchar(50) DEFAULT NULL,
  `f_platelets` double DEFAULT NULL,
  `f_bloodcorpuscles` double DEFAULT NULL,
  `f_blast_cells` double DEFAULT NULL,
  `promyelocyte` varchar(50) DEFAULT NULL,
  `neutro_myel` varchar(50) DEFAULT NULL,
  `neutro_meta` varchar(50) DEFAULT NULL,
  `neutro_band` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i18`
--

DROP TABLE IF EXISTS `i18`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i18` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site` varchar(50) DEFAULT NULL,
  `material` varchar(50) DEFAULT NULL,
  `cellularity` varchar(50) DEFAULT NULL,
  `erythro_cel` varchar(50) DEFAULT NULL,
  `granulo_cel` varchar(50) DEFAULT NULL,
  `lympho_cel` varchar(50) DEFAULT NULL,
  `megakaryocyte` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `anyoth` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i21`
--

DROP TABLE IF EXISTS `i21`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i21` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `fetus` varchar(50) DEFAULT NULL,
  `viability` varchar(50) DEFAULT NULL,
  `presentation` varchar(50) DEFAULT NULL,
  `f_clr` double DEFAULT NULL,
  `f_bpd` double DEFAULT NULL,
  `f_femur` double DEFAULT NULL,
  `f_head` double DEFAULT NULL,
  `f_gestational` double DEFAULT NULL,
  `f_liquor` double DEFAULT NULL,
  `f_fhr` double DEFAULT NULL,
  `iugr` varchar(50) DEFAULT NULL,
  `calculated` varchar(50) DEFAULT NULL,
  `maturity` varchar(50) DEFAULT NULL,
  `placental` varchar(50) DEFAULT NULL,
  `grading` varchar(50) DEFAULT NULL,
  `cogenital` varchar(50) DEFAULT NULL,
  `doppler` varchar(50) DEFAULT NULL,
  `ratio` varchar(50) DEFAULT NULL,
  `ammiocentesis` varchar(50) DEFAULT NULL,
  `feature` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i22`
--

DROP TABLE IF EXISTS `i22`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i22` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxchest_xray` longtext,
  `tbxabdomen_x` longtext,
  `tbxbarium_x` longtext,
  `tbxspine_x` longtext,
  `tbxpns_x` longtext,
  `tbxskull_x` longtext,
  `tbxfracture_x` longtext,
  `tbxswelling_x` longtext,
  `tbxother_x` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i23`
--

DROP TABLE IF EXISTS `i23`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i23` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `kidney` varchar(50) DEFAULT NULL,
  `shape` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `scar` varchar(50) DEFAULT NULL,
  `out_flow` varchar(50) DEFAULT NULL,
  `ivucalculas` varchar(50) DEFAULT NULL,
  `mic_cug` varchar(50) DEFAULT NULL,
  `cystoscopy` varchar(50) DEFAULT NULL,
  `retrograde` varchar(50) DEFAULT NULL,
  `antegrade` varchar(50) DEFAULT NULL,
  `rightartery` varchar(50) DEFAULT NULL,
  `leftartery` varchar(50) DEFAULT NULL,
  `rightvein` varchar(50) DEFAULT NULL,
  `leftvein` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i24`
--

DROP TABLE IF EXISTS `i24`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i24` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxchest_xray` longtext,
  `tbxdsa` longtext,
  `tbxrvg` longtext,
  `tbxcine_ct` longtext,
  `tbxpet` longtext,
  `tbxmra` longtext,
  `tbxmrs` longtext,
  `tbxtc_sesta_mibi` longtext,
  `tbxcoronary` longtext,
  `tbxlv_angio` longtext,
  `tbxaortography` longtext,
  `ef_slope` varchar(50) DEFAULT NULL,
  `mva` varchar(50) DEFAULT NULL,
  `ava` varchar(50) DEFAULT NULL,
  `effusion` varchar(50) DEFAULT NULL,
  `lv` varchar(50) DEFAULT NULL,
  `la` varchar(50) DEFAULT NULL,
  `rv` varchar(50) DEFAULT NULL,
  `ra` varchar(50) DEFAULT NULL,
  `svr` varchar(50) DEFAULT NULL,
  `pvr` varchar(50) DEFAULT NULL,
  `cardiac` varchar(50) DEFAULT NULL,
  `oxygen` varchar(50) DEFAULT NULL,
  `av_oxygen` varchar(50) DEFAULT NULL,
  `tbxother` longtext,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i25`
--

DROP TABLE IF EXISTS `i25`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i25` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxglbder` longtext,
  `tbxpancreas` longtext,
  `tbxspleen` longtext,
  `tbxstomach` longtext,
  `tbxintestine` longtext,
  `tbxkidneys` longtext,
  `tbxpelvis` longtext,
  `tbxoveries` longtext,
  `tbxuterus` longtext,
  `tbxurinary` longtext,
  `tbxaorotic` longtext,
  `tbxany` longtext,
  `tbximpression` longtext,
  `ctdate` varchar(50) DEFAULT NULL,
  `tbxliver` longtext,
  `tbxpan_creas` longtext,
  `tbxsple_en` longtext,
  `tbxsto_mach` longtext,
  `tbxinte_stine` longtext,
  `tbxkidn_eys` longtext,
  `tbxpe_lvis` longtext,
  `tbxove_ries` longtext,
  `tbxute_rus` longtext,
  `tbxurin_ary` longtext,
  `tbxaoro_tic` longtext,
  `tbx_any` longtext,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i26`
--

DROP TABLE IF EXISTS `i26`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i26` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxskull` longtext,
  `tbxbones` longtext,
  `tbxepidural` longtext,
  `tbxsubdural` longtext,
  `tbxventricles` longtext,
  `tbxgray` longtext,
  `tbxwhite` longtext,
  `tbxicsol` longtext,
  `tbxhemorrhage` longtext,
  `tbxinfarction` longtext,
  `tbxthrombosis` longtext,
  `tbxedema` longtext,
  `tbxother` longtext,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i27`
--

DROP TABLE IF EXISTS `i27`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i27` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxsku_ll` longtext,
  `tbxbon_es` longtext,
  `tbxepidu_ral` longtext,
  `tbxsubdu_ral` longtext,
  `tbxventr_icles` longtext,
  `tbxgra_y` longtext,
  `tbxwhi_te` longtext,
  `tbxics_ol` longtext,
  `tbxhemor_rhage` longtext,
  `tbxinfar_ction` longtext,
  `tbxthrombo_sis` longtext,
  `tbxede_ma` longtext,
  `tbxother` longtext,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i28`
--

DROP TABLE IF EXISTS `i28`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i28` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_rate` double DEFAULT NULL,
  `rhythm` varchar(50) DEFAULT NULL,
  `axis` varchar(50) DEFAULT NULL,
  `pwave` varchar(50) DEFAULT NULL,
  `printerval` varchar(50) DEFAULT NULL,
  `quwave` varchar(50) DEFAULT NULL,
  `f_qrscomplex` double DEFAULT NULL,
  `qtinterval` varchar(50) DEFAULT NULL,
  `stsegment` varchar(50) DEFAULT NULL,
  `twave` varchar(50) DEFAULT NULL,
  `uwave` varchar(50) DEFAULT NULL,
  `tbxothers` longtext,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i29`
--

DROP TABLE IF EXISTS `i29`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i29` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxecg` longtext,
  `tbxeeg` longtext,
  `tbxemg` longtext,
  `tbxncv` longtext,
  `tbxany` longtext,
  `tbxgeneralimp` longtext,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i30`
--

DROP TABLE IF EXISTS `i30`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i30` (
  `pat_id` char(18) NOT NULL,
  `modality` varchar(50) DEFAULT NULL,
  `study_name` varchar(50) DEFAULT NULL,
  `study_purpose` varchar(50) DEFAULT NULL,
  `roi` varchar(50) DEFAULT NULL,
  `contrast` varchar(50) DEFAULT NULL,
  `report` longtext,
  `prov_diagnosis` longtext,
  `abnormal` varchar(10) DEFAULT NULL,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `i31`
--

DROP TABLE IF EXISTS `i31`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `i31` (
  `pat_id` char(18) NOT NULL,
  `cbc` varchar(50) DEFAULT NULL,
  `urine` varchar(50) DEFAULT NULL,
  `stool` varchar(50) DEFAULT NULL,
  `xray` varchar(50) DEFAULT NULL,
  `mamogrm` varchar(50) DEFAULT NULL,
  `biopsy` varchar(50) DEFAULT NULL,
  `fnac` varchar(50) DEFAULT NULL,
  `usg` varchar(50) DEFAULT NULL,
  `ctscan` varchar(50) DEFAULT NULL,
  `endoscopy` varchar(50) DEFAULT NULL,
  `mri` varchar(50) DEFAULT NULL,
  `bonemarrow` varchar(50) DEFAULT NULL,
  `tumormarker` varchar(50) DEFAULT NULL,
  `liver` varchar(50) DEFAULT NULL,
  `IVP` varchar(50) DEFAULT NULL,
  `bonescan` varchar(50) DEFAULT NULL,
  `colposcopy` varchar(50) DEFAULT NULL,
  `papsmear` varchar(50) DEFAULT NULL,
  `nofimg` varchar(50) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `immun_schedule`
--

DROP TABLE IF EXISTS `immun_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `immun_schedule` (
  `vaccine_code` int NOT NULL,
  `age` varchar(50) NOT NULL,
  `vac_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `immunization`
--

DROP TABLE IF EXISTS `immunization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `immunization` (
  `vac_code` int NOT NULL,
  `vac_name` varchar(45) NOT NULL,
  `vac_info` varchar(200) DEFAULT NULL,
  `disease` varchar(150) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `k00`
--

DROP TABLE IF EXISTS `k00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `k00` (
  `pat_id` char(18) NOT NULL,
  `row_id` int NOT NULL AUTO_INCREMENT,
  `drug_id` int DEFAULT NULL,
  `formulation` varchar(50) DEFAULT NULL,
  `dose` double DEFAULT NULL,
  `pill_disp` int DEFAULT NULL,
  `pill_consumed` int DEFAULT NULL,
  `balance` int DEFAULT NULL,
  `name_hos` varchar(25) NOT NULL,
  `docrg_no` varchar(25) NOT NULL,
  `entrydate` datetime DEFAULT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `k01`
--

DROP TABLE IF EXISTS `k01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `k01` (
  `pat_id` char(18) NOT NULL,
  `row_id` int NOT NULL AUTO_INCREMENT,
  `formulation_id` int DEFAULT NULL,
  `dose` varchar(50) DEFAULT NULL,
  `pill_disp` int DEFAULT NULL,
  `pill_consumed` int DEFAULT NULL,
  `balance` int DEFAULT NULL,
  `name_hos` varchar(25) DEFAULT NULL,
  `docrg_no` varchar(25) DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `k02`
--

DROP TABLE IF EXISTS `k02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `k02` (
  `pat_id` char(18) NOT NULL,
  `row_id` int NOT NULL AUTO_INCREMENT,
  `drug_id` int DEFAULT NULL,
  `formulation_am` varchar(200) DEFAULT NULL,
  `formulation_pm` varchar(200) DEFAULT NULL,
  `dose_am` varchar(50) DEFAULT NULL,
  `dose_pm` varchar(50) DEFAULT NULL,
  `pill_disp` int DEFAULT NULL,
  `pill_consumed` int DEFAULT NULL,
  `balance` int DEFAULT NULL,
  `name_hos` varchar(25) DEFAULT NULL,
  `docrg_no` varchar(50) NOT NULL,
  `entrydate` datetime DEFAULT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_range`
--

DROP TABLE IF EXISTS `lab_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_range` (
  `year` tinyint unsigned NOT NULL,
  `test` varchar(45) NOT NULL,
  `lower` float NOT NULL,
  `upper` float NOT NULL,
  `label` varchar(45) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `month` tinyint unsigned NOT NULL,
  `day` tinyint unsigned NOT NULL,
  `color` varchar(45) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `listofforms`
--

DROP TABLE IF EXISTS `listofforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listofforms` (
  `pat_id` varchar(18) NOT NULL,
  `type` char(14) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  `sent` char(1) DEFAULT NULL,
  `sent_to` char(10) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  `rg_no` varchar(20) DEFAULT NULL,
  `lastupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`pat_id`,`type`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `local_sendq`
--

DROP TABLE IF EXISTS `local_sendq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_sendq` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `send_records` longtext NOT NULL,
  `referred_doc` varchar(20) NOT NULL DEFAULT '',
  `sent_by` varchar(20) NOT NULL DEFAULT '',
  `sent_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `uid` varchar(50) NOT NULL DEFAULT '',
  `pwd` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `crtdate` datetime DEFAULT NULL,
  `type` char(3) NOT NULL DEFAULT '',
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `emailid` varchar(50) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `dis` varchar(50) DEFAULT NULL,
  `rg_no` varchar(20) NOT NULL DEFAULT '',
  `center` varchar(8) DEFAULT NULL,
  `active` char(2) DEFAULT NULL,
  `sign` longblob,
  `doc_regno` varchar(50) DEFAULT NULL,
  `available` char(1) DEFAULT NULL,
  `referral` char(1) DEFAULT NULL,
  `verified` varchar(10) DEFAULT 'A',
  `verifemail` varchar(1) DEFAULT 'N',
  `verifphone` varchar(1) DEFAULT 'N',
  `consent` varchar(1) NOT NULL DEFAULT 'N',
  `ndhmhealthdata` longtext,
  PRIMARY KEY (`uid`,`rg_no`),
  UNIQUE KEY `emailid` (`emailid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_request`
--

DROP TABLE IF EXISTS `login_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_request` (
  `slno` int NOT NULL AUTO_INCREMENT,
  `pat_id` varchar(50) DEFAULT NULL,
  `pat_name` varchar(255) DEFAULT NULL,
  `emailid` varchar(50) DEFAULT NULL,
  `mobile` varchar(25) DEFAULT NULL,
  `rdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`slno`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lpatq`
--

DROP TABLE IF EXISTS `lpatq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lpatq` (
  `pat_id` varchar(18) NOT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `appdate` datetime DEFAULT NULL,
  `assigneddoc` varchar(20) DEFAULT NULL,
  `discategory` varchar(50) DEFAULT NULL,
  `checked` char(1) DEFAULT NULL,
  `delflag` char(1) DEFAULT NULL,
  `opdno` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY KEY (pat_id)
PARTITIONS 10 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lpatq_treated`
--

DROP TABLE IF EXISTS `lpatq_treated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lpatq_treated` (
  `serno` int NOT NULL AUTO_INCREMENT,
  `pat_id` varchar(18) DEFAULT NULL,
  `appdate` datetime DEFAULT NULL,
  `assigneddoc` varchar(20) DEFAULT NULL,
  `discategory` varchar(50) DEFAULT NULL,
  `data_moved` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `opdno` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`serno`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lpatq_treated11`
--

DROP TABLE IF EXISTS `lpatq_treated11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lpatq_treated11` (
  `serno` int NOT NULL AUTO_INCREMENT,
  `pat_id` varchar(18) DEFAULT NULL,
  `appdate` datetime DEFAULT NULL,
  `assigneddoc` varchar(20) DEFAULT NULL,
  `discategory` varchar(50) DEFAULT NULL,
  `data_moved` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `opdno` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`serno`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `med`
--

DROP TABLE IF EXISTS `med`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `med` (
  `pat_id` varchar(18) NOT NULL,
  `entrydate` datetime DEFAULT NULL,
  `pat_name` varchar(50) NOT NULL DEFAULT '',
  `type` char(1) DEFAULT NULL,
  `age` varchar(10) DEFAULT NULL,
  `sex` varchar(8) DEFAULT NULL,
  `religion` varchar(30) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `consent` char(2) DEFAULT NULL,
  `addline1` varchar(200) DEFAULT NULL,
  `addline2` varchar(200) DEFAULT NULL,
  `policestn` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `dist` varchar(30) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `country` char(2) DEFAULT NULL,
  `pin` decimal(18,0) DEFAULT NULL,
  `pat_person` varchar(50) DEFAULT NULL,
  `pat_relation` varchar(50) DEFAULT NULL,
  `pat_person_add` varchar(200) DEFAULT NULL,
  `referring_doctor` varchar(20) DEFAULT NULL,
  `dateofbirth` datetime DEFAULT NULL,
  `pre` varchar(4) DEFAULT NULL,
  `m_name` varchar(50) DEFAULT NULL,
  `l_name` varchar(50) NOT NULL DEFAULT '',
  `m_status` varchar(4) DEFAULT NULL,
  `race` varchar(30) DEFAULT NULL,
  `caste_category` varchar(30) DEFAULT NULL,
  `persidtype` varchar(50) DEFAULT NULL,
  `persidvalue` varchar(50) DEFAULT NULL,
  `persidchecked` int DEFAULT '0',
  `opdno` varchar(20) DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `primarypatid` varchar(50) DEFAULT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`),
  KEY `index_opdno` (`opdno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `med_history`
--

DROP TABLE IF EXISTS `med_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `med_history` (
  `pat_id` varchar(18) DEFAULT NULL,
  `entrydateofchange` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pat_name` varchar(50) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `age` varchar(10) DEFAULT NULL,
  `sex` varchar(8) DEFAULT NULL,
  `religion` varchar(30) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `consent` char(2) DEFAULT NULL,
  `addline1` varchar(50) DEFAULT NULL,
  `addline2` varchar(50) DEFAULT NULL,
  `policestn` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `dist` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `pin` decimal(18,0) DEFAULT NULL,
  `pat_person` varchar(50) DEFAULT NULL,
  `pat_relation` varchar(50) DEFAULT NULL,
  `pat_person_add` varchar(200) DEFAULT NULL,
  `referring_doctor` varchar(20) DEFAULT NULL,
  `dateofbirth` datetime DEFAULT NULL,
  `pre` varchar(4) DEFAULT NULL,
  `m_name` varchar(50) DEFAULT NULL,
  `l_name` varchar(50) DEFAULT NULL,
  `m_status` varchar(4) DEFAULT NULL,
  `race` varchar(30) DEFAULT NULL,
  `serno` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `med_pax_map`
--

DROP TABLE IF EXISTS `med_pax_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `med_pax_map` (
  `pax_id` varchar(50) NOT NULL,
  `pat_id` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`pax_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `med_procedure`
--

DROP TABLE IF EXISTS `med_procedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `med_procedure` (
  `proc_id` int NOT NULL,
  `testname` varchar(150) NOT NULL,
  `region` varchar(150) NOT NULL,
  `indication` longtext NOT NULL,
  `intervention` longtext,
  `specimen` longtext,
  `report` longtext,
  `diagnosis` longtext,
  `tbxother` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime DEFAULT NULL,
  `serno` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `new_listofforms`
--

DROP TABLE IF EXISTS `new_listofforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_listofforms` (
  `pat_id` char(18) NOT NULL DEFAULT '',
  `type` char(18) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  `sent` char(1) DEFAULT NULL,
  `sent_to` char(10) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  `rg_no` varchar(20) DEFAULT NULL,
  `lastupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`pat_id`,`type`,`date`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `normal_range`
--

DROP TABLE IF EXISTS `normal_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `normal_range` (
  `param_type` varchar(50) DEFAULT NULL,
  `quantity_name` varchar(50) DEFAULT NULL,
  `min_param` int DEFAULT NULL,
  `max_param` int DEFAULT NULL,
  `min_quantity` int DEFAULT NULL,
  `max_quantity` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `online_history`
--

DROP TABLE IF EXISTS `online_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `online_history` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `com_date` datetime DEFAULT NULL,
  `starttime` time DEFAULT NULL,
  `endtime` time DEFAULT NULL,
  `duration` varchar(30) DEFAULT NULL,
  `com_type` varchar(50) DEFAULT NULL,
  `remote_ccode` char(3) DEFAULT NULL,
  `local_doc` varchar(20) DEFAULT NULL,
  `remote_doc` varchar(20) DEFAULT NULL,
  `comments` longtext,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onto`
--

DROP TABLE IF EXISTS `onto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `onto` (
  `organ` varchar(30) DEFAULT NULL,
  `stage_t` varchar(200) DEFAULT NULL,
  `stage_n` varchar(200) DEFAULT NULL,
  `stage_m` varchar(200) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `othdis`
--

DROP TABLE IF EXISTS `othdis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `othdis` (
  `rg_no` varchar(50) NOT NULL DEFAULT '',
  `dis` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`rg_no`,`dis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p00`
--

DROP TABLE IF EXISTS `p00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p00` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `consciousness` varchar(50) DEFAULT NULL,
  `decubitus` varchar(50) DEFAULT NULL,
  `appearance` varchar(50) DEFAULT NULL,
  `build` varchar(50) DEFAULT NULL,
  `anemia` varchar(50) DEFAULT NULL,
  `skin_texture` varchar(50) DEFAULT NULL,
  `hair` varchar(50) DEFAULT NULL,
  `cyanosis` varchar(50) DEFAULT NULL,
  `jaundice` varchar(50) DEFAULT NULL,
  `facies` varchar(50) DEFAULT NULL,
  `neckglands` varchar(50) DEFAULT NULL,
  `fever` varchar(50) DEFAULT NULL,
  `weak` varchar(50) DEFAULT NULL,
  `haemorrhage` varchar(50) DEFAULT NULL,
  `pulse` varchar(50) DEFAULT NULL,
  `bp` varchar(50) DEFAULT NULL,
  `respiration` varchar(50) DEFAULT NULL,
  `tempature` varchar(50) DEFAULT NULL,
  `wt` float DEFAULT NULL,
  `ht` float DEFAULT NULL,
  `other` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p01`
--

DROP TABLE IF EXISTS `p01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p01` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `duration1` varchar(50) DEFAULT NULL,
  `mode_onset1` varchar(50) DEFAULT NULL,
  `pain1` varchar(50) DEFAULT NULL,
  `progress_swelling1` varchar(50) DEFAULT NULL,
  `presence1` varchar(50) DEFAULT NULL,
  `secondary_change1` varchar(50) DEFAULT NULL,
  `l_weight_appetite1` varchar(50) DEFAULT NULL,
  `upper_l1` varchar(50) DEFAULT NULL,
  `upper_r1` varchar(50) DEFAULT NULL,
  `lower_l1` varchar(50) DEFAULT NULL,
  `lower_r1` varchar(50) DEFAULT NULL,
  `inspection1` varchar(50) DEFAULT NULL,
  `temperature1` varchar(50) DEFAULT NULL,
  `tenderness1` varchar(50) DEFAULT NULL,
  `size1` varchar(50) DEFAULT NULL,
  `shape_extent1` varchar(50) DEFAULT NULL,
  `surface1` varchar(50) DEFAULT NULL,
  `edge1` varchar(50) DEFAULT NULL,
  `consistency1` varchar(50) DEFAULT NULL,
  `fluctuation1` varchar(50) DEFAULT NULL,
  `fluid_thrill1` varchar(50) DEFAULT NULL,
  `translucency1` varchar(50) DEFAULT NULL,
  `impulse_coughing1` varchar(50) DEFAULT NULL,
  `reducibility1` varchar(50) DEFAULT NULL,
  `compressibility1` varchar(50) DEFAULT NULL,
  `pulsatility1` varchar(50) DEFAULT NULL,
  `fixity1` varchar(50) DEFAULT NULL,
  `r_egional_lymph1` varchar(50) DEFAULT NULL,
  `auscultation1` varchar(50) DEFAULT NULL,
  `measurements1` varchar(50) DEFAULT NULL,
  `movements1` varchar(50) DEFAULT NULL,
  `pressure1` varchar(50) DEFAULT NULL,
  `others1` varchar(50) DEFAULT NULL,
  `tbxgeneralimp1` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p02`
--

DROP TABLE IF EXISTS `p02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p02` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site2` varchar(50) DEFAULT NULL,
  `time_onset2` varchar(50) DEFAULT NULL,
  `mode_onset2` varchar(50) DEFAULT NULL,
  `duration2` varchar(50) DEFAULT NULL,
  `shifting2` varchar(50) DEFAULT NULL,
  `radiation2` varchar(50) DEFAULT NULL,
  `referral2` varchar(50) DEFAULT NULL,
  `character2` varchar(50) DEFAULT NULL,
  `effect_pressure2` varchar(50) DEFAULT NULL,
  `effect_walking2` varchar(50) DEFAULT NULL,
  `jolting2` varchar(50) DEFAULT NULL,
  `breathing2` varchar(50) DEFAULT NULL,
  `micturition2` varchar(50) DEFAULT NULL,
  `worse2` varchar(50) DEFAULT NULL,
  `relieved2` varchar(50) DEFAULT NULL,
  `others2` varchar(50) DEFAULT NULL,
  `tbxgeneralimp2` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p03`
--

DROP TABLE IF EXISTS `p03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p03` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `onset3` varchar(50) DEFAULT NULL,
  `duration3` varchar(50) DEFAULT NULL,
  `severity3` varchar(50) DEFAULT NULL,
  `progress3` varchar(50) DEFAULT NULL,
  `proportionate3` varchar(50) DEFAULT NULL,
  `drugs3` varchar(50) DEFAULT NULL,
  `familyhis3` varchar(50) DEFAULT NULL,
  `parasitic3` varchar(50) DEFAULT NULL,
  `previous3` varchar(50) DEFAULT NULL,
  `anyother3` varchar(50) DEFAULT NULL,
  `tbxgeneralimp3` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p04`
--

DROP TABLE IF EXISTS `p04`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p04` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `onset4` varchar(50) DEFAULT NULL,
  `duration4` varchar(50) DEFAULT NULL,
  `severity4` varchar(50) DEFAULT NULL,
  `progress4` varchar(50) DEFAULT NULL,
  `blood_tranf4` varchar(50) DEFAULT NULL,
  `parenteral4` varchar(50) DEFAULT NULL,
  `alcoholism4` varchar(50) DEFAULT NULL,
  `family_his4` varchar(50) DEFAULT NULL,
  `details4` varchar(50) DEFAULT NULL,
  `others4` varchar(50) DEFAULT NULL,
  `tbxgeneralimp4` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p05`
--

DROP TABLE IF EXISTS `p05`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p05` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site5` varchar(50) DEFAULT NULL,
  `onset5` varchar(50) DEFAULT NULL,
  `duration5` varchar(50) DEFAULT NULL,
  `progress5` varchar(50) DEFAULT NULL,
  `fever5` varchar(50) DEFAULT NULL,
  `tenderness5` varchar(50) DEFAULT NULL,
  `txtsize5` varchar(50) DEFAULT NULL,
  `consistency5` varchar(50) DEFAULT NULL,
  `discharge5` varchar(50) DEFAULT NULL,
  `sinus5` varchar(50) DEFAULT NULL,
  `adherenceto5` varchar(50) DEFAULT NULL,
  `associat5` varchar(50) DEFAULT NULL,
  `treatment5` varchar(50) DEFAULT NULL,
  `response5` varchar(50) DEFAULT NULL,
  `tbxinspection5` longtext,
  `tbxpalpation5` longtext,
  `tbxpercussion5` longtext,
  `tbxauscultation5` longtext,
  `tbxothers5` longtext,
  `tbxgeneralimp5` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p06`
--

DROP TABLE IF EXISTS `p06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p06` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site6` varchar(50) DEFAULT NULL,
  `character6` varchar(50) DEFAULT NULL,
  `time_onset6` varchar(50) DEFAULT NULL,
  `mode_onset6` varchar(50) DEFAULT NULL,
  `duration6` varchar(50) DEFAULT NULL,
  `worse6` varchar(50) DEFAULT NULL,
  `relieved6` varchar(50) DEFAULT NULL,
  `culture6` varchar(50) DEFAULT NULL,
  `anyoth6` varchar(50) DEFAULT NULL,
  `tbxgeneralimp6` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p07`
--

DROP TABLE IF EXISTS `p07`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p07` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `onset7` varchar(50) DEFAULT NULL,
  `duration7` varchar(50) DEFAULT NULL,
  `chill_rigor7` varchar(50) DEFAULT NULL,
  `frequency7` varchar(50) DEFAULT NULL,
  `variations7` varchar(50) DEFAULT NULL,
  `tbxany7` longtext,
  `nature7` varchar(50) DEFAULT NULL,
  `relatedblood7` varchar(50) DEFAULT NULL,
  `remission7` varchar(50) DEFAULT NULL,
  `treatment7` varchar(50) DEFAULT NULL,
  `response7` varchar(50) DEFAULT NULL,
  `tbxgeneralimp7` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p08`
--

DROP TABLE IF EXISTS `p08`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p08` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `onset8` varchar(50) DEFAULT NULL,
  `duration8` varchar(50) DEFAULT NULL,
  `severity8` varchar(50) DEFAULT NULL,
  `progress8` varchar(50) DEFAULT NULL,
  `infection8` varchar(50) DEFAULT NULL,
  `toxins8` varchar(50) DEFAULT NULL,
  `morbidity8` varchar(50) DEFAULT NULL,
  `others8` varchar(50) DEFAULT NULL,
  `tbxgeneralimp8` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p09`
--

DROP TABLE IF EXISTS `p09`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p09` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `dimness` varchar(50) DEFAULT NULL,
  `onset` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `glasses` varchar(50) DEFAULT NULL,
  `power` varchar(50) DEFAULT NULL,
  `dimnessf` varchar(50) DEFAULT NULL,
  `diplopia` varchar(50) DEFAULT NULL,
  `p_redness` varchar(50) DEFAULT NULL,
  `p_t_eyes` varchar(50) DEFAULT NULL,
  `p_g_illnesses` varchar(50) DEFAULT NULL,
  `e_duration` varchar(50) DEFAULT NULL,
  `e_persistence` varchar(50) DEFAULT NULL,
  `e_aggravated` varchar(50) DEFAULT NULL,
  `e_a_redness` varchar(50) DEFAULT NULL,
  `e_discharge` varchar(50) DEFAULT NULL,
  `e_photophobia` varchar(50) DEFAULT NULL,
  `e_trauma` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `ti_me` varchar(50) DEFAULT NULL,
  `degree` varchar(50) DEFAULT NULL,
  `frequency` varchar(50) DEFAULT NULL,
  `aggravated` varchar(50) DEFAULT NULL,
  `features` varchar(50) DEFAULT NULL,
  `head` varchar(50) DEFAULT NULL,
  `face` varchar(50) DEFAULT NULL,
  `eyebrows` varchar(50) DEFAULT NULL,
  `palpebral` varchar(50) DEFAULT NULL,
  `upper` varchar(50) DEFAULT NULL,
  `lower` varchar(50) DEFAULT NULL,
  `e_size` varchar(50) DEFAULT NULL,
  `posi_tion` varchar(50) DEFAULT NULL,
  `squint` varchar(50) DEFAULT NULL,
  `pulsating` varchar(50) DEFAULT NULL,
  `tbxnystagmus` longtext,
  `orbits` varchar(50) DEFAULT NULL,
  `eyelids` varchar(50) DEFAULT NULL,
  `lacrimal` varchar(50) DEFAULT NULL,
  `bulbar` varchar(50) DEFAULT NULL,
  `u_tarsal` varchar(50) DEFAULT NULL,
  `l_tarsal` varchar(50) DEFAULT NULL,
  `limbus` varchar(50) DEFAULT NULL,
  `diameter` varchar(50) DEFAULT NULL,
  `curvature` varchar(50) DEFAULT NULL,
  `surface` varchar(50) DEFAULT NULL,
  `opacity` varchar(50) DEFAULT NULL,
  `density` varchar(50) DEFAULT NULL,
  `pupil` varchar(50) DEFAULT NULL,
  `pigmentation` varchar(50) DEFAULT NULL,
  `adhesion` varchar(50) DEFAULT NULL,
  `presence` varchar(50) DEFAULT NULL,
  `keratic` varchar(50) DEFAULT NULL,
  `corneal` varchar(50) DEFAULT NULL,
  `depth` varchar(50) DEFAULT NULL,
  `extraneous` varchar(50) DEFAULT NULL,
  `angle` varchar(50) DEFAULT NULL,
  `pupils` varchar(50) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `shape` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `margin` varchar(50) DEFAULT NULL,
  `aperture` varchar(50) DEFAULT NULL,
  `reflex` varchar(50) DEFAULT NULL,
  `accommodation` varchar(50) DEFAULT NULL,
  `pattern` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `r_vessels` varchar(50) DEFAULT NULL,
  `atrophic` varchar(50) DEFAULT NULL,
  `iris` varchar(50) DEFAULT NULL,
  `iridodonesis` varchar(50) DEFAULT NULL,
  `iridodialysis` varchar(50) DEFAULT NULL,
  `synechia` varchar(50) DEFAULT NULL,
  `l_color` varchar(50) DEFAULT NULL,
  `l_opacity` varchar(50) DEFAULT NULL,
  `displacement` varchar(50) DEFAULT NULL,
  `images` varchar(50) DEFAULT NULL,
  `other` varchar(50) DEFAULT NULL,
  `tonometry` varchar(50) DEFAULT NULL,
  `visual` varchar(50) DEFAULT NULL,
  `acuity_f` varchar(50) DEFAULT NULL,
  `acuity_n` varchar(50) DEFAULT NULL,
  `c_vision` varchar(50) DEFAULT NULL,
  `cranial_nerves` varchar(50) DEFAULT NULL,
  `ophthalmoscopy` varchar(50) DEFAULT NULL,
  `optic` varchar(50) DEFAULT NULL,
  `macular` varchar(50) DEFAULT NULL,
  `vessels` varchar(50) DEFAULT NULL,
  `appearance` varchar(50) DEFAULT NULL,
  `choroidal` varchar(50) DEFAULT NULL,
  `red_free` varchar(50) DEFAULT NULL,
  `lesions` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p10`
--

DROP TABLE IF EXISTS `p10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p10` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site1` varchar(50) DEFAULT NULL,
  `time_onset1` varchar(50) DEFAULT NULL,
  `mode_onset1` varchar(50) DEFAULT NULL,
  `duration1` varchar(50) DEFAULT NULL,
  `shifting1` varchar(50) DEFAULT NULL,
  `radiation1` varchar(50) DEFAULT NULL,
  `referral1` varchar(50) DEFAULT NULL,
  `character1` varchar(50) DEFAULT NULL,
  `effect_pressure1` varchar(50) DEFAULT NULL,
  `effect_walking1` varchar(50) DEFAULT NULL,
  `jolting1` varchar(50) DEFAULT NULL,
  `breathing1` varchar(50) DEFAULT NULL,
  `micturition1` varchar(50) DEFAULT NULL,
  `worse1` varchar(50) DEFAULT NULL,
  `relieved1` varchar(50) DEFAULT NULL,
  `others1` varchar(50) DEFAULT NULL,
  `tbxgeneralimp1` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p12`
--

DROP TABLE IF EXISTS `p12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p12` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `pain` varchar(50) DEFAULT NULL,
  `discharge` varchar(50) DEFAULT NULL,
  `deafness` varchar(50) DEFAULT NULL,
  `tinnitus` varchar(50) DEFAULT NULL,
  `otalgia` varchar(50) DEFAULT NULL,
  `otorrhea` varchar(50) DEFAULT NULL,
  `nasal_obstruction` varchar(50) DEFAULT NULL,
  `epistaxis` varchar(50) DEFAULT NULL,
  `smell_disturbances` varchar(50) DEFAULT NULL,
  `sneezing` varchar(50) DEFAULT NULL,
  `regional_symptoms` varchar(50) DEFAULT NULL,
  `sore_throat` varchar(50) DEFAULT NULL,
  `dysphagia` varchar(50) DEFAULT NULL,
  `aphonia` varchar(50) DEFAULT NULL,
  `lump` varchar(50) DEFAULT NULL,
  `cough` varchar(50) DEFAULT NULL,
  `hoarseness` varchar(50) DEFAULT NULL,
  `vertigo` varchar(50) DEFAULT NULL,
  `nystagmus` varchar(50) DEFAULT NULL,
  `anyoth` varchar(50) DEFAULT NULL,
  `head` varchar(50) DEFAULT NULL,
  `face` varchar(50) DEFAULT NULL,
  `torch` varchar(50) DEFAULT NULL,
  `l_conversation` varchar(50) DEFAULT NULL,
  `l_color` varchar(50) DEFAULT NULL,
  `l_membrane` varchar(50) DEFAULT NULL,
  `l_perforation` varchar(50) DEFAULT NULL,
  `l_state` varchar(50) DEFAULT NULL,
  `l_fluid` varchar(50) DEFAULT NULL,
  `l_mobility` varchar(50) DEFAULT NULL,
  `l_rinne` varchar(50) DEFAULT NULL,
  `l_weber` varchar(50) DEFAULT NULL,
  `l_abc` varchar(50) DEFAULT NULL,
  `l_teubs` varchar(50) DEFAULT NULL,
  `l_otomicroscopy` varchar(50) DEFAULT NULL,
  `l_fistula` varchar(50) DEFAULT NULL,
  `l_audiometry` varchar(50) DEFAULT NULL,
  `l_tympanometry` varchar(50) DEFAULT NULL,
  `l_reflex` varchar(50) DEFAULT NULL,
  `l_baer` varchar(50) DEFAULT NULL,
  `l_vestibular` varchar(50) DEFAULT NULL,
  `l_nasal_speculum` varchar(50) DEFAULT NULL,
  `l_x_rays` varchar(50) DEFAULT NULL,
  `l_nconversation` varchar(50) DEFAULT NULL,
  `r_conversation` varchar(50) DEFAULT NULL,
  `r_color` varchar(50) DEFAULT NULL,
  `r_membrane` varchar(50) DEFAULT NULL,
  `r_perforation` varchar(50) DEFAULT NULL,
  `r_state` varchar(50) DEFAULT NULL,
  `r_fluid` varchar(50) DEFAULT NULL,
  `r_mobility` varchar(50) DEFAULT NULL,
  `r_rinne` varchar(50) DEFAULT NULL,
  `r_weber` varchar(50) DEFAULT NULL,
  `r_abc` varchar(50) DEFAULT NULL,
  `r_e_tube` varchar(50) DEFAULT NULL,
  `r_otomicroscopy` varchar(50) DEFAULT NULL,
  `r_fistula` varchar(50) DEFAULT NULL,
  `r_audiometry` varchar(50) DEFAULT NULL,
  `r_tympanometry` varchar(50) DEFAULT NULL,
  `r_reflex` varchar(50) DEFAULT NULL,
  `r_baer` varchar(50) DEFAULT NULL,
  `r_vestibular` varchar(50) DEFAULT NULL,
  `r_nasal_speculum` varchar(50) DEFAULT NULL,
  `r_x_rays` varchar(50) DEFAULT NULL,
  `r_nconversation` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p13`
--

DROP TABLE IF EXISTS `p13`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p13` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site` varchar(50) DEFAULT NULL,
  `time_onset` varchar(50) DEFAULT NULL,
  `mode_onset` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `shifting` varchar(50) DEFAULT NULL,
  `radiation` varchar(50) DEFAULT NULL,
  `referral` varchar(50) DEFAULT NULL,
  `characters` varchar(50) DEFAULT NULL,
  `effect_pressure` varchar(50) DEFAULT NULL,
  `effect_walking` varchar(50) DEFAULT NULL,
  `jolting` varchar(50) DEFAULT NULL,
  `breathing` varchar(50) DEFAULT NULL,
  `micturition` varchar(50) DEFAULT NULL,
  `worse` varchar(50) DEFAULT NULL,
  `relieved` varchar(50) DEFAULT NULL,
  `others1` varchar(50) DEFAULT NULL,
  `tbxgeneralimp1` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p14`
--

DROP TABLE IF EXISTS `p14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p14` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site2` varchar(50) DEFAULT NULL,
  `character2` varchar(50) DEFAULT NULL,
  `time_onset2` varchar(50) DEFAULT NULL,
  `mode_onset2` varchar(50) DEFAULT NULL,
  `duration2` varchar(50) DEFAULT NULL,
  `worse2` varchar(50) DEFAULT NULL,
  `relieved2` varchar(50) DEFAULT NULL,
  `culture2` varchar(50) DEFAULT NULL,
  `anyoth2` varchar(50) DEFAULT NULL,
  `tbxgeneralimp2` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p15`
--

DROP TABLE IF EXISTS `p15`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p15` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `gastroscopy` varchar(50) DEFAULT NULL,
  `ercp` varchar(50) DEFAULT NULL,
  `proctoscopy` varchar(50) DEFAULT NULL,
  `colonoscopy` varchar(50) DEFAULT NULL,
  `esophagoscopy` varchar(50) DEFAULT NULL,
  `laryngoscopy` varchar(50) DEFAULT NULL,
  `posterior` varchar(50) DEFAULT NULL,
  `bronchoscopy` varchar(50) DEFAULT NULL,
  `laparoscopy` varchar(50) DEFAULT NULL,
  `others3` varchar(50) DEFAULT NULL,
  `tbxgeneralimp3` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p16`
--

DROP TABLE IF EXISTS `p16`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p16` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxendocrinology` longtext,
  `tbximmunology` longtext,
  `tbxhematology` longtext,
  `tbxrheumatology` longtext,
  `tbxgenitourinary` longtext,
  `tbxpediatrics` longtext,
  `tbxnon_specific` longtext,
  `tbxother_x` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p17`
--

DROP TABLE IF EXISTS `p17`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p17` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `shape_size` varchar(50) DEFAULT NULL,
  `f_rate` double DEFAULT NULL,
  `neck_veins` varchar(50) DEFAULT NULL,
  `trachea` varchar(50) DEFAULT NULL,
  `apex` varchar(50) DEFAULT NULL,
  `swelling` varchar(50) DEFAULT NULL,
  `cardiac_dullness` varchar(50) DEFAULT NULL,
  `hepatic_dullness` varchar(50) DEFAULT NULL,
  `dullness` varchar(50) DEFAULT NULL,
  `obvious_swelling` varchar(50) DEFAULT NULL,
  `p_trachea` varchar(50) DEFAULT NULL,
  `apex_beat` varchar(50) DEFAULT NULL,
  `respiratory` varchar(50) DEFAULT NULL,
  `vocal_fremitus` varchar(50) DEFAULT NULL,
  `breath` varchar(50) DEFAULT NULL,
  `vocal` varchar(50) DEFAULT NULL,
  `adventitious` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p18`
--

DROP TABLE IF EXISTS `p18`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p18` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `shape_size` varchar(50) DEFAULT NULL,
  `trachea` varchar(50) DEFAULT NULL,
  `apex` varchar(50) DEFAULT NULL,
  `swelling` varchar(50) DEFAULT NULL,
  `cardiac_dullness` varchar(50) DEFAULT NULL,
  `hepatic_dullness` varchar(50) DEFAULT NULL,
  `dullness` varchar(50) DEFAULT NULL,
  `obvious_swelling` varchar(50) DEFAULT NULL,
  `p_trachea` varchar(50) DEFAULT NULL,
  `apex_beat` varchar(50) DEFAULT NULL,
  `respiratory` varchar(50) DEFAULT NULL,
  `vocal_fremitus` varchar(50) DEFAULT NULL,
  `breath` varchar(50) DEFAULT NULL,
  `heart_s1_m` varchar(50) DEFAULT NULL,
  `heart_s1_p` varchar(50) DEFAULT NULL,
  `heart_s1_a` varchar(50) DEFAULT NULL,
  `heart_s1_t` varchar(50) DEFAULT NULL,
  `heart_a1_m` varchar(50) DEFAULT NULL,
  `heart_a1_p` varchar(50) DEFAULT NULL,
  `heart_a1_a` varchar(50) DEFAULT NULL,
  `heart_a1_t` varchar(50) DEFAULT NULL,
  `heart_s2_m` varchar(50) DEFAULT NULL,
  `heart_s2_p` varchar(50) DEFAULT NULL,
  `heart_s2_a` varchar(50) DEFAULT NULL,
  `heart_s2_t` varchar(50) DEFAULT NULL,
  `heart_a2_m` varchar(50) DEFAULT NULL,
  `heart_a2_p` varchar(50) DEFAULT NULL,
  `heart_a2_a` varchar(50) DEFAULT NULL,
  `heart_a2_t` varchar(50) DEFAULT NULL,
  `heart_s3_m` varchar(50) DEFAULT NULL,
  `heart_s3_p` varchar(50) DEFAULT NULL,
  `heart_s3_a` varchar(50) DEFAULT NULL,
  `heart_s3_t` varchar(50) DEFAULT NULL,
  `heart_s4_m` varchar(50) DEFAULT NULL,
  `heart_s4_p` varchar(50) DEFAULT NULL,
  `heart_s4_a` varchar(50) DEFAULT NULL,
  `heart_s4_t` varchar(50) DEFAULT NULL,
  `n_murmur` varchar(50) DEFAULT NULL,
  `murmurs` varchar(50) DEFAULT NULL,
  `lateral` varchar(50) DEFAULT NULL,
  `salva` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p19`
--

DROP TABLE IF EXISTS `p19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p19` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `palpation` varchar(50) DEFAULT NULL,
  `dysphagia` varchar(50) DEFAULT NULL,
  `redness` varchar(50) DEFAULT NULL,
  `swelling` varchar(50) DEFAULT NULL,
  `ulcers` varchar(50) DEFAULT NULL,
  `arteriography` varchar(50) DEFAULT NULL,
  `interventional` varchar(50) DEFAULT NULL,
  `secretory` varchar(50) DEFAULT NULL,
  `malabsorption` varchar(50) DEFAULT NULL,
  `breath` varchar(50) DEFAULT NULL,
  `motility` varchar(50) DEFAULT NULL,
  `paracentesis` varchar(50) DEFAULT NULL,
  `esophagus` varchar(50) DEFAULT NULL,
  `stomach` varchar(50) DEFAULT NULL,
  `s_intestines` varchar(50) DEFAULT NULL,
  `l_intestines` varchar(50) DEFAULT NULL,
  `colon` varchar(50) DEFAULT NULL,
  `bladder` varchar(50) DEFAULT NULL,
  `tbxinspection` longtext,
  `tbxpalpation` longtext,
  `tbxpercussion` longtext,
  `tbxauscultation` longtext,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p20`
--

DROP TABLE IF EXISTS `p20`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p20` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site` varchar(50) DEFAULT NULL,
  `time_onset` varchar(50) DEFAULT NULL,
  `mode_onset` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `shifting` varchar(50) DEFAULT NULL,
  `radiation` varchar(50) DEFAULT NULL,
  `referral` varchar(50) DEFAULT NULL,
  `characters` varchar(50) DEFAULT NULL,
  `effect_pressure` varchar(50) DEFAULT NULL,
  `effect_walking` varchar(50) DEFAULT NULL,
  `jolting` varchar(50) DEFAULT NULL,
  `breathing` varchar(50) DEFAULT NULL,
  `micturition` varchar(50) DEFAULT NULL,
  `worse` varchar(50) DEFAULT NULL,
  `relieved` varchar(50) DEFAULT NULL,
  `others1` varchar(50) DEFAULT NULL,
  `tbxgeneralimp1` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p21`
--

DROP TABLE IF EXISTS `p21`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p21` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `gastroscopy` varchar(50) DEFAULT NULL,
  `ercp` varchar(50) DEFAULT NULL,
  `proctoscopy` varchar(50) DEFAULT NULL,
  `colonoscopy` varchar(50) DEFAULT NULL,
  `esophagoscopy` varchar(50) DEFAULT NULL,
  `laryngoscopy` varchar(50) DEFAULT NULL,
  `posterior` varchar(50) DEFAULT NULL,
  `bronchoscopy` varchar(50) DEFAULT NULL,
  `laparoscopy` varchar(50) DEFAULT NULL,
  `others2` varchar(50) DEFAULT NULL,
  `tbxgeneralimp2` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p22`
--

DROP TABLE IF EXISTS `p22`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p22` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `pigmentation` varchar(50) DEFAULT NULL,
  `hemorrhage` varchar(50) DEFAULT NULL,
  `distribution` varchar(50) DEFAULT NULL,
  `morphology` varchar(50) DEFAULT NULL,
  `hair` varchar(50) DEFAULT NULL,
  `nails` varchar(50) DEFAULT NULL,
  `microscopical` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p23`
--

DROP TABLE IF EXISTS `p23`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p23` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `menarche` varchar(50) DEFAULT NULL,
  `cycle` varchar(50) DEFAULT NULL,
  `intervals` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  `pain` varchar(50) DEFAULT NULL,
  `l_menstrual` varchar(50) DEFAULT NULL,
  `marital` varchar(50) DEFAULT NULL,
  `parity` varchar(50) DEFAULT NULL,
  `f_fpreg` double DEFAULT NULL,
  `pregnancy` varchar(50) DEFAULT NULL,
  `f_spreg` double DEFAULT NULL,
  `s_pregnancy` varchar(50) DEFAULT NULL,
  `tbxothers` longtext,
  `general` varchar(50) DEFAULT NULL,
  `systemic` varchar(50) DEFAULT NULL,
  `cvs` varchar(50) DEFAULT NULL,
  `r_s` varchar(50) DEFAULT NULL,
  `brest` varchar(50) DEFAULT NULL,
  `abdominal` varchar(50) DEFAULT NULL,
  `obstetric` varchar(50) DEFAULT NULL,
  `culum` varchar(50) DEFAULT NULL,
  `vagenal` varchar(50) DEFAULT NULL,
  `rectal` varchar(50) DEFAULT NULL,
  `summary` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p24`
--

DROP TABLE IF EXISTS `p24`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p24` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `appearance` varchar(50) DEFAULT NULL,
  `emotional` varchar(50) DEFAULT NULL,
  `delusions` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `spac` varchar(50) DEFAULT NULL,
  `person` varchar(50) DEFAULT NULL,
  `clouding` varchar(50) DEFAULT NULL,
  `recent` varchar(50) DEFAULT NULL,
  `short` varchar(50) DEFAULT NULL,
  `long` varchar(50) DEFAULT NULL,
  `general` varchar(50) DEFAULT NULL,
  `released` varchar(50) DEFAULT NULL,
  `cooperation` varchar(50) DEFAULT NULL,
  `thought` varchar(50) DEFAULT NULL,
  `ocp` varchar(50) DEFAULT NULL,
  `suicide` varchar(50) DEFAULT NULL,
  `psychometric` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p25`
--

DROP TABLE IF EXISTS `p25`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p25` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxskull` longtext,
  `tbxbones` longtext,
  `tbxepidural` longtext,
  `tbxsubdural` longtext,
  `tbxventricles` longtext,
  `tbxgray` longtext,
  `tbxwhite` longtext,
  `tbxicsol` longtext,
  `tbxhemorrhage` longtext,
  `tbxinfarction` longtext,
  `tbxthrombosis` longtext,
  `tbxedema` longtext,
  `tbxctother` longtext,
  `tbxctimpassion` longtext,
  `ctdate` varchar(50) DEFAULT NULL,
  `tbxsku_ll` longtext,
  `tbxbon_es` longtext,
  `tbxepidu_ral` longtext,
  `tbxsubdu_ral` longtext,
  `tbxventr_icles` longtext,
  `tbxgra_y` longtext,
  `tbxwhi_te` longtext,
  `tbxics_ol` longtext,
  `tbxhemor_rhage` longtext,
  `tbxinfar_ction` longtext,
  `tbxthrombo_sis` longtext,
  `tbxede_ma` longtext,
  `tbxmriother` longtext,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p26`
--

DROP TABLE IF EXISTS `p26`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p26` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `speech` varchar(50) DEFAULT NULL,
  `apraxia` varchar(50) DEFAULT NULL,
  `umnr1` varchar(50) DEFAULT NULL,
  `umnl1` varchar(50) DEFAULT NULL,
  `lmnr1` varchar(50) DEFAULT NULL,
  `lmnl1` varchar(50) DEFAULT NULL,
  `umnr2` varchar(50) DEFAULT NULL,
  `umnl2` varchar(50) DEFAULT NULL,
  `lmnr2` varchar(50) DEFAULT NULL,
  `lmnl2` varchar(50) DEFAULT NULL,
  `umnr3` varchar(50) DEFAULT NULL,
  `umnl3` varchar(50) DEFAULT NULL,
  `lmnr3` varchar(50) DEFAULT NULL,
  `lmnl3` varchar(50) DEFAULT NULL,
  `umnr4` varchar(50) DEFAULT NULL,
  `umnl4` varchar(50) DEFAULT NULL,
  `lmnr4` varchar(50) DEFAULT NULL,
  `lmnl4` varchar(50) DEFAULT NULL,
  `umnr5` varchar(50) DEFAULT NULL,
  `umnl5` varchar(50) DEFAULT NULL,
  `lmnr5` varchar(50) DEFAULT NULL,
  `lmnl5` varchar(50) DEFAULT NULL,
  `umnr6` varchar(50) DEFAULT NULL,
  `umnl6` varchar(50) DEFAULT NULL,
  `lmnr6` varchar(50) DEFAULT NULL,
  `lmnl6` varchar(50) DEFAULT NULL,
  `umnr7` varchar(50) DEFAULT NULL,
  `umnl7` varchar(50) DEFAULT NULL,
  `lmnr7` varchar(50) DEFAULT NULL,
  `lmnl7` varchar(50) DEFAULT NULL,
  `umnr8` varchar(50) DEFAULT NULL,
  `umnl8` varchar(50) DEFAULT NULL,
  `lmnr8` varchar(50) DEFAULT NULL,
  `lmnl8` varchar(50) DEFAULT NULL,
  `umnr9` varchar(50) DEFAULT NULL,
  `umnl9` varchar(50) DEFAULT NULL,
  `lmnr9` varchar(50) DEFAULT NULL,
  `lmnl9` varchar(50) DEFAULT NULL,
  `umnr10` varchar(50) DEFAULT NULL,
  `umnl10` varchar(50) DEFAULT NULL,
  `lmnr10` varchar(50) DEFAULT NULL,
  `lmnl10` varchar(50) DEFAULT NULL,
  `umnr11` varchar(50) DEFAULT NULL,
  `umnl11` varchar(50) DEFAULT NULL,
  `lmnr11` varchar(50) DEFAULT NULL,
  `lmnl11` varchar(50) DEFAULT NULL,
  `umnr12` varchar(50) DEFAULT NULL,
  `umnl12` varchar(50) DEFAULT NULL,
  `lmnr12` varchar(50) DEFAULT NULL,
  `lmnl12` varchar(50) DEFAULT NULL,
  `rigidity` varchar(50) DEFAULT NULL,
  `kernig` varchar(50) DEFAULT NULL,
  `raising` varchar(50) DEFAULT NULL,
  `abdominalr` varchar(50) DEFAULT NULL,
  `abdominall` varchar(50) DEFAULT NULL,
  `cremastiricr` varchar(50) DEFAULT NULL,
  `cremastiricrl` varchar(50) DEFAULT NULL,
  `plantarr` varchar(50) DEFAULT NULL,
  `plantarl` varchar(50) DEFAULT NULL,
  `raother` varchar(50) DEFAULT NULL,
  `rbiceps` varchar(50) DEFAULT NULL,
  `lbiceps` varchar(50) DEFAULT NULL,
  `rtriceps` varchar(50) DEFAULT NULL,
  `ltriceps` varchar(50) DEFAULT NULL,
  `rsupinator` varchar(50) DEFAULT NULL,
  `lsupinator` varchar(50) DEFAULT NULL,
  `rknee` varchar(50) DEFAULT NULL,
  `lknee` varchar(50) DEFAULT NULL,
  `rankle` varchar(50) DEFAULT NULL,
  `lankle` varchar(50) DEFAULT NULL,
  `drother` varchar(50) DEFAULT NULL,
  `micturition` varchar(50) DEFAULT NULL,
  `defecation` varchar(50) DEFAULT NULL,
  `lotherd` varchar(50) DEFAULT NULL,
  `sig` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p27`
--

DROP TABLE IF EXISTS `p27`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p27` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `muscle` varchar(50) DEFAULT NULL,
  `muscleb` varchar(50) DEFAULT NULL,
  `tone` varchar(50) DEFAULT NULL,
  `strength` varchar(50) DEFAULT NULL,
  `coordination` varchar(50) DEFAULT NULL,
  `gait` varchar(50) DEFAULT NULL,
  `involuntary` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p28`
--

DROP TABLE IF EXISTS `p28`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p28` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `r_egion` varchar(50) DEFAULT NULL,
  `touch` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `shape` varchar(50) DEFAULT NULL,
  `vibration` varchar(50) DEFAULT NULL,
  `pain` varchar(50) DEFAULT NULL,
  `temperature` varchar(50) DEFAULT NULL,
  `others1` varchar(50) DEFAULT NULL,
  `tbxgeneralimp1` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p29`
--

DROP TABLE IF EXISTS `p29`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p29` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `appearance` varchar(50) DEFAULT NULL,
  `emotional` varchar(50) DEFAULT NULL,
  `delusions` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `spac` varchar(50) DEFAULT NULL,
  `person` varchar(50) DEFAULT NULL,
  `clouding` varchar(50) DEFAULT NULL,
  `recent` varchar(50) DEFAULT NULL,
  `short` varchar(50) DEFAULT NULL,
  `longs` varchar(50) DEFAULT NULL,
  `general` varchar(50) DEFAULT NULL,
  `released` varchar(50) DEFAULT NULL,
  `cooperation` varchar(50) DEFAULT NULL,
  `thought` varchar(50) DEFAULT NULL,
  `ocp` varchar(50) DEFAULT NULL,
  `suicide` varchar(50) DEFAULT NULL,
  `psychometric` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p30`
--

DROP TABLE IF EXISTS `p30`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p30` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxskull` longtext,
  `tbxbones` longtext,
  `tbxepidural` longtext,
  `tbxsubdural` longtext,
  `tbxventricles` longtext,
  `tbxgray` longtext,
  `tbxwhite` longtext,
  `tbxicsol` longtext,
  `tbxhemorrhage` longtext,
  `tbxinfarction` longtext,
  `tbxthrombosis` longtext,
  `tbxedema` longtext,
  `tbxother` longtext,
  `tbxgeneralimp1` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p31`
--

DROP TABLE IF EXISTS `p31`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p31` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxsku_ll` longtext,
  `tbxbon_es` longtext,
  `tbxepidu_ral` longtext CHARACTER SET big5 COLLATE big5_chinese_ci,
  `tbxsubdu_ral` longtext,
  `tbxventr_icles` longtext,
  `tbxgra_y` longtext,
  `tbxwhi_te` longtext,
  `tbxics_ol` longtext,
  `tbxhemor_rhage` longtext,
  `tbxinfar_ction` longtext,
  `tbxthrombo_sis` longtext,
  `tbxede_ma` longtext,
  `tbxothers` longtext,
  `tbxgeneralimp2` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p32`
--

DROP TABLE IF EXISTS `p32`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p32` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `pulse` varchar(50) DEFAULT NULL,
  `anaemia` varchar(50) DEFAULT NULL,
  `cyanosis` varchar(50) DEFAULT NULL,
  `jaundice` varchar(50) DEFAULT NULL,
  `oedema` varchar(50) DEFAULT NULL,
  `bp_syo` varchar(50) DEFAULT NULL,
  `bp_dia` varchar(50) DEFAULT NULL,
  `height` varchar(50) DEFAULT NULL,
  `weight` varchar(50) DEFAULT NULL,
  `height_uterus` varchar(50) DEFAULT NULL,
  `fhs` varchar(50) DEFAULT NULL,
  `presentation_ob` varchar(50) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL,
  `cx` varchar(50) DEFAULT NULL,
  `presentation_pv` varchar(50) DEFAULT NULL,
  `station` varchar(50) DEFAULT NULL,
  `membrane` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `fornices` varchar(50) DEFAULT NULL,
  `pod` varchar(50) DEFAULT NULL,
  `cervix` varchar(50) DEFAULT NULL,
  `vulva` varchar(50) DEFAULT NULL,
  `discharge` varchar(50) DEFAULT NULL,
  `tbxanyother` longtext,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p33`
--

DROP TABLE IF EXISTS `p33`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p33` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `weight` varchar(50) DEFAULT NULL,
  `length_height` varchar(50) DEFAULT NULL,
  `head_circumference` varchar(50) DEFAULT NULL,
  `reflexes` varchar(50) DEFAULT NULL,
  `pulse_rate` varchar(50) DEFAULT NULL,
  `resp_rate` varchar(50) DEFAULT NULL,
  `blood_pressure` varchar(50) DEFAULT NULL,
  `state_development` varchar(50) DEFAULT NULL,
  `shape_head` varchar(50) DEFAULT NULL,
  `anterior_frontanella` varchar(50) DEFAULT NULL,
  `posterior_frontanella` varchar(50) DEFAULT NULL,
  `facies` varchar(50) DEFAULT NULL,
  `deformity` varchar(50) DEFAULT NULL,
  `indrawing` varchar(50) DEFAULT NULL,
  `vocal_fremitus` varchar(50) DEFAULT NULL,
  `percussion` varchar(50) DEFAULT NULL,
  `breath_sounds` varchar(50) DEFAULT NULL,
  `crepititions` varchar(50) DEFAULT NULL,
  `rhonchi` varchar(50) DEFAULT NULL,
  `heart_sounds_s1` varchar(50) DEFAULT NULL,
  `heart_sounds_s2` varchar(50) DEFAULT NULL,
  `heart_sounds_s3` varchar(50) DEFAULT NULL,
  `heart_sounds_s4` varchar(50) DEFAULT NULL,
  `murmurs` varchar(50) DEFAULT NULL,
  `male` varchar(50) DEFAULT NULL,
  `female` varchar(50) DEFAULT NULL,
  `delayed_milestones` varchar(50) DEFAULT NULL,
  `teeth` varchar(50) DEFAULT NULL,
  `tongue` varchar(50) DEFAULT NULL,
  `mucous_membrane` varchar(50) DEFAULT NULL,
  `koplik_spot` varchar(50) DEFAULT NULL,
  `tonsils` varchar(50) DEFAULT NULL,
  `pharynx` varchar(50) DEFAULT NULL,
  `hearing` varchar(50) DEFAULT NULL,
  `nose` varchar(50) DEFAULT NULL,
  `level_consciousness` varchar(50) DEFAULT NULL,
  `muscle_power` varchar(50) DEFAULT NULL,
  `sensary_function` varchar(50) DEFAULT NULL,
  `jerks` varchar(50) DEFAULT NULL,
  `abnormal_movements` varchar(50) DEFAULT NULL,
  `in_coordination` varchar(50) DEFAULT NULL,
  `planter_signs` varchar(50) DEFAULT NULL,
  `kernigs_sign` varchar(50) DEFAULT NULL,
  `neck_rigidity` varchar(50) DEFAULT NULL,
  `other_reflexes` varchar(50) DEFAULT NULL,
  `fundal_examination` varchar(50) DEFAULT NULL,
  `tbxanyother` longtext,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p34`
--

DROP TABLE IF EXISTS `p34`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p34` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `respiratory_rate` varchar(50) DEFAULT NULL,
  `grunting` varchar(50) DEFAULT NULL,
  `intercostal` varchar(50) DEFAULT NULL,
  `subcostal` varchar(50) DEFAULT NULL,
  `others_chest` varchar(50) DEFAULT NULL,
  `shape` varchar(50) DEFAULT NULL,
  `meconium_passed` varchar(50) DEFAULT NULL,
  `urine_passed` varchar(50) DEFAULT NULL,
  `external_genitalia` varchar(50) DEFAULT NULL,
  `anus` varchar(50) DEFAULT NULL,
  `others_abdomen` varchar(50) DEFAULT NULL,
  `skeletal_system` varchar(50) DEFAULT NULL,
  `pulse` varchar(50) DEFAULT NULL,
  `cyanosis` varchar(50) DEFAULT NULL,
  `others_heart` varchar(50) DEFAULT NULL,
  `ant_fontanelle` varchar(50) DEFAULT NULL,
  `tone` varchar(50) DEFAULT NULL,
  `posture` varchar(50) DEFAULT NULL,
  `facial_nerve_palsy` varchar(50) DEFAULT NULL,
  `brachial_palsy` varchar(50) DEFAULT NULL,
  `grasp_reflex` varchar(50) DEFAULT NULL,
  `moros_reflex` varchar(50) DEFAULT NULL,
  `other_reflexes` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p35`
--

DROP TABLE IF EXISTS `p35`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p35` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `appearance` varchar(50) DEFAULT NULL,
  `cry` varchar(50) DEFAULT NULL,
  `reflex` varchar(50) DEFAULT NULL,
  `posture` varchar(50) DEFAULT NULL,
  `intercostal` varchar(50) DEFAULT NULL,
  `temperature` varchar(50) DEFAULT NULL,
  `pulse` varchar(50) DEFAULT NULL,
  `respiratory_rate` varchar(50) DEFAULT NULL,
  `crt` varchar(50) DEFAULT NULL,
  `fontanellae_sutures` varchar(50) DEFAULT NULL,
  `skull` varchar(50) DEFAULT NULL,
  `spine` varchar(50) DEFAULT NULL,
  `congenital_malformations` varchar(50) DEFAULT NULL,
  `weight_birth` varchar(50) DEFAULT NULL,
  `weight_admission` varchar(50) DEFAULT NULL,
  `head_circumference` varchar(50) DEFAULT NULL,
  `gestational_age` varchar(50) DEFAULT NULL,
  `position_on_iug_chart` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p40`
--

DROP TABLE IF EXISTS `p40`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p40` (
  `pat_id` char(18) NOT NULL,
  `tbxcomplaint` longtext,
  `tbxfindings` longtext,
  `tbxinvest` longtext,
  `tbxother_x` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p42`
--

DROP TABLE IF EXISTS `p42`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p42` (
  `pat_id` char(18) NOT NULL,
  `tbxlocalexam` longtext,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p43`
--

DROP TABLE IF EXISTS `p43`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p43` (
  `pat_id` char(18) NOT NULL,
  `tbxgnlcondition` longtext,
  `pallor` varchar(50) DEFAULT NULL,
  `Jaundice` varchar(50) DEFAULT NULL,
  `Cyanosis` varchar(50) DEFAULT NULL,
  `height` varchar(50) DEFAULT NULL,
  `weight` varchar(50) DEFAULT NULL,
  `pulse` varchar(50) DEFAULT NULL,
  `Edima` varchar(50) DEFAULT NULL,
  `Clubbing` varchar(50) DEFAULT NULL,
  `Obesity` varchar(50) DEFAULT NULL,
  `surfacearea` varchar(50) DEFAULT NULL,
  `bp` varchar(50) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p44`
--

DROP TABLE IF EXISTS `p44`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p44` (
  `pat_id` char(18) NOT NULL,
  `resprate` varchar(250) DEFAULT NULL,
  `pulseox` varchar(250) DEFAULT NULL,
  `nasal` varchar(250) DEFAULT NULL,
  `intercostal` varchar(250) DEFAULT NULL,
  `air` varchar(250) DEFAULT NULL,
  `resptxt` text,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p45`
--

DROP TABLE IF EXISTS `p45`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p45` (
  `pat_id` char(18) NOT NULL,
  `heartrate` varchar(50) DEFAULT NULL,
  `bldprs` varchar(50) DEFAULT NULL,
  `jvp` varchar(50) DEFAULT NULL,
  `apical` varchar(50) DEFAULT NULL,
  `hrtsnd_s1` varchar(50) DEFAULT NULL,
  `hrtsnd_s2` varchar(50) DEFAULT NULL,
  `rhythm` varchar(50) DEFAULT NULL,
  `peri_pul` varchar(50) DEFAULT NULL,
  `textarea1` varchar(400) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p46`
--

DROP TABLE IF EXISTS `p46`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p46` (
  `pat_id` char(18) NOT NULL,
  `systolic1` varchar(50) DEFAULT NULL,
  `diastolic_11` varchar(50) DEFAULT NULL,
  `diastolic_12` varchar(50) DEFAULT NULL,
  `diastolic_13` varchar(50) DEFAULT NULL,
  `textarea2` varchar(400) DEFAULT NULL,
  `midsystolic1` varchar(50) DEFAULT NULL,
  `midsystolic2` varchar(50) DEFAULT NULL,
  `midsystolic3` varchar(50) DEFAULT NULL,
  `midsystolic4` varchar(50) DEFAULT NULL,
  `midsystolic5` varchar(50) DEFAULT NULL,
  `pansystolic1` varchar(50) DEFAULT NULL,
  `pansystolic2` varchar(50) DEFAULT NULL,
  `pansystolic3` varchar(50) DEFAULT NULL,
  `pansystolic4` varchar(50) DEFAULT NULL,
  `diastolic_21` varchar(50) DEFAULT NULL,
  `diastolic_22` varchar(50) DEFAULT NULL,
  `diastolic_23` varchar(50) DEFAULT NULL,
  `textarea3` varchar(400) DEFAULT NULL,
  `sysdia1` varchar(50) DEFAULT NULL,
  `sysdia2` varchar(50) DEFAULT NULL,
  `sysdia3` varchar(50) DEFAULT NULL,
  `textarea4` varchar(400) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p47`
--

DROP TABLE IF EXISTS `p47`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p47` (
  `pat_id` char(18) NOT NULL,
  `temperature` varchar(50) DEFAULT NULL,
  `resprate` varchar(50) DEFAULT NULL,
  `pulse` varchar(50) DEFAULT NULL,
  `bldpres` varchar(50) DEFAULT NULL,
  `pulox` varchar(50) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p48`
--

DROP TABLE IF EXISTS `p48`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p48` (
  `pat_id` char(18) NOT NULL,
  `soft` varchar(50) DEFAULT NULL,
  `nonten` varchar(50) DEFAULT NULL,
  `bowel` varchar(50) DEFAULT NULL,
  `megaly` varchar(50) DEFAULT NULL,
  `resptxt` varchar(250) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p49`
--

DROP TABLE IF EXISTS `p49`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p49` (
  `pat_id` char(18) NOT NULL,
  `circum` varchar(50) DEFAULT NULL,
  `head_other` varchar(6) DEFAULT NULL,
  `tbxhead_dtls` varchar(150) DEFAULT NULL,
  `membrane` varchar(150) DEFAULT NULL,
  `ears_other` varchar(6) DEFAULT NULL,
  `tbxears_dtls` varchar(150) DEFAULT NULL,
  `acuity` varchar(50) DEFAULT NULL,
  `eyes_other` varchar(6) DEFAULT NULL,
  `tbxeyes_dtls` varchar(150) DEFAULT NULL,
  `nose_throat` varchar(150) DEFAULT NULL,
  `nose_other` varchar(6) DEFAULT NULL,
  `tbxnose_dtls` varchar(150) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `p50`
--

DROP TABLE IF EXISTS `p50`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p50` (
  `pat_id` char(18) NOT NULL,
  `cervical` varchar(20) DEFAULT NULL,
  `tbxcervical` varchar(150) DEFAULT NULL,
  `axillary` varchar(20) DEFAULT NULL,
  `tbxaxillary` varchar(150) DEFAULT NULL,
  `inguinal` varchar(20) DEFAULT NULL,
  `tbxinguinal` varchar(150) DEFAULT NULL,
  `epitro` varchar(20) DEFAULT NULL,
  `tbxepitro` varchar(150) DEFAULT NULL,
  `other` varchar(20) DEFAULT NULL,
  `tbxother` varchar(150) DEFAULT NULL,
  `testdate` datetime NOT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `param_drug`
--

DROP TABLE IF EXISTS `param_drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `param_drug` (
  `range_id` double DEFAULT NULL,
  `drug_id` double DEFAULT NULL,
  `initial_period` tinytext,
  `list_id` double DEFAULT NULL,
  `hasvalue` char(1) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=359 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `param_range`
--

DROP TABLE IF EXISTS `param_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `param_range` (
  `range_id` smallint NOT NULL,
  `param_start` double DEFAULT NULL,
  `param_end` double DEFAULT NULL,
  `param_type` char(1) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parchl`
--

DROP TABLE IF EXISTS `parchl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parchl` (
  `parent` char(3) NOT NULL DEFAULT '',
  `child` char(50) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patdoc`
--

DROP TABLE IF EXISTS `patdoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patdoc` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `ext` varchar(10) DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT '',
  `docdesc` varchar(255) DEFAULT NULL,
  `lab_name` varchar(70) DEFAULT NULL,
  `doc_name` varchar(70) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  `size` decimal(18,0) DEFAULT NULL,
  `patdoc` longblob,
  `con_type` varchar(50) DEFAULT NULL,
  `sent` char(1) DEFAULT NULL,
  `sent_to` varchar(50) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patdoclog`
--

DROP TABLE IF EXISTS `patdoclog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patdoclog` (
  `pat_id` char(18) NOT NULL DEFAULT '',
  `docid` char(20) DEFAULT NULL,
  `lastdatevisit` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `path`
--

DROP TABLE IF EXISTS `path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `path` (
  `program` varchar(50) NOT NULL DEFAULT '',
  `path` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(100) DEFAULT NULL,
  `ipaddr` varchar(15) NOT NULL DEFAULT '',
  `servertype` varchar(20) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pathoData`
--

DROP TABLE IF EXISTS `pathoData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pathoData` (
  `pat_id` varchar(18) NOT NULL,
  `test_id` varchar(30) NOT NULL,
  `fileId` varchar(20) NOT NULL,
  `rawData` longblob,
  `ext` varchar(6) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `size` decimal(18,0) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `entrydate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int DEFAULT NULL,
  PRIMARY KEY (`fileId`,`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patientvisit`
--

DROP TABLE IF EXISTS `patientvisit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patientvisit` (
  `pat_id` varchar(18) NOT NULL,
  `visitdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `attending_person` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`pat_id`,`visitdate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patimages`
--

DROP TABLE IF EXISTS `patimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patimages` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `ext` varchar(10) DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT '',
  `imgdesc` varchar(255) DEFAULT NULL,
  `lab_name` varchar(70) DEFAULT NULL,
  `doc_name` varchar(70) DEFAULT NULL,
  `formkey` int DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  `size` decimal(18,0) DEFAULT NULL,
  `patpic` longblob,
  `con_type` varchar(50) DEFAULT NULL,
  `sent` char(1) DEFAULT NULL,
  `sent_to` varchar(50) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patimages_bak`
--

DROP TABLE IF EXISTS `patimages_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patimages_bak` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `ext` varchar(10) DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT '',
  `imgdesc` varchar(255) DEFAULT NULL,
  `lab_name` varchar(70) DEFAULT NULL,
  `doc_name` varchar(70) DEFAULT NULL,
  `formkey` int DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  `size` decimal(18,0) DEFAULT NULL,
  `patpic` longblob,
  `con_type` varchar(50) DEFAULT NULL,
  `sent` char(1) DEFAULT NULL,
  `sent_to` varchar(50) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  PRIMARY KEY (`pat_id`,`type`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patmovies`
--

DROP TABLE IF EXISTS `patmovies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patmovies` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `ext` varchar(10) DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT '',
  `movdesc` varchar(255) DEFAULT NULL,
  `lab_name` varchar(70) DEFAULT NULL,
  `doc_name` varchar(70) DEFAULT NULL,
  `formkey` char(2) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  `size` decimal(18,0) DEFAULT NULL,
  `patmov` longblob,
  `con_type` varchar(50) DEFAULT NULL,
  `sent` char(1) DEFAULT NULL,
  `sent_to` varchar(50) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  PRIMARY KEY (`pat_id`,`type`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pre`
--

DROP TABLE IF EXISTS `pre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pre` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `diagnosis` longtext,
  `diet` longtext,
  `activity` varchar(50) DEFAULT NULL,
  `drugs` longtext,
  `quantity` longtext,
  `dose` longtext,
  `duration` longtext,
  `advice` longtext,
  `comments` longtext,
  `name_hos` varchar(50) DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `apptdate` datetime DEFAULT NULL,
  `docrg_no` varchar(50) DEFAULT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prs`
--

DROP TABLE IF EXISTS `prs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prs` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `diagnosis` longtext,
  `diet` longtext,
  `activity` varchar(50) DEFAULT NULL,
  `drugs` longtext,
  `quantity` longtext,
  `dose` longtext,
  `duration` longtext,
  `advice` longtext,
  `comments` longtext,
  `name_hos` varchar(50) DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `apptdate` datetime DEFAULT NULL,
  `docrg_no` varchar(50) DEFAULT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quantitative_field`
--

DROP TABLE IF EXISTS `quantitative_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quantitative_field` (
  `field_id` int NOT NULL,
  `form_id` char(3) NOT NULL,
  `field_name` varchar(50) NOT NULL,
  `field_caption` varchar(50) DEFAULT NULL,
  `field_unit` varchar(50) DEFAULT NULL,
  `field_group` varchar(50) DEFAULT NULL,
  `tab_name` varchar(30) DEFAULT NULL,
  `tab_field` varchar(50) DEFAULT NULL,
  `default_value` longtext,
  `is_required` char(1) DEFAULT NULL,
  `input_type` varchar(50) DEFAULT NULL,
  `max_length` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recdose`
--

DROP TABLE IF EXISTS `recdose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recdose` (
  `id_recdose` tinyint unsigned DEFAULT NULL,
  `comment` varchar(45) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receivelog`
--

DROP TABLE IF EXISTS `receivelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receivelog` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `received_from` varchar(20) NOT NULL DEFAULT '',
  `received_center` varchar(8) NOT NULL DEFAULT '',
  `received_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `received_records` longtext NOT NULL,
  `status` varchar(8) NOT NULL DEFAULT '',
  `received_doc` varchar(20) NOT NULL DEFAULT '',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `refered_to`
--

DROP TABLE IF EXISTS `refered_to`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refered_to` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `editing_doctor` varchar(50) NOT NULL DEFAULT '',
  `previous_discategory` varchar(50) DEFAULT NULL,
  `assigned_doctor` varchar(50) DEFAULT NULL,
  `present_discategory` varchar(50) DEFAULT NULL,
  `comments` longtext,
  `dateofreference` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference`
--

DROP TABLE IF EXISTS `reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reference` (
  `age` decimal(5,0) NOT NULL,
  `test` varchar(45) NOT NULL,
  `lownormal` float NOT NULL,
  `highnormal` float NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referhospitals`
--

DROP TABLE IF EXISTS `referhospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referhospitals` (
  `code` varchar(8) NOT NULL,
  `referred` tinytext,
  `referring` tinytext,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `refimages`
--

DROP TABLE IF EXISTS `refimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refimages` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `ext` varchar(10) DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT '',
  `imgdesc` varchar(255) DEFAULT NULL,
  `ref_code` varchar(8) NOT NULL DEFAULT '',
  `lab_name` varchar(70) DEFAULT NULL,
  `doc_name` varchar(70) DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `testdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  `img_serno` int NOT NULL DEFAULT '0',
  `size` decimal(18,0) DEFAULT NULL,
  `con_type` varchar(50) DEFAULT NULL,
  `sent` char(1) DEFAULT NULL,
  `sent_to` varchar(50) DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  `patpic` longblob,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`,`img_serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regusers`
--

DROP TABLE IF EXISTS `regusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regusers` (
  `uid` varchar(18) NOT NULL DEFAULT '',
  `pwd` varchar(25) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `type` char(3) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `emailid` varchar(50) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `dis` varchar(50) DEFAULT NULL,
  `rg_no` varchar(20) NOT NULL DEFAULT '',
  `qualification` varchar(50) DEFAULT NULL,
  `center` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `removedpat`
--

DROP TABLE IF EXISTS `removedpat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `removedpat` (
  `patid` char(18) NOT NULL DEFAULT '',
  `entrydate` datetime DEFAULT NULL,
  `pat_name` char(50) DEFAULT NULL,
  `class` char(50) DEFAULT NULL,
  `age` char(10) DEFAULT NULL,
  `sex` char(8) DEFAULT NULL,
  `backupdir` char(17) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s01`
--

DROP TABLE IF EXISTS `s01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s01` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `organism` varchar(50) DEFAULT NULL,
  `f_colony` double DEFAULT NULL,
  `f_ampicillin` double DEFAULT NULL,
  `sens_ampi` varchar(50) DEFAULT NULL,
  `f_amoxycillin` double DEFAULT NULL,
  `sens_amoxy` varchar(50) DEFAULT NULL,
  `f_cotrimoxazole` double DEFAULT NULL,
  `sens_cotrim` varchar(50) DEFAULT NULL,
  `f_ciprofloxacin` double DEFAULT NULL,
  `sens_cipro` varchar(50) DEFAULT NULL,
  `f_norfloxacin` double DEFAULT NULL,
  `sens_norf` varchar(50) DEFAULT NULL,
  `f_cephalosporin` double DEFAULT NULL,
  `sens_ceph` varchar(50) DEFAULT NULL,
  `f_cefaloridine` double DEFAULT NULL,
  `sens_cefa` varchar(50) DEFAULT NULL,
  `f_cefuroxime` double DEFAULT NULL,
  `sens_cefu` varchar(50) DEFAULT NULL,
  `f_cefadroxyl` double DEFAULT NULL,
  `sens_cefad` varchar(50) DEFAULT NULL,
  `f_cefixime` double DEFAULT NULL,
  `sens_cefi` varchar(50) DEFAULT NULL,
  `f_ceftriaxone` double DEFAULT NULL,
  `sens_ceft` varchar(50) DEFAULT NULL,
  `f_cefazoline` double DEFAULT NULL,
  `sens_cefaz` varchar(50) DEFAULT NULL,
  `f_clarithromycin` double DEFAULT NULL,
  `sens_clari` varchar(50) DEFAULT NULL,
  `f_gentamicin` double DEFAULT NULL,
  `sens_gent` varchar(50) DEFAULT NULL,
  `f_sparfloxacin` double DEFAULT NULL,
  `sens_sparf` varchar(50) DEFAULT NULL,
  `f_ofloxacin` double DEFAULT NULL,
  `sens_oflo` varchar(50) DEFAULT NULL,
  `f_furadantin` double DEFAULT NULL,
  `sens_fura` varchar(50) DEFAULT NULL,
  `f_chloramphenicol` double DEFAULT NULL,
  `sens_chlo` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s03`
--

DROP TABLE IF EXISTS `s03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s03` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_quantity` double DEFAULT NULL,
  `hours` varchar(50) DEFAULT NULL,
  `colour` varchar(50) DEFAULT NULL,
  `transparency` varchar(50) DEFAULT NULL,
  `sp_gravity` varchar(50) DEFAULT NULL,
  `sediment` varchar(50) DEFAULT NULL,
  `reaction` varchar(50) DEFAULT NULL,
  `albumin` varchar(50) DEFAULT NULL,
  `phosphates` varchar(50) DEFAULT NULL,
  `sugar` varchar(50) DEFAULT NULL,
  `bile_pigments` varchar(50) DEFAULT NULL,
  `bile_salts` varchar(50) DEFAULT NULL,
  `ketone_bodies` varchar(50) DEFAULT NULL,
  `creatinine` varchar(50) DEFAULT NULL,
  `epithelial` varchar(50) DEFAULT NULL,
  `leucocytes` varchar(50) DEFAULT NULL,
  `rbc` varchar(50) DEFAULT NULL,
  `crystals` varchar(50) DEFAULT NULL,
  `casts` varchar(50) DEFAULT NULL,
  `micro_organ` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s04`
--

DROP TABLE IF EXISTS `s04`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s04` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `organism` varchar(50) DEFAULT NULL,
  `f_colony` double DEFAULT NULL,
  `f_ampicillin` double DEFAULT NULL,
  `sens_ampi` varchar(50) DEFAULT NULL,
  `f_amoxycillin` double DEFAULT NULL,
  `sens_amoxy` varchar(50) DEFAULT NULL,
  `f_cotrimoxazole` double DEFAULT NULL,
  `sens_cotrim` varchar(50) DEFAULT NULL,
  `f_ciprofloxacin` double DEFAULT NULL,
  `sens_cipro` varchar(50) DEFAULT NULL,
  `f_norfloxacin` double DEFAULT NULL,
  `sens_norf` varchar(50) DEFAULT NULL,
  `f_cephalosporin` double DEFAULT NULL,
  `sens_ceph` varchar(50) DEFAULT NULL,
  `f_cefaloridine` double DEFAULT NULL,
  `sens_cefa` varchar(50) DEFAULT NULL,
  `f_cefuroxime` double DEFAULT NULL,
  `sens_cefu` varchar(50) DEFAULT NULL,
  `f_cefadroxyl` double DEFAULT NULL,
  `sens_cefad` varchar(50) DEFAULT NULL,
  `f_cefixime` double DEFAULT NULL,
  `sens_cefi` varchar(50) DEFAULT NULL,
  `f_ceftriaxone` double DEFAULT NULL,
  `sens_ceft` varchar(50) DEFAULT NULL,
  `f_cefazoline` double DEFAULT NULL,
  `sens_cefaz` varchar(50) DEFAULT NULL,
  `f_clarithromycin` double DEFAULT NULL,
  `sens_clari` varchar(50) DEFAULT NULL,
  `f_gentamicin` double DEFAULT NULL,
  `sens_gent` varchar(50) DEFAULT NULL,
  `f_sparfloxacin` double DEFAULT NULL,
  `sens_sparf` varchar(50) DEFAULT NULL,
  `f_ofloxacin` double DEFAULT NULL,
  `sens_oflo` varchar(50) DEFAULT NULL,
  `f_furadantin` double DEFAULT NULL,
  `sens_fura` varchar(50) DEFAULT NULL,
  `f_chloramphenicol` double DEFAULT NULL,
  `sens_chlo` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s05`
--

DROP TABLE IF EXISTS `s05`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s05` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `specimen` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `consistency` varchar(50) DEFAULT NULL,
  `mucus` varchar(50) DEFAULT NULL,
  `blood` varchar(50) DEFAULT NULL,
  `helminthis` varchar(50) DEFAULT NULL,
  `reaction` varchar(50) DEFAULT NULL,
  `occult_blood` varchar(50) DEFAULT NULL,
  `puscells` varchar(50) DEFAULT NULL,
  `rbc` varchar(50) DEFAULT NULL,
  `epithelial` varchar(50) DEFAULT NULL,
  `crystals` varchar(50) DEFAULT NULL,
  `bacteria` varchar(50) DEFAULT NULL,
  `remnants` varchar(50) DEFAULT NULL,
  `ohelminthis` varchar(50) DEFAULT NULL,
  `protozoa` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s06`
--

DROP TABLE IF EXISTS `s06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s06` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `organism` varchar(50) DEFAULT NULL,
  `f_colony` double DEFAULT NULL,
  `f_ampicillin` double DEFAULT NULL,
  `sens_ampi` varchar(50) DEFAULT NULL,
  `f_amoxycillin` double DEFAULT NULL,
  `sens_amoxy` varchar(50) DEFAULT NULL,
  `f_cotrimoxazole` double DEFAULT NULL,
  `sens_cotrim` varchar(50) DEFAULT NULL,
  `f_ciprofloxacin` double DEFAULT NULL,
  `sens_cipro` varchar(50) DEFAULT NULL,
  `f_norfloxacin` double DEFAULT NULL,
  `sens_norf` varchar(50) DEFAULT NULL,
  `f_cephalosporin` double DEFAULT NULL,
  `sens_ceph` varchar(50) DEFAULT NULL,
  `f_cefaloridine` double DEFAULT NULL,
  `sens_cefa` varchar(50) DEFAULT NULL,
  `f_cefuroxime` double DEFAULT NULL,
  `sens_cefu` varchar(50) DEFAULT NULL,
  `f_cefadroxyl` double DEFAULT NULL,
  `sens_cefad` varchar(50) DEFAULT NULL,
  `f_cefixime` double DEFAULT NULL,
  `sens_cefi` varchar(50) DEFAULT NULL,
  `f_ceftriaxone` double DEFAULT NULL,
  `sens_ceft` varchar(50) DEFAULT NULL,
  `f_cefazoline` double DEFAULT NULL,
  `sens_cefaz` varchar(50) DEFAULT NULL,
  `f_clarithromycin` double DEFAULT NULL,
  `sens_clari` varchar(50) DEFAULT NULL,
  `f_gentamicin` double DEFAULT NULL,
  `sens_gent` varchar(50) DEFAULT NULL,
  `f_sparfloxacin` double DEFAULT NULL,
  `sens_sparf` varchar(50) DEFAULT NULL,
  `f_ofloxacin` double DEFAULT NULL,
  `sens_oflo` varchar(50) DEFAULT NULL,
  `f_furadantin` double DEFAULT NULL,
  `sens_fura` varchar(50) DEFAULT NULL,
  `f_chloramphenicol` double DEFAULT NULL,
  `sens_chlo` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s08`
--

DROP TABLE IF EXISTS `s08`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s08` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_bs_fasting` double DEFAULT NULL,
  `f_bs_pp` double DEFAULT NULL,
  `f_bs_random` double DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s09`
--

DROP TABLE IF EXISTS `s09`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s09` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_urea` double DEFAULT NULL,
  `f_nitrogen` double DEFAULT NULL,
  `f_creatinine` double DEFAULT NULL,
  `f_uricacid` double DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s10`
--

DROP TABLE IF EXISTS `s10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s10` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_cholesterol` double DEFAULT NULL,
  `f_hdl_choles` double DEFAULT NULL,
  `f_ldl_choles` double DEFAULT NULL,
  `f_vldl_choles` double DEFAULT NULL,
  `f_triglycerides` double DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s11`
--

DROP TABLE IF EXISTS `s11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s11` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_bilirubin` double DEFAULT NULL,
  `f_con_bili` double DEFAULT NULL,
  `f_un_bili` double DEFAULT NULL,
  `f_sgpt` double DEFAULT NULL,
  `f_sgot` double DEFAULT NULL,
  `f_alk_phos` double DEFAULT NULL,
  `f_acid_phos` double DEFAULT NULL,
  `f_acid_pros` double DEFAULT NULL,
  `f_protein` double DEFAULT NULL,
  `f_albumin` double DEFAULT NULL,
  `f_globulin` double DEFAULT NULL,
  `f_ratio` double DEFAULT NULL,
  `f_ggt` double DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s12`
--

DROP TABLE IF EXISTS `s12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s12` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `altsgpt` varchar(50) DEFAULT NULL,
  `ntp` varchar(50) DEFAULT NULL,
  `alp` varchar(50) DEFAULT NULL,
  `ggt` varchar(50) DEFAULT NULL,
  `ckmb` varchar(50) DEFAULT NULL,
  `astsgot` varchar(50) DEFAULT NULL,
  `ldhld` varchar(50) DEFAULT NULL,
  `tncti` varchar(50) DEFAULT NULL,
  `ckmm` varchar(50) DEFAULT NULL,
  `ast` varchar(50) DEFAULT NULL,
  `ald` varchar(50) DEFAULT NULL,
  `balp` varchar(50) DEFAULT NULL,
  `psa` varchar(50) DEFAULT NULL,
  `acp` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s13`
--

DROP TABLE IF EXISTS `s13`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s13` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `f_sodium` double DEFAULT NULL,
  `f_potassium` double DEFAULT NULL,
  `f_calcium` double DEFAULT NULL,
  `f_chloride` double DEFAULT NULL,
  `f_bicarbonate` double DEFAULT NULL,
  `f_phosphorus` double DEFAULT NULL,
  `f_magnesium` double DEFAULT NULL,
  `anyother` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s14`
--

DROP TABLE IF EXISTS `s14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s14` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `volume` varchar(50) DEFAULT NULL,
  `bicarbonate` varchar(50) DEFAULT NULL,
  `amylase` varchar(50) DEFAULT NULL,
  `lipase` varchar(50) DEFAULT NULL,
  `volume_s` varchar(50) DEFAULT NULL,
  `bicarbonate_s` varchar(50) DEFAULT NULL,
  `amylase_s` varchar(50) DEFAULT NULL,
  `lipase_s` varchar(50) DEFAULT NULL,
  `bentiromide` varchar(50) DEFAULT NULL,
  `pancreolauryl` varchar(50) DEFAULT NULL,
  `immunoreactivity` varchar(50) DEFAULT NULL,
  `serum` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s15`
--

DROP TABLE IF EXISTS `s15`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s15` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `rf` varchar(50) DEFAULT NULL,
  `ana` varchar(50) DEFAULT NULL,
  `crp` varchar(50) DEFAULT NULL,
  `hav` varchar(50) DEFAULT NULL,
  `hbv` varchar(50) DEFAULT NULL,
  `hcv` varchar(50) DEFAULT NULL,
  `hdv` varchar(50) DEFAULT NULL,
  `hiv` varchar(50) DEFAULT NULL,
  `pneumococci` varchar(50) DEFAULT NULL,
  `mycoplasma` varchar(50) DEFAULT NULL,
  `chlamydia` varchar(50) DEFAULT NULL,
  `legionella` varchar(50) DEFAULT NULL,
  `anyoth` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s17`
--

DROP TABLE IF EXISTS `s17`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s17` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `bleeding` varchar(50) DEFAULT NULL,
  `clotting` varchar(50) DEFAULT NULL,
  `retraction` varchar(50) DEFAULT NULL,
  `capillary` varchar(50) DEFAULT NULL,
  `prothrombin` varchar(50) DEFAULT NULL,
  `partial` varchar(50) DEFAULT NULL,
  `thromboplastin` varchar(50) DEFAULT NULL,
  `f_coagulation` double DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s19`
--

DROP TABLE IF EXISTS `s19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s19` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `sodium` varchar(50) DEFAULT NULL,
  `potassium` varchar(50) DEFAULT NULL,
  `chloride` varchar(50) DEFAULT NULL,
  `urinary` varchar(50) DEFAULT NULL,
  `creatinine` varchar(50) DEFAULT NULL,
  `calcium` varchar(50) DEFAULT NULL,
  `osmolality` varchar(50) DEFAULT NULL,
  `protein` varchar(50) DEFAULT NULL,
  `aminoacid` varchar(50) DEFAULT NULL,
  `uricacid` varchar(50) DEFAULT NULL,
  `vma` varchar(50) DEFAULT NULL,
  `camp` varchar(50) DEFAULT NULL,
  `cortisone` varchar(50) DEFAULT NULL,
  `norepinephrine` varchar(50) DEFAULT NULL,
  `epinephrine` varchar(50) DEFAULT NULL,
  `ketosteroidoh` varchar(50) DEFAULT NULL,
  `ketosteroid` varchar(50) DEFAULT NULL,
  `hiaa` varchar(50) DEFAULT NULL,
  `metanephrine` varchar(50) DEFAULT NULL,
  `normetanephrine` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s20`
--

DROP TABLE IF EXISTS `s20`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s20` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `sugar` varchar(50) DEFAULT NULL,
  `protein` varchar(50) DEFAULT NULL,
  `urine_m` varchar(50) DEFAULT NULL,
  `est_riol` varchar(50) DEFAULT NULL,
  `creatinine` varchar(50) DEFAULT NULL,
  `prenancy` varchar(50) DEFAULT NULL,
  `anyother` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s28`
--

DROP TABLE IF EXISTS `s28`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s28` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `physical` varchar(50) DEFAULT NULL,
  `f_cytology` double DEFAULT NULL,
  `f_protin` double DEFAULT NULL,
  `f_glucose` double DEFAULT NULL,
  `syphilis` varchar(50) DEFAULT NULL,
  `stained` varchar(50) DEFAULT NULL,
  `culture` varchar(50) DEFAULT NULL,
  `anyother` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s29`
--

DROP TABLE IF EXISTS `s29`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s29` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `site` varchar(50) DEFAULT NULL,
  `stain` varchar(50) DEFAULT NULL,
  `magnification` varchar(50) DEFAULT NULL,
  `others` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s30`
--

DROP TABLE IF EXISTS `s30`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s30` (
  `pat_id` char(18) NOT NULL,
  `diagnosis` varchar(100) DEFAULT NULL,
  `reason_location` longtext,
  `onset` datetime DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `surgery` char(5) DEFAULT NULL,
  `hospitalized` char(5) DEFAULT NULL,
  `tbxothers` varchar(50) DEFAULT NULL,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s31`
--

DROP TABLE IF EXISTS `s31`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s31` (
  `pat_id` char(18) NOT NULL,
  `nrti_thymidine` longtext,
  `nrti_nucleoside` longtext,
  `nnrti` longtext,
  `protease_minor` longtext,
  `protease_major` longtext,
  `fusion` longtext,
  `integrase` longtext,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s32`
--

DROP TABLE IF EXISTS `s32`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s32` (
  `pat_id` char(18) NOT NULL,
  `total_leucocytes` varchar(50) DEFAULT NULL,
  `total_lymphocytes` varchar(50) DEFAULT NULL,
  `cd4_count` varchar(50) DEFAULT NULL,
  `cd4_percent` varchar(50) DEFAULT NULL,
  `cd8_count` varchar(50) DEFAULT NULL,
  `ratio` varchar(50) DEFAULT NULL,
  `viralload` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s34`
--

DROP TABLE IF EXISTS `s34`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s34` (
  `pat_id` char(18) NOT NULL,
  `identify_agent` varchar(50) DEFAULT NULL,
  `specimen` varchar(50) DEFAULT NULL,
  `test_method` varchar(50) DEFAULT NULL,
  `titre` varchar(50) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s35`
--

DROP TABLE IF EXISTS `s35`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s35` (
  `pat_id` char(18) NOT NULL,
  `name_test` varchar(50) DEFAULT NULL,
  `test_specimen` varchar(50) DEFAULT NULL,
  `purpose_study` varchar(50) DEFAULT NULL,
  `report` longtext,
  `prov_diagnosis` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s36`
--

DROP TABLE IF EXISTS `s36`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s36` (
  `pat_id` char(18) NOT NULL,
  `esr` int DEFAULT NULL,
  `haemoglobin` int DEFAULT NULL,
  `rbc` int DEFAULT NULL,
  `hematocrit` int DEFAULT NULL,
  `mcv` int DEFAULT NULL,
  `mchc` int DEFAULT NULL,
  `rdw` int DEFAULT NULL,
  `mch` int DEFAULT NULL,
  `lymphocyte` int DEFAULT NULL,
  `eosinophil` int DEFAULT NULL,
  `basophil` int DEFAULT NULL,
  `leucocute` int DEFAULT NULL,
  `monoocyte` int DEFAULT NULL,
  `platelet` int DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sendinglog`
--

DROP TABLE IF EXISTS `sendinglog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sendinglog` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `attending_doc` varchar(20) NOT NULL DEFAULT '',
  `referred_doc` varchar(20) DEFAULT NULL,
  `referred_hospital` varchar(8) NOT NULL DEFAULT '',
  `send_records` longtext NOT NULL,
  `sent_by` varchar(20) NOT NULL DEFAULT '',
  `sent_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sendq`
--

DROP TABLE IF EXISTS `sendq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sendq` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `attending_doc` varchar(20) NOT NULL DEFAULT '',
  `referred_doc` varchar(20) DEFAULT NULL,
  `referred_hospital` varchar(8) NOT NULL DEFAULT '',
  `send_records` longtext NOT NULL,
  `sent_by` varchar(20) NOT NULL DEFAULT '',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessionlog`
--

DROP TABLE IF EXISTS `sessionlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessionlog` (
  `uid` varchar(20) NOT NULL DEFAULT '',
  `loginat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `logoutat` datetime DEFAULT NULL,
  `center` varchar(10) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smr`
--

DROP TABLE IF EXISTS `smr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `smr` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxcomplaint` longtext,
  `tbxfindings` longtext,
  `tbxinvestigations` longtext,
  `tbxdiagnosis` longtext,
  `tbxtreatment` longtext,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms_logs`
--

DROP TABLE IF EXISTS `sms_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_logs` (
  `slno` int NOT NULL AUTO_INCREMENT,
  `mobileno` varchar(25) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `result` varchar(10) DEFAULT NULL,
  `mdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`slno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms_type`
--

DROP TABLE IF EXISTS `sms_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_type` (
  `msgid` varchar(4) DEFAULT NULL,
  `description` varchar(50) NOT NULL COMMENT 'Assignment/Appointment/...',
  `params` int DEFAULT NULL,
  `body` varchar(500) NOT NULL COMMENT 'body containing dynamic fields',
  PRIMARY KEY (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='describes the types of messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t01`
--

DROP TABLE IF EXISTS `t01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t01` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxchief_complaints` longtext,
  `tbxon_examination` longtext,
  `tbxgeneral_survey` longtext,
  `tbxrespiratory_system` longtext,
  `tbxcardiovascular_system` longtext,
  `tbxdigestive` longtext,
  `tbxnervous_system` longtext,
  `tbxbones_joints` longtext,
  `tbxobstetrical_gynaecological` longtext,
  `tbxdermatological` longtext,
  `tbxent` longtext,
  `tbxeye` longtext,
  `tbxinvestigation` longtext,
  `tbxprovisional` longtext,
  `tbxtreatment_given` longtext,
  `tbxother` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t02`
--

DROP TABLE IF EXISTS `t02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t02` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `time_accident` varchar(50) DEFAULT NULL,
  `type_accident` varchar(50) DEFAULT NULL,
  `pulse` varchar(50) DEFAULT NULL,
  `bp` varchar(50) DEFAULT NULL,
  `pallor` varchar(50) DEFAULT NULL,
  `level_conciousness` varchar(50) DEFAULT NULL,
  `respiration` varchar(50) DEFAULT NULL,
  `pupillary_reflex` varchar(50) DEFAULT NULL,
  `details_accident` varchar(50) DEFAULT NULL,
  `general_exam` varchar(50) DEFAULT NULL,
  `superficial_injury` varchar(50) DEFAULT NULL,
  `muscle_injury` varchar(50) DEFAULT NULL,
  `ligament_injury` varchar(50) DEFAULT NULL,
  `limbs` varchar(50) DEFAULT NULL,
  `ribs` varchar(50) DEFAULT NULL,
  `vertebra` varchar(50) DEFAULT NULL,
  `skull` varchar(50) DEFAULT NULL,
  `joint_injury` varchar(50) DEFAULT NULL,
  `level_of_conciousness` varchar(50) DEFAULT NULL,
  `active_bleeding` varchar(50) DEFAULT NULL,
  `bony_injury` varchar(50) DEFAULT NULL,
  `resp_distress` varchar(50) DEFAULT NULL,
  `chest_pain` varchar(50) DEFAULT NULL,
  `abdominal_pain` varchar(50) DEFAULT NULL,
  `hematuria` varchar(50) DEFAULT NULL,
  `bleeding_pv` varchar(50) DEFAULT NULL,
  `bleeding_p_r` varchar(50) DEFAULT NULL,
  `hematemesis` varchar(50) DEFAULT NULL,
  `urinary_retention` varchar(50) DEFAULT NULL,
  `brain` varchar(50) DEFAULT NULL,
  `spinal_cord` varchar(50) DEFAULT NULL,
  `heart` varchar(50) DEFAULT NULL,
  `lungs` varchar(50) DEFAULT NULL,
  `liver` varchar(50) DEFAULT NULL,
  `spleen` varchar(50) DEFAULT NULL,
  `intestine` varchar(50) DEFAULT NULL,
  `kidneys` varchar(50) DEFAULT NULL,
  `eyes` varchar(50) DEFAULT NULL,
  `ears` varchar(50) DEFAULT NULL,
  `tbxanyother` longtext,
  `tbxgeneralimp` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t03`
--

DROP TABLE IF EXISTS `t03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t03` (
  `pat_id` char(18) NOT NULL,
  `risk_group` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t04`
--

DROP TABLE IF EXISTS `t04`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t04` (
  `pat_id` char(18) NOT NULL,
  `bacilli_sample1` varchar(200) DEFAULT NULL,
  `bacilli_sample2` varchar(200) DEFAULT NULL,
  `bacilli_sample3` varchar(200) DEFAULT NULL,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t05`
--

DROP TABLE IF EXISTS `t05`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t05` (
  `pat_id` char(18) NOT NULL,
  `tbxculture` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t06`
--

DROP TABLE IF EXISTS `t06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t06` (
  `pat_id` char(18) NOT NULL,
  `tbxnucleic` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t07`
--

DROP TABLE IF EXISTS `t07`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t07` (
  `pat_id` char(18) NOT NULL,
  `tbxsusceptibility` longtext,
  `testdate` datetime DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testtable`
--

DROP TABLE IF EXISTS `testtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testtable` (
  `year` decimal(10,0) NOT NULL,
  `what` varchar(45) NOT NULL,
  `low` tinyint unsigned NOT NULL,
  `high` tinyint unsigned NOT NULL,
  `match` varchar(45) DEFAULT NULL,
  `label` varchar(45) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tpatq`
--

DROP TABLE IF EXISTS `tpatq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tpatq` (
  `pat_id` varchar(18) NOT NULL,
  `entrydate` datetime DEFAULT NULL,
  `teleconsultdt` datetime DEFAULT NULL,
  `assigneddoc` varchar(20) NOT NULL DEFAULT '',
  `refer_doc` varchar(20) DEFAULT NULL,
  `refer_center` varchar(8) DEFAULT NULL,
  `discategory` varchar(50) DEFAULT NULL,
  `checked` char(1) DEFAULT NULL,
  `delflag` char(1) DEFAULT NULL,
  `assignedhos` varchar(8) NOT NULL,
  `issent` varchar(1) DEFAULT NULL,
  `lastsenddate` datetime DEFAULT NULL,
  PRIMARY KEY (`pat_id`,`assigneddoc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tpatq_treated`
--

DROP TABLE IF EXISTS `tpatq_treated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tpatq_treated` (
  `pat_id` varchar(18) NOT NULL,
  `entrydate` datetime DEFAULT NULL,
  `teleconsultdt` datetime DEFAULT NULL,
  `assigneddoc` varchar(20) NOT NULL DEFAULT '',
  `refer_doc` varchar(20) DEFAULT NULL,
  `refer_center` varchar(8) DEFAULT NULL,
  `discategory` varchar(50) DEFAULT NULL,
  `checked` char(1) DEFAULT NULL,
  `delflag` char(1) DEFAULT NULL,
  `assignedhos` varchar(8) DEFAULT NULL,
  `issent` varchar(1) DEFAULT NULL,
  `lastsenddate` datetime DEFAULT NULL,
  `data_moved` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`serno`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tpatq_treated11`
--

DROP TABLE IF EXISTS `tpatq_treated11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tpatq_treated11` (
  `pat_id` varchar(18) NOT NULL,
  `entrydate` datetime DEFAULT NULL,
  `teleconsultdt` datetime DEFAULT NULL,
  `assigneddoc` varchar(20) NOT NULL DEFAULT '',
  `refer_doc` varchar(20) DEFAULT NULL,
  `refer_center` varchar(8) DEFAULT NULL,
  `discategory` varchar(50) DEFAULT NULL,
  `checked` char(1) DEFAULT NULL,
  `delflag` char(1) DEFAULT NULL,
  `assignedhos` varchar(8) DEFAULT NULL,
  `issent` varchar(1) DEFAULT NULL,
  `lastsenddate` datetime DEFAULT NULL,
  `data_moved` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pat_id`,`assigneddoc`,`data_moved`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tpatwaitq`
--

DROP TABLE IF EXISTS `tpatwaitq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tpatwaitq` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `entrydate` datetime NOT NULL,
  `attending_doc` varchar(20) NOT NULL DEFAULT '',
  `referred_doc` varchar(20) NOT NULL DEFAULT '',
  `referred_hospital` varchar(8) DEFAULT NULL,
  `local_hospital` varchar(8) DEFAULT NULL,
  `sent_by` varchar(50) DEFAULT NULL,
  `send_records` varchar(10) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `usertype` varchar(50) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `req_id` varchar(200) NOT NULL,
  `delflg` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`pat_id`,`entrydate`,`attending_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tsr`
--

DROP TABLE IF EXISTS `tsr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tsr` (
  `pat_id` varchar(18) NOT NULL DEFAULT '',
  `tbxexam_perform` longtext,
  `tbxreport` longtext,
  `tbxfinding` longtext,
  `tbximpression` longtext,
  `name_hos` varchar(8) NOT NULL DEFAULT '',
  `entrydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`entrydate`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vaccine`
--

DROP TABLE IF EXISTS `vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccine` (
  `vac_code` tinyint unsigned NOT NULL,
  `vac_name` varchar(45) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vaccine_schedule`
--

DROP TABLE IF EXISTS `vaccine_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccine_schedule` (
  `vaccine` tinyint unsigned NOT NULL,
  `ageweek` decimal(5,0) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vidconf_meeting`
--

DROP TABLE IF EXISTS `vidconf_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vidconf_meeting` (
  `idvidconf_meeting` int NOT NULL AUTO_INCREMENT,
  `meeting_id` varchar(45) NOT NULL,
  `start_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `started_by` varchar(100) DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`idvidconf_meeting`,`meeting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vidconf_meeting_users`
--

DROP TABLE IF EXISTS `vidconf_meeting_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vidconf_meeting_users` (
  `idvidconf_meeting_docs` int NOT NULL AUTO_INCREMENT,
  `meeting_id` varchar(45) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `user_added_at` timestamp NULL DEFAULT NULL,
  `creator` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idvidconf_meeting_docs`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vital_checkup`
--

DROP TABLE IF EXISTS `vital_checkup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vital_checkup` (
  `pat_id` char(18) NOT NULL,
  `pulse` int DEFAULT NULL,
  `bp_sys` int DEFAULT NULL,
  `bp_dias` int DEFAULT NULL,
  `temperature` int DEFAULT NULL,
  `resprate` int DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weightband`
--

DROP TABLE IF EXISTS `weightband`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weightband` (
  `weight` tinyint unsigned NOT NULL,
  `id_pack` tinyint unsigned NOT NULL,
  `am` decimal(3,1) NOT NULL,
  `pm` decimal(3,1) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wt_boys`
--

DROP TABLE IF EXISTS `wt_boys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wt_boys` (
  `agemonth` double DEFAULT NULL,
  `L` double DEFAULT NULL,
  `M` double DEFAULT NULL,
  `S` double DEFAULT NULL,
  `P3` double DEFAULT NULL,
  `P5` double DEFAULT NULL,
  `P10` double DEFAULT NULL,
  `P25` double DEFAULT NULL,
  `P50` double DEFAULT NULL,
  `P75` double DEFAULT NULL,
  `P90` double DEFAULT NULL,
  `P95` double DEFAULT NULL,
  `P97` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wt_girls`
--

DROP TABLE IF EXISTS `wt_girls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wt_girls` (
  `agemonth` double DEFAULT NULL,
  `L` double DEFAULT NULL,
  `M` double DEFAULT NULL,
  `S` double DEFAULT NULL,
  `P3` double DEFAULT NULL,
  `P5` double DEFAULT NULL,
  `P10` double DEFAULT NULL,
  `P25` double DEFAULT NULL,
  `P50` double DEFAULT NULL,
  `P75` double DEFAULT NULL,
  `P90` double DEFAULT NULL,
  `P95` double DEFAULT NULL,
  `P97` double DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `z00`
--

DROP TABLE IF EXISTS `z00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `z00` (
  `pat_id` char(18) NOT NULL DEFAULT '',
  `prob_desc` longtext,
  `onset` datetime DEFAULT NULL,
  `outset` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `added_by` varchar(50) DEFAULT NULL,
  `entrydate` datetime NOT NULL,
  `serno` int NOT NULL,
  PRIMARY KEY (`pat_id`,`serno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-29 11:14:15
