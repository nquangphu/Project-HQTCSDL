USE ONLINESHOP
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHINHANH') and o.name = 'FK_CHINHANH_THUOC_HOPDONG')
alter table CHINHANH
   drop constraint FK_CHINHANH_THUOC_HOPDONG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DOITAC') and o.name = 'FK_DOITAC_CUA_LOAIHANG')
alter table DOITAC
   drop constraint FK_DOITAC_CUA_LOAIHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DOITAC') and o.name = 'FK_DOITAC_DT_KV_KHUVUC')
alter table DOITAC
   drop constraint FK_DOITAC_DT_KV_KHUVUC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DOITAC') and o.name = 'FK_DOITAC_INHERITAN_TAIKHOAN')
alter table DOITAC
   drop constraint FK_DOITAC_INHERITAN_TAIKHOAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DONHANG') and o.name = 'FK_DONHANG_DT_DH_DOITAC')
alter table DONHANG
   drop constraint FK_DONHANG_DT_DH_DOITAC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DONHANG') and o.name = 'FK_DONHANG_KH_DH_KHACHHAN')
alter table DONHANG
   drop constraint FK_DONHANG_KH_DH_KHACHHAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DONHANG') and o.name = 'FK_DONHANG_TX_DH_TAIXE')
alter table DONHANG
   drop constraint FK_DONHANG_TX_DH_TAIXE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('HOPDONG') and o.name = 'FK_HOPDONG_DANG_KY_DOITAC')
alter table HOPDONG
   drop constraint FK_HOPDONG_DANG_KY_DOITAC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KHACHHANG') and o.name = 'FK_KHACHHAN_INHERITAN_TAIKHOAN')
alter table KHACHHANG
   drop constraint FK_KHACHHAN_INHERITAN_TAIKHOAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('QLDONHANG') and o.name = 'FK_QLDONHAN_QLDONHANG_SANPHAM')
alter table QLDONHANG
   drop constraint FK_QLDONHAN_QLDONHANG_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('QLDONHANG') and o.name = 'FK_QLDONHAN_QLDONHANG_DONHANG')
alter table QLDONHANG
   drop constraint FK_QLDONHAN_QLDONHANG_DONHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('QLSANPHAM') and o.name = 'FK_QLSANPHA_QLSANPHAM_DOITAC')
alter table QLSANPHAM
   drop constraint FK_QLSANPHA_QLSANPHAM_DOITAC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('QLSANPHAM') and o.name = 'FK_QLSANPHA_QLSANPHAM_SANPHAM')
alter table QLSANPHAM
   drop constraint FK_QLSANPHA_QLSANPHAM_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('QLSANPHAM') and o.name = 'FK_QLSANPHA_QLSANPHAM_CHINHANH')
alter table QLSANPHAM
   drop constraint FK_QLSANPHA_QLSANPHAM_CHINHANH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SANPHAM') and o.name = 'FK_SANPHAM_LH_SP_LOAIHANG')
alter table SANPHAM
   drop constraint FK_SANPHAM_LH_SP_LOAIHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TAIXE') and o.name = 'FK_TAIXE_INHERITAN_TAIKHOAN')
alter table TAIXE
   drop constraint FK_TAIXE_INHERITAN_TAIKHOAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TAIXE') and o.name = 'FK_TAIXE_TX_KV_KHUVUC')
