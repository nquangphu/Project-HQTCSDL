USE ONLINESHOP
GO

BEGIN TRAN
	DECLARE @MADH AS BIGINT, @GIASP AS DECIMAL(15,2), @PHISP AS DECIMAL(15,2), @TONGTIEN AS DECIMAL(15,2)
	SELECT @GIASP=GIASP FROM dbo.QLSANPHAM WHERE MASP=1 AND MADT=1
	SET @PHISP=@GIASP*10
	SET @TONGTIEN= @PHISP+10000

	DECLARE @MADH1 BIGINT;
	EXEC dbo.TAO_DONHANG @MAKH = 1,                        -- bigint
	                     @MADT = 1,                        -- bigint
	                     @MATX = NULL,                        -- bigint
	                     @HINHTHUCTT = 'CARD',                 -- varchar(20)
	                     @NGAYTAO = '2021-11-21 13:20:04', -- datetime
	                     @DIACHIGH = 'QUAN BT',                   -- varchar(100)
	                     @PHISP =@PHISP,                    -- decimal(15, 2)
	                     @PHISHIP = 10000,                  -- decimal(15, 2)
	                     @TONGTIEN = @TONGTIEN,                 -- decimal(15, 2)
	                     @TRANGTHAISHIP = 0,               -- int
	                     @TRANGTHAITTOAN = 0,           -- bit
	                     @MADH = @MADH1 OUTPUT             -- bigint
	DECLARE @SLSPCC AS INT
	SELECT @SLSPCC= SLCUNGCAP FROM dbo.QLSANPHAM WHERE MADT=1 AND MASP=1

	WAITFOR DELAY '00:00:05'

	IF (10>@SLSPCC)
		BEGIN
		    RAISERROR('số lượng sp không đủ',15,1)
			ROLLBACK
		END
	EXEC dbo.THEMSANPHAM @MADH = @MADH1,     -- bigint
	                    @MASP = 1,     -- bigint
	                    @GIASP = @GIASP, -- decimal(15, 2)
	                    @SLSP = 10,      -- int
						@MADT=1
COMMIT
-- Ta thấy T1 thực hiện, đặt hàng sản phẩm 1 của đối tác một, sau đó tạo đơn hàng và kiểm tra số lượng sản phẩm
-- mình đặt (giả sử 10) có hợp lệ với số lượng sản phẩm còn lại của đối tác không (giả sử 15). Tuy nhiên lúc này, 
-- T2 đi vào tiến hành thao tác tương tự và số lượng đặt hàng cũng là 10 và cũng hợp lệ. Sau đó cả hai cùng thêm
-- sản phẩm vào đơn hàng dẫn đến số sản phẩm còn lại của đối tác giảm xuống còn -5