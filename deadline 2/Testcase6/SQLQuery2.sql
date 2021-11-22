USE ONLINESHOP
GO
BEGIN TRAN
	DECLARE @slchinhanh AS INT
	SET @slchinhanh= (SELECT SLCHINHANH FROM dbo.HOPDONG WHERE MAHD=1)
    INSERT INTO CHINHANH(MAHD,DIACHI) VALUES (
        1,
        'Tp hcm'
    );
	WAITFOR DELAY '00:00:10'
	SET @slchinhanh=@slchinhanh+1
	UPDATE dbo.HOPDONG SET SLCHINHANH=@slchinhanh WHERE MAHD=1
COMMIT TRAN
SELECT *  FROM dbo.HOPDONG
BEGIN TRAN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT * FROM dbo.HOPDONG hd WHERE ISACEPTED=1
	EXEC dbo.XEM_DSHD_DADUYET @MADT = 1 -- int
	EXEC dbo.XEM_DSHD_CHUADUYET @MADT = 1 -- int
	EXEC dbo.THONGBAO_GIAHAN @MADT = 1 -- bigint
BEGIN TRAN
	EXEC dbo.XEM_DSHD_DADUYET @MADT = 1 -- int
	EXEC dbo.THONGBAO_GIAHAN @MADT = 1 -- bigint
	WAITFOR DELAY '00:00:10'
	EXEC dbo.THONGBAO_GIAHAN @MADT = 1 -- bigint
COMMIT TRAN
	
EXEC dbo.DUYET_HOPDONG @MADT = 1 -- bigint

	
	
COMMIT
	
BEGIN TRAN
	EXEC dbo.DANGKI_HOPDONG @MADT = 1,            -- bigint
	                        @TGBD = '2021-11-21', -- date
	                        @TGKT = '2021-11-21', -- date
	                        @HOAHONG = 0.0        -- float
COMMIT
	
EXEC dbo.GIAHAN_HOPDONG @MAHD = 3,                     -- bigint
                        @TGKT = '2021-12-21', -- datetime
                        @HOAHONG = 10.5,                -- float
                        @ISACEPTED = 1              -- bit
SELECT * FROM dbo.SANPHAM