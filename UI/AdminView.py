from tkinter import *
from  tkinter import ttk

#======================= connect database =======================
import pyodbc as pyodbc

def view(fields,records,title):
    win=Tk()
    win.title(title)
    table=create_table(fields,win, records)
    table.pack()

def connectdb(server, dbname):
    conn = pyodbc.connect('Driver={SQL Server};'
                  'Server=DESKTOP-G9QD9GB\MYSQLSERVER;'
                  'Database=ONLINESHOP;'
                  'Trusted_Connection=yes;')
    return conn

def create_table(fields, tk, records):
    frame = Frame(tk)
    frame.pack()

    # scrollbar
    Scroll = Scrollbar(frame)
    Scroll.pack(side=RIGHT, fill=Y)

    Scroll = Scrollbar(frame, orient='horizontal')
    Scroll.pack(side=BOTTOM, fill=X)

    table = ttk.Treeview(frame, yscrollcommand=Scroll.set, xscrollcommand=Scroll.set)

    table.pack()

    Scroll.config(command=table.yview)
    Scroll.config(command=table.xview)

    # define our column
    table['columns'] = (fields)

    # format our column
    table.column("#0", width=0, stretch=NO)
    for b in fields:
        table.column(b, anchor=CENTER, width=80)

    # Create Headings
    table.heading("#0", text="", anchor=CENTER)
    for b in fields:
        table.heading(b, text=b, anchor=CENTER)
    i=0
    for record in records:
        l = []
        for j in record:
            l.append(j)
        table.insert(parent='', index='end', iid=i, text='', values=l)
        i = i + 1
    return table
def AdminView():

    admin=Tk()
    admin['bg'] = '#AC99F2'
    admin.title("Chức năng cho Quản trị")
    admin.geometry("600x600")
    btnDSTK=Button(admin, text="Xem danh sách tài khoản",width=30, font='Time 10', border=5, padx=10, pady=20, command=danhsachtaikhoan)
    btnDSHDChuaDuyet = Button(admin, text="Xem danh sách hợp đồng chưa duyệt", font='Time 10',width=30, border=5, padx=10, pady=20, command=xemdshopdongchuaduyet)

    btnDSHDDaDuyet= Button(admin, text="Xem danh sách hợp đồng đã duyệt", font='Time 10', border=5,width=30, padx=10, pady=20,command=xemdshopdongdaduyet)
    btnDuyetHD=Button(admin, text="Duyệt hợp đồng", font='Time 10', border=5, padx=10,width=30, pady=20, command=duyethopdong)
    btnCapNhatTK = Button(admin, text="Cập nhật tài khoản", font='Time 10',width=30, border=5,
                                   padx=10, pady=20, command=capnhattaikhoan)
    btnThongBaoGH = Button(admin, text="Thông báo gia hạn", font='Time 10',width=30, border=5,
                          padx=10, pady=20, command=thongbaogiahan)

    btnDSTK.grid(row=0, column=0, padx=10, pady=10)
    btnDSHDChuaDuyet.grid(row=0, column=1, padx=10, pady=10)
    btnDSHDDaDuyet.grid(row=1, column=0, padx=10, pady=10)
    btnDuyetHD.grid(row=1, column=1, padx=10, pady=10)
    btnCapNhatTK.grid(row=2, column=0, padx=10, pady=10)
    btnThongBaoGH.grid(row=2, column=1, padx=10, pady=10)
def danhsachtaikhoan():
    conn=connectdb("","")
    cursor = conn.cursor()
    cursor.execute('Exec XEM_DS_TK')
    records = cursor.fetchall()
    view(("ID","Username","Password","Staff","Admin","Phone","Email","Address","State"),records,"Danh sách tài khoản")

def xemdshopdongchuaduyet():
    xemdshopdongchuaduyet=Tk()
    xemdshopdongchuaduyet.title("Danh sách hợp đồng chưa duyệt")

    label_madt = Label(xemdshopdongchuaduyet, text='Điền mã đối tác')
    edt_madt = Entry(xemdshopdongchuaduyet, width=50)

    label_madt.grid(row=0, column=0, padx=10, pady=10)
    edt_madt.grid(row=0, column=1, padx=10, pady=10)

    btnSave = Button(xemdshopdongchuaduyet, text="Xem", command=lambda :dshopdongchuaduyet(edt_madt))
    btnSave.grid(row=2, column=1, padx=10, pady=10)
def dshopdongchuaduyet(entry):
    conn = connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("EXEC XEM_DSHD_CHUADUYET @MADT=?",entry.get())
    records = cursor.fetchall()
    view(("ID", "DoiTac", "SLChiNhanh", "StartTime", "EndTime","Tips","Status"), records, "Danh sách hợp đồng đã duyệt")

def xemdshopdongdaduyet():
    xemdshopdongchuaduyet=Tk()
    xemdshopdongchuaduyet.title("Danh sách hợp đồng đã duyệt")

    label_madt = Label(xemdshopdongchuaduyet, text='Điền mã đối tác')
    edt_madt = Entry(xemdshopdongchuaduyet, width=50)

    label_madt.grid(row=0, column=0, padx=10, pady=10)
    edt_madt.grid(row=0, column=1, padx=10, pady=10)

    btnSave = Button(xemdshopdongchuaduyet, text="Xem", command=lambda :dshopdongdaduyet(edt_madt))
    btnSave.grid(row=2, column=1, padx=10, pady=10)
