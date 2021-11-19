USE ONLINESHOP
GO
-- DROP PROC TAO_TAIKHOAN;
CREATE PROC TAO_TAIKHOAN (
        @ISSTAFF              BIT,
        @ISSUPERUSER          BIT,
        @USERNAME             CHAR(30),
        @PASS                 NCHAR(32),
        @SDT                  CHAR(15),
        @EMAIL                VARCHAR(50),
        @DIACHI               VARCHAR(100),
        @ISACTIVE             BIT,
        @MATK BIGINT OUTPUT
)
AS
BEGIN TRAN
    DECLARE @CIPASS CHAR(30);
    SET @CIPASS = CONVERT(VARCHAR(32),(SELECT HashBytes('MD5', @PASS)));
    DECLARE @MyTableVar table( 
        MATK                 BIGINT,
        USERNAME             CHAR(30),
        PASS                 VARCHAR(32),
        ISSTAFF              BIT,
        ISSUPERUSER          BIT,
        SDT                  CHAR(15),
        EMAIL                VARCHAR(50),
        DIACHI               VARCHAR(100),
        ISACTIVE             BIT
    );
    INSERT TAIKHOAN(ISSTAFF,ISSUPERUSER,USERNAME,PASS,SDT,EMAIL,DIACHI,ISACTIVE)
    OUTPUT INSERTED.* 
    INTO @MyTableVar VALUES (
        @ISSTAFF,
        @ISSUPERUSER,
        @USERNAME,
        @CIPASS,
        @SDT,
        @EMAIL,
        @DIACHI,
        @ISACTIVE
    );
    SELECT @MATK=OUT.MATK From @MyTableVar  OUT
COMMIT TRAN

GO
CREATE PROC XEM_DS_DONHANG_DT
	@MADT BIGINT
AS
BEGIN TRAN 
    SELECT * FROM DONHANG WHERE MADT=@MADT
COMMIT TRAN

GO
CREATE PROC XEM_DS_CHINHANH
	@MASP BIGINT
AS
BEGIN TRAN 
    SELECT CHINHANH.* FROM CHINHANH,QLSANPHAM WHERE QLSANPHAM.MASP = @MASP AND CHINHANH.MACN = QLSANPHAM.MACN
COMMIT TRAN

GO
CREATE PROC DANGKI_DT(
    @USERNAME_DT             CHAR(30),
    @PASS_DT                 CHAR(30),
    @SDT_DT                  CHAR(15),
    @EMAIL_DT                VARCHAR(50),
    @DIACHI_DT               VARCHAR(100),
    @MALH                 BIGINT,
    @MAKV                 BIGINT,
    @TENDT                VARCHAR(100),
    @DAIDIEN              VARCHAR(30)
)
AS
BEGIN TRAN
    DECLARE @MATK BIGINT;
    
    EXECUTE TAO_TAIKHOAN
        1,
        0,
        @USERNAME_DT,
        @PASS_DT,
        @SDT_DT,
        @EMAIL_DT,
        @DIACHI_DT,
        1,
        @MATK OUTPUT;
    INSERT INTO DOITAC(MATK,MALH,MAKV,TENDT,DAIDIEN,SOCHINHANH,SLDONHANG) VALUES (
        @MATK,
        @MALH,
        @MAKV,
        @TENDT,
        @DAIDIEN,
        0,
        0
    );
    
COMMIT TRAN

GO
CREATE PROC DANGKI_HOPDONG
    @MADT                 BIGINT,
    @TGBD                 DATETIME,
    @TGKT                 DATETIME,
    @HOAHONG              FLOAT,
    @ISACEPTED			    BIT,
    @ISUNEXPIRED            BIT			 
AS
BEGIN TRAN
    INSERT INTO HOPDONG(MADT, SLCHINHANH,TGBD,TGKT,HOAHONG,ISACEPTED) VALUES (
        @MADT,
        0,
        @TGBD,
        @TGKT,
        @HOAHONG,
        @ISACEPTED
    );
COMMIT TRAN

GO
CREATE PROC DANGKI_CHINHANH_HOPDONG
    @MAHD BIGINT,
    @DIACHI VARCHAR(100)
AS
BEGIN TRAN
    INSERT INTO CHINHANH(MAHD,DIACHI) VALUES (
        @MAHD,
        @DIACHI
    );
COMMIT TRAN

GO
CREATE PROC GIAHAN_HOPDONG
    @MAHD BIGINT,
    @TGKT                 DATETIME,
    @HOAHONG              FLOAT,
    @ISACEPTED			    BIT,
    @ISUNEXPIRED            BIT
AS
BEGIN TRAN
    UPDATE HOPDONG SET  TGKT=@TGKT,HOAHONG=@HOAHONG,ISACEPTED=@ISACEPTED,ISUNEXPIRED=@ISUNEXPIRED WHERE MAHD=@MAHD;
COMMIT TRAN

GO
CREATE PROC THEM_SANPHAM
    @MALH BIGINT,
    @TENSP VARCHAR(30)
AS
BEGIN TRAN
    INSERT INTO SANPHAM(MALH,TENSP) VALUES (@MALH,@TENSP);
COMMIT TRAN

GO
CREATE PROC SUA_SANPHAM
    @MASP BIGINT,
    @MALH BIGINT,
    @TENSP VARCHAR(30)
AS
BEGIN TRAN
    UPDATE SANPHAM SET MALH=@MALH,TENSP=@TENSP WHERE MASP=@MASP;
COMMIT TRAN

GO
CREATE PROC XOA_SANPHAM
    @MASP BIGINT
AS
BEGIN TRAN
    DELETE QLSANPHAM WHERE MASP=@MASP;
    DELETE SANPHAM WHERE MASP=@MASP;
COMMIT TRAN

GO
CREATE PROC THEM_CHINHANH_SP
    @MADT                 BIGINT,
    @MASP                 BIGINT,
    @MACN                 BIGINT,
    @GIASP                DECIMAL(15,2),
    @SLCUNGCAP            INT
AS
BEGIN TRAN
    INSERT INTO QLSANPHAM(MADT,MASP,MACN,GIASP,GIASP,SLCUNGCAP) VALUES (
        @MADT,
        @MASP,
        @MACN,
        @GIASP,
        @SLCUNGCAP
    );
COMMIT TRAN

GO
CREATE PROC SUA_CHINHANH_SP
    @MADT                 BIGINT,
    @MASP                 BIGINT,
    @MACN                 BIGINT,
    @GIASP                DECIMAL(15,2),
    @SLCUNGCAP            INT
AS
BEGIN TRAN
    UPDATE QLSANPHAM
    SET MACN=@MACN,
    GIASP=@GIASP,
    SLCUNGCAP=@SLCUNGCAP
    WHERE MADT=@MADT AND MASP=@MASP
COMMIT TRAN

GO
CREATE PROC XOA_CHINHANH_SP
    @MADT                 BIGINT,
    @MASP                 BIGINT
AS
BEGIN TRAN
    DELETE QLSANPHAM
    WHERE MADT=@MADT AND MASP=@MASP
COMMIT TRAN

GO
CREATE PROC CAPNHAT_DONHANG_DT
    @MADH BIGINT,
    @TRANGTHAISHIP        INT,
    @TRANGTHAITTOAN		BIT
AS
BEGIN TRAN
    UPDATE DONHANG
    SET TRANGTHAISHIP=@TRANGTHAISHIP,
    TRANGTHAITTOAN=@TRANGTHAITTOAN
    WHERE MADH=@MADH
COMMIT TRAN
