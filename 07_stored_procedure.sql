-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2026 at 05:26 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `modul6_005`
--

-- --------------------------------------------------------

--
-- Table structure for table `ambil_mk`
--

CREATE TABLE `ambil_mk` (
  `NIM` char(3) DEFAULT NULL,
  `KD_MK` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ambil_mk`
--

INSERT INTO `ambil_mk` (`NIM`, `KD_MK`) VALUES
('101', 'PTI447'),
('103', 'TIK333'),
('104', 'PTI333'),
('104', 'PTI777'),
('105', 'PTI123'),
('107', 'PTI777');

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `KODE_DOS` char(2) NOT NULL,
  `NAMA_DOS` varchar(30) DEFAULT NULL,
  `ALAMAT_DOS` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dosen`
--

INSERT INTO `dosen` (`KODE_DOS`, `NAMA_DOS`, `ALAMAT_DOS`) VALUES
('10', 'SUHARTO', 'JL. JOMBANG'),
('11', 'MARTONO', 'JL. KALPATARU'),
('12', 'RAHMAWATI', 'JL. JAKARTA'),
('13', 'BAMBANG', 'JL. BANDUNG'),
('14', 'NURUL', 'JL. RAYA TIDAR');

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE `jurusan` (
  `KODE_JUR` char(2) NOT NULL,
  `NAMA_JUR` varchar(30) DEFAULT NULL,
  `KODE_DOS` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jurusan`
--

INSERT INTO `jurusan` (`KODE_JUR`, `NAMA_JUR`, `KODE_DOS`) VALUES
('TE', 'TEKNIK ELEKTRO', '10'),
('TM', 'TEKNIK MESIN', '13'),
('TS', 'TEKNIK SIPIL', '23');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `NIM` char(3) NOT NULL,
  `NAMA_MHS` varchar(30) DEFAULT NULL,
  `JK_MHS` char(1) DEFAULT NULL,
  `ALAMAT_MHS` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`NIM`, `NAMA_MHS`, `JK_MHS`, `ALAMAT_MHS`) VALUES
('101', 'ARIF', 'L', 'JL.KENANGAN'),
('102', 'BUDI', 'L', 'JL.JOMBANG'),
('103', 'WATI', 'P', 'JL.SURABAYA'),
('104', 'IKA', 'P', 'JL.JOMBANG'),
('105', 'TONO', 'L', 'JL.JAKARTA'),
('106', 'IWAN', 'L', 'JL.BANDUNG'),
('107', 'SARI', 'P', 'JL.MALANG');

-- --------------------------------------------------------

--
-- Table structure for table `matakuliah`
--

CREATE TABLE `matakuliah` (
  `KD_MK` varchar(6) NOT NULL,
  `NAMA_MK` varchar(30) DEFAULT NULL,
  `SKS` int(1) DEFAULT NULL,
  `SEMESTER` int(1) DEFAULT NULL,
  `KODE_DOS` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `matakuliah`
--

INSERT INTO `matakuliah` (`KD_MK`, `NAMA_MK`, `SKS`, `SEMESTER`, `KODE_DOS`) VALUES
('PTI123', 'GRAFIKA MULTIMEDIA', 3, 5, '12'),
('PTI333', 'BASIS DATA TERDISTRIBUSI', 3, 5, '10'),
('PTI447', 'PRAKTIKUM BASIS DATA', 1, 3, '11'),
('PTI777', 'SISTEM INFORMASI', 2, 3, '99'),
('TIK123', 'JARINGAN KOMPUTER', 2, 5, '33'),
('TIK333', 'SISTEM OPERASI', 3, 5, '10'),
('TIK342', 'PRAKTIKUM BASIS DATA', 1, 3, '11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ambil_mk`
--
ALTER TABLE `ambil_mk`
  ADD KEY `NIM` (`NIM`),
  ADD KEY `KD_MK` (`KD_MK`),
  ADD KEY `NIM_2` (`NIM`),
  ADD KEY `KD_MK_2` (`KD_MK`);

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`KODE_DOS`);

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`KODE_JUR`),
  ADD KEY `KODE_DOS` (`KODE_DOS`),
  ADD KEY `KODE_DOS_2` (`KODE_DOS`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`NIM`);

--
-- Indexes for table `matakuliah`
--
ALTER TABLE `matakuliah`
  ADD PRIMARY KEY (`KD_MK`),
  ADD KEY `KODE_DOS` (`KODE_DOS`),
  ADD KEY `KODE_DOS_2` (`KODE_DOS`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ambil_mk`
--
ALTER TABLE `ambil_mk`
  ADD CONSTRAINT `fk_ambilmk_mhs` FOREIGN KEY (`NIM`) REFERENCES `mahasiswa` (`NIM`),
  ADD CONSTRAINT `fk_ambilmk_mk` FOREIGN KEY (`KD_MK`) REFERENCES `matakuliah` (`KD_MK`);

--
-- Constraints for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD CONSTRAINT `fk_jurusan_dos` FOREIGN KEY (`KODE_DOS`) REFERENCES `dosen` (`KODE_DOS`);

--
-- Constraints for table `matakuliah`
--
ALTER TABLE `matakuliah`
  ADD CONSTRAINT `fk_matakuliah_dos` FOREIGN KEY (`KODE_DOS`) REFERENCES `dosen` (`KODE_DOS`);
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
