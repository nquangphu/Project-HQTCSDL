CREATE DATABASE ONLINESHOP
GO
USE ONLINESHOP
GO 
/*==============================================================*/
/* Table: TAIKHOAN                                              */
/*==============================================================*/
create table TAIKHOAN (
   MATK                bigint             not null IDENTITY(1,1),
   USERNAME             char(30)             not NULL,
   PASS                 char(30)             null,
   ISSTAFF              bit                  null,
   ISSUPERUSER          bit                  null,
   SDT                  char(15)             null,
   EMAIL                varchar(50)          null,
   DIACHI               varchar(100)         null,
   ISACTIVE             BIT                  null,
   constraint PK_TAIKHOAN primary key nonclustered (MATK),
    CONSTRAINT AK_USERNAME_TK UNIQUE(USERNAME) 
)
go
/*==============================================================*/
/* Table: DOITAC                                                */
/*==============================================================*/
create table DOITAC (
   MADT                 bigint             not NULL IDENTITY(1,1),
   MATK					bigint			   NOT NULL UNIQUE,
   MALH                 bigint              NULL,
   MAKV                 bigint				 NULL,
   TENDT                varchar(100)         null,
   DAIDIEN              varchar(30)          null,
   SOCN                 int                  null,
   SLDONHANG            int                  null,
   constraint PK_DOITAC primary key nonclustered (MADT)
)

go

/*==============================================================*/
/* Table: DONHANG                                               */
/*==============================================================*/
create table DONHANG (
   MADH                 bigint             not NULL IDENTITY(1,1),
   MAKH                 bigint             not null,
   MADT					BIGINT             NOT NULL,
   MATX					BIGINT             not null,
   HINHTHUCTT           varchar(20)          null,
   NGAYTAO              datetime             null,
   DIACHIGH             varchar(100)         null,
   PHISP                decimal              null,
   PHISHIP              decimal              null,
   TONGTIEN             decimal              null,
   TRANGTHAISHIP        int                  null,
   constraint PK_DONHANG primary key nonclustered (MADH)
)

go

/*==============================================================*/
/* Table: HOPDONG                                               */
/*==============================================================*/
create table HOPDONG (
   MAHD                 bigint             not null IDENTITY(1,1),
   MADT                 bigint             not null,
   SLCHINHANH           int                  null,
   TGBD                 datetime             null,
   TGKT                 datetime             null,
   HOAHONG              float                null,
   constraint PK_HOPDONG primary key nonclustered (MAHD)
)


go

/*==============================================================*/
/* Table: KHACHHANG                                             */
/*==============================================================*/
create table KHACHHANG (
   MAKH                 bigint             not null IDENTITY(1,1),
   MATK					BIGINT			   NOT NULL UNIQUE,
   constraint PK_KHACHHANG primary key nonclustered (MAKH)
)
go

/*==============================================================*/
/* Table: KHUVUC                                                */
/*==============================================================*/
create table KHUVUC (
   MAKV                 bigint            not NULL IDENTITY(1,1),
   QUAN                 varchar(50)          null,
   TP                   varchar(50)          null,
   constraint PK_KHUVUC primary key nonclustered (MAKV)
)
go

/*==============================================================*/
/* Table: LOAIHANG                                              */
/*==============================================================*/
create table LOAIHANG (
   MALH                 bigint            not NULL IDENTITY(1,1),
   TENLH                varchar(100)         null,
   constraint PK_LOAIHANG primary key nonclustered (MALH)
)
go

/*==============================================================*/
/* Table: QLDONHANG                                             */
/*==============================================================*/
create table QLDONHANG (
   MASP                 bigint             not null,
   MADH                bigint             not null,
   GIASP                decimal              null,
   SLSP                 int                  null,
   THANHTIEN            decimal              null,
   constraint PK_QLDONHANG primary key (MASP, MADH)
)
go


/*==============================================================*/
/* Table: QLSANPHAM                                             */
/*==============================================================*/
create table QLSANPHAM (
   MADT                 bigint             not null,
   MASP                 bigint            not null,
   MACN                 bigint            not null,
   GIASP                decimal              null,
   SLCUNGCAP            int                  null,
   constraint PK_QLSANPHAM primary key (MADT, MASP)
)

go


/*==============================================================*/
/* Table: SANPHAM                                               */
/*==============================================================*/
create table SANPHAM (
   MASP                 bigint            not NULL IDENTITY(1,1),
   MALH                 bigint            not null,
   TENSP                varchar(30)          null,
   constraint PK_SANPHAM primary key nonclustered (MASP)
)
go



/*==============================================================*/
/* Table: CHINHANH                                              */
/*==============================================================*/
create table CHINHANH (
   MACN                 bigint             not NULL IDENTITY(1,1),
   MAHD                 bigint             not null,
   DIACHI               varchar(100)         null,
   constraint PK_CHINHANH primary key nonclustered (MACN)
)
GO
/*==============================================================*/
/* Table: TAIXE                                                 */
/*==============================================================*/
create table TAIXE (
   MATX					bigint				NOT NULL IDENTITY(1,1),
   MATK					bigint			    NOT NULL UNIQUE,
   MAKV					bigint				NULL,
   CMND                 char(15)             null,
   DIACHI               varchar(100)         null,
   BIENSO               char(10)             null,
   STK                  varchar(30)          null,
   NGANHANG             varchar(50)          null,
   constraint PK_TAIXE primary key nonclustered (MATX)
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



