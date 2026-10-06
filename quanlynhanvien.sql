SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `quanlybanhanglinhkien`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `quanlybanhanglinhkien`;

DROP TABLE IF EXISTS `serial_imei`;
DROP TABLE IF EXISTS `chitiethoadon`;
DROP TABLE IF EXISTS `chitietphieunhap`;
DROP TABLE IF EXISTS `hoadon`;
DROP TABLE IF EXISTS `chitietphieunhap`;
DROP TABLE IF EXISTS `phieunhap`;
DROP TABLE IF EXISTS `sanpham`;
DROP TABLE IF EXISTS `khachhang`;
DROP TABLE IF EXISTS `nhacungcap`;
DROP TABLE IF EXISTS `nhanvien`;
DROP TABLE IF EXISTS `loaisanpham`;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `chitiethoadon` (
  `MaHD` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `SoLuong` int(11) DEFAULT NULL CHECK (`SoLuong` > 0),
  `DonGia` decimal(18,2) DEFAULT NULL CHECK (`DonGia` >= 0),
  `GiaGiam` decimal(18,2) DEFAULT 0.00,
  `ThanhTien` decimal(18,2) GENERATED ALWAYS AS ((`DonGia` - `GiaGiam`) * `SoLuong`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `chitietphieunhap`
CREATE TABLE `chitietphieunhap` (
  `MaPN` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `SoLuong` int(11) DEFAULT NULL CHECK (`SoLuong` > 0),
  `DonGiaNhap` decimal(18,2) DEFAULT NULL CHECK (`DonGiaNhap` >= 0),
  `ThanhTien` decimal(18,2) GENERATED ALWAYS AS (`SoLuong` * `DonGiaNhap`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `hoadon`
CREATE TABLE `hoadon` (
  `MaHD` int(11) NOT NULL,
  `MaKH` int(11) DEFAULT NULL,
  `MaNV` int(11) NOT NULL,
  `NgayLap` datetime DEFAULT current_timestamp(),
  `TongTien` decimal(18,2) DEFAULT 0.00,
  `PhuongThucThanhToan` varchar(50) DEFAULT 'Tiền mặt',
  `TrangThai` varchar(50) DEFAULT 'Đã thanh toán'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `khachhang`
CREATE TABLE `khachhang` (
  `MaKH` int(11) NOT NULL,
  `HoTen` varchar(100) NOT NULL,
  `SoDienThoai` varchar(15) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `DiemTichLuy` int(11) DEFAULT 0,
  `HangThanhVien` varchar(50) DEFAULT 'Đồng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `loaisanpham`
CREATE TABLE `loaisanpham` (
  `MaLoai` int(11) NOT NULL,
  `TenLoai` varchar(100) NOT NULL,
  `MoTa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `nhacungcap`
CREATE TABLE `nhacungcap` (
  `MaNCC` int(11) NOT NULL,
  `TenNCC` varchar(150) NOT NULL,
  `SoDienThoai` varchar(15) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `nhanvien`
CREATE TABLE `nhanvien` (
  `MaNV` int(11) NOT NULL,
  `HoTen` varchar(100) NOT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `ChucVu` varchar(50) NOT NULL,
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `TrangThai` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `phieunhap`
CREATE TABLE `phieunhap` (
  `MaPN` int(11) NOT NULL,
  `MaNCC` int(11) NOT NULL,
  `MaNV` int(11) NOT NULL,
  `NgayNhap` datetime DEFAULT current_timestamp(),
  `TongTien` decimal(18,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `sanpham`
CREATE TABLE `sanpham` (
  `MaSP` int(11) NOT NULL,
  `TenSP` varchar(200) NOT NULL,
  `MaLoai` int(11) NOT NULL,
  `HangSanXuat` varchar(100) NOT NULL,
  `ThoiGianBaoHanh` int(11) DEFAULT 12,
  `GiaNhap` decimal(18,2) DEFAULT NULL CHECK (`GiaNhap` >= 0),
  `GiaBan` decimal(18,2) DEFAULT NULL CHECK (`GiaBan` >= 0),
  `SoLuongTon` int(11) DEFAULT 0,
  `ThongSoKyThuat` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `serial_imei`
CREATE TABLE `serial_imei` (
  `SoSerial` varchar(100) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `MaPN` int(11) NOT NULL,
  `MaHD` int(11) DEFAULT NULL,
  `TrangThai` varchar(50) DEFAULT 'TrongKho'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Chỉ mục cho bảng `chitiethoadon`
ALTER TABLE `chitiethoadon`
  ADD PRIMARY KEY (`MaHD`,`MaSP`),
  ADD KEY `FK_CTHD_SanPham` (`MaSP`);

-- Chỉ mục cho bảng `chitietphieunhap`
ALTER TABLE `chitietphieunhap`
  ADD PRIMARY KEY (`MaPN`,`MaSP`),
  ADD KEY `FK_CTPN_SanPham` (`MaSP`);

-- Chỉ mục cho bảng `hoadon`
ALTER TABLE `hoadon`
  ADD PRIMARY KEY (`MaHD`),
  ADD KEY `FK_HoaDon_KhachHang` (`MaKH`),
  ADD KEY `FK_HoaDon_NhanVien` (`MaNV`);

-- Chỉ mục cho bảng `khachhang`
ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`MaKH`),
  ADD UNIQUE KEY `SoDienThoai` (`SoDienThoai`);

-- Chỉ mục cho bảng `loaisanpham`
ALTER TABLE `loaisanpham`
  ADD PRIMARY KEY (`MaLoai`);

-- Chỉ mục cho bảng `nhacungcap`
ALTER TABLE `nhacungcap`
  ADD PRIMARY KEY (`MaNCC`),
  ADD UNIQUE KEY `SoDienThoai` (`SoDienThoai`);

-- Chỉ mục cho bảng `nhanvien`
ALTER TABLE `nhanvien`
  ADD PRIMARY KEY (`MaNV`),
  ADD UNIQUE KEY `TenDangNhap` (`TenDangNhap`),
  ADD UNIQUE KEY `Email` (`Email`);

-- Chỉ mục cho bảng `phieunhap`
ALTER TABLE `phieunhap`
  ADD PRIMARY KEY (`MaPN`),
  ADD KEY `FK_PhieuNhap_NhaCungCap` (`MaNCC`),
  ADD KEY `FK_PhieuNhap_NhanVien` (`MaNV`);

-- Chỉ mục cho bảng `sanpham`
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`MaSP`),
  ADD KEY `FK_SanPham_LoaiSanPham` (`MaLoai`);

-- Chỉ mục cho bảng `serial_imei`
ALTER TABLE `serial_imei`
  ADD PRIMARY KEY (`SoSerial`),
  ADD KEY `FK_Serial_SanPham` (`MaSP`),
  ADD KEY `FK_Serial_PhieuNhap` (`MaPN`),
  ADD KEY `FK_Serial_HoaDon` (`MaHD`);


ALTER TABLE `hoadon`
  MODIFY `MaHD` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `khachhang`
ALTER TABLE `khachhang`
  MODIFY `MaKH` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `loaisanpham`
ALTER TABLE `loaisanpham`
  MODIFY `MaLoai` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `nhacungcap`
ALTER TABLE `nhacungcap`
  MODIFY `MaNCC` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `nhanvien`
ALTER TABLE `nhanvien`
  MODIFY `MaNV` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `phieunhap`
ALTER TABLE `phieunhap`
  MODIFY `MaPN` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `sanpham`
ALTER TABLE `sanpham`
  MODIFY `MaSP` int(11) NOT NULL AUTO_INCREMENT;

-- Các ràng buộc cho bảng `chitiethoadon`
ALTER TABLE `chitiethoadon`
  ADD CONSTRAINT `FK_CTHD_HoaDon` FOREIGN KEY (`MaHD`) REFERENCES `hoadon` (`MaHD`),
  ADD CONSTRAINT `FK_CTHD_SanPham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

-- Các ràng buộc cho bảng `chitietphieunhap`
--
ALTER TABLE `chitietphieunhap`
  ADD CONSTRAINT `FK_CTPN_PhieuNhap` FOREIGN KEY (`MaPN`) REFERENCES `phieunhap` (`MaPN`),
  ADD CONSTRAINT `FK_CTPN_SanPham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

-- Các ràng buộc cho bảng `hoadon`
ALTER TABLE `hoadon`
  ADD CONSTRAINT `FK_HoaDon_KhachHang` FOREIGN KEY (`MaKH`) REFERENCES `khachhang` (`MaKH`),
  ADD CONSTRAINT `FK_HoaDon_NhanVien` FOREIGN KEY (`MaNV`) REFERENCES `nhanvien` (`MaNV`);

-- Các ràng buộc cho bảng `phieunhap`
ALTER TABLE `phieunhap`
  ADD CONSTRAINT `FK_PhieuNhap_NhaCungCap` FOREIGN KEY (`MaNCC`) REFERENCES `nhacungcap` (`MaNCC`),
  ADD CONSTRAINT `FK_PhieuNhap_NhanVien` FOREIGN KEY (`MaNV`) REFERENCES `nhanvien` (`MaNV`);

-- Các ràng buộc cho bảng `sanpham`
ALTER TABLE `sanpham`
  ADD CONSTRAINT `FK_SanPham_LoaiSanPham` FOREIGN KEY (`MaLoai`) REFERENCES `loaisanpham` (`MaLoai`);

-- Các ràng buộc cho bảng `serial_imei`
ALTER TABLE `serial_imei`
  ADD CONSTRAINT `FK_Serial_HoaDon` FOREIGN KEY (`MaHD`) REFERENCES `hoadon` (`MaHD`),
  ADD CONSTRAINT `FK_Serial_PhieuNhap` FOREIGN KEY (`MaPN`) REFERENCES `phieunhap` (`MaPN`),
  ADD CONSTRAINT `FK_Serial_SanPham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);
COMMIT;

-- Khôi phục kiểm tra khóa ngoại
SET FOREIGN_KEY_CHECKS = 1;
