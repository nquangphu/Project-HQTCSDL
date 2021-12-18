from tkinter import *
from tksheet import Sheet

def danhsachdonhang(xemdanhsachdonhang):
    danhsachdonhang=Toplevel(xemdanhsachdonhang)
    xemdanhsachdonhang.withdraw()
    danhsachdonhang.title("Danh sách đơn hàng")
    frame= Frame(danhsachdonhang)

    sheet = Sheet(frame)
    sheet.enable_bindings()
    frame.grid(row=0, column=0, sticky="nswe")
    sheet.grid(row=0, column=0, sticky="nswe")
    sheet.set_sheet_data([[1,2,3],[4,5,6]])

    danhsachdonhang.protocol("WM_DELETE_WINDOW", danhsachdonhang.destroy)

def xemdanhsachdonhang():
    xemdanhsachdonhang=Tk()
    xemdanhsachdonhang.title("Danh sách đơn hàng của đối tác")

    label_madt = Label(xemdanhsachdonhang, text='Điền mã quý đối tác')
    edt_madt = Entry(xemdanhsachdonhang, width=50)

    label_madt.grid(row=0, column=0, padx=10, pady=10)
    edt_madt.grid(row=0, column=1, padx=10, pady=10)

    btnSave = Button(xemdanhsachdonhang, text="Xem danh sach don hang", command=lambda:danhsachdonhang(xemdanhsachdonhang))
    btnSave.grid(row=1, column=1, padx=10, pady=10)
def dkchinhanh():
    dkchinhanh=Tk()
    dkchinhanh.title("Đăng kí chi nhánh cho hợp đồng")

    label_mahd=Label(dkchinhanh,text='Điền mã hợp đồng của quý đối tác')
    edt_mahd=Entry(dkchinhanh, width=50)

    label_diachi = Label(dkchinhanh, text='Điền địa chỉ của chi nhánh')
    edt_diachi = Entry(dkchinhanh, width=50)

    label_mahd.grid(row=0, column=0, padx=10, pady=10)
    edt_mahd.grid(row=0, column=1, padx=10, pady=10)

    label_diachi.grid(row=1, column=0, padx=10, pady=10)
    edt_diachi.grid(row=1, column=1, padx=10, pady=10)

    btnSave=Button(dkchinhanh,text="Lưu chi nhánh")
    btnSave.grid(row=2, column=1, padx=10, pady=10)
def giahanHopdong():
    giahanHopdong=Tk()
    giahanHopdong.title("Gia hạn hợp đồng")

    label_mahd = Label(giahanHopdong, text='Điền mã hợp đồng của quý đối tác')
    edt_mahd = Entry(giahanHopdong, width=50)

    label_thoigian = Label(giahanHopdong, text='Điền thời gian')
    edt_thoigian = Entry(giahanHopdong, width=50)

    label_hoahong = Label(giahanHopdong, text='Điền hoa hồng')
    edt_hoahong = Entry(giahanHopdong, width=50)

    label_mahd.grid(row=0, column=0, padx=10, pady=10)
    edt_mahd.grid(row=0, column=1, padx=10, pady=10)

    label_thoigian.grid(row=1, column=0, padx=10, pady=10)
    edt_thoigian.grid(row=1, column=1, padx=10, pady=10)

    label_hoahong.grid(row=2, column=0, padx=10, pady=10)
    edt_hoahong.grid(row=2, column=1, padx=10, pady=10)

    btnSave = Button(giahanHopdong, text="Lưu thông tin hợp đồng")
    btnSave.grid(row=3, column=1, padx=10, pady=10)
def themSanPham():
    themSanPham=Tk()
    themSanPham.title("Thêm sản phẩm")

    label_malh = Label(themSanPham, text='Điền mã hợp đồng của quý đối tác')
    edt_malh = Entry(themSanPham, width=50)

    label_tensp = Label(themSanPham, text='Điền thời gian')
    edt_tensp = Entry(themSanPham, width=50)


    label_malh.grid(row=0, column=0, padx=10, pady=10)
    edt_malh.grid(row=0, column=1, padx=10, pady=10)

    label_tensp.grid(row=1, column=0, padx=10, pady=10)
    edt_tensp.grid(row=1, column=1, padx=10, pady=10)

    btnSave = Button(themSanPham, text="Lưu thông tin sản phẩm")
    btnSave.grid(row=3, column=1, padx=10, pady=10)
def suaSanPham():
    suaSanPham=Tk()
    suaSanPham.title("Sửa sản phẩm")

    label_masp = Label(suaSanPham, text='Điền mã hợp đồng của quý đối tác')
    edt_masp = Entry(suaSanPham, width=50)

    label_malh = Label(suaSanPham, text='Điền mã hợp đồng của quý đối tác')
    edt_malh = Entry(suaSanPham, width=50)

    label_tensp = Label(suaSanPham, text='Điền thời gian')
    edt_tensp = Entry(suaSanPham, width=50)

    label_masp.grid(row=0, column=0, padx=10, pady=10)
    edt_masp.grid(row=0, column=1, padx=10, pady=10)

    label_malh.grid(row=1, column=0, padx=10, pady=10)
    edt_malh.grid(row=1, column=1, padx=10, pady=10)

    label_tensp.grid(row=2, column=0, padx=10, pady=10)
    edt_tensp.grid(row=2, column=1, padx=10, pady=10)

    btnSave = Button(suaSanPham, text="Lưu thông tin sản phẩm")
    btnSave.grid(row=3, column=1, padx=10, pady=10)
def doitacView():
    doitac=Tk()
    doitac.title("Chức năng cho đối tác")
    #doitac.geometry("600x600")
    btnDkChinhanh=Button(doitac, text="Đăng kí chi nhánh cho hợp đồng", font='Time 10', border=5, padx=10, pady=20,
                         command=dkchinhanh)
    btnGiahan = Button(doitac, text="Gia hạn hợp đồng", font='Time 10', border=5, padx=10, pady=20,
                           command=giahanHopdong)

    btnThemSP= Button(doitac, text="Thêm sản phẩm", font='Time 10', border=5, padx=10, pady=20,
                           command=themSanPham)
    btnSuaSP=Button(doitac, text="Sửa sản phẩm", font='Time 10', border=5, padx=10, pady=20,
                           command=suaSanPham)
    btnXemDanhSachDonHang = Button(doitac, text="Xem danh sách đơn hàng", font='Time 20 bold', border=10,
                                   padx=20, pady=40, command=xemdanhsachdonhang)
    btnXemDanhSachDonHang.pack(pady=10)

    btnDkChinhanh.pack()
    btnGiahan.pack()
    btnThemSP.pack()
    btnSuaSP.pack()