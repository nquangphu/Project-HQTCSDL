USE ONLINESHOP 
GO
BEGIN TRAN
	EXEC dbo.DATHANG @MAKH = 1,        -- bigint
	                 @MASP = 1,        -- bigint
	                 @MADT = 1,        -- bigint
	                 @SLSP = 10,        -- int
	                 @HINHTHUCTT = 'card', -- varchar(20)
	                 @DIACHIGH = 'hcm',   -- varchar(100)
	                 @PHISHIP = '12000'   -- decimal(15, 2)
	WAITFOR DELAY '00:00:05'
	EXEC dbo.XEM_DS_SP @MADT = 1 -- bigint
COMMIT
	

	