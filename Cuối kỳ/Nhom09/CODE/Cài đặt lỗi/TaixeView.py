import AdminView
from tkinter import *
global loggedInID

def XemDanhSachDonHangKV(conn):

    cursor = conn.cursor()
    cursor.execute("exec HIENTHI_DSDH_LOI ?", loggedInID)
    records = cursor.fetchall()
    AdminView.view(["Mã đơn hàng", "Mã khách hàng", "Mã đối tác", "Mã tài xế", "HTTT", "Ngày tạo", "Địa chỉ", "Tiền SP",
                    "Vận chuyển", "Tổng tiền", "TTVC", "TTTT"], records, "Danh sách đơn hàng")
    conn.commit()
def XemDanhSachDonHang_DaNhan(conn):

    cursor = conn.cursor()
    cursor.execute("exec XEM_DS_DONHANG_DANHAN ?", loggedInID)
    records = cursor.fetchall()
    AdminView.view(["Mã đơn hàng", "Mã khách hàng", "Mã đối tác", "Mã tài xế", "HTTT", "Ngày tạo", "Địa chỉ", "Tiền SP",
                    "Vận chuyển", "Tổng tiền", "TTVC", "TTTT"], records, "Danh sách đơn hàng")
    conn.commit()

def NhanDonHang(conn):
    NhanDonHang = Tk()
    NhanDonHang.title("Nhận đơn hàng")
    NhanDonHang['bg'] = '#AC99F2'
    NhanDonHang.geometry("300x200")

    fr1 = Frame(NhanDonHang, border=2)
    label_madh = Label(fr1, text='Điền mã đơn hàng:', width=20)
    edt_madh = Entry(fr1, width=20, bg='#CDE6FF')

    fr1.pack(padx=10, pady=30)
    label_madh.pack(side=LEFT)
    edt_madh.pack(side=RIGHT, padx=5)

    btnSave = Button(NhanDonHang, width=15, bg='#F4FF89', text="Nhận đơn hàng",
            command=lambda:NhanDonHangDB(edt_madh, conn), activebackground='#4551FC', activeforeground='white')
    btnSave.pack(padx=10, pady=10)

def NhanDonHangDB(madh, conn):
    cursor = conn.cursor()
    cursor.execute("exec NHAN_DONHANG_LOI ?, ?",madh.get(), loggedInID)
    conn.commit()


def taixeView(conn):
    taixe = Tk()
    taixe['bg'] = '#AC99F2'
    taixe.title("Chức năng cho tài xế")
    taixe.geometry("400x400")

    btnXemDanhSachDonHang = Button(taixe, text="Xem DS đơn hàng trong khu vực", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:XemDanhSachDonHangKV(conn), activebackground='#4551FC', activeforeground='white')
    btnNhanDonHang= Button(taixe, text="Nhận đơn hàng", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                        command=lambda:NhanDonHang(conn), activebackground='#4551FC', activeforeground='white')

    btnXemDanhSachDonHang_DaNhan = Button(taixe, text="Xem danh sách đơn hàng đã nhận", width=30, height=3, border=2, bg='#FDFFB2', font='Time 11',
                            command=lambda: XemDanhSachDonHang_DaNhan(conn), activebackground='#4551FC', activeforeground='white')

    btnXemDanhSachDonHang.pack(pady=20)
    btnNhanDonHang.pack(pady=20)
    btnXemDanhSachDonHang_DaNhan.pack(pady=20)
