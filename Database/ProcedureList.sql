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
    SELECT * FROM DONHANG WHERE MADT=@MADT

GO
CREATE PROC XEM_TT_DONHANG_DT
	@MADT BIGINT
AS
    SELECT * FROM DONHANG, dbo.QLDONHANG WHERE MADT=@MADT AND dbo.DONHANG.MADH=dbo.QLDONHANG.MADH

GO
CREATE PROC XEM_DS_CHINHANH
	@MASP BIGINT
AS
    SELECT CHINHANH.* FROM CHINHANH,QLSANPHAM WHERE QLSANPHAM.MASP = @MASP AND CHINHANH.MACN = QLSANPHAM.MACN

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
        0,
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
    @TGBD                 DATE,
    @TGKT                 DATE,
    @HOAHONG              FLOAT	 
AS
    INSERT INTO HOPDONG(MADT, SLCHINHANH,TGBD,TGKT,HOAHONG,ISACEPTED) VALUES (
        @MADT,
		0,
        @TGBD,
        @TGKT,
        @HOAHONG,
        0
    );

GO
CREATE PROC DANGKI_CHINHANH_HOPDONG
    @MAHD BIGINT,
    @DIACHI VARCHAR(100)
AS
BEGIN TRAN
    DECLARE @slchinhanh AS INT
	SET @slchinhanh= (SELECT SLCHINHANH FROM dbo.HOPDONG WHERE MAHD=@MAHD)
    INSERT INTO CHINHANH(MAHD,DIACHI) VALUES (
        @MAHD,
        @DIACHI
    );
	SET @slchinhanh=@slchinhanh+1
	UPDATE dbo.HOPDONG SET SLCHINHANH=@slchinhanh WHERE MAHD=@MAHD
COMMIT TRAN

GO
CREATE PROC GIAHAN_HOPDONG
    @MAHD BIGINT,
    @TGKT                 DATETIME,
    @HOAHONG              FLOAT,
    @ISACEPTED			    BIT
AS
    UPDATE HOPDONG SET  TGKT=@TGKT,HOAHONG=@HOAHONG,ISACEPTED=@ISACEPTED WHERE MAHD=@MAHD;

GO
CREATE PROC THEM_SANPHAM
    @MALH BIGINT,
    @TENSP VARCHAR(30)
AS
    INSERT INTO SANPHAM(MALH,TENSP) VALUES (@MALH,@TENSP);

GO
CREATE PROC SUA_SANPHAM
    @MASP BIGINT,
    @MALH BIGINT,
    @TENSP VARCHAR(30)
AS
    UPDATE SANPHAM SET MALH=@MALH,TENSP=@TENSP WHERE MASP=@MASP;

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
    INSERT INTO QLSANPHAM(MADT,MASP,MACN,GIASP,SLCUNGCAP) VALUES (
        @MADT,
        @MASP,
        @MACN,
        @GIASP,
        @SLCUNGCAP
    );

GO
CREATE PROC SUA_CHINHANH_SP
    @MADT                 BIGINT,
    @MASP                 BIGINT,
    @MACN                 BIGINT,
    @GIASP                DECIMAL(15,2),
    @SLCUNGCAP            INT
AS
    UPDATE QLSANPHAM
    SET MACN=@MACN,
    GIASP=@GIASP,
    SLCUNGCAP=@SLCUNGCAP
    WHERE MADT=@MADT AND MASP=@MASP

GO
CREATE PROC XOA_CHINHANH_SP
    @MADT                 BIGINT,
    @MASP                 BIGINT
AS
    DELETE QLSANPHAM
    WHERE MADT=@MADT AND MASP=@MASP

GO
CREATE PROC CAPNHAT_DONHANG_DT
    @MADH BIGINT,
    @TRANGTHAISHIP        INT,
    @TRANGTHAITTOAN		BIT
