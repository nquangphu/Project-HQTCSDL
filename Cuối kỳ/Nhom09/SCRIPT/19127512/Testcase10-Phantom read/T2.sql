USE ONLINESHOP
GO
BEGIN TRAN
	EXEC dbo.DANGKI_KH @USERNAME_KH = 'dinhphuc', -- char(30)
	                   @PASS_KH = '123456',     -- char(30)
	                   @SDT_KH = '12345678',      -- char(15)
	                   @EMAIL_KH = 'dinhphuc@gmail.com',    -- varchar(50)
	                   @DIACHI_KH = 'Quan binhthanh'    -- varchar(100)
COMMIT
	