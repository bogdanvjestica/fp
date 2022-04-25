-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: news
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

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
-- Table structure for table `destinations`
--

DROP TABLE IF EXISTS `destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destinations` (
  `name` varchar(45) NOT NULL,
  `desc` varchar(256) NOT NULL,
  `img` varchar(256) NOT NULL,
  `link` varchar(256) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destinations`
--

LOCK TABLES `destinations` WRITE;
/*!40000 ALTER TABLE `destinations` DISABLE KEYS */;
INSERT INTO `destinations` VALUES ('Bec','from 8 EUR via Ryanair','https://www.esl-languages.com/sites/default/files/styles/image_gallery/public/city/gallery/esl-vienna-language-stay-hero.jpg?itok=B_R79XbR','https://www.ryanair.com/ba/en'),('Beograd','from 30 EUR via Air Serbia','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxl9U4CC7cOyJn0_Onkz8JMDMAKnaHzaoTlw&usqp=CAU','https://airserbia.com/'),('Dortmund','from 20 EUR via Wizz Air','https://tvilight.com/wp-content/uploads/2020/05/City-Center-Dortmund.webp','https://wizzair.com/'),('Milano','from 5 EUR via Ryanair','http://www.klik2go.si/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/m/i/milano_klik2go_6__1_2_1_3.jpg','https://www.ryanair.com/ba/en'),('Stokholm','from 5 EUR via Ryanair','https://www.gavelintl.com/wp-content/uploads/2018/06/stockholm1.jpg','https://www.ryanair.com/ba/en'),('Tivat','from 47 EUR via Air Montenegro','https://www.flydubai.com/en/media/Tivat_2560x960_tcm8-56594.jpg','https://airmontenegro.com/');
/*!40000 ALTER TABLE `destinations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `content` longtext NOT NULL COMMENT '	',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (66,'COVID-19 testiranje na Aerodromu','Putovanja u vrijeme COVIDA-a su donijela razne izazove a u cilju zastite od sirenja aktuelnog virusa. Svakako su globalno komplikovanija zbog zahtjeva nadleznih institucija zemalja u koje putnici planiraju putovati kao i zahtjeva izabranih avio-kompanija a odnose se na eventualne zahtjeve za testovima ili potvrdama o vakcinaciji ili prelezanom virusu.<br /><br />Ovim Saopstenjem obavjesavamo nase putnike da je u prostorijma Aerodroma omogucena usluga COVID testiranja. Obavljace ga <b>Zdravstvena ustanova Healt Express</b> Banja Luka i to metodom antigenskog testiranja po cijeni od 37.00 KM uz dobijanje rezultata u roku od 10 do 15 minuta. Predvidjeno je i serolosko testiranje po cijeni od 40.00 KM.<br /><br />Nadamo se ovom odlukom olaksati nasim putnicima procedure vezane za putovanja. I dalje sve informacije vezane za COVID zahtjeve avio-kompanija odnosno nadleznih institucija zemalja opredjenja nasi putnici mogu dobiti na broj <a href=tel:051535225>051 535 225</a>.','2022-04-22 13:14:02'),(67,'Letovi avio kompanije Air Serbia ka Beogradu','Nacionalna avio kompanija Republike Srbije <b>Air Serbia</b> ce dva puta sedmicno (ponedjeljkom i petkom) obavljati letove na relaciji: <br /><br /><b>BEG => BNX => BEG</b><br /><br /> Za informacije i rezervacije posjetite sajt <a href=https://airserbia.com>www.airserbia.com</a> ili nas kontaktirajte na broj telefona <a href=tel:051535210>051 535 210</a> svakog radnog dana od 08.00 do 16.00 casova.','2022-04-22 14:19:10'),(73,'Letovi avio komanije Air Montenegro iz Banja Luke','Kompanija Air Montenegro ce u junu uspostaviti direktne avio-linije ka Banjaluci i Ljubljani. Kako je saopsteno iz nove crnogorske avio-kompanije, linija ka Banjaluci ce biti uspostavljena 27. juna, a prema Ljubljani 29. juna, prenijela je tv stanica RTCG. Avioni Air Montenegra ce tokom ljetne sezone letjeti na liniji Tivat-Ljubljana tri puta sedmicno, a na ruti Tivat - Banjaluka dva puta sedmicno. Avioni ce dovoditi putnike iz Ljubljane tri puta sedmicno, dok ce iz Banjaluke letjeti tokom ljetne sezone dva puta sedmicno. Obje destinacije ce saobracati prema Tivtu.<br />Povratne karte za ove destinacije ce se kretati od 89 evra za Banjaluku, odnosno od 129 evra za Ljubljanu, precizira se u saopstenju.<br /><br />Detaljni podaci o avio-linijama, redu letenja i cijenama karata mogu se naci na sajtu <a href=https://airmontenegro.com/>airmontenegro.com</a>. Izvrsni direktor kompanije, Predrag Todorovic, kazao je da se raduju letovima prema novim destinacijama, napominjuci da je to samo pocetak.<br />U narednom periodu ocekujemo uspostavljanje dodatnih avio-linija ka novim destinacijama, porucio je Todorovic.<br /><br />Iz kompanije su podsjetili da je i dalje u toku promotivna akcija na povratne karte iz Podgorice ili Tivta za Beograd od 109 evra.','2022-04-24 19:20:15');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Bogdan','Vjestica','vjesticabogdan@hotmail.com','1234');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-25 17:16:42
