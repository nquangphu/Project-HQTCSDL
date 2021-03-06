USE ONLINESHOP
GO
CREATE PROC NHAN_DONHANG_FIX
	@MADH BIGINT,
	@MATX BIGINT
AS
	set transaction isolation level repeatable read
	BEGIN TRAN
		IF NOT EXISTS (SELECT * FROM DONHANG WHERE MATX IS NULL AND MADH=@MADH)
			ROLLBACK TRAN
		ELSE 
		BEGIN
			WAITFOR DELAY '00:00:10'
			UPDATE dbo.DONHANG SET MATX=@MATX WHERE MADH=@MADH
			COMMIT TRAN
		END
GO

EXEC NHAN_DONHANG_FIX 1, 1
-- Ta thấy sau khi T1 thêm 1 sản phẩm thì, T2 ghi đè nên đã xóa sản phẩm
-- dẫn đến trong cơ sở dữ liệu không có sản phẩm bánh trung thu

	
	