alter table TAIXE
   drop constraint FK_TAIXE_TX_KV_KHUVUC
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHINHANH')
            and   name  = 'RELATIONSHIP_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHINHANH.RELATIONSHIP_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHINHANH')
            and   type = 'U')
   drop table CHINHANH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DOITAC')
            and   name  = 'DT_KV_FK'
            and   indid > 0
            and   indid < 255)
   drop index DOITAC.DT_KV_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DOITAC')
            and   name  = 'RELATIONSHIP_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index DOITAC.RELATIONSHIP_3_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DOITAC')
            and   type = 'U')
   drop table DOITAC
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DONHANG')
            and   name  = 'TX_DH_FK'
            and   indid > 0
            and   indid < 255)
   drop index DONHANG.TX_DH_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DONHANG')
            and   name  = 'KH_DH_FK'
            and   indid > 0
            and   indid < 255)
   drop index DONHANG.KH_DH_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DONHANG')
            and   name  = 'DT_DH_FK'
            and   indid > 0
            and   indid < 255)
   drop index DONHANG.DT_DH_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DONHANG')
            and   type = 'U')
   drop table DONHANG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('HOPDONG')
            and   name  = 'RELATIONSHIP_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index HOPDONG.RELATIONSHIP_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('HOPDONG')
            and   type = 'U')
   drop table HOPDONG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KHACHHANG')
            and   type = 'U')
   drop table KHACHHANG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KHUVUC')
            and   type = 'U')
   drop table KHUVUC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LOAIHANG')
            and   type = 'U')
   drop table LOAIHANG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('QLDONHANG')
            and   name  = 'QLDONHANG2_FK'
            and   indid > 0
            and   indid < 255)
   drop index QLDONHANG.QLDONHANG2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('QLDONHANG')
            and   name  = 'QLDONHANG_FK'
            and   indid > 0
            and   indid < 255)
   drop index QLDONHANG.QLDONHANG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('QLDONHANG')
            and   type = 'U')
   drop table QLDONHANG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('QLSANPHAM')
            and   name  = 'ASSOCIATION_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index QLSANPHAM.ASSOCIATION_3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('QLSANPHAM')
            and   name  = 'ASSOCIATION_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index QLSANPHAM.ASSOCIATION_2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('QLSANPHAM')
            and   name  = 'ASSOCIATION_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index QLSANPHAM.ASSOCIATION_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('QLSANPHAM')
            and   type = 'U')
   drop table QLSANPHAM
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SANPHAM')
            and   name  = 'LH_SP_FK'
            and   indid > 0
            and   indid < 255)
   drop index SANPHAM.LH_SP_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SANPHAM')
            and   type = 'U')
   drop table SANPHAM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TAIKHOAN')
            and   type = 'U')
   drop table TAIKHOAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TAIXE')
            and   name  = 'TX_KV_FK'
            and   indid > 0
            and   indid < 255)
   drop index TAIXE.TX_KV_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TAIXE')
            and   type = 'U')
   drop table TAIXE
go

