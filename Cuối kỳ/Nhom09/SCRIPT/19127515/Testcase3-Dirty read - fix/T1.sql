USE ONLINESHOP
GO
BEGIN TRAN
	EXEC dbo.XEM_DSHD_CHUADUYET @MADT = 2 -- int
	EXEC dbo.DUYET_HOPDONG @MADT = 2 -- bigint
	WAITFOR DELAY '00:00:05'
ROLLBACK

EXEC dbo.XEM_DSHD_DADUYET @MADT = 2 -- int

-- Ta thây được rằng sau khi gặp lỗi buộc rollback thì danh sách hợp đồng đã 
-- duyệt của đối tác 2 là rỗng

-- Tuy nhiên ở Giao tác T2 thì vẫn xuất hiện danh sách hợp đồng đã duyệt

	
	 
	