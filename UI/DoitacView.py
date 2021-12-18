from tkinter import *
import AdminView
global loggedInID

def danhsachdonhang(conn):
    #conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("EXEC XEM_DS_DONHANG_DT @MADT=?",loggedInID)
    records = cursor.fetchall()
    AdminView.view(("ID", "MAKH", "MADT", "MATX", "HINHTHUCTT","NGAYTAO","DIACHIGH",
                    "PHISP", "PHISHIP","TONGTIEN","TRANGTHAISHP","TRANGTHAITT"), records, "Danh sách đơn hàng")

def danhsachchinhanh(conn):
    #conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("select HOPDONG.MAHD, CHINHANH.MACN, CHINHANH.DIACHI  from CHINHANH, HOPDONG where HOPDONG.MADT=? AND HOPDONG.MAHD=CHINHANH.MAHD"
                   , loggedInID)
    records = cursor.fetchall()
    AdminView.view(("MAHD", "MACN", "DIAHCI"), records, "Danh sách chi nhánh")

def danhsachhopdong(conn):
    #conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("Select * from ONLINESHOP.dbo.HOPDONG where MADT=?", loggedInID)
    records = cursor.fetchall()
    AdminView.view(("ID", "DoiTac", "SLChiNhanh", "StartTime", "EndTime", "Tips", "Status"), records,
         "Danh sách hợp đồng của quý đối tác")

def dkhopdong(conn):
    dkhopdong=Tk()
    dkhopdong.title("Đăng kí hợp đồng")

    label_TGBD = Label(dkhopdong, text='Thời gian bắt đầu của hợp đồng')
    edt_TGBD = Entry(dkhopdong, width=50)

    label_TGKT = Label(dkhopdong, text='Thời gian kết thúc của hợp đồng')
    edt_TGKT = Entry(dkhopdong, width=50)

    label_hoahong = Label(dkhopdong, text='Hoa hồng của hợp đồng')
    edt_hoahong = Entry(dkhopdong, width=50)

    label_TGBD.grid(row=0, column=0, padx=10, pady=10)
    edt_TGBD.grid(row=0, column=1, padx=10, pady=10)

    label_TGKT.grid(row=1, column=0, padx=10, pady=10)
    edt_TGKT.grid(row=1, column=1, padx=10, pady=10)

    label_hoahong.grid(row=3, column=0, padx=10, pady=10)
    edt_hoahong.grid(row=3, column=1, padx=10, pady=10)

    btnSave = Button(dkhopdong, text="Đăng kí",
                command=lambda:giahanhopdongDB(edt_TGBD, edt_TGKT, edt_hoahong, conn))
    btnSave.grid(row=3, column=1, padx=10, pady=10)

def dkhopdongDB(TGBD, TGKT, HOAHONG, conn):
    #conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("EXEC DANGKI_HOPDONG @MADT=?, @TGBD=?, @TGKT=?, @HOAHONG=?",loggedInID, TGBD.get(), TGKT.get(), HOAHONG.get())
    conn.commit()
def dkchinhanh(conn):
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

    btnSave=Button(dkchinhanh,text="Lưu chi nhánh", command=lambda :dkchinhanhDB(edt_mahd,edt_diachi, conn))
    btnSave.grid(row=2, column=1, padx=10, pady=10)
def dkchinhanhDB(mahd, diachi, conn):
    #conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("EXEC DANGKI_CHINHANH_HOPDONG @MAHD=?, @DIACHI=?", mahd.get(), diachi.get())
    conn.commit()
def giahanHopdong(conn):
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

    btnSave = Button(giahanHopdong, text="Lưu thông tin hợp đồng", command= lambda :giahanhopdongDB(edt_mahd, edt_thoigian,
                                                                                                    edt_hoahong,conn))
    btnSave.grid(row=3, column=1, padx=10, pady=10)
def giahanhopdongDB(mahd, tgkt, hoahong, conn):
    #conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("EXEC GIAHAN_HOPDONG @MAHD=?, @TGKT=?, @HOAHONG=?, @ISACEPTED=1", mahd.get(), tgkt.get(), hoahong.get())
    conn.commit()

def doitacView(conn):
    doitac=Tk()
    doitac['bg'] = '#AC99F2'
    doitac.title("Chức năng cho đối tác")
    doitac.geometry("600x600")
    btnDkChinhanh=Button(doitac, text="Đăng kí chi nhánh cho hợp đồng", width=30, font='Time 10', border=5, padx=10, pady=20,
                        command=lambda:dkchinhanh(conn))
    btnDkHopdong = Button(doitac, text="Đăng kí hợp đồng", width=30, font='Time 10', border=5, padx=10,pady=20,
                        command=lambda:dkhopdong(conn))
    btnGiahan = Button(doitac, text="Gia hạn hợp đồng", width=30, font='Time 10', border=5, padx=10, pady=20,
                        command=lambda:giahanHopdong(conn))
    btnXemDanhSachDonHang = Button(doitac, text="Xem danh sách đơn hàng", width=30, font='Time 10', border=5, padx=10, pady=20,
                        command=lambda:danhsachdonhang(conn))
    btnXemDanhSachHopDong = Button(doitac, text="Xem danh sách hợp đồng", width=30, font='Time 10', border=5, padx=10,pady=20,
                        command=lambda:danhsachhopdong(conn))
    btnXemDanhSachChiNhanh=Button(doitac, text="Xem danh sách chi nhánh", width=30, font='Time 10', border=5, padx=10, pady=20,
                        command=lambda:danhsachchinhanh(conn))

    btnXemDanhSachDonHang.grid(row=0, column=0, padx=10, pady=10)
    btnDkChinhanh.grid(row=0, column=1, padx=10, pady=10)
    btnGiahan.grid(row=1, column=0, padx=10, pady=10)
    btnXemDanhSachHopDong.grid(row=1, column=1, padx=10, pady=10)
    btnDkHopdong.grid(row=2, column=0, padx=10, pady=10)
    btnXemDanhSachChiNhanh.grid(row=2, column=1, padx=10, pady=10)