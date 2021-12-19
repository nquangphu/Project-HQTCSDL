import AdminView
from tkinter import *
from tkinter import messagebox

global loggedInID
def XemDanhSachDoiTac(conn):
    cursor = conn.cursor()
    cursor.execute("select MADT, TENDT, LOAIHANG.TENLH from DOITAC, LOAIHANG where DOITAC.MALH=LOAIHANG.MALH")
    records=cursor.fetchall()
    AdminView.view(["Mã đối tác", "Tên đối tác","Loại mặt hàng"], records,"Danh sách đối tác")
    conn.commit()
def XemDanhSachSanPham(conn):
    XemDanhSachSanPham = Tk()
    XemDanhSachSanPham.title("Chọn đối tác")
    XemDanhSachSanPham.geometry("300x200")
    XemDanhSachSanPham['bg'] = '#AC99F2'
    
    fr = Frame(XemDanhSachSanPham, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=30, bg='#CDE6FF')

    fr.pack(padx=10, pady=30)
    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(XemDanhSachSanPham, width=10, bg='#F4FF89', text="Xem",
        command=lambda:DanhSachSanPham(edt_madt, conn), activebackground='#4551FC', activeforeground='white')
    btnSave.pack(padx=10, pady=10)

def DanhSachSanPham(madt, conn):
    cursor = conn.cursor()
    cursor.execute("select SANPHAM.MASP, TENSP, GIASP, SLCUNGCAP from SANPHAM, QLSANPHAM where QLSANPHAM.MASP=SANPHAM.MASP AND QLSANPHAM.MADT=?", madt.get())

    records = cursor.fetchall()
    AdminView.view(["Mã sản phẩm", "Tên sản phẩm", "Đơn giá", "Số lượng tồn kho"], records, "Danh sách sản phẩm của đối tác")
    conn.commit()
def dathang(conn):
    dathang=Tk()
    dathang.title("Đặt hàng")
    dathang['bg'] = '#AC99F2'
    dathang.geometry("600x400")

    fr1 = Frame(dathang)
    label_masp = Label(fr1, text='Điền mã sản phẩm:', width=20)
    edt_masp = Entry(fr1, width=30, bg='#CDE6FF')

    fr2 = Frame(dathang)
    label_madt = Label(fr2, text='Điền mã đối tác:', width=20)
    edt_madt = Entry(fr2, width=30, bg='#CDE6FF')

    fr3 = Frame(dathang)
    label_soluong = Label(fr3, text='Số lượng:', width=20)
    edt_soluong = Entry(fr3, width=30, bg='#CDE6FF')

    fr4 = Frame(dathang)
    label_httt = Label(fr4, text='Hình thức thanh toán:', width=20)
    edt_httt = Entry(fr4, width=30, bg='#CDE6FF')

    fr5 = Frame(dathang)
    label_diachidh = Label(fr5, text='Địa chi giao hàng:', width=20)
    edt_diachigh = Entry(fr5, width=30, bg='#CDE6FF')

    fr1.pack(padx=10, pady=10)
    fr2.pack(padx=10, pady=10)
    fr3.pack(padx=10, pady=10)
    fr4.pack(padx=10, pady=10)
    fr5.pack(padx=10, pady=10)

    label_masp.pack(side=LEFT, padx=5)
    edt_masp.pack(side=RIGHT)

    label_madt.pack(side=LEFT, padx=5)
    edt_madt.pack(side=RIGHT)

    label_soluong.pack(side=LEFT, padx=5)
    edt_soluong.pack(side=RIGHT)

    label_httt.pack(side=LEFT, padx=5)
    edt_httt.pack(side=RIGHT)

    label_diachidh.pack(side=LEFT, padx=5)
    edt_diachigh.pack(side=RIGHT)

    btnSave = Button(dathang, text="Đặt hàng", width=15, bg='#F4FF89', activebackground='#4551FC', activeforeground='white',
                     command=lambda:dathangDB(edt_masp,edt_madt,edt_soluong,edt_httt,edt_diachigh, conn))
    btnSave.pack(pady=20)

def dathangDB(masp, madt, soluong, httt, diachigh, conn):
    
    cursor = conn.cursor()
    cursor.execute("Exec DATHANG_LOI ?, ?, ?, ?, ?, ?, ?",
                   loggedInID, masp.get(), madt.get(), soluong.get(), httt.get(), diachigh.get(), '10000')
    conn.commit()

def XemDanhsachDonHang(conn):
    cursor = conn.cursor()
    cursor.execute("select MADH, NGAYTAO, DIACHIGH, TONGTIEN FROM DONHANG WHERE MAKH=?", loggedInID)

    records = cursor.fetchall()
    AdminView.view(["Mã đơn hàng", "Ngày tạo", "Địa chỉ", "Tổng tiền"], records, "Danh sách đơn hàng")
    conn.commit()


def khachhangView(conn):
    khachhang = Tk()
    khachhang['bg'] = '#AC99F2'
    khachhang.title("Chức năng khách hàng")
    khachhang.geometry("600x400")

    fr1 = Frame(khachhang, bg='#AC99F2')
    btnXemDanhSachDoiTac = Button(fr1, text="Xem DS đối tác", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                    command=lambda:XemDanhSachDoiTac(conn), activebackground='#4551FC', activeforeground='white')
    btnXemDanhSachSanPham= Button(fr1, text="Xem DS sản phẩm", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                    command=lambda:XemDanhSachSanPham(conn), activebackground='#4551FC', activeforeground='white')
    
    fr2 = Frame(khachhang, bg='#AC99F2')
    btnDathang = Button(fr2, text="Đặt hàng", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                    command=lambda:dathang(conn), activebackground='#4551FC', activeforeground='white')
    btnXemDanhSachDonHang = Button(fr2, text="Xem DS đơn hàng", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                    command=lambda:XemDanhsachDonHang(conn), activebackground='#4551FC', activeforeground='white')

    fr1.pack(padx=10,pady=20)
    fr2.pack(padx=10,pady=20)

    btnXemDanhSachDoiTac.pack(side=LEFT, padx=10)
    btnXemDanhSachSanPham.pack(side=RIGHT, padx=10)
    btnDathang.pack(side=LEFT, padx=10)
    btnXemDanhSachDonHang.pack(side=RIGHT, padx=10)