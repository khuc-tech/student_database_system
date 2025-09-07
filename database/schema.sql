-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: student_database_system
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `achievements`
--

DROP TABLE IF EXISTS `achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `achievements` (
  `Student_Id` varchar(12) DEFAULT NULL,
  `Tech_Events_Participated` varchar(100) DEFAULT NULL,
  `Non_Tech_Events_Participated` varchar(100) DEFAULT NULL,
  `Extra_Skills` varchar(200) DEFAULT NULL,
  `Achievement_Id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Achievement_Id`),
  KEY `achievements_student_fk` (`Student_Id`),
  CONSTRAINT `achievements_student_fk` FOREIGN KEY (`Student_Id`) REFERENCES `student` (`Student_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admission`
--

DROP TABLE IF EXISTS `admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admission` (
  `Admission_No` int NOT NULL AUTO_INCREMENT,
  `Student_Id` varchar(12) NOT NULL,
  `Joining_Date` date NOT NULL,
  `Enrolled_Program_Code` varchar(20) NOT NULL,
  `HSC_Result` decimal(4,2) DEFAULT NULL,
  `Hostel_Accommodation` char(1) DEFAULT NULL,
  `Transport_Facility` char(1) DEFAULT NULL,
  `Batch` int NOT NULL,
  PRIMARY KEY (`Admission_No`),
  KEY `admission_student_fk` (`Student_Id`),
  KEY `admission_program_fk` (`Batch`,`Enrolled_Program_Code`),
  CONSTRAINT `admission_program_fk` FOREIGN KEY (`Batch`, `Enrolled_Program_Code`) REFERENCES `program` (`Batch`, `Program_Code`),
  CONSTRAINT `admission_student_fk` FOREIGN KEY (`Student_Id`) REFERENCES `student` (`Student_Id`),
  CONSTRAINT `chk_hostel` CHECK ((`Hostel_Accommodation` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `chk_transport` CHECK ((`Transport_Facility` in (_utf8mb4'Y',_utf8mb4'N')))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `Faculty_Code` varchar(10) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Middle_Name` varchar(20) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Email_Id` varchar(30) DEFAULT NULL,
  `Contact` varchar(15) NOT NULL,
  PRIMARY KEY (`Faculty_Code`),
  UNIQUE KEY `uq_faculty_email` (`Email_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fees` (
  `Semester` int NOT NULL,
  `Student_Id` varchar(12) NOT NULL,
  `Total_Fees` decimal(10,2) NOT NULL,
  `Fees_Paid` decimal(10,2) NOT NULL,
  `Mode_Of_Payment` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Semester`,`Student_Id`),
  KEY `fees_student_fk` (`Student_Id`),
  CONSTRAINT `fees_student_fk` FOREIGN KEY (`Student_Id`) REFERENCES `student` (`Student_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `Batch` int NOT NULL,
  `Program_Code` varchar(20) NOT NULL,
  `Program_Name` varchar(100) DEFAULT NULL,
  `Program_Duration` int DEFAULT NULL,
  `Program_Coordinator_Code` varchar(20) NOT NULL,
  PRIMARY KEY (`Batch`,`Program_Code`),
  KEY `program_faculty_fk` (`Program_Coordinator_Code`),
  CONSTRAINT `program_faculty_fk` FOREIGN KEY (`Program_Coordinator_Code`) REFERENCES `faculty` (`Faculty_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `result`
--

DROP TABLE IF EXISTS `result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `result` (
  `Semester` int NOT NULL,
  `Student_Id` varchar(12) NOT NULL,
  `SGPA` decimal(4,2) NOT NULL,
  `Backlog` int NOT NULL DEFAULT '0',
  `Total_Credits_Earned` int DEFAULT NULL,
  `Batch` int NOT NULL,
  `Program_Code` varchar(20) NOT NULL,
  `Subject_Code` varchar(20) NOT NULL,
  PRIMARY KEY (`Student_Id`,`Subject_Code`,`Program_Code`,`Semester`,`Batch`),
  KEY `result_subject_fk` (`Batch`,`Semester`,`Program_Code`,`Subject_Code`),
  CONSTRAINT `result_student_fk` FOREIGN KEY (`Student_Id`) REFERENCES `student` (`Student_Id`),
  CONSTRAINT `result_subject_fk` FOREIGN KEY (`Batch`, `Semester`, `Program_Code`, `Subject_Code`) REFERENCES `subject` (`Batch`, `Semester`, `Program_Code`, `Subject_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `Student_Id` varchar(12) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Middle_Name` varchar(20) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Email_Id` varchar(30) DEFAULT NULL,
  `Contact` varchar(15) DEFAULT NULL,
  `DOB` date NOT NULL,
  PRIMARY KEY (`Student_Id`),
  UNIQUE KEY `uq_student_email` (`Email_Id`),
  CONSTRAINT `chk_student_contact` CHECK (regexp_like(`Contact`,_utf8mb4'^\\+?[0-9]'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `Batch` int NOT NULL,
  `Semester` int NOT NULL,
  `Program_Code` varchar(20) NOT NULL,
  `Subject_Code` varchar(10) NOT NULL,
  `Subject_Name` varchar(100) DEFAULT NULL,
  `Faculty_Code` varchar(10) NOT NULL,
  `Subject_Credits` int NOT NULL,
  PRIMARY KEY (`Batch`,`Semester`,`Program_Code`,`Subject_Code`),
  KEY `subject_faculty_fk` (`Faculty_Code`),
  CONSTRAINT `subject_faculty_fk` FOREIGN KEY (`Faculty_Code`) REFERENCES `faculty` (`Faculty_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-07 17:47:15
