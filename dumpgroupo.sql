-- MySQL dump 10.13  Distrib 8.0.28, for macos12.2 (arm64)
--
-- Host: localhost    Database: groupomania
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentaires` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PublicationId` int NOT NULL,
  `UserId` int NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_commentaire` (`PublicationId`),
  KEY `fk_user` (`UserId`),
  CONSTRAINT `fk_commentaire` FOREIGN KEY (`PublicationId`) REFERENCES `publications` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_user` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentaires`
--

LOCK TABLES `commentaires` WRITE;
/*!40000 ALTER TABLE `commentaires` DISABLE KEYS */;
INSERT INTO `commentaires` VALUES (68,99,49,'salut',1,'2022-03-25 11:19:54','2022-03-25 11:19:54'),(70,99,61,'Salut besoin d\'aide',1,'2022-03-25 11:30:22','2022-03-25 11:31:19');
/*!40000 ALTER TABLE `commentaires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publications`
--

DROP TABLE IF EXISTS `publications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `UserId` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users` (`UserId`),
  CONSTRAINT `fk_users` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publications`
--

LOCK TABLES `publications` WRITE;
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;
INSERT INTO `publications` VALUES (99,59,'Coucou, il y a quelqu\'un par ici ? Besoin d\'aide pour le travail...',NULL,'2022-03-25 10:56:19','2022-03-25 10:59:00',1),(101,60,'Bonjour','http://localhost:3000/images/Pilepoil.jpeg1648207644546.jpg','2022-03-25 11:27:24','2022-03-25 11:30:44',1),(102,60,'Bonjour',NULL,'2022-03-25 11:27:33','2022-03-25 11:30:51',1),(103,61,'Salut à tous',NULL,'2022-03-25 11:30:09','2022-03-25 11:30:56',1),(104,49,'dda',NULL,'2022-03-25 12:11:28','2022-03-25 12:11:28',1),(105,49,'bonsoir',NULL,'2022-03-25 12:14:09','2022-03-25 12:14:09',1),(106,49,'bonsoir',NULL,'2022-03-25 12:14:10','2022-03-25 12:14:10',1),(107,49,'bonsoir',NULL,'2022-03-25 12:14:11','2022-03-25 12:14:11',1),(108,49,'fze',NULL,'2022-03-25 12:14:43','2022-03-25 12:14:43',1),(109,49,'fze',NULL,'2022-03-25 12:14:45','2022-03-25 12:14:45',1),(110,49,'test',NULL,'2022-03-25 12:15:23','2022-03-25 12:15:23',1),(111,49,'test',NULL,'2022-03-25 12:15:24','2022-03-25 12:15:24',1),(112,49,'test',NULL,'2022-03-25 12:15:29','2022-03-25 12:15:29',1),(113,49,'rgz',NULL,'2022-03-25 12:15:31','2022-03-25 12:15:31',1),(114,49,'coucou',NULL,'2022-03-25 12:15:36','2022-03-25 12:15:36',1),(115,49,'greger',NULL,'2022-03-25 12:15:45','2022-03-25 12:15:45',1),(116,62,'test',NULL,'2022-03-25 12:16:14','2022-03-25 12:16:14',0);
/*!40000 ALTER TABLE `publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequelizemeta`
--

DROP TABLE IF EXISTS `sequelizemeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequelizemeta` (
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequelizemeta`
--

LOCK TABLES `sequelizemeta` WRITE;
/*!40000 ALTER TABLE `sequelizemeta` DISABLE KEYS */;
INSERT INTO `sequelizemeta` VALUES ('20220310155940-create-user.js'),('20220310160157-create-commentaire.js'),('20220310160511-create-publication.js'),('20220311081911-create-commentaire.js'),('20220311081937-create-publication.js'),('20220311082727-create-commentaire.js'),('20220311082733-create-publication.js');
/*!40000 ALTER TABLE `sequelizemeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (49,'Admin@admin.com','Administrateur','$2b$10$/DU7ZQrrJRWKDaGU0z3G9OGW/mqhyVXpWz4c5AAa7475UtqIujiue','Administrateur',1,0,'2022-03-24 09:56:05','2022-03-25 10:53:07','http://localhost:3000/images/favicon.ico1648205587130.undefined'),(50,'Test@test.com','Test','$2b$10$tAZ.SwogNrore3V3NsFmHun6pSzl.Y9koQYKMKdoOq4k3DXC9Y1fm','Test',1,0,'2022-03-24 10:01:04','2022-03-24 10:01:11','http://localhost:3000/images/Zunesha-est-un-garcon-de-joie-PAIujon-2.jpeg1648116071691.jpg'),(59,'Julie@hotmail.com','Julie','$2b$10$gs1pXz26aJQeVocWQ79eluNmu285Y4PI66toS36YYkZNrsN6g..5C','',0,0,'2022-03-25 10:50:53','2022-03-25 11:06:40','http://localhost:3000/images/Pilepoil.jpeg1648206400582.jpg'),(60,'Woody@hotmail.fr','Woody','$2b$10$Odu9vTeG/1G4Y4VTpTwkju7vrIkjntCljbqV/kgo/DFRlJu21F3jm','Salut, moi c\'est Woody cow-boy avisé !',0,0,'2022-03-25 11:26:10','2022-03-25 11:28:26','http://localhost:3000/images/woody.webp1648207706033.undefined'),(61,'abcd@gmail.com','Abcd','$2b$10$qJ4pvIFh5vGBgF2c1HA7o.u2Du7.rGUC.9qh5gP5PsdOvu209daTa','salut à tous',0,0,'2022-03-25 11:29:17','2022-03-25 11:29:41',NULL),(62,'Test@test.org','Test','$2b$10$OFiRTzp7aOCPVdfsAOfc9udGwe5gkuf8C1HXaJf7aEb5DGHdVh8zK','Test',0,0,'2022-03-25 12:16:07','2022-03-25 12:16:07',NULL);
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

-- Dump completed on 2022-03-25 13:25:19