AS
    UPDATE DONHANG
    SET TRANGTHAISHIP=@TRANGTHAISHIP,
    TRANGTHAITTOAN=@TRANGTHAITTOAN
    WHERE MADH=@MADH
GO
CREATE PROC XEM_TTIN_DONHANG
	@MADH BIGINT
AS
	SELECT * FROM dbo.DONHANG, dbo.QLDONHANG WHERE dbo.DONHANG.MADH=dbo.QLDONHANG.MADH AND dbo.DONHANG.MADH=@MADH


--CẬP NHẬT TÀI KHOẢN
CREATE PROC CAPNHAT_TAIKHOAN
	@MATK BIGINT, 
	@USERNAME CHAR(30), 
	@PASS CHAR(30), 
	@ISSTAFF BIT, 
	@ISSUPPERUSER BIT, 
	@SDT CHAR(15), 
	@EMAIL CHAR(50), 
	@DIACHI VARCHAR(100)
AS
	UPDATE dbo.TAIKHOAN 
	SET USERNAME= @USERNAME, PASS=@PASS, ISSTAFF=@ISSTAFF, ISSUPERUSER=@ISSUPPERUSER, SDT=@SDT, EMAIL=@EMAIL, DIACHI=@DIACHI 
	WHERE MATK=@MATK
GO
-- Xem danh sách hợp đồng đã duyệt
CREATE PROC XEM_DSHD_DADUYET 
	@MADT INT
AS
	SELECT * FROM dbo.HOPDONG hd WHERE hd.MADT=@MADT AND ISACEPTED=1
GO

-- Xem danh sách hợp đồng chưa duyệt
CREATE PROC XEM_DSHD_CHUADUYET
	@MADT INT
AS
	SELECT * FROM dbo.HOPDONG hd WHERE hd.MADT=@MADT AND ISACEPTED=0

GO 
-- THÔNG BÁO GIA HẠN ĐẾN ĐỐI TÁC ĐỐI VỚI NHỮNG HỢP ĐỒNG SẮP ĐẾN HẠN
CREATE PROC THONGBAO_GIAHAN  
	@MADT BIGINT
AS 
	SELECT * FROM dbo.HOPDONG WHERE MADT= @MADT AND DATEDIFF(DAYOFYEAR, CAST( GETDATE() AS Date ),TGKT) < 10 AND ISACEPTED=1
GO
-- DUYỆT HỢP ĐỒNG
CREATE PROC DUYET_HOPDONG
	@MADT BIGINT
AS
BEGIN TRAN 
	DECLARE @MyTableVar table(  
    MAHD BIGINT NOT NULL,  
    MADT BIGINT,  
    EXPRIEDTIME DATE,  
    ACCEPTEDDATE DATETIME);  
	
	UPDATE dbo.HOPDONG  
	SET ISACEPTED=1
	OUTPUT INSERTED.MAHD,
			INSERTED.MADT,
			INSERTED.TGKT,
			GETDATE() 
	INTO @MyTableVar
	 WHERE MADT=@MADT AND ISACEPTED=0

	--Display the result set of the table variable.  
	SELECT *  
	FROM @MyTableVar;  
COMMIT TRAN
-- XEM DANH SÁCH TÀI KHOẢN
GO 
CREATE PROC XEM_DS_TK
AS
	SELECT * FROM dbo.TAIKHOAN
		
-- XÓA TÀI KHOẢN CỦA NHÂN VIÊN/ADMIN
GO
CREATE PROC XOA_TK_NV_AD
	@USERNAME CHAR(30)
AS
BEGIN TRAN 
	DELETE FROM dbo.TAIKHOAN WHERE USERNAME=@USERNAME
	
-- KHÓA MỘT TÀI KHOẢN
GO
CREATE PROC KHOA_TK
	@USERNAME CHAR(30)
AS
	UPDATE dbo.TAIKHOAN SET ISACTIVE = 0 WHERE USERNAME=@USERNAME
