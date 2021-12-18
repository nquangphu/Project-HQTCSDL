from tkinter import *
from  tkinter import ttk
from tkinter import messagebox

def view(fields,records,title):
    win=Tk()
    win.title(title)
    table=create_table(fields,win, records)
    table.pack()

def create_table(fields, tk, records):
    frame = Frame(tk)
    frame.pack()

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
        table.column(b, anchor=CENTER)

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


def danhsachtaikhoan(conn):
    #conn=connectdb("DESKTOP-EC6UGJB","ONLINESHOP")
    cursor = conn.cursor()
    cursor.execute('Exec XEM_DS_TK')
    records = cursor.fetchall()
    view(("ID","Username","Password","Staff","Admin","Phone","Email","Address","State"),records,"Danh sách tài khoản")

def xemdshopdongchuaduyet(conn):
    xemdshopdongchuaduyet=Tk()
    xemdshopdongchuaduyet.title("Danh sách hợp đồng chưa duyệt")
    xemdshopdongchuaduyet.geometry("300x200")
    xemdshopdongchuaduyet['bg'] = '#AC99F2'

    fr = Frame(xemdshopdongchuaduyet, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=20, bg='#CDE6FF')
    fr.pack(padx=10, pady=30)
    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(xemdshopdongchuaduyet, width=10, bg='#F4FF89', text="Xem", command=lambda:dshopdongchuaduyet(edt_madt, conn))
    btnSave.pack(padx=10, pady=10)

def dshopdongchuaduyet(entry, conn):
    #conn = connectdb("DESKTOP-EC6UGJB", "ONLINESHOP")
    cursor = conn.cursor()
    cursor.execute("EXEC XEM_DSHD_CHUADUYET @MADT=?",entry.get())
    records = cursor.fetchall()
    view(("ID", "DoiTac", "SLChiNhanh", "StartTime", "EndTime","Tips","Status"), records, "Danh sách hợp đồng đã duyệt")

def xemdshopdongdaduyet(conn):
    xemdshopdongdaduyet=Tk()
    xemdshopdongdaduyet.title("DS hợp đồng đã duyệt")
    xemdshopdongdaduyet.geometry("300x200")
    xemdshopdongdaduyet['bg'] = '#AC99F2'

    fr = Frame(xemdshopdongdaduyet, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=20, bg='#CDE6FF')
    fr.pack(padx=10, pady=30)

    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(xemdshopdongdaduyet, width=10, bg='#F4FF89', text="Xem", command=lambda:dshopdongdaduyet(edt_madt, conn))
    btnSave.pack(padx=10, pady=10)

def dshopdongdaduyet(entry, conn):
    cursor = conn.cursor()
    cursor.execute("EXEC XEM_DSHD_DADUYET @MADT=?",entry.get())
    records = cursor.fetchall()
    view(("Mã hợp đồng", "Mã đối tác", "SL chi nhánh", "TGBD", "TGKT","Hoa hồng","Trạng thái"), records, "Danh sách hợp đồng đã duyệt")

def duyethopdong(conn):
    duyethopdong=Tk()
    duyethopdong.title("Duyệt hợp đồng")
    duyethopdong.geometry("300x200")
    duyethopdong['bg'] = '#AC99F2'

    fr = Frame(duyethopdong, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=20, bg='#CDE6FF')

    fr.pack(padx=10, pady=30)
    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(duyethopdong, width=10, bg='#F4FF89', text="Duyệt", command=lambda:duyet(edt_madt,duyethopdong, conn))
    btnSave.pack(padx=10, pady=10)

def duyet(entry,view, conn):

    #conn = connectdb("DESKTOP-EC6UGJB", "ONLINESHOP")
    cursor = conn.cursor()
    cursor.execute("EXEC DUYET_HOPDONG @MADT=?", entry.get())
    conn.commit()
    view.destroy()
    messagebox.showinfo("Thông báo", "Duyệt thành công!")

def capnhattaikhoan(conn):
    capnhattaikhoan=Tk()
    capnhattaikhoan.title("Cập nhật tài khoản")
    capnhattaikhoan['bg'] = '#AC99F2'
    capnhattaikhoan.geometry("600x400")

    fr1 = Frame(capnhattaikhoan)
    label_matk = Label(fr1,     text='Mã tài khoản:', width=20)
    edt_matk = Entry(fr1, width=30, bg='#CDE6FF')

    fr2 = Frame(capnhattaikhoan)
    label_username = Label(fr2, text='Tài khoản:', width=20)
    edt_username = Entry(fr2, width=30, bg='#CDE6FF')

    fr3 = Frame(capnhattaikhoan)
    label_password = Label(fr3, text='Mật khẩu:', width=20)
    edt_password = Entry(fr3, width=30, bg='#CDE6FF')

    fr4 = Frame(capnhattaikhoan)
    label_isStaff = Label(fr4, text='Là nhân viên? (0 or 1):', width=20)
    edt_isStaff = Entry(fr4, width=30, bg='#CDE6FF')

    fr5 = Frame(capnhattaikhoan)
    label_isAdmin = Label(fr5, text='Là quản trị? (0 or 1):', width=20)
    edt_isAdmin= Entry(fr5, width=30, bg='#CDE6FF')

    fr6 = Frame(capnhattaikhoan)
    label_phone = Label(fr6,   text='Số điện thoại:', width=20)
    edt_phone = Entry(fr6, width=30, bg='#CDE6FF')

    fr7 = Frame(capnhattaikhoan)
    label_email = Label(fr7, text='Email:', width=20)
    edt_email = Entry(fr7, width=30, bg='#CDE6FF') 

    fr8 = Frame(capnhattaikhoan)
    label_address = Label(fr8, text='Địa chỉ:', width=20)
    edt_address = Entry(fr8, width=30, bg='#CDE6FF')

    fr1.pack(padx=10, pady=10)
    fr2.pack(padx=10, pady=10)
    fr3.pack(padx=10, pady=10)
    fr4.pack(padx=10, pady=10)
    fr5.pack(padx=10, pady=10)
    fr6.pack(padx=10, pady=10)
    fr7.pack(padx=10, pady=10)
    fr8.pack(padx=10, pady=10)

    label_matk.pack(side=LEFT, padx=5)
    edt_matk.pack(side=RIGHT)

    label_username.pack(side=LEFT, padx=5)
    edt_username.pack(side=RIGHT)

    label_password.pack(side=LEFT, padx=5)
    edt_password.pack(side=RIGHT)

    label_isStaff.pack(side=LEFT, padx=5)
    edt_isStaff.pack(side=RIGHT)

    label_isAdmin.pack(side=LEFT, padx=5)
    edt_isAdmin.pack(side=RIGHT)

    label_phone.pack(side=LEFT, padx=5)
    edt_phone.pack(side=RIGHT)

    label_email.pack(side=LEFT, padx=5)
    edt_email.pack(side=RIGHT)

    label_address.pack(side=LEFT, padx=5)
    edt_address.pack(side=RIGHT)

    btnSave = Button(capnhattaikhoan, text="Cập nhật", width=15, bg='#F4FF89',
        command=lambda :capnhattaikhoanDB(capnhattaikhoan,edt_matk,edt_username,edt_password,edt_isStaff,edt_isAdmin,edt_phone,edt_email,edt_address, conn))
    btnSave.pack(pady=20)

