﻿USE ONLINESHOP
GO 
CREATE TABLE DOITAC (
	MADT CHAR(15),
	TENDT NVARCHAR(100),
	DAIDIEN CHAR(15),
	DIACHI NVARCHAR(100),
	SLDH INT,
	MALH CHAR(15),
	DIACHIKD NVARCHAR(100),
	SDT CHAR(15),
	EMAIL VARCHAR(50),
	PRIMARY KEY (MADT),
)
GO 
CREATE TABLE CHINHANH (
	MACN CHAR(15),
	MADT CHAR(15),
	DIACHI NVARCHAR(100),
	PRIMARY KEY(MACN)
)

GO
CREATE TABLE LOAIHANG (
	MALOAI CHAR(15),
	TENLOAI NVARCHAR(20),
	PRIMARY KEY(MALOAI)
)
GO
CREATE TABLE SANPHAM (
	MASP CHAR(15),
	TENSP NVARCHAR(100),
	MALH CHAR(15),
	PRIMARY KEY(MASP)
)
GO
CREATE TABLE HOPDONG (
	MAHD CHAR(15),
	MADT CHAR(15),
	SLCN INT,
	TGBD DATETIME,
	TGKT DATETIME,
	HOAHONG INT,
	PRIMARY KEY (MAHD)
)
GO
CREATE TABLE DANGKI (
	MACN CHAR(15),
	MAHD CHAR(15),
	PRIMARY KEY (MACN,MAHD)
)
GO
CREATE TABLE QLSP(
	MACN CHAR(15),
	MASP CHAR(15),
	PRIMARY KEY (MACN,MASP)
)
GO
-- Tạo bảng khách hàng
CREATE TABLE KHACHHANG (
	MaKH char(15) primary key,
	HoTen nvarchar(100),
	SDT char(15),
	Diachi nvarchar(100),
	Email varchar(50),
)
GO
-- Tạo bảng tài xế
create table TAIXE (
	MaTX char(15) primary key,
	HoTen nvarchar(100),
	CMND char(15),
	SDT char(15),
	Diachi nvarchar(100),
	BienSo char(10),
	KhuVuc nvarchar(100),
	Email varchar(50),
	STK char(20),
	NganHang nvarchar(50)
)
GO
-- Tạo bảng đơn hàng
create table DONHANG (
	MaDH char(15) primary key,
	MaKH char(15),
	MaTX char(15),
	HinhThucTT varchar(10),
	DiaChiGH nvarchar(100),
	PhiSP int,
	PhiShip int,
	TongTien int,
	TrangThai int
)
GO
-- Tạo bảng Sản phẩm đơn hàng
create table SPDH (
	MaDH char(15),
	MaSP char(15),
	SL int
	primary key (MaDH, MaSP)
)
go
ALTER TABLE dbo.DOITAC ADD CONSTRAINT DOITAC_LOAIHANG FOREIGN KEY (MALH) REFERENCES dbo.LOAIHANG(MALOAI)
ALTER TABLE dbo.CHINHANH ADD CONSTRAINT CHINHANH_DOITAC FOREIGN KEY (MADT) REFERENCES dbo.DOITAC(MADT)
ALTER TABLE dbo.HOPDONG ADD CONSTRAINT HOPDONG_DOITAC FOREIGN KEY (MADT) REFERENCES dbo.DOITAC(MADT)
ALTER TABLE dbo.SANPHAM ADD CONSTRAINT SANPHAM_LOAIHANG FOREIGN KEY(MALH) REFERENCES dbo.LOAIHANG(MALOAI)
ALTER TABLE dbo.DANGKI ADD CONSTRAINT DANGKI_CHINHANH FOREIGN KEY(MACN) REFERENCES dbo.CHINHANH(MACN), CONSTRAINT DANGKI_HOPDONG FOREIGN KEY (MAHD) REFERENCES dbo.HOPDONG(MAHD)
ALTER TABLE dbo.QLSP ADD CONSTRAINT QLSP_CHINHANH FOREIGN KEY(MACN) REFERENCES dbo.CHINHANH(MACN), CONSTRAINT QLSP_SANPHAM FOREIGN KEY(MASP) REFERENCES dbo.SANPHAM(MASP)
alter table DONHANG add foreign key (MaKH) references KHACHHANG(MaKH),
	foreign key (MaTX) references TAIXE(MaTX)
alter table SPDH add foreign key (MaDH) references DONHANG(MaDH),
	foreign key (MaSP) references SANPHAM(MaSP)
