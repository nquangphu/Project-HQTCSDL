import AdminView
from tkinter import *
global loggedInID

def XemDanhSachDonHangKV():
    conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("exec HIENTHI_DSDH ?", loggedInID)
    records = cursor.fetchall()
    AdminView.view(["MaDH", "MAKH", "MADT", "MATX", "HINHTHUCTT", "NGAYTAO", "DIACHIGH", "PHISP",
                    "TONGTIEN", "TRANGTHAISHP", "TRANGTHAITHANHTOAN"], records, "Danh sách đơn hàng")
    conn.commit()
def NhanDonHang():
    NhanDonHang = Tk()
    NhanDonHang.title("Nhân đơn hàng")

    label_madh = Label(NhanDonHang, text='Điền mã đơn hàng')
    edt_madh = Entry(NhanDonHang, width=50)

    label_madh.grid(row=0, column=0, padx=10, pady=10)
    edt_madh.grid(row=0, column=1, padx=10, pady=10)

    btnSave = Button(NhanDonHang, text="Xem", command=lambda: NhanDonHangDB(edt_madh))
    btnSave.grid(row=1, column=1, padx=10, pady=10)
def NhanDonHangDB(madh):
    conn = AdminView.connectdb("", "")
    cursor = conn.cursor()
    cursor.execute("exec NHAN_DONHANG ?, ?",madh.get(), loggedInID)
    conn.commit()
def taixeView():
    taixe = Tk()
    taixe['bg'] = '#AC99F2'
    taixe.title("Chức năng cho tài xế")
    taixe.geometry("600x600")

    btnXemDanhSachDonHang = Button(taixe, text="Xem danh sách đơn hàng trong khu vực", width=30, font='Time 10', border=5, padx=10,
                          pady=20,
                          command=XemDanhSachDonHangKV)
    btnNhanDonHang= Button(taixe, text="Nhận đơn hàng", width=30, font='Time 10', border=5, padx=10,
                          pady=20, command=NhanDonHang)

    btnXemDanhSachDonHang.grid(row=0, column=0, padx=10, pady=10)
    btnNhanDonHang.grid(row=0, column=1, padx=10, pady=10)
