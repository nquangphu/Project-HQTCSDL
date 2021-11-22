USE ONLINESHOP
GO
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
