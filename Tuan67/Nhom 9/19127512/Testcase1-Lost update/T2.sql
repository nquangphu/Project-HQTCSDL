USE ONLINESHOP
GO
SELECT * FROM dbo.HOPDONG WHERE MAHD=1
BEGIN TRAN
	DECLARE @slchinhanh AS INT
	SET @slchinhanh= (SELECT SLCHINHANH 
	FROM dbo.HOPDONG (updlock) WHERE MAHD=1)
	WAITFOR DELAY '00:00:1'
	 INSERT INTO CHINHANH
	(MAHD,DIACHI) VALUES
	 (
			1,
			'Quan 8'
		);
	SET @slchinhanh=
	@slchinhanh+1
	UPDATE dbo.HOPDONG 
	SET SLCHINHANH=@slchinhanh 
	WHERE MAHD=1
COMMIT

--SELECT * FROM dbo.HOPDONG WHERE MAHD=1