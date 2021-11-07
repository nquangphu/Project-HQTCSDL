CREATE DATABASE ONLINESHOP
GO
USE ONLINESHOP
GO 
/*==============================================================*/
/* Table: TAIKHOAN                                              */
/*==============================================================*/
create table TAIKHOAN (
   MATK                 BIGINT               NOT NULL,
   USERNAME             CHAR(30)             NOT NULL,
   PASS                 CHAR(30)             NOT NULL,
   ISSTAFF              BIT                  NULL,
   ISSUPERUSER          BIT                  NULL,
   SDT                  CHAR(15)             NULL,
   EMAIL                VARCHAR(50)          NULL,
   DIACHI               VARCHAR(100)         NULL,
   ISACTIVE             BIT                  NULL,
   CONSTRAINT PK_TAIKHOAN PRIMARY KEY (MATK),
   CONSTRAINT AK_USERNAME_TK UNIQUE(USERNAME)
)
GO
/*==============================================================*/
/* Table: DOITAC                                                */
/*==============================================================*/
CREATE TABLE DOITAC (
   MADT                 BIGINT             NOT NULL,
   MATK					BIGINT			   NOT NULL UNIQUE,
   MALH                 BIGINT             NULL,
   MAKV                 BIGINT			   NULL,
   TENDT                VARCHAR(100)       NULL,
   DAIDIEN              VARCHAR(30)        NULL,
   SOCHINHANH           INT                NULL,
   SLDONHANG            INT                NULL,
   CONSTRAINT PK_DOITAC PRIMARY KEY (MADT)
)

GO

/*==============================================================*/
/* Table: DONHANG                                               */
/*==============================================================*/
CREATE TABLE DONHANG (
   MADH                 BIGINT             NOT NULL,
   MAKH                 BIGINT             NOT NULL,
   MADT					BIGINT             NOT NULL,
   MATX					BIGINT             NOT NULL,
   HINHTHUCTT           VARCHAR(20)        NULL,
   NGAYTAO              DATETIME           NULL,
   DIACHIGH             VARCHAR(100)       NULL,
   PHISP                DECIMAL(15,2)      NULL,
   PHISHIP              DECIMAL(15,2)      NULL,
   TONGTIEN             DECIMAL(15,2)      NULL,
   TRANGTHAISHIP        INT                NULL,
   TRANGTHAITTOAN		BIT                NULL,
   CONSTRAINT PK_DONHANG PRIMARY KEY (MADH)
)

GO

/*==============================================================*/
/* Table: HOPDONG                                               */
/*==============================================================*/
CREATE TABLE HOPDONG (
   MAHD                 BIGINT             NOT NULL,
   MADT                 BIGINT             NOT NULL,
   SLCHINHANH           INT                NULL,
   TGBD                 DATETIME           NULL,
   TGKT                 DATETIME           NULL,
   HOAHONG              FLOAT              NULL,
   ISACEPTED			BIT				   NULL,
   ISUNEXPIRED			BIT				   NULL,
   CONSTRAINT PK_HOPDONG PRIMARY KEY (MAHD)
)

GO

/*==============================================================*/
/* Table: KHACHHANG                                             */
/*==============================================================*/
CREATE TABLE KHACHHANG (
   MAKH                 BIGINT             NOT NULL,
   MATK					BIGINT			   NOT NULL UNIQUE,
   CONSTRAINT PK_KHACHHANG PRIMARY KEY (MAKH)
)
GO

/*==============================================================*/
/* Table: KHUVUC                                                */
/*==============================================================*/
CREATE TABLE KHUVUC (
   MAKV                 BIGINT               NOT NULL,
   QUAN                 VARCHAR(50)          NULL,
   TP                   VARCHAR(50)          NULL,
   CONSTRAINT PK_KHUVUC PRIMARY KEY (MAKV),
   CONSTRAINT AK_QUAN_TP_KV UNIQUE(QUAN, TP)
)
GO

/*==============================================================*/
/* Table: LOAIHANG                                              */
/*==============================================================*/
CREATE TABLE LOAIHANG (
   MALH                 BIGINT               NOT NULL,
   TENLH                VARCHAR(100)         NULL,
   CONSTRAINT PK_LOAIHANG PRIMARY KEY (MALH)
)
GO

/*==============================================================*/
/* Table: QLDONHANG                                             */
/*==============================================================*/
create table QLDONHANG (
   MASP                 BIGINT             NOT NULL,
   MADH                 BIGINT             NOT NULL,
   GIASP                DECIMAL(15,2)      NULL,
   SLSP                 INT                NULL,
   THANHTIEN            DECIMAL(15,2)      NULL,
   CONSTRAINT PK_QLDONHANG PRIMARY KEY (MASP, MADH)
)
GO


/*==============================================================*/
/* Table: QLSANPHAM                                             */
/*==============================================================*/
CREATE TABLE QLSANPHAM (
   MADT                 BIGINT              NOT NULL,
   MASP                 BIGINT              NOT NULL,
   MACN                 BIGINT              NOT NULL,
   GIASP                DECIMAL(15,2)       NULL,
   SLCUNGCAP            INT                 NULL,
   CONSTRAINT PK_QLSANPHAM PRIMARY KEY (MADT, MASP)
)

GO


/*==============================================================*/
/* Table: SANPHAM                                               */
/*==============================================================*/
CREATE TABLE SANPHAM (
   MASP                 BIGINT            NOT NULL,
   MALH                 BIGINT            NOT null,
   TENSP                VARCHAR(30)       NULL,
   CONSTRAINT PK_SANPHAM PRIMARY KEY (MASP)
)
go



