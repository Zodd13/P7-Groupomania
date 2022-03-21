-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentaires`
--

LOCK TABLES `commentaires` WRITE;
/*!40000 ALTER TABLE `commentaires` DISABLE KEYS */;
INSERT INTO `commentaires` VALUES (26,34,24,'test',0,'2022-03-21 16:48:04','2022-03-21 16:48:04'),(27,34,24,'test',1,'2022-03-21 17:40:55','2022-03-21 19:02:37'),(30,34,24,'Bonjour',1,'2022-03-21 18:31:06','2022-03-21 18:39:43'),(31,37,24,'yoooo',1,'2022-03-21 19:02:43','2022-03-21 19:02:48');
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publications`
--

LOCK TABLES `publications` WRITE;
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;
INSERT INTO `publications` VALUES (34,24,'Salut','http://localhost:3000/images/20492753.jpg1647879134527.jpg','2022-03-21 16:12:14','2022-03-21 16:12:17',1),(35,24,'test',NULL,'2022-03-21 17:27:20','2022-03-21 17:27:20',0),(36,24,'test',NULL,'2022-03-21 17:40:46','2022-03-21 18:37:09',1),(37,24,'bonsoiiiir','http://localhost:3000/images/20492753.jpg1647887839649.jpg','2022-03-21 18:37:19','2022-03-21 18:37:23',1);
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (9,'berniam.pro@gmail.co','zaeaz','$2b$10$Ct9e4zTue7IfaZQk0vS5CO4EH49Ap4uO6h6kOIrLKP9j1mC.iMYAC','ezaeza',0,0,'2022-03-12 16:16:35','2022-03-12 16:16:35'),(10,'karim@gmail.com','Karim','$2b$10$qc0gJNSpIuYeb5kABTwHEOFvzgDRXo8wId73oJQAObJlmMYsDpn9a','Bonjour',0,0,'2022-03-12 17:14:28','2022-03-12 17:14:28'),(12,'ter@gm','','$2b$10$t5mxEH6pR7/A4P9bG9PqLuBey9y04JZ.LPOCYfSsyFwwWfJ/lmvzq','',0,0,'2022-03-17 08:51:41','2022-03-17 08:51:41'),(13,'rza','','$2b$10$5A5jPM2XONsm1liuNlV3.OpoDLhqd6VZwfD.fsUF82mlWMBVRe8YW','',0,0,'2022-03-17 08:56:00','2022-03-17 08:56:00'),(24,'Admin@admin.com','Admin','$2b$10$mUhppoDjAZzuD1pmuVyyseKGs7ScnlzdxrnJkcOf7sYVGT350XfRW','Admin@admin.com',1,0,'2022-03-17 15:34:09','2022-03-18 10:24:34'),(25,'te','T','$2b$10$./W9w2sjXEKZZMGq41EgRer7yUqAOxtn4GhsDOARM68k/I.G0BvE2','t',0,0,'2022-03-18 09:58:48','2022-03-18 09:58:48'),(26,'test@test.fr','test','$2b$10$5lSnIH8FyMPmpxIJrbHbT.xDaa3kzLE0Fo5vevGFSOxjUslTFifiG','Test',0,0,'2022-03-21 16:01:57','2022-03-21 16:01:57');
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

-- Dump completed on 2022-03-21 20:14:55