def capnhattaikhoanDB(view, matk, username, password, isStaff, isAdmin, phone, email, address, conn):
    cursor = conn.cursor()
    print(matk.get(),username.get(),password.get(),isStaff.get(),isAdmin.get(),phone.get(),email.get(),address.get())
    cursor.execute('Exec CAPNHAT_TAIKHOAN @MATK=?, @USERNAME=?, @PASS=?, @ISSTAFF=?, @ISSUPPERUSER=?, @SDT=?, @EMAIL=?, @DIACHI=?',
                   matk.get(),username.get(),password.get(),isStaff.get(),isAdmin.get(),phone.get(),email.get(),address.get())
    conn.commit()
    messagebox.showinfo("Thông báo", "Cập nhật thành công!")


def thongbaogiahan(conn):
    thongbaogiahan=Tk()
    thongbaogiahan.title("Xem hợp đồng đến hạn")
    thongbaogiahan.geometry("300x200")
    thongbaogiahan['bg'] = '#AC99F2'

    fr = Frame(thongbaogiahan, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=20, bg='#CDE6FF')

    fr.pack(padx=10, pady=30)
    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(thongbaogiahan, width=10, bg='#F4FF89', text="Xem", command=lambda:thongbaogiahanDB(edt_madt, conn))
    btnSave.pack(padx=10, pady=10)

def thongbaogiahanDB(madt, conn):
    cursor = conn.cursor()
    cursor.execute('Exec THONGBAO_GIAHAN @MADT=?',madt.get())
    records = cursor.fetchall()
    view(["Mã hợp đồng", "Mã đối tác", "SL chi nhánh", "TGBD", "TGKT", "Hoa hồng", "Trạng thái"],records,"Thông báo gia hạn")


#================================ MAIN VIEW ================================#
def AdminView(conn):
    admin=Tk()
    admin['bg'] = '#AC99F2'
    admin.title("Chức năng quản trị")
    admin.geometry("600x400")
    
    fr1 = Frame(admin, bg='#AC99F2')
    btnDSTK=Button(fr1, text="Xem DS tài khoản", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:danhsachtaikhoan(conn), activebackground='#4551FC', activeforeground='white')
    btnDSHDChuaDuyet = Button(fr1, text="Xem DS hợp đồng chưa duyệt", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11', 
                        command=lambda:xemdshopdongchuaduyet(conn), activebackground='#4551FC', activeforeground='white')

    fr2 = Frame(admin, bg='#AC99F2')
    btnDSHDDaDuyet= Button(fr2, text="Xem DS hợp đồng đã duyệt", border=2, width=30, height=3, bg='#FDFFB2', font='Time 11',
                        command=lambda:xemdshopdongdaduyet(conn), activebackground='#4551FC', activeforeground='white')
    btnDuyetHD=Button(fr2, text="Duyệt hợp đồng", border=2, width=30, height=3, bg='#FDFFB2', font='Time 11',
                        command=lambda:duyethopdong(conn), activebackground='#4551FC', activeforeground='white')

    fr3 = Frame(admin, bg='#AC99F2')
    btnCapNhatTK = Button(fr3, text="Cập nhật tài khoản", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:capnhattaikhoan(conn), activebackground='#4551FC', activeforeground='white')
    btnThongBaoGH = Button(fr3, text="Thông báo gia hạn", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:thongbaogiahan(conn), activebackground='#4551FC', activeforeground='white')

    fr1.pack(padx=10,pady=20)
    fr2.pack(padx=10,pady=20)
    fr3.pack(padx=10,pady=20)

    btnDSTK.pack(side=LEFT, padx=10)
    btnDSHDChuaDuyet.pack(side=RIGHT, padx=10)
    btnDSHDDaDuyet.pack(side=LEFT, padx=10)
    btnDuyetHD.pack(side=RIGHT, padx=10)
    btnCapNhatTK.pack(side=LEFT, padx=10)
    btnThongBaoGH.pack(side=RIGHT, padx=10)
    
    #DESKTOP-EC6UGJB
