USE ONLINESHOP
GO
BEGIN TRAN
	EXEC dbo.XEM_DSHD_DADUYET @MADT = 1 -- int
	WAITFOR DELAY '00:00:10'
	EXEC dbo.THONGBAO_GIAHAN @MADT = 1 -- bigint
COMMIT
-- như ta thấy ban đầu thì danh sách hợp đồng thì hợp đồng 1 cần được thông báo 
-- ngày em test là 22 (cách thời hạn nhỏ hơn 10 ngày mặc đinh) tuy nhiên do đối tác
-- 1 thực hiện Gia hạn nên dẫn đến danh sách thông báo gia hạn bị khác đi.
	
	
