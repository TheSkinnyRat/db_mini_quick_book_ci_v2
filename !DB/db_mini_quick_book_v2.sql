-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 25 Okt 2018 pada 08.04
-- Versi Server: 10.1.30-MariaDB
-- PHP Version: 5.6.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_mini_quick_book_v2`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang`
--

CREATE TABLE `tbl_barang` (
  `kd_barang` int(20) NOT NULL,
  `deskripsi_barang` text NOT NULL,
  `spesifikasi_barang` text NOT NULL,
  `stock` int(10) NOT NULL,
  `hrg_modal` decimal(20,0) NOT NULL,
  `hrg_jual` decimal(20,0) NOT NULL,
  `diskon` varchar(10) NOT NULL,
  `status` enum('1','0') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang`
--

INSERT INTO `tbl_barang` (`kd_barang`, `deskripsi_barang`, `spesifikasi_barang`, `stock`, `hrg_modal`, `hrg_jual`, `diskon`, `status`) VALUES
(111, 'zzz', 'zzz', 54, '111', '111', '0', '1');

--
-- Trigger `tbl_barang`
--
DELIMITER $$
CREATE TRIGGER `after_insert` AFTER INSERT ON `tbl_barang` FOR EACH ROW INSERT INTO tbl_log (ket, user, new_data)
VALUES (CONCAT('insert data ke tbl_barang, kd_barang = ',NEW.kd_barang), USER(), CONCAT('Kode Barang : ',NEW.kd_barang ,'<br> Deskripsi Barang : ',NEW.deskripsi_barang,'<br> Spesifikasi Barang : ',NEW.spesifikasi_barang,'<br> Stock : ',NEW.stock,'<br> Harga Modal : ',NEW.hrg_modal,'<br> Harga Jual : ',NEW.hrg_jual,'<br> Diskon : ',NEW.diskon,'<br> Status : ',NEW.status))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update` AFTER UPDATE ON `tbl_barang` FOR EACH ROW INSERT INTO tbl_log (ket, user, old_data, new_data)
VALUES (CONCAT('Update data ke tbl_barang, kd_barang = ',NEW.kd_barang), USER(),CONCAT('Kode Barang : ',old.kd_barang ,'<br> Deskripsi Barang : ',old.deskripsi_barang,'<br> Spesifikasi Barang : ',old.spesifikasi_barang,'<br> Stock : ',old.stock,'<br> Harga Modal : ',old.hrg_modal,'<br> Harga Jual : ',old.hrg_jual,'<br> Diskon : ',old.diskon,'<br> Status : ',old.status), CONCAT('Kode Barang : ',NEW.kd_barang ,'<br> Deskripsi Barang : ',NEW.deskripsi_barang,'<br> Spesifikasi Barang : ',NEW.spesifikasi_barang,'<br> Stock : ',NEW.stock,'<br> Harga Modal : ',NEW.hrg_modal,'<br> Harga Jual : ',NEW.hrg_jual,'<br> Diskon : ',NEW.diskon,'<br> Status : ',NEW.status))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `setelah_hapus` BEFORE DELETE ON `tbl_barang` FOR EACH ROW INSERT INTO tbl_log (ket, user, old_data)
VALUES (CONCAT('Delete data dari tbl_barang, kd_barang = ',old.kd_barang), USER(), CONCAT('Kode Barang : ',old.kd_barang ,'<br> Deskripsi Barang : ',old.deskripsi_barang,'<br> Spesifikasi Barang : ',old.spesifikasi_barang,'<br> Stock : ',old.stock,'<br> Harga Modal : ',old.hrg_modal,'<br> Harga Jual : ',old.hrg_jual,'<br> Diskon : ',old.diskon,'<br> Status : ',old.status))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_beli`
--

CREATE TABLE `tbl_beli` (
  `kd_pembelian` int(20) NOT NULL,
  `pembeli` varchar(10) NOT NULL,
  `kd_barang` int(20) NOT NULL,
  `deskripsi_barang` text NOT NULL,
  `spesifikasi_barang` text NOT NULL,
  `jumlah` varchar(10) NOT NULL,
  `harga_satuan` decimal(30,0) NOT NULL,
  `harga_total` decimal(30,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_beli`
--

INSERT INTO `tbl_beli` (`kd_pembelian`, `pembeli`, `kd_barang`, `deskripsi_barang`, `spesifikasi_barang`, `jumlah`, `harga_satuan`, `harga_total`) VALUES
(24, 'qwe', 111, 'zzz', 'zzz', '2', '111', '222');

--
-- Trigger `tbl_beli`
--
DELIMITER $$
CREATE TRIGGER `auto_update_stock` AFTER INSERT ON `tbl_beli` FOR EACH ROW update tbl_barang set stock = stock - NEW.jumlah WHERE kd_barang = NEW.kd_barang
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete` BEFORE DELETE ON `tbl_beli` FOR EACH ROW INSERT INTO tbl_log_bayar (ket, kd_pembelian, kd_barang, pembeli, deskripsi_barang, spesifikasi_barang, jumlah, hrg_satuan, hrg_total)
VALUES ('0', old.kd_pembelian, old.kd_barang, old.pembeli, old.deskripsi_barang, old.spesifikasi_barang, old.jumlah, old.harga_satuan, old.harga_total)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_log`
--

CREATE TABLE `tbl_log` (
  `ket` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` varchar(50) NOT NULL DEFAULT '',
  `old_data` varchar(10000) NOT NULL DEFAULT '',
  `new_data` varchar(10000) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_log`
--

INSERT INTO `tbl_log` (`ket`, `datetime`, `user`, `old_data`, `new_data`) VALUES
('insert data ke tbl_barang, kd_barang = 1', '2018-08-17 07:27:18', 'root@localhost', '', 'Kode Barang : 1<br> Deskripsi Barang : handphone<br> Spesifikasi Barang : samsung<br> Stock : 200<br> Harga Modal : 1000000<br> Harga Jual : 1200000<br> Diskon : 0<br> Status : 1'),
('insert data ke tbl_barang, kd_barang = 2', '2018-08-17 07:27:48', 'root@localhost', '', 'Kode Barang : 2<br> Deskripsi Barang : laptop<br> Spesifikasi Barang : asus<br> Stock : 300<br> Harga Modal : 3000000<br> Harga Jual : 3500000<br> Diskon : 0<br> Status : 1'),
('insert data ke tbl_barang, kd_barang = 3', '2018-08-17 07:28:20', 'root@localhost', '', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 10<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 3', '2018-08-17 07:28:30', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 10<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 0<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 10<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 1', '2018-08-17 07:29:52', 'root@localhost', 'Kode Barang : 1<br> Deskripsi Barang : handphone<br> Spesifikasi Barang : samsung<br> Stock : 200<br> Harga Modal : 1000000<br> Harga Jual : 1200000<br> Diskon : 0<br> Status : 1', 'Kode Barang : 1<br> Deskripsi Barang : handphone<br> Spesifikasi Barang : samsung<br> Stock : 199<br> Harga Modal : 1000000<br> Harga Jual : 1200000<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 2', '2018-08-17 07:32:03', 'root@localhost', 'Kode Barang : 2<br> Deskripsi Barang : laptop<br> Spesifikasi Barang : asus<br> Stock : 300<br> Harga Modal : 3000000<br> Harga Jual : 3500000<br> Diskon : 0<br> Status : 1', 'Kode Barang : 2<br> Deskripsi Barang : laptop<br> Spesifikasi Barang : asus<br> Stock : 0<br> Harga Modal : 3000000<br> Harga Jual : 3500000<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 3', '2018-08-17 07:34:15', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 10<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 9<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 1', '2018-08-17 07:51:57', 'root@localhost', 'Kode Barang : 1<br> Deskripsi Barang : handphone<br> Spesifikasi Barang : samsung<br> Stock : 199<br> Harga Modal : 1000000<br> Harga Jual : 1200000<br> Diskon : 0<br> Status : 1', 'Kode Barang : 1<br> Deskripsi Barang : handphone<br> Spesifikasi Barang : samsung<br> Stock : 198<br> Harga Modal : 1000000<br> Harga Jual : 1200000<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 3', '2018-08-19 15:18:58', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 9<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 8<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 1', '2018-09-02 00:59:55', 'root@localhost', 'Kode Barang : 1<br> Deskripsi Barang : handphone<br> Spesifikasi Barang : samsung<br> Stock : 198<br> Harga Modal : 1000000<br> Harga Jual : 1200000<br> Diskon : 0<br> Status : 1', 'Kode Barang : 1<br> Deskripsi Barang : handphone<br> Spesifikasi Barang : samsung<br> Stock : 197<br> Harga Modal : 1000000<br> Harga Jual : 1200000<br> Diskon : 0<br> Status : 1'),
('insert data ke tbl_barang, kd_barang = 0', '2018-09-02 02:03:00', 'root@localhost', '', 'Kode Barang : 0<br> Deskripsi Barang : dfs<br> Spesifikasi Barang : fds<br> Stock : 1<br> Harga Modal : 1<br> Harga Jual : 1<br> Diskon : 1<br> Status : 1'),
('Delete data dari tbl_barang, kd_barang = 0', '2018-09-02 02:03:02', 'root@localhost', 'Kode Barang : 0<br> Deskripsi Barang : dfs<br> Spesifikasi Barang : fds<br> Stock : 1<br> Harga Modal : 1<br> Harga Jual : 1<br> Diskon : 1<br> Status : 1', ''),
('Update data ke tbl_barang, kd_barang = 3', '2018-09-02 02:17:19', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 8<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 7<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 3', '2018-09-02 02:19:55', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 7<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 6<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Delete data dari tbl_barang, kd_barang = 1', '2018-09-02 14:39:10', 'root@localhost', 'Kode Barang : 1<br> Deskripsi Barang : handphone<br> Spesifikasi Barang : samsung<br> Stock : 197<br> Harga Modal : 1000000<br> Harga Jual : 1200000<br> Diskon : 0<br> Status : 1', ''),
('Update data ke tbl_barang, kd_barang = 3', '2018-09-02 14:58:36', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 6<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 5<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 2', '2018-09-18 00:46:22', 'root@localhost', 'Kode Barang : 2<br> Deskripsi Barang : laptop<br> Spesifikasi Barang : asus<br> Stock : 0<br> Harga Modal : 3000000<br> Harga Jual : 3500000<br> Diskon : 0<br> Status : 1', 'Kode Barang : 2<br> Deskripsi Barang : laptop<br> Spesifikasi Barang : asus<br> Stock : 0<br> Harga Modal : 3000000<br> Harga Jual : 3500000<br> Diskon : 0<br> Status : 1'),
('Delete data dari tbl_barang, kd_barang = 2', '2018-09-18 00:46:27', 'root@localhost', 'Kode Barang : 2<br> Deskripsi Barang : laptop<br> Spesifikasi Barang : asus<br> Stock : 0<br> Harga Modal : 3000000<br> Harga Jual : 3500000<br> Diskon : 0<br> Status : 1', ''),
('Update data ke tbl_barang, kd_barang = 3', '2018-09-18 00:48:28', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 5<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 4<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 3', '2018-09-18 05:21:12', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 4<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 4<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 3', '2018-09-18 05:22:39', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 4<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 3<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('insert data ke tbl_barang, kd_barang = 111', '2018-09-24 13:52:19', 'root@localhost', '', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 111<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 0'),
('Update data ke tbl_barang, kd_barang = 3', '2018-09-24 13:52:24', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 3<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 3<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 0'),
('Update data ke tbl_barang, kd_barang = 3', '2018-09-24 13:52:29', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 3<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 0', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 3<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1'),
('Delete data dari tbl_barang, kd_barang = 3', '2018-09-24 13:53:27', 'root@localhost', 'Kode Barang : 3<br> Deskripsi Barang : monitor<br> Spesifikasi Barang : benq<br> Stock : 3<br> Harga Modal : 2000000<br> Harga Jual : 2100000<br> Diskon : 10<br> Status : 1', ''),
('insert data ke tbl_barang, kd_barang = 2', '2018-09-30 03:06:24', 'root@localhost', '', 'Kode Barang : 2<br> Deskripsi Barang : qq<br> Spesifikasi Barang : qq<br> Stock : 22<br> Harga Modal : 2222<br> Harga Jual : 2222<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-09-30 03:07:22', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 111<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 0', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 111<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-09-30 03:07:53', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 111<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 110<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 12:49:02', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 110<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 109<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 14:50:34', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 109<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 108<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 14:50:44', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 108<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 106<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 15:02:53', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 106<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 105<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 15:02:57', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 105<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 103<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 15:03:01', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 103<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 100<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 16:04:51', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 100<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 94<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 16:04:56', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 94<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 87<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 16:05:00', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 87<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 79<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-01 16:05:04', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 79<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 70<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-02 00:06:09', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 70<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 65<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Delete data dari tbl_barang, kd_barang = 2', '2018-10-02 07:38:15', 'root@localhost', 'Kode Barang : 2<br> Deskripsi Barang : qq<br> Spesifikasi Barang : qq<br> Stock : 22<br> Harga Modal : 2222<br> Harga Jual : 2222<br> Diskon : 0<br> Status : 1', ''),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-02 08:48:11', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 65<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 64<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-03 02:55:52', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 64<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 63<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-23 04:29:23', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 63<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 62<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-23 04:37:06', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 62<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 61<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-25 05:53:56', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 61<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 60<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-25 05:54:00', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 60<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 58<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-25 05:54:28', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 58<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 57<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-25 05:54:32', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 57<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 56<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1'),
('Update data ke tbl_barang, kd_barang = 111', '2018-10-25 06:03:07', 'root@localhost', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 56<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1', 'Kode Barang : 111<br> Deskripsi Barang : zzz<br> Spesifikasi Barang : zzz<br> Stock : 54<br> Harga Modal : 111<br> Harga Jual : 111<br> Diskon : 0<br> Status : 1');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_login`
--

CREATE TABLE `tbl_login` (
  `ux_user` varchar(10) NOT NULL,
  `ux_pass` varchar(225) NOT NULL,
  `ux_akses` enum('admin','super_admin','member') NOT NULL DEFAULT 'member'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_login`
--

INSERT INTO `tbl_login` (`ux_user`, `ux_pass`, `ux_akses`) VALUES
('123', '202cb962ac59075b964b07152d234b70', 'super_admin'),
('456', '250cf8b51c773f3f8dc8b4be867a9a02', 'admin'),
('789', '68053af2923e00204c3ca7c6a3150cf7', 'member'),
('asd', '7815696ecbf1c96e6894b779456d330e', 'member'),
('asdf', '912ec803b2ce49e4a541068d495ab570', 'member'),
('bnm', 'bd93b91d4a5e9a7a5fcd1fad5b9cb999', 'member'),
('iko', 'c865be5baf7929abcef390311740798f', 'member'),
('qwe', '76d80224611fc919a5d54f0ff9fba446', 'member'),
('tyu', 'af27bab84283536c346b97ced4bc5c58', 'member');

--
-- Trigger `tbl_login`
--
DELIMITER $$
CREATE TRIGGER `seletah_daftar` AFTER INSERT ON `tbl_login` FOR EACH ROW INSERT INTO tbl_log_daftar (ket, data)
VALUES (CONCAT('insert data ke tbl_login, username = ',NEW.ux_user), CONCAT('Username : ',NEW.ux_user ,'<br> Password : ',NEW.ux_pass,'<br> Hak Akses : ',NEW.ux_akses))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_log_bayar`
--

CREATE TABLE `tbl_log_bayar` (
  `ket` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `kd_pembelian` int(20) NOT NULL,
  `kd_barang` int(20) NOT NULL,
  `pembeli` varchar(10) NOT NULL,
  `deskripsi_barang` text NOT NULL,
  `spesifikasi_barang` text NOT NULL,
  `jumlah` varchar(10) NOT NULL,
  `hrg_satuan` decimal(30,0) NOT NULL,
  `hrg_total` decimal(30,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_log_bayar`
--

INSERT INTO `tbl_log_bayar` (`ket`, `datetime`, `kd_pembelian`, `kd_barang`, `pembeli`, `deskripsi_barang`, `spesifikasi_barang`, `jumlah`, `hrg_satuan`, `hrg_total`) VALUES
('1', '2018-10-25 05:54:08', 20, 111, 'qwe', 'zzz', 'zzz', '1', '111', '111'),
('1', '2018-10-25 05:54:15', 21, 111, 'qwe', 'zzz', 'zzz', '2', '111', '222'),
('2', '2018-10-25 05:55:00', 22, 111, 'qwe', 'zzz', 'zzz', '1', '111', '111'),
('0', '2018-10-25 05:55:07', 23, 111, 'qwe', 'zzz', 'zzz', '1', '111', '111');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_log_daftar`
--

CREATE TABLE `tbl_log_daftar` (
  `ket` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_log_daftar`
--

INSERT INTO `tbl_log_daftar` (`ket`, `datetime`, `data`) VALUES
('insert data ke tbl_login, Username = asd', '2018-02-12 07:05:48', 'Username : asd<br> Password : asd<br> Hak Akses : member'),
('insert data ke tbl_login, username = tyu', '2018-02-15 09:52:19', 'Username : tyu<br> Password : af27bab84283536c346b97ced4bc5c58<br> Hak Akses : member'),
('insert data ke tbl_login, username = asd', '2018-07-30 15:14:24', 'Username : asd<br> Password : 7815696ecbf1c96e6894b779456d330e<br> Hak Akses : member'),
('insert data ke tbl_login, username = asdf', '2018-09-02 00:59:39', 'Username : asdf<br> Password : 912ec803b2ce49e4a541068d495ab570<br> Hak Akses : member'),
('insert data ke tbl_login, username = bnm', '2018-09-02 01:49:50', 'Username : bnm<br> Password : bd93b91d4a5e9a7a5fcd1fad5b9cb999<br> Hak Akses : member');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pembayaran`
--

CREATE TABLE `tbl_pembayaran` (
  `id_pembayaran` int(225) NOT NULL,
  `kd_pembelian` int(20) NOT NULL,
  `pembeli` varchar(10) NOT NULL,
  `harga_total` decimal(30,0) NOT NULL,
  `bukti_pembayaran` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pembayaran`
--

INSERT INTO `tbl_pembayaran` (`id_pembayaran`, `kd_pembelian`, `pembeli`, `harga_total`, `bukti_pembayaran`) VALUES
(7, 23, 'qwe', '111', '1016007015_13.JPG');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indexes for table `tbl_beli`
--
ALTER TABLE `tbl_beli`
  ADD PRIMARY KEY (`kd_pembelian`),
  ADD KEY `kd_barang` (`kd_barang`);

--
-- Indexes for table `tbl_login`
--
ALTER TABLE `tbl_login`
  ADD PRIMARY KEY (`ux_user`);

--
-- Indexes for table `tbl_log_bayar`
--
ALTER TABLE `tbl_log_bayar`
  ADD PRIMARY KEY (`kd_pembelian`),
  ADD KEY `kd_pembelian` (`kd_pembelian`),
  ADD KEY `kd_barang` (`kd_barang`),
  ADD KEY `kd_pembelian_2` (`kd_pembelian`);

--
-- Indexes for table `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_beli`
--
ALTER TABLE `tbl_beli`
  MODIFY `kd_pembelian` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  MODIFY `id_pembayaran` int(225) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