/*==============================================================*/
/* Table: CHINHANH                                              */
/*==============================================================*/
CREATE TABLE CHINHANH (
   MACN                 BIGINT             NOT NULL,
   MAHD                 BIGINT             NOT NULL,
   DIACHI               VARCHAR(100)         null,
   CONSTRAINT PK_CHINHANH PRIMARY KEY (MACN)
)
GO
/*==============================================================*/
/* Table: TAIXE                                                 */
/*==============================================================*/
CREATE TABLE TAIXE (
   MATX					BIGINT				NOT NULL,
   MATK					BIGINT			    NOT NULL UNIQUE,
   MAKV					BIGINT				NOT NULL,
   CMND                 CHAR(15)            NOT NULL UNIQUE,
   DIACHI               VARCHAR(100)        NULL,
   BIENSO               CHAR(10)            NOT NULL,
   STK                  VARCHAR(30)         NULL,
   NGANHANG             VARCHAR(50)         NULL,
   CONSTRAINT PK_TAIXE PRIMARY KEY (MATX)
)

/*==============================================================*/
/*FOREIGN KEY DOITAC_KHUVUC  FOREIGN KEY DOITAC_LOAIHANG        */
/*==============================================================*/
ALTER TABLE dbo.DOITAC ADD CONSTRAINT FK_DT_KV FOREIGN KEY (MAKV) REFERENCES dbo.KHUVUC(MAKV), CONSTRAINT FK_DT_LH FOREIGN KEY (MALH) REFERENCES dbo.LOAIHANG(MALH);


/*==============================================================*/
/*FOREIGN KEY HOPDONG_DOITAC								    */
/*==============================================================*/
ALTER TABLE dbo.HOPDONG ADD CONSTRAINT FK_HD_DT FOREIGN KEY (MADT) REFERENCES dbo.DOITAC(MADT);

/*==============================================================*/
/*FOREIGN KEY CHINHANH_HOPDONG							        */
/*==============================================================*/
ALTER TABLE dbo.CHINHANH ADD CONSTRAINT FK_CN_HD FOREIGN KEY(MAHD) REFERENCES dbo.HOPDONG(MAHD);

/*====================================================================================================*/
/*FOREIGN KEY QLSANPHAM_DOITAC  FOREIGN KEY QLSANPHAM_CHINHANH  FOREIGN KEY QLSANPHAM_SANPHAM         */
/*====================================================================================================*/
ALTER TABLE dbo.QLSANPHAM ADD CONSTRAINT FK_QLSP_DT FOREIGN KEY(MADT) REFERENCES dbo.DOITAC(MADT), CONSTRAINT FK_QLSP_CN FOREIGN KEY(MACN) REFERENCES dbo.CHINHANH(MACN),
CONSTRAINT FK_QLSP_SP FOREIGN KEY(MASP) REFERENCES dbo.SANPHAM(MASP);

/*==============================================================*/
/*FOREIGN KEY SANPHAM_LOAIHANG							        */
/*==============================================================*/
ALTER TABLE dbo.SANPHAM ADD CONSTRAINT FK_SP_LH FOREIGN KEY(MALH) REFERENCES dbo.LOAIHANG(MALH);

/*==================================================================*/
/*FOREIGN KEY QLDONHANG_SANPHAM  FOREIGN KEY QLDONHANG_DONHANG	    */
/*==================================================================*/
ALTER TABLE dbo.QLDONHANG ADD CONSTRAINT FK_QLDH_SP FOREIGN KEY (MASP) REFERENCES dbo.SANPHAM(MASP), CONSTRAINT FK_QLDH_DH FOREIGN KEY(MADH) REFERENCES dbo.DONHANG(MADH);

/*==============================================================*/
/*FOREIGN KEY TAIXE_KHUVUC   							        */
/*==============================================================*/
ALTER TABLE dbo.TAIXE ADD CONSTRAINT FK_TX_KV FOREIGN KEY (MAKV) REFERENCES dbo.KHUVUC(MAKV);

/*===================================================================================================================*/
/*FOREIGN KEY DONHANG_DOITAC	FOREIGN KEY DONHANG_KHACHHANG		FOREIGN KEY DONHANG_TAIXE				        */
/*==================================================================================================================*/

ALTER TABLE dbo.DONHANG ADD CONSTRAINT FK_DH_DT FOREIGN KEY(MADT) REFERENCES dbo.DOITAC(MADT), CONSTRAINT FK_DH_KH FOREIGN KEY(MAKH) REFERENCES dbo.KHACHHANG(MAKH),
CONSTRAINT FK_DH_TX FOREIGN KEY(MATX) REFERENCES dbo.TAIXE(MATX);

/*==============================*/
/*FOREIGN KEY TAIXE_TAIKHOAN*/	
/*=============================*/
ALTER TABLE TAIXE ADD CONSTRAINT FK_TAIXE_INHERITAN_TAIKHOAN FOREIGN KEY (MATK) REFERENCES TAIKHOAN (MATK);
/*==============================*/
/*FOREIGN KEY KHACHHANG_TAIKHOAN*/	
/*=============================*/
ALTER TABLE KHACHHANG ADD CONSTRAINT FK_KHACHHANG_INHERITAN_TAIKHOAN FOREIGN KEY (MATK) REFERENCES TAIKHOAN (MATK);
/*==============================*/
/*FOREIGN KEY DOITAC_TAIKHOAN*/	
/*=============================*/
ALTER TABLE DOITAC ADD CONSTRAINT FK_DOITAC_INHERITAN_TAIKHOAN FOREIGN KEY (MATK) REFERENCES TAIKHOAN (MATK);



