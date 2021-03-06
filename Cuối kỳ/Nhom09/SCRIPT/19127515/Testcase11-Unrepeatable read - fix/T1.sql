USE ONLINESHOP
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
BEGIN TRAN
	SELECT * FROM dbo.HOPDONG hd WHERE hd.MADT=1 AND ISACEPTED=1
	WAITFOR DELAY '00:00:10'
	SELECT * FROM dbo.HOPDONG WHERE MADT= 1 AND DATEDIFF(DAYOFYEAR, CAST( GETDATE() AS Date ),TGKT) < 10 AND ISACEPTED=1
COMMIT TRAN

-- Ta thấy ban đầu chỉ có 2 hợp đồng cần thông báo Gia hạn là
-- hợp đồng 1 và 2 vì khoảng cách đến ngày hôm nay (22-11-2021)
-- nhỏ hơn 10 ngày.
-- Tuy nhiên thực tế thì có thêm hợp đồng 6, vì T2 đã duyệt hợp đồng
-- 6 và vô tình hợp đồng này cũng sắp đáo hạn dẫn đến danh sách này bị
-- thay đổi đi.
	

	
	