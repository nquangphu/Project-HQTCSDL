USE ONLINESHOP
GO
BEGIN TRAN
	EXEC dbo.XEM_DS_TK
	EXEC dbo.CAPNHAT_TAIKHOAN @MATK = 1,            -- bigint
	                          @USERNAME = 'phucccc',       -- char(30)
	                          @PASS = '1234564',           -- char(30)
	                          @ISSTAFF = 1,      -- bit
	                          @ISSUPPERUSER = 0, -- bit
	                          @SDT = '12345',            -- char(15)
	                          @EMAIL = 'phuc@gmail.commmm',          -- char(50)
	                          @DIACHI = 'Quan 10'          -- varchar(100)
	WAITFOR DELAY '00:00:05'
	EXEC dbo.XEM_DS_TK
COMMIT
-- ta thấy danh sách tài khoản đã xuất hiện thêm một tài khoản 7,
-- do T2 đã thực hiện đăng kí khách hàng nên thêm một tài khoản
-- vào bảng
	