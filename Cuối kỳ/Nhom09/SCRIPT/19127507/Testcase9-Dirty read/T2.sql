USE ONLINESHOP
GO
BEGIN TRAN
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	EXEC dbo.XEM_DS_DONHANG_DT @MADT = 1 -- bigint
COMMIT TRAN
-- Ta thấy rằng mặc dù sau khi không đủ hàng thì T1 đã roll back nhưng T2
-- vẫn đọc được đơn hàng này của T1 đã hủy.