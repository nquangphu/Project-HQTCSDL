USE ONLINESHOP
GO
BEGIN TRAN
	SET TRAN ISOLATION LEVEL READ COMMITTED
	EXEC dbo.XEM_DSHD_DADUYET @MADT = 2 -- int
COMMIT



-- vì sql server tự cấp khóa XLOCK khi ghi ở T1, nên em 
-- set mức cô lập của T2 là read uncommited để có thể test 
-- được dirty read