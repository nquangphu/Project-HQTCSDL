USE ONLINESHOP
GO
BEGIN TRAN
	EXEC dbo.SUA_CHINHANH_SP @MADT = 1,     -- bigint
	                         @MASP = 1,     -- bigint
	                         @MACN = 1,     -- bigint
	                         @GIASP = 15000, -- decimal(15, 2)
	                         @SLCUNGCAP = 15 -- int
	WAITFOR DELAY '00:00:05'
	EXEC dbo.SUA_SANPHAM @MASP = 1,  -- bigint
	                     @MALH = 1,  -- bigint
	                     @TENSP = 'Thit bo' -- varchar(30)
COMMIT
	
	