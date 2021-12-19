USE ONLINESHOP
GO
CREATE PROC XEM_DSHD_DADUYET_TB_GIAHAN
	@MADT BIGINT
AS
	BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
		EXEC dbo.XEM_DSHD_DADUYET @MADT -- int
		WAITFOR DELAY '00:00:10'
		EXEC dbo.THONGBAO_GIAHAN @MADT-- bigint
	COMMIT
EXEC XEM_DSHD_DADUYET_TB_GIAHAN 1

	
