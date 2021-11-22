USE ONLINESHOP
GO
BEGIN TRAN
	DECLARE @MADH AS BIGINT, @GIASP AS DECIMAL(15,2), @PHISP AS DECIMAL(15,2), @TONGTIEN AS DECIMAL(15,2)
	SELECT @GIASP=GIASP FROM dbo.QLSANPHAM WHERE MASP=1 AND MADT=1
	SET @PHISP=@GIASP*10
	SET @TONGTIEN= @PHISP+10000

	DECLARE @MADH1 BIGINT;
	EXEC dbo.TAO_DONHANG @MAKH = 2,                        -- bigint
	                     @MADT = 1,                        -- bigint
	                     @MATX = NULL,                        -- bigint
	                     @HINHTHUCTT = 'CARD',                 -- varchar(20)
	                     @NGAYTAO = '2021-11-21 13:20:04', -- datetime
	                     @DIACHIGH = 'QUAN 8',                   -- varchar(100)
	                     @PHISP =@PHISP,                    -- decimal(15, 2)
	                     @PHISHIP = 10000,                  -- decimal(15, 2)
	                     @TONGTIEN = @TONGTIEN,                 -- decimal(15, 2)
	                     @TRANGTHAISHIP = 0,               -- int
	                     @TRANGTHAITTOAN = 0,           -- bit
	                     @MADH = @MADH1 OUTPUT             -- bigint
	DECLARE @SLSPCC AS INT
	SELECT @SLSPCC= SLCUNGCAP FROM dbo.QLSANPHAM WHERE MADT=1 AND MASP=1

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