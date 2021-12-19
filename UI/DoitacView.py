from tkinter import *
from types import GenericAlias
import AdminView
global loggedInID

def danhsachdonhang(conn):
    cursor = conn.cursor()
    cursor.execute("EXEC XEM_DS_DONHANG_DT @MADT=?",loggedInID)
    records = cursor.fetchall()
    AdminView.view(("Mã đơn hàng", "Mã khách hàng", "Mã đối tác", "Mã tài xế", "HT thanh toán", "Ngày tạo", "Địa chỉ giao hàng",
                    "Tiền sản phẩm", "Phí vận chuyển","Tổng tiền","Trạng thái vận chuyển","Trang thái thanh toán"), records, "DS đơn hàng")

def danhsachchinhanh(conn):
    cursor = conn.cursor()
    cursor.execute("select HOPDONG.MAHD, CHINHANH.MACN, CHINHANH.DIACHI  from CHINHANH, HOPDONG where HOPDONG.MADT=? AND HOPDONG.MAHD=CHINHANH.MAHD"
                   , loggedInID)
    records = cursor.fetchall()
    AdminView.view(("Mã hợp đồng", "Mã chi nhánh", "Địa chỉ chi nhánh"), records, "DS chi nhánh")

def danhsachhopdong(conn):
    cursor = conn.cursor()
    cursor.execute("Select * from ONLINESHOP.dbo.HOPDONG where MADT=?", loggedInID)
    records = cursor.fetchall()
    AdminView.view(("Mã hợp đồng", "Mã đối tác", "SL chi nhánh", "TGBD", "TGKT", "Hoa hồng", "Trạng thái"), records,
         "DS hợp đồng của đối tác")

def dkhopdong(conn):
    dkhopdong=Tk()
    dkhopdong.title("Đăng kí hợp đồng")
    dkhopdong['bg'] = '#AC99F2'
    dkhopdong.geometry("600x300")

    fr1 = Frame(dkhopdong)
    label_TGBD = Label(fr1, text='Thời gian bắt đầu:', width=20)
    edt_TGBD = Entry(fr1, width=30, bg='#CDE6FF')

    fr2 = Frame(dkhopdong)
    label_TGKT = Label(fr2, text='Thời gian kết thúc:', width=20)
    edt_TGKT = Entry(fr2, width=30, bg='#CDE6FF')

    fr3 = Frame(dkhopdong)
    label_hoahong = Label(fr3, text='Hoa hồng:', width=20)
    edt_hoahong = Entry(fr3, width=30, bg='#CDE6FF')

    fr1.pack(padx=10, pady=10)
    fr2.pack(padx=10, pady=10)
    fr3.pack(padx=10, pady=10)

    label_TGBD.pack(side=LEFT, padx=5)
    edt_TGBD.pack(side=RIGHT)

    label_TGKT.pack(side=LEFT, padx=5)
    edt_TGKT.pack(side=RIGHT)

    label_hoahong.pack(side=LEFT, padx=5)
    edt_hoahong.pack(side=RIGHT)

    btnSave = Button(dkhopdong, text="Đăng kí", width=15, bg='#F4FF89', activebackground='#4551FC', activeforeground='white',
                command=lambda:dkhopdongDB(edt_TGBD, edt_TGKT, edt_hoahong, conn))
    btnSave.pack(pady=20)

def dkhopdongDB(TGBD, TGKT, HOAHONG, conn):
    cursor = conn.cursor()
    cursor.execute("EXEC DANGKI_HOPDONG @MADT=?, @TGBD=?, @TGKT=?, @HOAHONG=?",loggedInID, TGBD.get(), TGKT.get(), HOAHONG.get())
    conn.commit()

def dkchinhanh(conn):
    dkchinhanh=Tk()
    dkchinhanh.title("Đăng kí chi nhánh cho hợp đồng")
    dkchinhanh.geometry("600x300")
    dkchinhanh['bg'] = '#AC99F2'

    fr1 = Frame(dkchinhanh, border=2)
    label_mahd=Label(fr1,text='Điền mã hợp đồng của đối tác:', width=30)
    edt_mahd=Entry(fr1, width=20, bg='#CDE6FF')

    fr2 = Frame(dkchinhanh, border=2)
    label_diachi = Label(fr2, text='Điền địa chỉ của chi nhánh:', width=30)
    edt_diachi = Entry(fr2, width=20, bg='#CDE6FF')

    fr1.pack(padx=10, pady=30)
    fr2.pack(padx=10, pady=30)

    label_mahd.pack(side=LEFT)
    edt_mahd.pack(side=RIGHT, padx=5)

    label_diachi.pack(side=LEFT)
    edt_diachi.pack(side=RIGHT, padx=5)

    btnSave=Button(dkchinhanh, width=10, bg='#F4FF89', text="Lưu",
        command=lambda :dkchinhanhDB(edt_mahd,edt_diachi, conn), activebackground='#4551FC', activeforeground='white')
    btnSave.pack(padx=10, pady=10)

