USE ONLINESHOP
GO
CREATE PROC XEM_DS_TK_CAPNHAT
	@MATK BIGINT, 
	@USERNAME CHAR(30), 
	@PASS CHAR(30), 
	@ISSTAFF BIT, 
	@ISSUPPERUSER BIT, 
	@SDT CHAR(15), 
	@EMAIL CHAR(50), 
	@DIACHI VARCHAR(100)
AS
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
	EXEC dbo.XEM_DS_TK
	EXEC dbo.CAPNHAT_TAIKHOAN @MATK, @USERNAME, @PASS, @ISSTAFF, @ISSUPPERUSER, @SDT, @EMAIL, @DIACHI
	WAITFOR DELAY '00:00:05'
	EXEC dbo.XEM_DS_TK
COMMIT

EXEC XEM_DS_TK_CAPNHAT 1, 'phucccc', '1234564', 1, 0, '12345', 'phuc@gmail.commmm', 'Quan 10'
-- ta thấy danh sách tài khoản đã xuất hiện thêm một tài khoản 7,
-- do T2 đã thực hiện đăng kí khách hàng nên thêm một tài khoản
-- vào bảng
	