def dshopdongdaduyet(entry):
    conn = connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("EXEC XEM_DSHD_DADUYET @MADT=?",entry.get())
    records = cursor.fetchall()
    print(records)
    view(("ID", "DoiTac", "SLChiNhanh", "StartTime", "EndTime","Tips","Status"), records, "Danh sách hợp đồng đã duyệt")

def duyethopdong():
    duyethopdong=Tk()
    duyethopdong.title("Duyệt hợp đồng")

    label_madt = Label(duyethopdong, text='Điền mã đối tác cần xét duyệt')
    edt_madt = Entry(duyethopdong, width=50)

    label_madt.grid(row=0, column=0, padx=10, pady=10)
    edt_madt.grid(row=0, column=1, padx=10, pady=10)

    btnSave = Button(duyethopdong, text="Duyêt hợp đồng", command=lambda :duyet(edt_madt,duyethopdong))
    btnSave.grid(row=2, column=1, padx=10, pady=10)

def duyet(entry,view):

    conn = connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("EXEC DUYET_HOPDONG @MADT=?", entry.get())
    conn.commit()
    view.destroy()

def capnhattaikhoan():
    capnhattaikhoan=Tk()
    capnhattaikhoan.title("Cập nhật tài khoản")

    label_matk = Label(capnhattaikhoan, text='Điền mã tài khoản cần sửa')
    edt_matk = Entry(capnhattaikhoan, width=50)

    label_username = Label(capnhattaikhoan, text='Username mới')
    edt_username = Entry(capnhattaikhoan, width=50)

    label_password = Label(capnhattaikhoan, text='Mật khẩu mới')
    edt_password = Entry(capnhattaikhoan, width=50)

    label_isStaff = Label(capnhattaikhoan, text='Có là nhân viên không (0/1)')
    edt_isStaff = Entry(capnhattaikhoan, width=50)

    label_isAdmin = Label(capnhattaikhoan, text='Có là quản trị không (0/1)')
    edt_isAdmin= Entry(capnhattaikhoan, width=50)

    label_phone = Label(capnhattaikhoan, text='Số điện thoại mới')
    edt_phone = Entry(capnhattaikhoan, width=50)

    label_email = Label(capnhattaikhoan, text='Email mới')
    edt_email = Entry(capnhattaikhoan, width=50)

    label_address = Label(capnhattaikhoan, text='Địa chỉ mới')
    edt_address = Entry(capnhattaikhoan, width=50)

    label_matk.grid(row=0, column=0, padx=10, pady=10)
    edt_matk.grid(row=0, column=1, padx=10, pady=10)

    label_username.grid(row=1, column=0, padx=10, pady=10)
    edt_username.grid(row=1, column=1, padx=10, pady=10)

    label_password.grid(row=2, column=0, padx=10, pady=10)
    edt_password.grid(row=2, column=1, padx=10, pady=10)

    label_isStaff.grid(row=3, column=0, padx=10, pady=10)
    edt_isStaff.grid(row=3, column=1, padx=10, pady=10)

    label_isAdmin.grid(row=4, column=0, padx=10, pady=10)
    edt_isAdmin.grid(row=4, column=1, padx=10, pady=10)

    label_phone.grid(row=5, column=0, padx=10, pady=10)
    edt_phone.grid(row=5, column=1, padx=10, pady=10)

    label_email.grid(row=6, column=0, padx=10, pady=10)
    edt_email.grid(row=6, column=1, padx=10, pady=10)

    label_address.grid(row=7, column=0, padx=10, pady=10)
    edt_address.grid(row=7, column=1, padx=10, pady=10)

    btnSave = Button(capnhattaikhoan, text="Cập nhật tài khoản",
                     command=lambda :capnhattaikhoanDB(capnhattaikhoan,edt_matk,edt_username,edt_password,edt_isStaff,edt_isAdmin,edt_phone,edt_email,edt_address))
    btnSave.grid(row=8, column=1, padx=10, pady=10)
def capnhattaikhoanDB(view, matk, username, password, isStaff, isAdmin, phone, email, address):

    conn = connectdb("", "")
    cursor = conn.cursor()
    print(matk.get(),username.get(),password.get(),isStaff.get(),isAdmin.get(),phone.get(),email.get(),address.get())
    cursor.execute('Exec CAPNHAT_TAIKHOAN @MATK=?, @USERNAME=?, @PASS=?, @ISSTAFF=?, @ISSUPPERUSER=?, @SDT=?, @EMAIL=?, @DIACHI=?',
                   matk.get(),username.get(),password.get(),isStaff.get(),isAdmin.get(),phone.get(),email.get(),address.get())
    conn.commit()
    view.destroy()

def thongbaogiahan():
    thongbaogiahan=Tk()
    thongbaogiahan.title("Mã đối tác")

    label_madt = Label(thongbaogiahan, text='Điền mã đối tác')
    edt_madt = Entry(thongbaogiahan, width=50)

    label_madt.grid(row=0, column=0, padx=10, pady=10)
    edt_madt.grid(row=0, column=1, padx=10, pady=10)

    btnSave = Button(thongbaogiahan, text="Xem", command=lambda: thongbaogiahanDB(edt_madt))
    btnSave.grid(row=2, column=1, padx=10, pady=10)
def thongbaogiahanDB(madt):
    conn = connectdb("", "")
    cursor = conn.cursor()
    cursor.execute('Exec THONGBAO_GIAHAN @MADT=?',madt.get())
    records = cursor.fetchall()
    view(["ID", "DoiTac", "SLChiNhanh", "StartTime", "EndTime", "Tips", "Status"],records,"Thông báo gia hạn")