def dkchinhanhDB(mahd, diachi, conn):
    cursor = conn.cursor()
    cursor.execute("EXEC DANGKI_CHINHANH_HOPDONG @MAHD=?, @DIACHI=?", mahd.get(), diachi.get())
    conn.commit()
def giahanHopdong(conn):
    giahanHopdong=Tk()
    giahanHopdong.title("Gia hạn hợp đồng")
    giahanHopdong['bg'] = '#AC99F2'
    giahanHopdong.geometry("600x300")

    fr1 = Frame(giahanHopdong)
    label_mahd = Label(fr1, text='Điền mã hợp đồng cần gia hạn:', width=30)
    edt_mahd = Entry(fr1, width=20, bg='#CDE6FF')

    fr2 = Frame(giahanHopdong)
    label_thoigian = Label(fr2, text='Thời gian gia hạn:', width=30)
    edt_thoigian = Entry(fr2, width=20, bg='#CDE6FF')

    fr3 = Frame(giahanHopdong)
    label_hoahong = Label(fr3, text='Điền hoa hồng:', width=30)
    edt_hoahong = Entry(fr3, width=20, bg='#CDE6FF')

    fr1.pack(padx=10, pady=10)
    fr2.pack(padx=10, pady=10)
    fr3.pack(padx=10, pady=10)

    label_mahd.pack(side=LEFT, padx=5)
    edt_mahd.pack(side=RIGHT)

    label_thoigian.pack(side=LEFT, padx=5)
    edt_thoigian.pack(side=RIGHT)

    label_hoahong.pack(side=LEFT, padx=5)
    edt_hoahong.pack(side=RIGHT)

    btnSave = Button(giahanHopdong, text="Lưu", width=10, bg='#F4FF89', activebackground='#4551FC', activeforeground='white', 
        command= lambda :giahanhopdongDB(edt_mahd, edt_thoigian,edt_hoahong,conn))
    btnSave.pack(pady=20)

def giahanhopdongDB(mahd, tgkt, hoahong, conn):
    #conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("EXEC GIAHAN_HOPDONG @MAHD=?, @TGKT=?, @HOAHONG=?, @ISACEPTED=1", mahd.get(), tgkt.get(), hoahong.get())
    conn.commit()

def doitacView(conn):
    doitac=Tk()
    doitac['bg'] = '#AC99F2'
    doitac.title("Chức năng đối tác")
    doitac.geometry("700x400")

    fr1 = Frame(doitac, bg='#AC99F2')
    btnDkChinhanh=Button(fr1, text="Đăng kí chi nhánh cho hợp đồng", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:dkchinhanh(conn), activebackground='#4551FC', activeforeground='white')
    btnDkHopdong = Button(fr1, text="Đăng kí hợp đồng", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:dkhopdong(conn), activebackground='#4551FC', activeforeground='white')
    
    fr2 = Frame(doitac, bg='#AC99F2')
    btnGiahan = Button(fr2, text="Gia hạn hợp đồng", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:giahanHopdong(conn), activebackground='#4551FC', activeforeground='white')
    btnXemDanhSachDonHang = Button(fr2, text="Xem danh sách đơn hàng", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:danhsachdonhang(conn), activebackground='#4551FC', activeforeground='white')

    fr3 = Frame(doitac, bg='#AC99F2')
    btnXemDanhSachHopDong = Button(fr3, text="Xem danh sách hợp đồng", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:danhsachhopdong(conn), activebackground='#4551FC', activeforeground='white')
    btnXemDanhSachChiNhanh=Button(fr3, text="Xem danh sách chi nhánh", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:danhsachchinhanh(conn), activebackground='#4551FC', activeforeground='white')


    fr1.pack(padx=10,pady=20)
    fr2.pack(padx=10,pady=20)
    fr3.pack(padx=10,pady=20)

    btnXemDanhSachDonHang.pack(side=LEFT, padx=10)
    btnDkChinhanh.pack(side=RIGHT, padx=10)
    btnGiahan.pack(side=LEFT, padx=10)
    btnXemDanhSachHopDong.pack(side=RIGHT, padx=10)
    btnDkHopdong.pack(side=LEFT, padx=10)
    btnXemDanhSachChiNhanh.pack(side=RIGHT, padx=10)