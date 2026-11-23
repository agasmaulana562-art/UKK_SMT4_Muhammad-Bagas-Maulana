-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Nov 2026 pada 18.05
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_bankv4`
--
CREATE DATABASE IF NOT EXISTS `db_bankv4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_bankv4`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_setoran`
--

CREATE TABLE `jenis_setoran` (
  `id_js` int(10) NOT NULL,
  `nama_setoran` varchar(100) DEFAULT NULL,
  `nilai_setoran` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan`
--

CREATE TABLE `jurusan` (
  `id_jur` int(10) NOT NULL,
  `nama_jurusan` varchar(100) DEFAULT NULL,
  `singkat_jur` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas`
--

CREATE TABLE `kelas` (
  `id_kel` int(10) NOT NULL,
  `tingkat_kelas` enum('1','2','3','4','5','6','7','8','9','10','11','12') DEFAULT NULL,
  `singkat_jur` varchar(100) DEFAULT NULL,
  `rombel` varchar(100) DEFAULT NULL,
  `id_jur` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nasabah`
--

CREATE TABLE `nasabah` (
  `id_nasabah` varchar(50) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `jk` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `tmpt_lahir` varchar(100) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `no_tlpn` varchar(100) DEFAULT NULL,
  `tanda_pengenal` varchar(100) DEFAULT NULL,
  `no_pengenal` varchar(100) DEFAULT NULL,
  `id_jurusan` varchar(100) DEFAULT NULL,
  `nama_kelas` varchar(100) DEFAULT NULL,
  `saldo` int(10) DEFAULT NULL,
  `transaksi_terakhir` date DEFAULT NULL,
  `nama_ibu` varchar(25) DEFAULT NULL,
  `nama_ayah` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `no_pembayaran` varchar(100) DEFAULT NULL,
  `tanggal_pembayaran` date DEFAULT NULL,
  `no_penggenal` varchar(100) DEFAULT NULL,
  `nama_nasabah` varchar(100) DEFAULT NULL,
  `kelas` varchar(100) DEFAULT NULL,
  `nama_setoran` varchar(100) DEFAULT NULL,
  `jumlah` varchar(100) DEFAULT NULL,
  `status` enum('Lunas','Belum Lunas') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penarikan`
--

CREATE TABLE `penarikan` (
  `id_penarikan` int(10) NOT NULL,
  `no_penarikan` varchar(100) DEFAULT NULL,
  `id_nasabah` varchar(100) DEFAULT NULL,
  `nama_nasabah` varchar(100) DEFAULT NULL,
  `jk` varchar(100) DEFAULT NULL,
  `no_pengenal` varchar(100) DEFAULT NULL,
  `nama_kelas` varchar(100) DEFAULT NULL,
  `ket` varchar(100) DEFAULT NULL,
  `tanggal_penarikan` date DEFAULT NULL,
  `jumlah` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `setoran`
--

CREATE TABLE `setoran` (
  `id_setoran` int(10) NOT NULL,
  `no_setoran` varchar(100) DEFAULT NULL,
  `nama_nasabah` varchar(100) DEFAULT NULL,
  `id_nasabah` varchar(100) DEFAULT NULL,
  `tgl_setoran` date DEFAULT NULL,
  `jumlah` varchar(100) DEFAULT NULL,
  `no_pengenal` varchar(100) DEFAULT NULL,
  `nama_kelas` varchar(100) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `nama_setoran` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tanda_pengenal`
--

CREATE TABLE `tanda_pengenal` (
  `id_tp` int(10) NOT NULL,
  `tanda_pengenal` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tarik_bayar`
--

CREATE TABLE `tarik_bayar` (
  `id_tarik` int(11) NOT NULL,
  `no_tarik` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `tanggal_tarik` date DEFAULT NULL,
  `ket` varchar(100) DEFAULT NULL,
  `jumlah` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_admin`
--

CREATE TABLE `tbl_admin` (
  `id_admin` int(11) NOT NULL,
  `nama_admin` varchar(100) DEFAULT NULL,
  `telepon_admin` varchar(100) DEFAULT NULL,
  `alamat_admin` varchar(256) DEFAULT NULL,
  `jenis_kelamin` enum('L','P','') DEFAULT NULL,
  `path_photo_admin` varchar(255) DEFAULT NULL,
  `id_user` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tbl_admin`
--

INSERT INTO `tbl_admin` (`id_admin`, `nama_admin`, `telepon_admin`, `alamat_admin`, `jenis_kelamin`, `path_photo_admin`, `id_user`, `created_at`, `updated_at`) VALUES
(8, 'p3doel', '0895643216', 'jl.antapanilama', 'L', 'ADM_ADM000000120261113_1327126af6adc0d33c9.jpeg', 'ADM0000001', '2026-09-25 06:47:18', '2026-11-13 06:27:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pengawas`
--

CREATE TABLE `tbl_pengawas` (
  `id_pengawas` int(11) NOT NULL,
  `nama_pengawas` varchar(100) NOT NULL,
  `telepon_pengawas` varchar(100) NOT NULL,
  `alamat_pengawas` varchar(256) NOT NULL,
  `jenis_kelamin` enum('L','P','') DEFAULT NULL,
  `path_photo_pengawas` varchar(255) DEFAULT NULL,
  `id_user` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tbl_pengawas`
--

INSERT INTO `tbl_pengawas` (`id_pengawas`, `nama_pengawas`, `telepon_pengawas`, `alamat_pengawas`, `jenis_kelamin`, `path_photo_pengawas`, `id_user`, `created_at`, `updated_at`) VALUES
(7, 'ridwan', '0896735421', 'Bandung', 'L', 'PGW_PGW000000120261116_1118526afa842c3ec7a.jpeg', 'PGW0000001', '2026-11-16 04:08:23', '2026-11-16 04:18:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_tipe_user`
--

CREATE TABLE `tbl_tipe_user` (
  `id_tipe_user` int(11) NOT NULL,
  `tipe_user` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tbl_tipe_user`
--

INSERT INTO `tbl_tipe_user` (`id_tipe_user`, `tipe_user`) VALUES
(1, 'Admin'),
(2, 'Petugas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_tipe_users`
--

CREATE TABLE `tbl_tipe_users` (
  `id_tipe_user` int(11) NOT NULL,
  `tipe_user` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tbl_tipe_users`
--

INSERT INTO `tbl_tipe_users` (`id_tipe_user`, `tipe_user`, `created_at`, `updated_at`) VALUES
(5, 'Admin', '2026-09-25 06:47:03', '2026-09-25 06:47:03'),
(6, 'Petugas', '2026-09-25 06:47:03', '2026-09-25 06:47:03'),
(7, 'Admin', '2026-09-25 06:47:06', '2026-09-25 06:47:06'),
(8, 'Petugas', '2026-09-25 06:47:06', '2026-09-25 06:47:06'),
(9, 'Admin', '2026-09-25 06:47:18', '2026-09-25 06:47:18'),
(10, 'Petugas', '2026-09-25 06:47:18', '2026-09-25 06:47:18'),
(11, 'Admin', '2026-09-25 06:47:21', '2026-09-25 06:47:21'),
(12, 'Petugas', '2026-09-25 06:47:21', '2026-09-25 06:47:21'),
(13, 'Admin', '2026-09-25 06:47:30', '2026-09-25 06:47:30'),
(14, 'Petugas', '2026-09-25 06:47:30', '2026-09-25 06:47:30'),
(15, 'Admin', '2026-09-25 06:47:32', '2026-09-25 06:47:32'),
(16, 'Petugas', '2026-09-25 06:47:32', '2026-09-25 06:47:32'),
(17, 'Admin', '2026-09-25 06:47:35', '2026-09-25 06:47:35'),
(18, 'Petugas', '2026-09-25 06:47:35', '2026-09-25 06:47:35'),
(19, 'Admin', '2026-09-25 06:47:54', '2026-09-25 06:47:54'),
(20, 'Petugas', '2026-09-25 06:47:54', '2026-09-25 06:47:54'),
(21, 'Admin', '2026-09-25 06:47:58', '2026-09-25 06:47:58'),
(22, 'Petugas', '2026-09-25 06:47:58', '2026-09-25 06:47:58'),
(23, 'Admin', '2026-09-25 06:48:06', '2026-09-25 06:48:06'),
(24, 'Petugas', '2026-09-25 06:48:06', '2026-09-25 06:48:06'),
(25, 'Admin', '2026-09-25 06:48:07', '2026-09-25 06:48:07'),
(26, 'Petugas', '2026-09-25 06:48:07', '2026-09-25 06:48:07'),
(27, 'Admin', '2026-09-25 06:48:09', '2026-09-25 06:48:09'),
(28, 'Petugas', '2026-09-25 06:48:09', '2026-09-25 06:48:09'),
(29, 'Admin', '2026-09-25 06:48:18', '2026-09-25 06:48:18'),
(30, 'Petugas', '2026-09-25 06:48:18', '2026-09-25 06:48:18'),
(31, 'Admin', '2026-09-25 06:48:33', '2026-09-25 06:48:33'),
(32, 'Petugas', '2026-09-25 06:48:33', '2026-09-25 06:48:33'),
(33, 'Admin', '2026-09-25 06:48:35', '2026-09-25 06:48:35'),
(34, 'Petugas', '2026-09-25 06:48:35', '2026-09-25 06:48:35'),
(35, 'Admin', '2026-09-25 06:50:26', '2026-09-25 06:50:26'),
(36, 'Petugas', '2026-09-25 06:50:26', '2026-09-25 06:50:26'),
(37, 'Admin', '2026-09-25 06:50:41', '2026-09-25 06:50:41'),
(38, 'Petugas', '2026-09-25 06:50:41', '2026-09-25 06:50:41'),
(39, 'Admin', '2026-09-25 06:52:09', '2026-09-25 06:52:09'),
(40, 'Petugas', '2026-09-25 06:52:09', '2026-09-25 06:52:09'),
(41, 'Admin', '2026-09-25 06:52:20', '2026-09-25 06:52:20'),
(42, 'Petugas', '2026-09-25 06:52:20', '2026-09-25 06:52:20'),
(43, 'Admin', '2026-09-25 06:52:25', '2026-09-25 06:52:25'),
(44, 'Petugas', '2026-09-25 06:52:25', '2026-09-25 06:52:25'),
(45, 'Admin', '2026-09-25 06:53:54', '2026-09-25 06:53:54'),
(46, 'Petugas', '2026-09-25 06:53:54', '2026-09-25 06:53:54'),
(47, 'Admin', '2026-09-25 06:54:05', '2026-09-25 06:54:05'),
(48, 'Petugas', '2026-09-25 06:54:05', '2026-09-25 06:54:05'),
(49, 'Admin', '2026-09-25 07:02:47', '2026-09-25 07:02:47'),
(50, 'Petugas', '2026-09-25 07:02:47', '2026-09-25 07:02:47'),
(51, 'Admin', '2026-09-25 07:06:19', '2026-09-25 07:06:19'),
(52, 'Petugas', '2026-09-25 07:06:19', '2026-09-25 07:06:19'),
(53, 'Admin', '2026-09-25 07:07:05', '2026-09-25 07:07:05'),
(54, 'Petugas', '2026-09-25 07:07:05', '2026-09-25 07:07:05'),
(55, 'Admin', '2026-10-05 02:06:31', '2026-10-05 02:06:31'),
(56, 'Petugas', '2026-10-05 02:06:31', '2026-10-05 02:06:31'),
(57, 'Admin', '2026-10-05 02:54:04', '2026-10-05 02:54:04'),
(58, 'Petugas', '2026-10-05 02:54:04', '2026-10-05 02:54:04'),
(59, 'Admin', '2026-10-05 02:54:12', '2026-10-05 02:54:12'),
(60, 'Petugas', '2026-10-05 02:54:12', '2026-10-05 02:54:12'),
(61, 'Admin', '2026-10-05 02:54:14', '2026-10-05 02:54:14'),
(62, 'Petugas', '2026-10-05 02:54:14', '2026-10-05 02:54:14'),
(63, 'Admin', '2026-10-05 02:54:19', '2026-10-05 02:54:19'),
(64, 'Petugas', '2026-10-05 02:54:19', '2026-10-05 02:54:19'),
(65, 'Admin', '2026-10-05 03:00:19', '2026-10-05 03:00:19'),
(66, 'Petugas', '2026-10-05 03:00:19', '2026-10-05 03:00:19'),
(67, 'Admin', '2026-10-05 03:00:22', '2026-10-05 03:00:22'),
(68, 'Petugas', '2026-10-05 03:00:22', '2026-10-05 03:00:22'),
(69, 'Admin', '2026-10-05 03:00:33', '2026-10-05 03:00:33'),
(70, 'Petugas', '2026-10-05 03:00:33', '2026-10-05 03:00:33'),
(71, 'Admin', '2026-10-05 03:00:38', '2026-10-05 03:00:38'),
(72, 'Petugas', '2026-10-05 03:00:38', '2026-10-05 03:00:38'),
(73, 'Admin', '2026-10-05 03:00:40', '2026-10-05 03:00:40'),
(74, 'Petugas', '2026-10-05 03:00:40', '2026-10-05 03:00:40'),
(75, 'Admin', '2026-10-05 03:01:23', '2026-10-05 03:01:23'),
(76, 'Petugas', '2026-10-05 03:01:23', '2026-10-05 03:01:23'),
(77, 'Admin', '2026-10-05 03:02:39', '2026-10-05 03:02:39'),
(78, 'Petugas', '2026-10-05 03:02:39', '2026-10-05 03:02:39'),
(79, 'Admin', '2026-10-05 03:03:41', '2026-10-05 03:03:41'),
(80, 'Petugas', '2026-10-05 03:03:41', '2026-10-05 03:03:41'),
(81, 'Admin', '2026-10-05 03:03:41', '2026-10-05 03:03:41'),
(82, 'Petugas', '2026-10-05 03:03:41', '2026-10-05 03:03:41'),
(83, 'Admin', '2026-10-05 03:03:45', '2026-10-05 03:03:45'),
(84, 'Petugas', '2026-10-05 03:03:45', '2026-10-05 03:03:45'),
(85, 'Admin', '2026-10-05 03:04:03', '2026-10-05 03:04:03'),
(86, 'Petugas', '2026-10-05 03:04:03', '2026-10-05 03:04:03'),
(87, 'Admin', '2026-10-05 03:04:05', '2026-10-05 03:04:05'),
(88, 'Petugas', '2026-10-05 03:04:05', '2026-10-05 03:04:05'),
(89, 'Admin', '2026-10-05 03:04:12', '2026-10-05 03:04:12'),
(90, 'Petugas', '2026-10-05 03:04:12', '2026-10-05 03:04:12'),
(91, 'Admin', '2026-10-05 03:04:17', '2026-10-05 03:04:17'),
(92, 'Petugas', '2026-10-05 03:04:17', '2026-10-05 03:04:17'),
(93, 'Admin', '2026-10-05 03:04:19', '2026-10-05 03:04:19'),
(94, 'Petugas', '2026-10-05 03:04:19', '2026-10-05 03:04:19'),
(95, 'Admin', '2026-10-05 03:04:20', '2026-10-05 03:04:20'),
(96, 'Petugas', '2026-10-05 03:04:20', '2026-10-05 03:04:20'),
(97, 'Admin', '2026-10-05 03:05:30', '2026-10-05 03:05:30'),
(98, 'Petugas', '2026-10-05 03:05:30', '2026-10-05 03:05:30'),
(99, 'Admin', '2026-10-05 06:10:30', '2026-10-05 06:10:30'),
(100, 'Petugas', '2026-10-05 06:10:30', '2026-10-05 06:10:30'),
(101, 'Admin', '2026-10-05 06:10:39', '2026-10-05 06:10:39'),
(102, 'Petugas', '2026-10-05 06:10:39', '2026-10-05 06:10:39'),
(103, 'Admin', '2026-10-05 06:10:43', '2026-10-05 06:10:43'),
(104, 'Petugas', '2026-10-05 06:10:43', '2026-10-05 06:10:43'),
(105, 'Admin', '2026-10-05 06:10:46', '2026-10-05 06:10:46'),
(106, 'Petugas', '2026-10-05 06:10:46', '2026-10-05 06:10:46'),
(107, 'Admin', '2026-10-05 06:11:21', '2026-10-05 06:11:21'),
(108, 'Petugas', '2026-10-05 06:11:21', '2026-10-05 06:11:21'),
(109, 'Admin', '2026-10-05 06:11:29', '2026-10-05 06:11:29'),
(110, 'Petugas', '2026-10-05 06:11:29', '2026-10-05 06:11:29'),
(111, 'Admin', '2026-10-05 06:11:47', '2026-10-05 06:11:47'),
(112, 'Petugas', '2026-10-05 06:11:47', '2026-10-05 06:11:47'),
(113, 'Admin', '2026-10-05 06:11:49', '2026-10-05 06:11:49'),
(114, 'Petugas', '2026-10-05 06:11:49', '2026-10-05 06:11:49'),
(115, 'Admin', '2026-10-05 06:11:58', '2026-10-05 06:11:58'),
(116, 'Petugas', '2026-10-05 06:11:58', '2026-10-05 06:11:58'),
(117, 'Admin', '2026-10-05 07:44:01', '2026-10-05 07:44:01'),
(118, 'Petugas', '2026-10-05 07:44:01', '2026-10-05 07:44:01'),
(119, 'Admin', '2026-10-06 03:16:01', '2026-10-06 03:16:01'),
(120, 'Petugas', '2026-10-06 03:16:01', '2026-10-06 03:16:01'),
(121, 'Admin', '2026-10-06 03:16:05', '2026-10-06 03:16:05'),
(122, 'Petugas', '2026-10-06 03:16:05', '2026-10-06 03:16:05'),
(123, 'Admin', '2026-10-06 03:16:31', '2026-10-06 03:16:31'),
(124, 'Petugas', '2026-10-06 03:16:31', '2026-10-06 03:16:31'),
(125, 'Admin', '2026-10-06 03:16:37', '2026-10-06 03:16:37'),
(126, 'Petugas', '2026-10-06 03:16:37', '2026-10-06 03:16:37'),
(127, 'Admin', '2026-10-06 03:16:50', '2026-10-06 03:16:50'),
(128, 'Petugas', '2026-10-06 03:16:50', '2026-10-06 03:16:50'),
(129, 'Admin', '2026-10-06 03:16:56', '2026-10-06 03:16:56'),
(130, 'Petugas', '2026-10-06 03:16:56', '2026-10-06 03:16:56'),
(131, 'Admin', '2026-10-06 03:17:15', '2026-10-06 03:17:15'),
(132, 'Petugas', '2026-10-06 03:17:15', '2026-10-06 03:17:15'),
(133, 'Admin', '2026-10-06 03:17:20', '2026-10-06 03:17:20'),
(134, 'Petugas', '2026-10-06 03:17:20', '2026-10-06 03:17:20'),
(135, 'Admin', '2026-10-06 07:19:24', '2026-10-06 07:19:24'),
(136, 'Petugas', '2026-10-06 07:19:24', '2026-10-06 07:19:24'),
(137, 'Admin', '2026-10-06 07:19:26', '2026-10-06 07:19:26'),
(138, 'Petugas', '2026-10-06 07:19:26', '2026-10-06 07:19:26'),
(139, 'Admin', '2026-10-06 07:19:28', '2026-10-06 07:19:28'),
(140, 'Petugas', '2026-10-06 07:19:28', '2026-10-06 07:19:28'),
(141, 'Admin', '2026-10-06 07:19:36', '2026-10-06 07:19:36'),
(142, 'Petugas', '2026-10-06 07:19:36', '2026-10-06 07:19:36'),
(143, 'Admin', '2026-10-06 07:19:39', '2026-10-06 07:19:39'),
(144, 'Petugas', '2026-10-06 07:19:39', '2026-10-06 07:19:39'),
(145, 'Admin', '2026-10-06 07:19:49', '2026-10-06 07:19:49'),
(146, 'Petugas', '2026-10-06 07:19:49', '2026-10-06 07:19:49'),
(147, 'Admin', '2026-10-06 07:19:56', '2026-10-06 07:19:56'),
(148, 'Petugas', '2026-10-06 07:19:56', '2026-10-06 07:19:56'),
(149, 'Admin', '2026-10-06 07:19:59', '2026-10-06 07:19:59'),
(150, 'Petugas', '2026-10-06 07:19:59', '2026-10-06 07:19:59'),
(151, 'Admin', '2026-10-06 07:25:51', '2026-10-06 07:25:51'),
(152, 'Petugas', '2026-10-06 07:25:51', '2026-10-06 07:25:51'),
(153, 'Admin', '2026-10-06 07:25:58', '2026-10-06 07:25:58'),
(154, 'Petugas', '2026-10-06 07:25:58', '2026-10-06 07:25:58'),
(155, 'Admin', '2026-10-06 07:25:59', '2026-10-06 07:25:59'),
(156, 'Petugas', '2026-10-06 07:25:59', '2026-10-06 07:25:59'),
(157, 'Admin', '2026-10-06 07:26:02', '2026-10-06 07:26:02'),
(158, 'Petugas', '2026-10-06 07:26:02', '2026-10-06 07:26:02'),
(159, 'Admin', '2026-10-06 07:26:05', '2026-10-06 07:26:05'),
(160, 'Petugas', '2026-10-06 07:26:05', '2026-10-06 07:26:05'),
(161, 'Admin', '2026-10-06 07:26:27', '2026-10-06 07:26:27'),
(162, 'Petugas', '2026-10-06 07:26:27', '2026-10-06 07:26:27'),
(163, 'Admin', '2026-10-06 07:26:35', '2026-10-06 07:26:35'),
(164, 'Petugas', '2026-10-06 07:26:35', '2026-10-06 07:26:35'),
(165, 'Admin', '2026-10-06 07:26:37', '2026-10-06 07:26:37'),
(166, 'Petugas', '2026-10-06 07:26:37', '2026-10-06 07:26:37'),
(167, 'Admin', '2026-10-06 07:26:39', '2026-10-06 07:26:39'),
(168, 'Petugas', '2026-10-06 07:26:39', '2026-10-06 07:26:39'),
(169, 'Admin', '2026-10-06 07:26:40', '2026-10-06 07:26:40'),
(170, 'Petugas', '2026-10-06 07:26:40', '2026-10-06 07:26:40'),
(171, 'Admin', '2026-10-06 07:26:46', '2026-10-06 07:26:46'),
(172, 'Petugas', '2026-10-06 07:26:46', '2026-10-06 07:26:46'),
(173, 'Admin', '2026-10-06 07:26:58', '2026-10-06 07:26:58'),
(174, 'Petugas', '2026-10-06 07:26:58', '2026-10-06 07:26:58'),
(175, 'Admin', '2026-10-06 07:27:03', '2026-10-06 07:27:03'),
(176, 'Petugas', '2026-10-06 07:27:03', '2026-10-06 07:27:03'),
(177, 'Admin', '2026-10-06 07:27:07', '2026-10-06 07:27:07'),
(178, 'Petugas', '2026-10-06 07:27:07', '2026-10-06 07:27:07'),
(179, 'Admin', '2026-10-06 07:27:13', '2026-10-06 07:27:13'),
(180, 'Petugas', '2026-10-06 07:27:13', '2026-10-06 07:27:13'),
(181, 'Admin', '2026-10-06 07:27:41', '2026-10-06 07:27:41'),
(182, 'Petugas', '2026-10-06 07:27:41', '2026-10-06 07:27:41'),
(183, 'Admin', '2026-10-06 07:27:45', '2026-10-06 07:27:45'),
(184, 'Petugas', '2026-10-06 07:27:45', '2026-10-06 07:27:45'),
(185, 'Admin', '2026-10-06 07:27:57', '2026-10-06 07:27:57'),
(186, 'Petugas', '2026-10-06 07:27:57', '2026-10-06 07:27:57'),
(187, 'Admin', '2026-10-06 07:27:59', '2026-10-06 07:27:59'),
(188, 'Petugas', '2026-10-06 07:27:59', '2026-10-06 07:27:59'),
(189, 'Admin', '2026-10-06 07:28:14', '2026-10-06 07:28:14'),
(190, 'Petugas', '2026-10-06 07:28:14', '2026-10-06 07:28:14'),
(191, 'Admin', '2026-10-06 07:30:19', '2026-10-06 07:30:19'),
(192, 'Petugas', '2026-10-06 07:30:19', '2026-10-06 07:30:19'),
(193, 'Admin', '2026-10-06 07:30:21', '2026-10-06 07:30:21'),
(194, 'Petugas', '2026-10-06 07:30:21', '2026-10-06 07:30:21'),
(195, 'Admin', '2026-10-06 07:30:39', '2026-10-06 07:30:39'),
(196, 'Petugas', '2026-10-06 07:30:39', '2026-10-06 07:30:39'),
(197, 'Admin', '2026-10-06 07:30:41', '2026-10-06 07:30:41'),
(198, 'Petugas', '2026-10-06 07:30:41', '2026-10-06 07:30:41'),
(199, 'Admin', '2026-10-06 07:30:50', '2026-10-06 07:30:50'),
(200, 'Petugas', '2026-10-06 07:30:50', '2026-10-06 07:30:50'),
(201, 'Admin', '2026-10-06 07:30:51', '2026-10-06 07:30:51'),
(202, 'Petugas', '2026-10-06 07:30:51', '2026-10-06 07:30:51'),
(203, 'Admin', '2026-10-08 01:07:20', '2026-10-08 01:07:20'),
(204, 'Petugas', '2026-10-08 01:07:20', '2026-10-08 01:07:20'),
(205, 'Admin', '2026-10-08 01:07:23', '2026-10-08 01:07:23'),
(206, 'Petugas', '2026-10-08 01:07:23', '2026-10-08 01:07:23'),
(207, 'Admin', '2026-10-08 01:07:47', '2026-10-08 01:07:47'),
(208, 'Petugas', '2026-10-08 01:07:47', '2026-10-08 01:07:47'),
(209, 'Admin', '2026-10-08 01:07:50', '2026-10-08 01:07:50'),
(210, 'Petugas', '2026-10-08 01:07:50', '2026-10-08 01:07:50'),
(211, 'Admin', '2026-10-08 01:08:02', '2026-10-08 01:08:02'),
(212, 'Petugas', '2026-10-08 01:08:02', '2026-10-08 01:08:02'),
(213, 'Admin', '2026-10-08 01:08:05', '2026-10-08 01:08:05'),
(214, 'Petugas', '2026-10-08 01:08:05', '2026-10-08 01:08:05'),
(215, 'Admin', '2026-10-08 01:08:08', '2026-10-08 01:08:08'),
(216, 'Petugas', '2026-10-08 01:08:08', '2026-10-08 01:08:08'),
(217, 'Admin', '2026-10-08 01:08:12', '2026-10-08 01:08:12'),
(218, 'Petugas', '2026-10-08 01:08:12', '2026-10-08 01:08:12'),
(219, 'Admin', '2026-10-08 01:08:12', '2026-10-08 01:08:12'),
(220, 'Petugas', '2026-10-08 01:08:12', '2026-10-08 01:08:12'),
(221, 'Admin', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(222, 'Petugas', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(223, 'Admin', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(224, 'Petugas', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(225, 'Admin', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(226, 'Petugas', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(227, 'Admin', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(228, 'Petugas', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(229, 'Admin', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(230, 'Petugas', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(231, 'Admin', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(232, 'Petugas', '2026-10-08 01:08:13', '2026-10-08 01:08:13'),
(233, 'Admin', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(234, 'Petugas', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(235, 'Admin', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(236, 'Petugas', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(237, 'Admin', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(238, 'Petugas', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(239, 'Admin', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(240, 'Petugas', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(241, 'Admin', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(242, 'Petugas', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(243, 'Admin', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(244, 'Petugas', '2026-10-08 01:08:14', '2026-10-08 01:08:14'),
(245, 'Admin', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(246, 'Petugas', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(247, 'Admin', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(248, 'Petugas', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(249, 'Admin', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(250, 'Petugas', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(251, 'Admin', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(252, 'Petugas', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(253, 'Admin', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(254, 'Petugas', '2026-10-08 01:08:15', '2026-10-08 01:08:15'),
(255, 'Admin', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(256, 'Petugas', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(257, 'Admin', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(258, 'Petugas', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(259, 'Admin', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(260, 'Petugas', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(261, 'Admin', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(262, 'Petugas', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(263, 'Admin', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(264, 'Petugas', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(265, 'Admin', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(266, 'Petugas', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(267, 'Admin', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(268, 'Petugas', '2026-10-08 01:08:16', '2026-10-08 01:08:16'),
(269, 'Admin', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(270, 'Petugas', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(271, 'Admin', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(272, 'Petugas', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(273, 'Admin', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(274, 'Petugas', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(275, 'Admin', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(276, 'Petugas', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(277, 'Admin', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(278, 'Petugas', '2026-10-08 01:08:17', '2026-10-08 01:08:17'),
(279, 'Admin', '2026-10-08 01:11:30', '2026-10-08 01:11:30'),
(280, 'Petugas', '2026-10-08 01:11:30', '2026-10-08 01:11:30'),
(281, 'Admin', '2026-10-08 01:11:56', '2026-10-08 01:11:56'),
(282, 'Petugas', '2026-10-08 01:11:56', '2026-10-08 01:11:56'),
(283, 'Admin', '2026-10-08 01:12:18', '2026-10-08 01:12:18'),
(284, 'Petugas', '2026-10-08 01:12:18', '2026-10-08 01:12:18'),
(285, 'Admin', '2026-10-08 01:21:27', '2026-10-08 01:21:27'),
(286, 'Petugas', '2026-10-08 01:21:27', '2026-10-08 01:21:27'),
(287, 'Admin', '2026-10-08 01:21:33', '2026-10-08 01:21:33'),
(288, 'Petugas', '2026-10-08 01:21:33', '2026-10-08 01:21:33'),
(289, 'Admin', '2026-10-08 01:21:39', '2026-10-08 01:21:39'),
(290, 'Petugas', '2026-10-08 01:21:39', '2026-10-08 01:21:39'),
(291, 'Admin', '2026-10-08 01:21:43', '2026-10-08 01:21:43'),
(292, 'Petugas', '2026-10-08 01:21:43', '2026-10-08 01:21:43'),
(293, 'Admin', '2026-10-08 01:21:48', '2026-10-08 01:21:48'),
(294, 'Petugas', '2026-10-08 01:21:48', '2026-10-08 01:21:48'),
(295, 'Admin', '2026-10-08 01:21:56', '2026-10-08 01:21:56'),
(296, 'Petugas', '2026-10-08 01:21:56', '2026-10-08 01:21:56'),
(297, 'Admin', '2026-10-08 01:43:53', '2026-10-08 01:43:53'),
(298, 'Petugas', '2026-10-08 01:43:53', '2026-10-08 01:43:53'),
(299, 'Admin', '2026-10-08 01:43:57', '2026-10-08 01:43:57'),
(300, 'Petugas', '2026-10-08 01:43:57', '2026-10-08 01:43:57'),
(301, 'Admin', '2026-10-08 01:44:01', '2026-10-08 01:44:01'),
(302, 'Petugas', '2026-10-08 01:44:01', '2026-10-08 01:44:01'),
(303, 'Admin', '2026-10-08 01:44:14', '2026-10-08 01:44:14'),
(304, 'Petugas', '2026-10-08 01:44:14', '2026-10-08 01:44:14'),
(305, 'Admin', '2026-10-08 01:44:21', '2026-10-08 01:44:21'),
(306, 'Petugas', '2026-10-08 01:44:21', '2026-10-08 01:44:21'),
(307, 'Admin', '2026-10-08 01:44:31', '2026-10-08 01:44:31'),
(308, 'Petugas', '2026-10-08 01:44:31', '2026-10-08 01:44:31'),
(309, 'Admin', '2026-10-08 01:44:33', '2026-10-08 01:44:33'),
(310, 'Petugas', '2026-10-08 01:44:33', '2026-10-08 01:44:33'),
(311, 'Admin', '2026-10-08 01:44:41', '2026-10-08 01:44:41'),
(312, 'Petugas', '2026-10-08 01:44:41', '2026-10-08 01:44:41'),
(313, 'Admin', '2026-10-08 01:44:45', '2026-10-08 01:44:45'),
(314, 'Petugas', '2026-10-08 01:44:45', '2026-10-08 01:44:45'),
(315, 'Admin', '2026-10-08 01:44:48', '2026-10-08 01:44:48'),
(316, 'Petugas', '2026-10-08 01:44:48', '2026-10-08 01:44:48'),
(317, 'Admin', '2026-10-08 01:45:02', '2026-10-08 01:45:02'),
(318, 'Petugas', '2026-10-08 01:45:02', '2026-10-08 01:45:02'),
(319, 'Admin', '2026-10-08 01:45:07', '2026-10-08 01:45:07'),
(320, 'Petugas', '2026-10-08 01:45:07', '2026-10-08 01:45:07'),
(321, 'Admin', '2026-10-08 01:45:14', '2026-10-08 01:45:14'),
(322, 'Petugas', '2026-10-08 01:45:14', '2026-10-08 01:45:14'),
(323, 'Admin', '2026-10-08 01:45:23', '2026-10-08 01:45:23'),
(324, 'Petugas', '2026-10-08 01:45:23', '2026-10-08 01:45:23'),
(325, 'Admin', '2026-10-08 01:45:24', '2026-10-08 01:45:24'),
(326, 'Petugas', '2026-10-08 01:45:24', '2026-10-08 01:45:24'),
(327, 'Admin', '2026-10-08 01:45:33', '2026-10-08 01:45:33'),
(328, 'Petugas', '2026-10-08 01:45:33', '2026-10-08 01:45:33'),
(329, 'Admin', '2026-10-08 01:45:42', '2026-10-08 01:45:42'),
(330, 'Petugas', '2026-10-08 01:45:42', '2026-10-08 01:45:42'),
(331, 'Admin', '2026-10-08 01:45:44', '2026-10-08 01:45:44'),
(332, 'Petugas', '2026-10-08 01:45:44', '2026-10-08 01:45:44'),
(333, 'Admin', '2026-10-08 01:45:52', '2026-10-08 01:45:52'),
(334, 'Petugas', '2026-10-08 01:45:52', '2026-10-08 01:45:52'),
(335, 'Admin', '2026-10-08 01:46:15', '2026-10-08 01:46:15'),
(336, 'Petugas', '2026-10-08 01:46:15', '2026-10-08 01:46:15'),
(337, 'Admin', '2026-10-08 01:46:24', '2026-10-08 01:46:24'),
(338, 'Petugas', '2026-10-08 01:46:24', '2026-10-08 01:46:24'),
(339, 'Admin', '2026-10-08 01:46:29', '2026-10-08 01:46:29'),
(340, 'Petugas', '2026-10-08 01:46:29', '2026-10-08 01:46:29'),
(341, 'Admin', '2026-10-08 01:46:41', '2026-10-08 01:46:41'),
(342, 'Petugas', '2026-10-08 01:46:41', '2026-10-08 01:46:41'),
(343, 'Admin', '2026-10-08 01:46:44', '2026-10-08 01:46:44'),
(344, 'Petugas', '2026-10-08 01:46:44', '2026-10-08 01:46:44'),
(345, 'Admin', '2026-10-11 15:32:37', '2026-10-11 15:32:37'),
(346, 'Petugas', '2026-10-11 15:32:37', '2026-10-11 15:32:37'),
(347, 'Admin', '2026-10-11 15:32:42', '2026-10-11 15:32:42'),
(348, 'Petugas', '2026-10-11 15:32:42', '2026-10-11 15:32:42'),
(349, 'Admin', '2026-10-11 15:32:58', '2026-10-11 15:32:58'),
(350, 'Petugas', '2026-10-11 15:32:58', '2026-10-11 15:32:58'),
(351, 'Admin', '2026-10-11 15:33:01', '2026-10-11 15:33:01'),
(352, 'Petugas', '2026-10-11 15:33:01', '2026-10-11 15:33:01'),
(353, 'Admin', '2026-10-11 15:33:07', '2026-10-11 15:33:07'),
(354, 'Petugas', '2026-10-11 15:33:07', '2026-10-11 15:33:07'),
(355, 'Admin', '2026-10-11 15:33:12', '2026-10-11 15:33:12'),
(356, 'Petugas', '2026-10-11 15:33:12', '2026-10-11 15:33:12'),
(357, 'Admin', '2026-10-11 15:33:13', '2026-10-11 15:33:13'),
(358, 'Petugas', '2026-10-11 15:33:13', '2026-10-11 15:33:13'),
(359, 'Admin', '2026-10-11 15:33:18', '2026-10-11 15:33:18'),
(360, 'Petugas', '2026-10-11 15:33:18', '2026-10-11 15:33:18'),
(361, 'Admin', '2026-10-11 15:33:21', '2026-10-11 15:33:21'),
(362, 'Petugas', '2026-10-11 15:33:21', '2026-10-11 15:33:21'),
(363, 'Admin', '2026-10-11 15:33:33', '2026-10-11 15:33:33'),
(364, 'Petugas', '2026-10-11 15:33:33', '2026-10-11 15:33:33'),
(365, 'Admin', '2026-10-11 15:33:40', '2026-10-11 15:33:40'),
(366, 'Petugas', '2026-10-11 15:33:40', '2026-10-11 15:33:40'),
(367, 'Admin', '2026-10-11 15:33:53', '2026-10-11 15:33:53'),
(368, 'Petugas', '2026-10-11 15:33:53', '2026-10-11 15:33:53'),
(369, 'Admin', '2026-10-11 15:34:54', '2026-10-11 15:34:54'),
(370, 'Petugas', '2026-10-11 15:34:54', '2026-10-11 15:34:54'),
(371, 'Admin', '2026-10-11 15:35:04', '2026-10-11 15:35:04'),
(372, 'Petugas', '2026-10-11 15:35:04', '2026-10-11 15:35:04'),
(373, 'Admin', '2026-10-11 15:35:37', '2026-10-11 15:35:37'),
(374, 'Petugas', '2026-10-11 15:35:37', '2026-10-11 15:35:37'),
(375, 'Admin', '2026-10-11 15:35:56', '2026-10-11 15:35:56'),
(376, 'Petugas', '2026-10-11 15:35:56', '2026-10-11 15:35:56'),
(377, 'Admin', '2026-10-11 15:36:01', '2026-10-11 15:36:01'),
(378, 'Petugas', '2026-10-11 15:36:01', '2026-10-11 15:36:01'),
(379, 'Admin', '2026-10-11 15:36:36', '2026-10-11 15:36:36'),
(380, 'Petugas', '2026-10-11 15:36:36', '2026-10-11 15:36:36'),
(381, 'Admin', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(382, 'Petugas', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(383, 'Admin', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(384, 'Petugas', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(385, 'Admin', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(386, 'Petugas', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(387, 'Admin', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(388, 'Petugas', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(389, 'Admin', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(390, 'Petugas', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(391, 'Admin', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(392, 'Petugas', '2026-10-11 15:38:54', '2026-10-11 15:38:54'),
(393, 'Admin', '2026-10-11 15:38:55', '2026-10-11 15:38:55'),
(394, 'Petugas', '2026-10-11 15:38:55', '2026-10-11 15:38:55'),
(395, 'Admin', '2026-10-11 15:38:55', '2026-10-11 15:38:55'),
(396, 'Petugas', '2026-10-11 15:38:55', '2026-10-11 15:38:55'),
(397, 'Admin', '2026-10-11 15:38:55', '2026-10-11 15:38:55'),
(398, 'Petugas', '2026-10-11 15:38:55', '2026-10-11 15:38:55'),
(399, 'Admin', '2026-10-11 15:38:55', '2026-10-11 15:38:55'),
(400, 'Petugas', '2026-10-11 15:38:55', '2026-10-11 15:38:55'),
(401, 'Admin', '2026-10-11 15:45:17', '2026-10-11 15:45:17'),
(402, 'Petugas', '2026-10-11 15:45:17', '2026-10-11 15:45:17'),
(403, 'Admin', '2026-10-11 15:45:19', '2026-10-11 15:45:19'),
(404, 'Petugas', '2026-10-11 15:45:19', '2026-10-11 15:45:19'),
(405, 'Admin', '2026-10-11 15:45:35', '2026-10-11 15:45:35'),
(406, 'Petugas', '2026-10-11 15:45:35', '2026-10-11 15:45:35'),
(407, 'Admin', '2026-10-11 15:45:39', '2026-10-11 15:45:39'),
(408, 'Petugas', '2026-10-11 15:45:39', '2026-10-11 15:45:39'),
(409, 'Admin', '2026-10-11 15:45:56', '2026-10-11 15:45:56'),
(410, 'Petugas', '2026-10-11 15:45:56', '2026-10-11 15:45:56'),
(411, 'Admin', '2026-10-11 15:45:59', '2026-10-11 15:45:59'),
(412, 'Petugas', '2026-10-11 15:45:59', '2026-10-11 15:45:59'),
(413, 'Admin', '2026-10-11 15:46:06', '2026-10-11 15:46:06'),
(414, 'Petugas', '2026-10-11 15:46:06', '2026-10-11 15:46:06'),
(415, 'Admin', '2026-10-11 15:46:11', '2026-10-11 15:46:11'),
(416, 'Petugas', '2026-10-11 15:46:11', '2026-10-11 15:46:11'),
(417, 'Admin', '2026-10-11 15:46:20', '2026-10-11 15:46:20'),
(418, 'Petugas', '2026-10-11 15:46:20', '2026-10-11 15:46:20'),
(419, 'Admin', '2026-10-11 15:46:27', '2026-10-11 15:46:27'),
(420, 'Petugas', '2026-10-11 15:46:27', '2026-10-11 15:46:27'),
(421, 'Admin', '2026-10-11 15:46:37', '2026-10-11 15:46:37'),
(422, 'Petugas', '2026-10-11 15:46:37', '2026-10-11 15:46:37'),
(423, 'Pengawas', '2026-11-16 03:18:39', '2026-11-16 03:18:39');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id_user` varchar(10) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tbl_users`
--

INSERT INTO `tbl_users` (`id_user`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
('ADM0000001', 'agasmaulana562@gmail.com', '$2y$10$DF5dLk8puEi3sh5/xMiZlekoRfcJN.IX5T9oC9ClFIXvrJ.2PONBm', 5, '2026-09-25 06:47:18', '2026-11-13 06:27:12'),
('PGW0000001', 'pengawas@bankmini.com', '$2y$10$XESe6wOTevzi8oz0s07IvOYlYtUaHxPMuWbSgUvYTf5IeZa5asume', 423, '2026-11-16 04:08:23', '2026-11-16 04:18:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `total_tarikbayar`
--

CREATE TABLE `total_tarikbayar` (
  `id_total` int(11) NOT NULL,
  `no_pembayaran` varchar(100) DEFAULT NULL,
  `no_tarik` varchar(100) DEFAULT NULL,
  `no_pengenal` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `kelas` varchar(100) DEFAULT NULL,
  `nama_setoran` varchar(100) DEFAULT NULL,
  `ket` varchar(100) DEFAULT NULL,
  `jumlah_b` varchar(100) DEFAULT NULL,
  `jumlah_t` varchar(100) DEFAULT NULL,
  `tanggal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_semua`
--

CREATE TABLE `transaksi_semua` (
  `id_semua` int(10) NOT NULL,
  `no_setoran` varchar(100) DEFAULT NULL,
  `no_penarikan` varchar(100) DEFAULT NULL,
  `id_nasabah` varchar(100) DEFAULT NULL,
  `nama_nasabah` varchar(100) DEFAULT NULL,
  `no_pengenal` varchar(100) DEFAULT NULL,
  `nama_kelas` varchar(100) DEFAULT NULL,
  `nama_setoran` varchar(100) DEFAULT NULL,
  `ket` varchar(100) DEFAULT NULL,
  `jumlah_setoran` varchar(100) DEFAULT NULL,
  `jumlah_penarikan` varchar(100) DEFAULT NULL,
  `tanggal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `jenis_setoran`
--
ALTER TABLE `jenis_setoran`
  ADD PRIMARY KEY (`id_js`);

--
-- Indeks untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id_jur`);

--
-- Indeks untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kel`),
  ADD KEY `fk_kelas_jurusan` (`id_jur`);

--
-- Indeks untuk tabel `nasabah`
--
ALTER TABLE `nasabah`
  ADD PRIMARY KEY (`id_nasabah`);

--
-- Indeks untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Indeks untuk tabel `penarikan`
--
ALTER TABLE `penarikan`
  ADD PRIMARY KEY (`id_penarikan`);

--
-- Indeks untuk tabel `setoran`
--
ALTER TABLE `setoran`
  ADD PRIMARY KEY (`id_setoran`);

--
-- Indeks untuk tabel `tanda_pengenal`
--
ALTER TABLE `tanda_pengenal`
  ADD PRIMARY KEY (`id_tp`);

--
-- Indeks untuk tabel `tarik_bayar`
--
ALTER TABLE `tarik_bayar`
  ADD PRIMARY KEY (`id_tarik`);

--
-- Indeks untuk tabel `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD KEY `fk_admin_user` (`id_user`);

--
-- Indeks untuk tabel `tbl_pengawas`
--
ALTER TABLE `tbl_pengawas`
  ADD PRIMARY KEY (`id_pengawas`),
  ADD UNIQUE KEY `uq_pengawas_user` (`id_user`);

--
-- Indeks untuk tabel `tbl_tipe_user`
--
ALTER TABLE `tbl_tipe_user`
  ADD PRIMARY KEY (`id_tipe_user`),
  ADD UNIQUE KEY `tipe_user` (`tipe_user`);

--
-- Indeks untuk tabel `tbl_tipe_users`
--
ALTER TABLE `tbl_tipe_users`
  ADD PRIMARY KEY (`id_tipe_user`);

--
-- Indeks untuk tabel `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `fk_users_tipe_user` (`role`);

--
-- Indeks untuk tabel `total_tarikbayar`
--
ALTER TABLE `total_tarikbayar`
  ADD PRIMARY KEY (`id_total`);

--
-- Indeks untuk tabel `transaksi_semua`
--
ALTER TABLE `transaksi_semua`
  ADD PRIMARY KEY (`id_semua`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `jenis_setoran`
--
ALTER TABLE `jenis_setoran`
  MODIFY `id_js` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  MODIFY `id_jur` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kel` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `penarikan`
--
ALTER TABLE `penarikan`
  MODIFY `id_penarikan` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `setoran`
--
ALTER TABLE `setoran`
  MODIFY `id_setoran` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tanda_pengenal`
--
ALTER TABLE `tanda_pengenal`
  MODIFY `id_tp` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tarik_bayar`
--
ALTER TABLE `tarik_bayar`
  MODIFY `id_tarik` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_admin`
--
ALTER TABLE `tbl_admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT untuk tabel `tbl_pengawas`
--
ALTER TABLE `tbl_pengawas`
  MODIFY `id_pengawas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tbl_tipe_user`
--
ALTER TABLE `tbl_tipe_user`
  MODIFY `id_tipe_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_tipe_users`
--
ALTER TABLE `tbl_tipe_users`
  MODIFY `id_tipe_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=424;

--
-- AUTO_INCREMENT untuk tabel `total_tarikbayar`
--
ALTER TABLE `total_tarikbayar`
  MODIFY `id_total` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi_semua`
--
ALTER TABLE `transaksi_semua`
  MODIFY `id_semua` int(10) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `fk_kelas_jurusan` FOREIGN KEY (`id_jur`) REFERENCES `jurusan` (`id_jur`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD CONSTRAINT `fk_admin_user` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id_user`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pengawas`
--
ALTER TABLE `tbl_pengawas`
  ADD CONSTRAINT `fk_pengawas_user` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD CONSTRAINT `fk_users_tipe_user` FOREIGN KEY (`role`) REFERENCES `tbl_tipe_users` (`id_tipe_user`) ON DELETE SET NULL ON UPDATE CASCADE;
--
-- Database: `db_profile_company`
--
CREATE DATABASE IF NOT EXISTS `db_profile_company` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_profile_company`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'Rekayasa Prangkat Lunak', '2026-11-14 06:44:50.849', '2026-11-14 06:45:26.825');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan`
--

CREATE TABLE `jurusan` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `role` varchar(191) NOT NULL DEFAULT 'staff',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  `token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `role`, `created_at`, `updated_at`, `token`) VALUES
(1, 'Asep Suherman', 'admin@example.com', 'scrypt$dedc99f03ef9019eda15ba2bcdbe7a7e$045b48737ca2be7189792949c9a7a4d3cce6df09e929c7cc790dcfa4874e4cc7697d7436bd8cc05e21512f0e06c52c06d875e8a912eef7f76480cf0ad70ac2c4', 'admin', '2026-11-13 23:56:30.000', '2026-11-14 05:07:04.312', NULL),
(6, 'Dudung', 'staff@gmail.com', 'scrypt$6d87d2b25ffdea306dc37971c5e34325$1fe64fc85027d53d37f078374009672917d6196f00d274dc3e521990358e27b816d2897871d17be5805376cedbeef79bc72e1810339d75591ecbb35ba88cfd40', 'staff', '2026-11-14 04:35:38.572', '2026-11-18 05:49:46.271', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2IiwiZW1haWwiOiJzdGFmZkBnbWFpbC5jb20iLCJmdWxsbmFtZSI6IkR1ZHVuZyIsInJvbGUiOiJzdGFmZiIsImlhdCI6MTc5NDk4MDk4NiwiZXhwIjoxNzk1MDY3Mzg2fQ.A3Puh-WhCMH1OZA5zagQN9xFL8bd9iGIiBOiMIntvZg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('16a39672-2fb5-4f6c-894b-59305afc7103', '2f590be635c425dbc6d040ae98e26093161d2501fd5905fb7f92d616503ab623', '2026-11-13 16:56:02.579', '20261113165602_add_token_to_user', NULL, NULL, '2026-11-13 16:56:02.561', 1),
('f86634f7-efa5-4732-ab92-46f761dcbb3d', 'a0ab786c0a0f4c2d73e4bdc7e8e812462bd37fc56130958b9ca8d1a0ed219def', '2026-11-13 00:18:46.089', '20261027011826_init', NULL, NULL, '2026-11-13 00:18:46.037', 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_key` (`email`);

--
-- Indeks untuk tabel `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- Database: `db_ukksmt3_bagas`
--
CREATE DATABASE IF NOT EXISTS `db_ukksmt3_bagas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_ukksmt3_bagas`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan`
--

CREATE TABLE `jurusan` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_facility`
--

CREATE TABLE `tbl_facility` (
  `kode_facility` varchar(20) NOT NULL,
  `nama_facility` varchar(191) NOT NULL,
  `create_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `update_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_facility`
--

INSERT INTO `tbl_facility` (`kode_facility`, `nama_facility`, `create_at`, `update_at`) VALUES
('FCT001', '30 m2 (30 meter persegi)', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT002', '40 m2 (40 meter persegi)', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT003', 'TV 32 Inchi', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT004', 'One-Bedroom', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT005', 'Two-Bedroom', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT006', 'Living room', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT007', 'Fully equipped kitchen', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT008', 'Refrigerator, stove, microwave', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT009', 'On-site laundry', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT010', 'Private Balcony', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT011', 'Air conditioning (AC)', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT012', 'High-speed internet', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT013', '24-hour security', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT014', 'Parking', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT015', 'Cleanning Room Service', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT016', 'Breakfast', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
('FCT017', 'Loundry Service', '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_type_unit`
--

CREATE TABLE `tbl_type_unit` (
  `id_unit_type` int(11) NOT NULL,
  `nama_type_unit` varchar(191) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `create_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `update_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_type_unit`
--

INSERT INTO `tbl_type_unit` (`id_unit_type`, `nama_type_unit`, `branch_id`, `create_at`, `update_at`) VALUES
(1, 'Studio', 1, '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
(2, 'Alcove', 1, '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
(3, 'Konvertibel', 1, '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
(4, 'Junior One', 1, '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
(5, 'gfhjk', 1, '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
(6, 'Alcove', 2, '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
(7, 'Kamr bulan Madu', 1, '2026-11-23 22:54:12.000', '2026-11-23 22:54:12.000'),
(9, 'Penthouse', 2, '2026-11-23 16:30:16.937', '2026-11-23 16:30:16.937');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_type_unit_facility`
--

CREATE TABLE `tbl_type_unit_facility` (
  `id_unit_type` int(11) NOT NULL,
  `kode_facility` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_type_unit_facility`
--

INSERT INTO `tbl_type_unit_facility` (`id_unit_type`, `kode_facility`) VALUES
(1, 'FCT001'),
(1, 'FCT003'),
(1, 'FCT004'),
(9, 'FCT001'),
(9, 'FCT002'),
(9, 'FCT003'),
(9, 'FCT005'),
(9, 'FCT006'),
(9, 'FCT007'),
(9, 'FCT008'),
(9, 'FCT009'),
(9, 'FCT010'),
(9, 'FCT011'),
(9, 'FCT012'),
(9, 'FCT013'),
(9, 'FCT014'),
(9, 'FCT015'),
(9, 'FCT016'),
(9, 'FCT017');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `role` varchar(191) NOT NULL DEFAULT 'staff',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(2, 'admin', 'admin@gmail.com', 'scrypt:fa037b8762713a38975477453b565b36:14648af76c0adfad2e12612f2f1254c4706d586991caa50f6ec5abfd66e77372bc5c5d411520c56d3830e09cdbaac5e77849417dbb1b6555e9e14eb8cc95df3f', 'admin', '2026-11-18 12:43:29.000', '2026-11-18 06:04:20.397'),
(3, 'Asep Suherman', 'agasmaulana562@gmail.com', 'scrypt:27fc731399a807c995b0643aca8ff199:f04db4a81a4bd8c54152769ef29b56fd5f594be2ad740c205e7a4aa7844e1a63270efdbd77bbf964e6f647f605eaf499c40361a184f71b00d946d74952819afc', 'staff', '2026-11-19 08:11:44.785', '2026-11-19 08:11:44.785');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_facility`
--
ALTER TABLE `tbl_facility`
  ADD PRIMARY KEY (`kode_facility`);

--
-- Indeks untuk tabel `tbl_type_unit`
--
ALTER TABLE `tbl_type_unit`
  ADD PRIMARY KEY (`id_unit_type`);

--
-- Indeks untuk tabel `tbl_type_unit_facility`
--
ALTER TABLE `tbl_type_unit_facility`
  ADD PRIMARY KEY (`id_unit_type`,`kode_facility`),
  ADD KEY `tbl_type_unit_facility_kode_facility_fkey` (`kode_facility`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_key` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_type_unit`
--
ALTER TABLE `tbl_type_unit`
  MODIFY `id_unit_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbl_type_unit_facility`
--
ALTER TABLE `tbl_type_unit_facility`
  ADD CONSTRAINT `tbl_type_unit_facility_id_unit_type_fkey` FOREIGN KEY (`id_unit_type`) REFERENCES `tbl_type_unit` (`id_unit_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_type_unit_facility_kode_facility_fkey` FOREIGN KEY (`kode_facility`) REFERENCES `tbl_facility` (`kode_facility`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Dumping data untuk tabel `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"snap_to_grid\":\"off\",\"relation_lines\":\"true\",\"angular_direct\":\"direct\"}');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data untuk tabel `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"db_ukksmt3_bagas\",\"table\":\"tbl_facility\"},{\"db\":\"db_ukksmt3_bagas\",\"table\":\"tbl_type_unit_facility\"},{\"db\":\"db_ukksmt3_bagas\",\"table\":\"tbl_type_unit\"},{\"db\":\"db_apartement_fix\",\"table\":\"tbl_type_unit\"},{\"db\":\"db_apartement_fix\",\"table\":\"tbl_type_unit_facility\"},{\"db\":\"db_ukksmt3_bagas\",\"table\":\"users\"},{\"db\":\"db_ukksmt3_bagas\",\"table\":\"jurusan\"},{\"db\":\"db_ukksmt4_bagas\",\"table\":\"users\"},{\"db\":\"db_bankv4\",\"table\":\"tbl_pengawas\"},{\"db\":\"db_bankv4\",\"table\":\"tbl_tipe_user\"}]');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data untuk tabel `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'db_ukksmt3_bagas', 'users', '{\"sorted_col\":\"`users`.`password` ASC\"}', '2026-11-23 15:41:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data untuk tabel `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-11-23 17:04:11', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"id\"}');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Struktur dari tabel `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indeks untuk tabel `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indeks untuk tabel `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indeks untuk tabel `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indeks untuk tabel `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indeks untuk tabel `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indeks untuk tabel `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indeks untuk tabel `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indeks untuk tabel `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indeks untuk tabel `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indeks untuk tabel `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indeks untuk tabel `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
