USE ONLINESHOP
GO
BEGIN TRAN
	EXEC dbo.XEM_DS_SP @MADT = 1 -- bigint
	EXEC dbo.THEM_SANPHAM @MALH = 1,  -- bigint
	                      @TENSP = 'Banh Trung Thu' -- varchar(30)
	WAITFOR DELAY '00:00:05'
COMMIT

SELECT * FROM dbo.SANPHAM
-- Ta thấy sau khi T1 thêm 1 sản phẩm thì, T2 ghi đè nên đã xóa sản phẩm
-- dẫn đến trong cơ sở dữ liệu không có sản phẩm bánh trung thu

	
	