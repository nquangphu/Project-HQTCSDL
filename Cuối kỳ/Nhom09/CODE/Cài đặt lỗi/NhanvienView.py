from tkinter import *
from tkinter import ttk
from tkinter import messagebox
import AdminView


def xemdshopdongchuaduyet(conn):
    xemdshopdongchuaduyet = Tk()
    xemdshopdongchuaduyet.title("Danh sách hợp đồng chưa duyệt")
    xemdshopdongchuaduyet.geometry("300x200")
    xemdshopdongchuaduyet['bg'] = '#AC99F2'

    fr = Frame(xemdshopdongchuaduyet, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=20, bg='#CDE6FF')
    fr.pack(padx=10, pady=30)
    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(xemdshopdongchuaduyet, width=10, bg='#F4FF89', text="Xem",
                     command=lambda: dshopdongchuaduyet(edt_madt, conn))
    btnSave.pack(padx=10, pady=10)


def dshopdongchuaduyet(entry, conn):
    # conn = connectdb("DESKTOP-EC6UGJB", "ONLINESHOP")
    cursor = conn.cursor()
    cursor.execute("EXEC XEM_DSHD_CHUADUYET @MADT=?", entry.get())
    records = cursor.fetchall()
    AdminView.view(("ID", "DoiTac", "SLChiNhanh", "StartTime", "EndTime", "Tips", "Status"), records,
         "Danh sách hợp đồng đã duyệt")


def xemdshopdongdaduyet(conn):
    xemdshopdongdaduyet = Tk()
    xemdshopdongdaduyet.title("DS hợp đồng đã duyệt")
    xemdshopdongdaduyet.geometry("300x200")
    xemdshopdongdaduyet['bg'] = '#AC99F2'

    fr = Frame(xemdshopdongdaduyet, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=20, bg='#CDE6FF')
    fr.pack(padx=10, pady=30)

    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(xemdshopdongdaduyet, width=10, bg='#F4FF89', text="Xem",
                     command=lambda: dshopdongdaduyet(edt_madt, conn))
    btnSave.pack(padx=10, pady=10)


def dshopdongdaduyet(entry, conn):
    cursor = conn.cursor()
    cursor.execute("EXEC XEM_DSHD_DADUYET @MADT=?", entry.get())
    records = cursor.fetchall()
    AdminView.view(("Mã hợp đồng", "Mã đối tác", "SL chi nhánh", "TGBD", "TGKT", "Hoa hồng", "Trạng thái"), records,
         "Danh sách hợp đồng đã duyệt")


def duyethopdong(conn):
    duyethopdong = Tk()
    duyethopdong.title("Duyệt hợp đồng")
    duyethopdong.geometry("300x200")
    duyethopdong['bg'] = '#AC99F2'

    fr = Frame(duyethopdong, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=20, bg='#CDE6FF')

    fr.pack(padx=10, pady=30)
    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(duyethopdong, width=10, bg='#F4FF89', text="Duyệt",
                     command=lambda: duyet(edt_madt, duyethopdong, conn))
    btnSave.pack(padx=10, pady=10)


def duyet(entry, view, conn):
    # conn = connectdb("DESKTOP-EC6UGJB", "ONLINESHOP")
    cursor = conn.cursor()
    cursor.execute("EXEC DUYET_HOPDONG @MADT=?", entry.get())
    conn.commit()
    view.destroy()
    messagebox.showinfo("Thông báo", "Duyệt thành công!")


def thongbaogiahan(conn):
    thongbaogiahan = Tk()
    thongbaogiahan.title("Xem hợp đồng đến hạn")
    thongbaogiahan.geometry("300x200")
    thongbaogiahan['bg'] = '#AC99F2'

    fr = Frame(thongbaogiahan, border=2)
    label_madt = Label(fr, text='Điền mã đối tác:')
    edt_madt = Entry(fr, width=20, bg='#CDE6FF')

    fr.pack(padx=10, pady=30)
    label_madt.pack(side=LEFT)
    edt_madt.pack(side=RIGHT, padx=5)

    btnSave = Button(thongbaogiahan, width=10, bg='#F4FF89', text="Xem",
                     command=lambda: thongbaogiahanDB(edt_madt, conn))
    btnSave.pack(padx=10, pady=10)


def thongbaogiahanDB(madt, conn):
    cursor = conn.cursor()
    cursor.execute('Exec THONGBAO_GIAHAN @MADT=?', madt.get())
    records = cursor.fetchall()
    AdminView.view(["Mã hợp đồng", "Mã đối tác", "SL chi nhánh", "TGBD", "TGKT", "Hoa hồng", "Trạng thái"], records,
         "Thông báo gia hạn")


# ================================ MAIN VIEW ================================#
def NhanvienView(conn):
    admin = Tk()
    admin['bg'] = '#AC99F2'
    admin.title("Chức năng nhân viên")
    admin.geometry("600x400")

    fr1 = Frame(admin, bg='#AC99F2')
    btnDSHDDaDuyet = Button(fr1, text="Xem DS hợp đồng đã duyệt", border=2, width=30, height=3, bg='#FDFFB2',
                            font='Time 11',
                            command=lambda: xemdshopdongdaduyet(conn), activebackground='#4551FC',
                            activeforeground='white')
    btnDSHDChuaDuyet = Button(fr1, text="Xem DS hợp đồng chưa duyệt", width=30, height=3, border=2, bg='#FDFFB2',
                              font='Time 11',
                              command=lambda: xemdshopdongchuaduyet(conn), activebackground='#4551FC',
                              activeforeground='white')

    fr2 = Frame(admin, bg='#AC99F2')

    btnDuyetHD = Button(fr2, text="Duyệt hợp đồng", border=2, width=30, height=3, bg='#FDFFB2', font='Time 11',
                        command=lambda: duyethopdong(conn), activebackground='#4551FC', activeforeground='white')

    btnThongBaoGH = Button(fr2, text="Thông báo gia hạn", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                           command=lambda: thongbaogiahan(conn), activebackground='#4551FC', activeforeground='white')

    fr1.pack(padx=10, pady=20)
    fr2.pack(padx=10, pady=20)

    btnDSHDChuaDuyet.pack(side=LEFT, padx=10)
    btnDSHDDaDuyet.pack(side=RIGHT, padx=10)
    btnDuyetHD.pack(side=LEFT, padx=10)
    btnThongBaoGH.pack(side=RIGHT, padx=10)
    # DESKTOP-EC6UGJB