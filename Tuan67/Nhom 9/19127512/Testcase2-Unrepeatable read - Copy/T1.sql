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
-- như ta thấy ban đầu thì danh sách hợp đồng thì hợp đồng 1 cần được thông báo 
-- ngày em test là 22 (cách thời hạn nhỏ hơn 10 ngày mặc đinh) tuy nhiên do đối tác
-- 1 thực hiện Gia hạn nên dẫn đến danh sách thông báo gia hạn bị khác đi.
	
	