-- KÍCH HOẠT MỘT TÀI KHOẢN
GO
CREATE PROC KICHHOAT_TK
	@USERNAME CHAR(30)
AS
	UPDATE dbo.TAIKHOAN SET ISACTIVE = 1 WHERE USERNAME=@USERNAME
-- CẤP QUYỀN CHO MỘT TÀI KHOẢN
GO
CREATE PROC CAPQUYEN_DULIEU
	@USERNAME CHAR(30)
AS
BEGIN TRAN 
	IF EXISTS (SELECT * FROM dbo.TAIKHOAN WHERE USERNAME=@USERNAME)
		
		BEGIN
			DECLARE @user_pass CHAR(30)
			SET @user_pass= (SELECT PASS FROM dbo.TAIKHOAN WHERE USERNAME=@USERNAME)
			EXEC sys.sp_addlogin @loginame = @USERNAME,    -- sysname
			                     @passwd = @user_pass,      -- sysname
			                     @defdb = ONLINESHOP
			EXEC sys.sp_addrolemember @rolename = 'db_datawriter',  -- sysname
			                          @membername = @USERNAME -- sysname
		END
	ELSE
		BEGIN
			RAISERROR('Tài khoản không hợp lệ',15,1)
			ROLLBACK
		END
COMMIT TRAN


-- proc đăng kí khách hàng
CREATE PROC DANGKI_KH
	@USERNAME_KH             CHAR(30),
    @PASS_KH                 CHAR(30),
    @SDT_KH                  CHAR(15),
    @EMAIL_KH                VARCHAR(50),
    @DIACHI_KH               VARCHAR(100)
AS
	BEGIN TRAN
		DECLARE @MATK BIGINT;
    
		EXECUTE TAO_TAIKHOAN
			0,
			0,
			@USERNAME_KH,
			@PASS_KH,
			@SDT_KH,
			@EMAIL_KH,
			@DIACHI_KH,
			1,
			@MATK OUTPUT;
		INSERT INTO dbo.KHACHHANG
		(
		    MATK
		)
		VALUES
		(@MATK  -- MATK - bigint
		    )
	COMMIT
GO
-- proc xem danh sách đối tác 
CREATE PROC XEM_DS_DT
AS 
	SELECT * FROM dbo.DOITAC
GO
-- proc xem danh sách sản phẩm của đối tác
CREATE PROC XEM_DS_SP 
	@MADT		BIGINT
AS
	SELECT dbo.SANPHAM.* 
	FROM dbo.SANPHAM, dbo.QLSANPHAM 
	WHERE dbo.SANPHAM.MASP=dbo.QLSANPHAM.MASP 
			AND dbo.QLSANPHAM.MADT=@MADT
GO
-- proc tạo một đơn hàng
CREATE PROC TAO_DONHANG
	@MAKH BIGINT,
	@MADT BIGINT,
	@MATX BIGINT,
	@HINHTHUCTT VARCHAR(20),
	@NGAYTAO DATETIME,
	@DIACHIGH VARCHAR(100),
	@PHISP DECIMAL(15,2),
	@PHISHIP DECIMAL(15,2),
	@TONGTIEN DECIMAL(15,2),
	@TRANGTHAISHIP INT,
	@TRANGTHAITTOAN BIT,
	@MADH BIGINT OUTPUT