/*==============================================================*/
/* Table: CHINHANH                                              */
/*==============================================================*/
create table CHINHANH (
   MACN                 char(15)             not null,
   MAHD                 char(15)             not null,
   DIACHI               varchar(100)         null,
   constraint PK_CHINHANH primary key nonclustered (MACN)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on CHINHANH (
MAHD ASC
)
go

/*==============================================================*/
/* Table: DOITAC                                                */
/*==============================================================*/
create table DOITAC (
   MATK                 char(15)             not null,
   USERNAME             char(30)             not null,
   MALH                 char(15)             not null,
   MAKV                 char(15)             not null,
   PASS                 char(30)             null,
   ISSTAFF              bit                  null,
   ISSUPERUSER          bit                  null,
   DIACHI               varchar(100)         null,
   TENDT                varchar(100)         null,
   DAIDIEN              varchar(30)          null,
   SOCN                 int                  null,
   SLDONHANG            int                  null,
   SDT                  char(15)             null,
   EMAIL                varchar(50)          null,
   constraint PK_DOITAC primary key nonclustered (MATK)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_3_FK on DOITAC (
MALH ASC
)
go

/*==============================================================*/
/* Index: DT_KV_FK                                              */
/*==============================================================*/
create index DT_KV_FK on DOITAC (
MAKV ASC
)
go

/*==============================================================*/
/* Table: DONHANG                                               */
/*==============================================================*/
create table DONHANG (
   MADH                 char(15)             not null,
   MATK                 char(15)             not null,
   DOI_MATK             char(15)             not null,
   TAI_MATK             char(15)             not null,
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
/* Index: DT_DH_FK                                              */
/*==============================================================*/
create index DT_DH_FK on DONHANG (
DOI_MATK ASC
)
go

/*==============================================================*/
/* Index: KH_DH_FK                                              */
/*==============================================================*/
create index KH_DH_FK on DONHANG (
MATK ASC
)
go

/*==============================================================*/
/* Index: TX_DH_FK                                              */
/*==============================================================*/
create index TX_DH_FK on DONHANG (
TAI_MATK ASC
)
go

/*==============================================================*/
/* Table: HOPDONG                                               */
/*==============================================================*/
create table HOPDONG (
   MAHD                 char(15)             not null,
   MATK                 char(15)             not null,
   SLCHINHANH           int                  null,
   TGBD                 datetime             null,
   TGKT                 datetime             null,
   HOAHONG              float                null,
   constraint PK_HOPDONG primary key nonclustered (MAHD)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on HOPDONG (
MATK ASC
)
go

/*==============================================================*/
/* Table: KHACHHANG                                             */
/*==============================================================*/
create table KHACHHANG (
   MATK                 char(15)             not null,
   USERNAME             char(30)             not null,
   PASS                 char(30)             null,
   ISSTAFF              bit                  null,
   ISSUPERUSER          bit                  null,
   HOTEN                varchar(100)         null,
   SDT                  char(15)             null,
   DIACHI               varchar(100)         null,
   EMAIL                varchar(50)          null,
   constraint PK_KHACHHANG primary key nonclustered (MATK)
)
go

/*==============================================================*/
/* Table: KHUVUC                                                */
/*==============================================================*/
create table KHUVUC (
   MAKV                 char(15)             not null,
   QUAN                 varchar(50)          null,
   TP                   varchar(50)          null,
   constraint PK_KHUVUC primary key nonclustered (MAKV)
)
go

/*==============================================================*/
/* Table: LOAIHANG                                              */
/*==============================================================*/
create table LOAIHANG (
   MALH                 char(15)             not null,
   TENLH                varchar(100)         null,
   constraint PK_LOAIHANG primary key nonclustered (MALH)
)
go

/*==============================================================*/
/* Table: QLDONHANG                                             */
/*==============================================================*/
create table QLDONHANG (
   MASP                 char(15)             not null,
   MADH                 char(15)             not null,
   GIASP                decimal              null,
   SLSP                 int                  null,
   THANHTIEN            decimal              null,
   constraint PK_QLDONHANG primary key (MASP, MADH)
)
go

/*==============================================================*/
/* Index: QLDONHANG_FK                                          */
/*==============================================================*/
create index QLDONHANG_FK on QLDONHANG (
MASP ASC
)
go

/*==============================================================*/
/* Index: QLDONHANG2_FK                                         */
/*==============================================================*/
create index QLDONHANG2_FK on QLDONHANG (
MADH ASC
)
go

/*==============================================================*/
/* Table: QLSANPHAM                                             */
/*==============================================================*/
create table QLSANPHAM (
   MATK                 char(15)             not null,
   MASP                 char(15)             not null,
   MACN                 char(15)             not null,
   GIASP                decimal              null,
   SLCUNGCAP            int                  null,
   constraint PK_QLSANPHAM primary key (MATK, MASP)
)
go

/*==============================================================*/
/* Index: ASSOCIATION_1_FK                                      */
/*==============================================================*/
create index ASSOCIATION_1_FK on QLSANPHAM (
MATK ASC
)
go

/*==============================================================*/
/* Index: ASSOCIATION_2_FK                                      */
/*==============================================================*/
create index ASSOCIATION_2_FK on QLSANPHAM (
MASP ASC
)
go

/*==============================================================*/
/* Index: ASSOCIATION_3_FK                                      */
/*==============================================================*/
create index ASSOCIATION_3_FK on QLSANPHAM (
MACN ASC
)
go

/*==============================================================*/
/* Table: SANPHAM                                               */
/*==============================================================*/
create table SANPHAM (
   MASP                 char(15)             not null,
   MALH                 char(15)             not null,
   TENSP                varchar(30)          null,
   constraint PK_SANPHAM primary key nonclustered (MASP)
)
go

/*==============================================================*/
/* Index: LH_SP_FK                                              */
/*==============================================================*/
create index LH_SP_FK on SANPHAM (
MALH ASC
)
go

/*==============================================================*/
/* Table: TAIKHOAN                                              */
/*==============================================================*/
create table TAIKHOAN (
   MATK                 char(15)             not null,
   USERNAME             char(30)             not null,
   PASS                 char(30)             null,
   ISSTAFF              bit                  null,
   ISSUPERUSER          bit                  null,
   SDT                  char(15)             null,
   EMAIL                varchar(50)          null,
   DIACHI               varchar(100)         null,
   constraint PK_TAIKHOAN primary key nonclustered (MATK)
)
go

/*==============================================================*/
/* Table: TAIXE                                                 */
/*==============================================================*/
create table TAIXE (
   MATK                 char(15)             not null,
   USERNAME             char(30)             not null,
   MAKV                 char(15)             not null,
   PASS                 char(30)             null,
   ISSTAFF              bit                  null,
   ISSUPERUSER          bit                  null,
   HOTEN                varchar(100)         null,
   CMND                 char(15)             null,
   SDT                  char(15)             null,
   DIACHI               varchar(100)         null,
   BIENSO               char(10)             null,
   EMAIL                varchar(50)          null,
   STK                  varchar(30)          null,
   NGANHANG             varchar(50)          null,
   constraint PK_TAIXE primary key nonclustered (MATK)
)
go

/*==============================================================*/
/* Index: TX_KV_FK                                              */
/*==============================================================*/
create index TX_KV_FK on TAIXE (
MAKV ASC
)
go

alter table CHINHANH
   add constraint FK_CHINHANH_THUOC_HOPDONG foreign key (MAHD)
      references HOPDONG (MAHD)
go

alter table DOITAC
   add constraint FK_DOITAC_CUA_LOAIHANG foreign key (MALH)
      references LOAIHANG (MALH)
go

alter table DOITAC
   add constraint FK_DOITAC_DT_KV_KHUVUC foreign key (MAKV)
      references KHUVUC (MAKV)
go

alter table DOITAC
   add constraint FK_DOITAC_INHERITAN_TAIKHOAN foreign key (MATK)
      references TAIKHOAN (MATK)
go

alter table DONHANG
   add constraint FK_DONHANG_DT_DH_DOITAC foreign key (DOI_MATK)
      references DOITAC (MATK)
go

alter table DONHANG
   add constraint FK_DONHANG_KH_DH_KHACHHAN foreign key (MATK)
      references KHACHHANG (MATK)
go

alter table DONHANG
   add constraint FK_DONHANG_TX_DH_TAIXE foreign key (TAI_MATK)
      references TAIXE (MATK)
go

alter table HOPDONG
   add constraint FK_HOPDONG_DANG_KY_DOITAC foreign key (MATK)
      references DOITAC (MATK)
go

alter table KHACHHANG
   add constraint FK_KHACHHAN_INHERITAN_TAIKHOAN foreign key (MATK)
      references TAIKHOAN (MATK)
go

alter table QLDONHANG
   add constraint FK_QLDONHAN_QLDONHANG_SANPHAM foreign key (MASP)
      references SANPHAM (MASP)
go

alter table QLDONHANG
   add constraint FK_QLDONHAN_QLDONHANG_DONHANG foreign key (MADH)
      references DONHANG (MADH)
go

alter table QLSANPHAM
   add constraint FK_QLSANPHA_QLSANPHAM_DOITAC foreign key (MATK)
      references DOITAC (MATK)
go

alter table QLSANPHAM
   add constraint FK_QLSANPHA_QLSANPHAM_SANPHAM foreign key (MASP)
      references SANPHAM (MASP)
go

alter table QLSANPHAM
   add constraint FK_QLSANPHA_QLSANPHAM_CHINHANH foreign key (MACN)
      references CHINHANH (MACN)
go

alter table SANPHAM
   add constraint FK_SANPHAM_LH_SP_LOAIHANG foreign key (MALH)
      references LOAIHANG (MALH)
go

alter table TAIXE
   add constraint FK_TAIXE_INHERITAN_TAIKHOAN foreign key (MATK)
      references TAIKHOAN (MATK)
go

alter table TAIXE
   add constraint FK_TAIXE_TX_KV_KHUVUC foreign key (MAKV)
      references KHUVUC (MAKV)
go

