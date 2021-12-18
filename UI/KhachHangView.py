import AdminView
from tkinter import *

global loggedInID
def XemDanhSachDoiTac():
    conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("select MADT, TENDT, LOAIHANG.TENLH from DOITAC, LOAIHANG where DOITAC.MALH=LOAIHANG.MALH")
    records=cursor.fetchall()
    AdminView.view(["MaDT", "TENDT","LOAIHANG"], records,"Danh sách đối tác")
    conn.commit()
def XemDanhSachSanPham():
    XemDanhSachSanPham = Tk()
    XemDanhSachSanPham.title("Điền mã đối tác")

    label_madt = Label(XemDanhSachSanPham, text='Điền mã đối tác')
    edt_madt = Entry(XemDanhSachSanPham, width=50)

    label_madt.grid(row=0, column=0, padx=10, pady=10)
    edt_madt.grid(row=0, column=1, padx=10, pady=10)

    btnSave = Button(XemDanhSachSanPham, text="Duyêt hợp đồng", command=lambda: DanhSachSanPham(edt_madt))
    btnSave.grid(row=2, column=1, padx=10, pady=10)
def DanhSachSanPham(madt):
    conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("select SANPHAM.MASP, TENSP, GIASP, SLCUNGCAP from SANPHAM, QLSANPHAM where QLSANPHAM.MASP=SANPHAM.MASP AND QLSANPHAM.MADT=?", madt.get())

    records = cursor.fetchall()
    AdminView.view(["MASP", "TENSP", "DONGIA", "SOLUONGTONKHO"], records, "Danh sách sản phẩm của đối tác")
    conn.commit()
def dathang():
    dathang=Tk()
    dathang.title("Đặt hàng")

    label_masp = Label(dathang, text='Điền mã sản phẩm')
    edt_masp = Entry(dathang, width=50)

    label_madt = Label(dathang, text='Điền mã đối tác')
    edt_madt = Entry(dathang, width=50)

    label_soluong = Label(dathang, text='Số lượng')
    edt_soluong = Entry(dathang, width=50)

    label_httt = Label(dathang, text='Hình thức thanh toán')
    edt_httt = Entry(dathang, width=50)

    label_diachidh = Label(dathang, text='Địa chi giao hàng')
    edt_diachigh = Entry(dathang, width=50)

    label_masp.grid(row=0, column=0, padx=10, pady=10)
    edt_masp.grid(row=0, column=1, padx=10, pady=10)

    label_madt.grid(row=1, column=0, padx=10, pady=10)
    edt_madt.grid(row=1, column=1, padx=10, pady=10)

    label_soluong.grid(row=2, column=0, padx=10, pady=10)
    edt_soluong.grid(row=2, column=1, padx=10, pady=10)

    label_httt.grid(row=3, column=0, padx=10, pady=10)
    edt_httt.grid(row=3, column=1, padx=10, pady=10)

    label_diachidh.grid(row=4, column=0, padx=10, pady=10)
    edt_diachigh.grid(row=4, column=1, padx=10, pady=10)

    btnSave = Button(dathang, text="Đặt hàng",
                     command=lambda: dathangDB(edt_masp,edt_madt,edt_soluong,edt_httt,edt_diachigh))
    btnSave.grid(row=5, column=1, padx=10, pady=10)

def dathangDB(masp, madt, soluong, httt, diachigh):
    conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("Exec DATHANG ?, ?, ?, ?, ?, ?, ?",
                   loggedInID, masp.get(), madt.get(), soluong.get(), httt.get(), diachigh.get(), '10000')
    conn.commit()
def XemDanhsachDonHang():
    conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("select MADH, NGAYTAO, DIACHIGH, TONGTIEN FROM DONHANG WHERE MAKH=?", loggedInID)

    records = cursor.fetchall()
    AdminView.view(["MADH", "NGAYTAO", "DIACHIGH", "TONGTIEN"], records, "Danh sách đơn hàng")
    conn.commit()
def khachhangView():
    khachhang = Tk()
    khachhang['bg'] = '#AC99F2'
    khachhang.title("Chức năng cho đối tác")
    khachhang.geometry("600x600")


    btnXemDanhSachDoiTac = Button(khachhang, text="Xem danh sách đối tác", width=30, font='Time 10', border=5, padx=10,
                          pady=20,
                          command=XemDanhSachDoiTac)
    btnXemDanhSachSanPham= Button(khachhang, text="Xem sản phẩm", width=30, font='Time 10', border=5, padx=10,
                          pady=20, command=XemDanhSachSanPham)
    btnDathang = Button(khachhang, text="Đặt hàng", width=30, font='Time 10', border=5, padx=10,
                        pady=20,
                        command=dathang)
    btnXemDanhSachDonHang = Button(khachhang, text="Xem danh sách đơn hàng", width=30, font='Time 10', border=5, padx=10,
                        pady=20,command=XemDanhsachDonHang)
    btnXemDanhSachDoiTac.grid(row=0, column=0, padx=10, pady=10)
    btnXemDanhSachSanPham.grid(row=0, column=1, padx=10, pady=10)
    btnDathang.grid(row=1, column=0, padx=10, pady=10)
    btnXemDanhSachDonHang.grid(row=1, column=1, padx=10, pady=10)