AS
BEGIN TRAN
	DECLARE @MyTableVar TABLE ( MADH_ BIGINT); 
	INSERT INTO dbo.DONHANG
	(
	    MAKH,
	    MADT,
	    MATX,
	    HINHTHUCTT,
	    NGAYTAO,
	    DIACHIGH,
	    PHISP,
	    PHISHIP,
	    TONGTIEN,
	    TRANGTHAISHIP,
	    TRANGTHAITTOAN
	)
	OUTPUT Inserted.MADH INTO @MyTableVar(MADH_)
	VALUES
	(   @MAKH,         -- MAKH - bigint
	    @MADT,         -- MADT - bigint
	    @MATX,         -- MATX - bigint
	    @HINHTHUCTT,        -- HINHTHUCTT - varchar(20)
	    @NGAYTAO, -- NGAYTAO - datetime
	    @DIACHIGH,        -- DIACHIGH - varchar(100)
	    @PHISP,      -- PHISP - decimal(15, 2)
	    @PHISHIP,      -- PHISHIP - decimal(15, 2)
	    @TONGTIEN,      -- TONGTIEN - decimal(15, 2)
	    @TRANGTHAISHIP,         -- TRANGTHAISHIP - int
	    @TRANGTHAITTOAN       -- TRANGTHAITTOAN - bit
	    ) 
	SELECT @MADH=MADH_ FROM @MyTableVar
COMMIT
GO
-- proc thêm sản phẩm cho một đơn hàng
CREATE PROC THEMSANPHAM
	@MADH BIGINT,
	@MASP BIGINT,
	@GIASP DECIMAL(15,2),
	@SLSP INT,
	@MADT BIGINT
AS
BEGIN TRAN
	INSERT INTO dbo.QLDONHANG
	(
	    MASP,
	    MADH,
	    GIASP,
	    SLSP,
	    THANHTIEN
	)
	VALUES
	(   @MASP,    -- MASP - bigint
	    @MADH,    -- MADH - bigint
	    @GIASP, -- GIASP - decimal(15, 2)
	    @SLSP,    -- SLSP - int
	    @GIASP*@SLSP  -- THANHTIEN - decimal(15, 2)
	 )
	 UPDATE dbo.QLSANPHAM SET SLCUNGCAP= SLCUNGCAP-@SLSP WHERE MASP=@MASP AND MADT=@MADT
COMMIT TRAN
-- proc đặt hàng
GO
CREATE PROC DATHANG
	@MAKH BIGINT,
	@MASP BIGINT,
	@MADT BIGINT,
	@SLSP INT,
	@HINHTHUCTT VARCHAR(20),
	@DIACHIGH VARCHAR(100),
	@PHISHIP DECIMAL(15,2)
AS
BEGIN TRAN
	DECLARE @MADH AS BIGINT, @GIASP AS DECIMAL(15,2), @PHISP AS DECIMAL(15,2), @TONGTIEN AS DECIMAL(15,2)
	SELECT @GIASP=GIASP FROM dbo.QLSANPHAM WHERE MASP=@MASP AND MADT=@MADT
	SET @PHISP=@GIASP*@SLSP
	SET @TONGTIEN= @PHISP+@PHISHIP

	DECLARE @MADH1 BIGINT;
	EXEC dbo.TAO_DONHANG @MAKH = @MAKH,                        -- bigint
	                     @MADT = @MADT,                        -- bigint
	                     @MATX = NULL,                        -- bigint
	                     @HINHTHUCTT = @HINHTHUCTT,                 -- varchar(20)
	                     @NGAYTAO = '2021-11-21 13:20:04', -- datetime
	                     @DIACHIGH = @DIACHIGH,                   -- varchar(100)
	                     @PHISP =@PHISP,                    -- decimal(15, 2)
	                     @PHISHIP = @PHISHIP,                  -- decimal(15, 2)
	                     @TONGTIEN = @TONGTIEN,                 -- decimal(15, 2)
	                     @TRANGTHAISHIP = 0,               -- int
	                     @TRANGTHAITTOAN = 0,           -- bit
	                     @MADH = @MADH1 OUTPUT             -- bigint
	DECLARE @SLSPCC AS INT
	SELECT @SLSPCC= SLCUNGCAP FROM dbo.QLSANPHAM WHERE MADT=@MADT AND MASP=@MASP
	IF (@SLSP>@SLSPCC)
		BEGIN
		    RAISERROR('số lượng sp không đủ',15,1)
			ROLLBACK
		END
	EXEC dbo.THEMSANPHAM @MADH = @MADH1,     -- bigint
	                    @MASP = @MASP,     -- bigint
	                    @GIASP = @GIASP, -- decimal(15, 2)
	                    @SLSP = @SLSP,      -- int
						@MADT=@MADT
COMMIT
	
GO
-- proc xác nhận đơn hàng
CREATE PROC XACNHAN_DONHANG
	@MADH	BIGINT
AS
	UPDATE dbo.DONHANG SET TRANGTHAITTOAN=1 WHERE MADH=@MADH
GO
-- proc xem tthai đơn hàng
CREATE PROC XEM_TTHAI_DONHANG 
	@MADH	BIGINT
AS
	SELECT MADH, TRANGTHAITTOAN,HINHTHUCTT,TRANGTHAISHIP,TONGTIEN FROM dbo.DONHANG WHERE MADH=@MADH
GO
-- proc đăng kí tài xế
CREATE PROC DANGKI_TAIXE
	@USERNAME_TX             CHAR(30),
    @PASS_TX                CHAR(30),
    @SDT_TX                  CHAR(15),
    @EMAIL_TX                VARCHAR(50),
    @DIACHI_TX               VARCHAR(100),
	@MAKV					BIGINT,
	@CMND					CHAR(15),
	@DIACHI					VARCHAR(100),
	@BIENSO					CHAR(10),
	@STK					VARCHAR(30),
	@NGANHANG				VARCHAR(50)
AS
BEGIN TRAN
	DECLARE @MATK BIGINT;
    
		EXECUTE TAO_TAIKHOAN
			0,
			0,
			@USERNAME_TX,
			@PASS_TX,
			@SDT_TX,
			@EMAIL_TX,
			@DIACHI_TX,
			1,
			@MATK OUTPUT;
		INSERT INTO dbo.TAIXE
		(
		    MATK,
		    MAKV,
		    CMND,
		    DIACHI,
		    BIENSO,
		    STK,
		    NGANHANG
		)
		VALUES
		(   @MATK,  -- MATK - bigint
		    @MAKV,  -- MAKV - bigint
		    @CMND, -- CMND - char(15)
		    @DIACHI, -- DIACHI - varchar(100)
		    @BIENSO, -- BIENSO - char(10)
		    @STK, -- STK - varchar(30)
		    @NGANHANG  -- NGANHANG - varchar(50)
		    )
		
COMMIT TRAN
GO
--proc hiên thị danh sách đơn hàng theo khu vực
CREATE PROC HIENTHI_DSDH 
	@MATX BIGINT
AS
	SELECT dbo.DONHANG.* FROM dbo.TAIXE,dbo.DONHANG,dbo.DOITAC
	WHERE dbo.DOITAC.MAKV=dbo.TAIXE.MAKV
	AND dbo.TAIXE.MATX=@MATX
	AND dbo.DONHANG.MADT=dbo.DOITAC.MADT
	AND dbo.DONHANG.TRANGTHAITTOAN=1
	AND dbo.DONHANG.MATX IS NULL
GO
-- proc nhận đơn hàng
CREATE PROC NHAN_DONHANG
	@MADH BIGINT,
	@MATX BIGINT
AS
	UPDATE dbo.DONHANG SET MATX=@MATX WHERE MADH=@MADH
GO
-- proc tài xế cập nhật đơn hàng
CREATE PROC CAPNHAT_DONHANG_TX
	@MADH BIGINT,
	@TRANGTHAISHIP INT
AS
	UPDATE dbo.DONHANG SET TRANGTHAISHIP=@TRANGTHAISHIP WHERE MADH=@MADH
GO
-- proc xem dnah sách đơn hàng đã nhận của tài xế 
CREATE PROC XEM_DS_DONHANG_DANHAN
	@MATX BIGINT
AS
	SELECT MADH, MAKH, PHISHIP FROM dbo.DONHANG WHERE MATX=@MATX
