from tkinter import *
from tkinter import font
import AdminView
import DoitacView
import KhachHangView
import TaixeView
from tkinter import messagebox

def Login(username, password, conn):
    #conn=AdminView.connectdb("DESKTOP-EC6UGJB","ONLINESHOP")
    cursor = conn.cursor()

    cursor.execute('select * from ONLINESHOP.dbo.TAIKHOAN where ISSUPERUSER=1 and USERNAME=? and PASS=?'
                         ,username.get(),password.get())
    admin=cursor.fetchall()

    cursor.execute('select DOITAC.MADT from ONLINESHOP.dbo.TAIKHOAN, ONLINESHOP.dbo.DOITAC where USERNAME=? AND PASS=? AND TAIKHOAN.MATK=DOITAC.MATK'
                   , username.get(), password.get())
    doitac=cursor.fetchall()

    cursor.execute('select KHACHHANG.MAKH from TAIKHOAN, KHACHHANG where USERNAME=? AND PASS=? AND TAIKHOAN.MATK=KHACHHANG.MATK'
                   , username.get(), password.get())
    khachhang=cursor.fetchall()

    cursor.execute('select TAIXE.MATX from TAIKHOAN, TAIXE where USERNAME=? AND PASS=? AND TAIKHOAN.MATK=TAIXE.MATK'
                          , username.get(), password.get())
    taixe=cursor.fetchall()

    success = 0
    if (len(admin)>0):
        success = 1
        AdminView.AdminView(conn)
    if (len(doitac)>0):
        success = 1
        DoitacView.loggedInID=doitac[0][0]
        DoitacView.doitacView(conn)
    if (len(khachhang)>0):
        success = 1
        KhachHangView.loggedInID=khachhang[0][0]
        KhachHangView.khachhangView(conn)
    if (len(taixe)>0):
        success = 1
        TaixeView.loggedInID=taixe[0][0]
        TaixeView.taixeView(conn)
    if (success == 0):
        messagebox.showinfo("Thông báo", "Sai thông tin đăng nhập!")


def LoginView(conn):
    root= Tk()
    root.title("Đăng nhập")
    root.geometry("400x300")
    root['bg'] = '#AC99F2'

    label_login = Label(root, text=" Thông tin tài khoản ", font=20, pady = 10, bg='white')
    label_login.pack(side=TOP, pady=10)

    user_frame = Frame(root, border=2)
    label_username = Label(user_frame, text='Username :', underline=0)
    edt_username = Entry(user_frame, width=40, bg='#FDFCD9')
    user_frame.pack(padx=10, pady=10)
    label_username.pack(side=LEFT)
    edt_username.pack(side=RIGHT)

    pass_frame = Frame(root, border=2)
    label_password = Label(pass_frame, text='Password  :', underline=0)
    edt_password = Entry(pass_frame, width=40, show="*", bg='#FDFCD9')
    pass_frame.pack(padx=10, pady=10)
    label_password.pack(side=LEFT)
    edt_password.pack(side=RIGHT)

    btn_frame = Frame(root, bg='#AC99F2')
    btnSave = Button(btn_frame, text="Đăng nhập", width=10, bg='#3D50FF', fg='white', underline=0)
    btnSave['command']=lambda :Login(edt_username,edt_password, conn)
    btnExit = Button(btn_frame, text="Thoát", width=10, bg='#D81E3D', fg='white', underline=0, command=root.destroy)
    btnSave.pack(side=LEFT, padx=20)
    btnExit.pack(side=RIGHT, padx=20)
    btn_frame.pack(pady=40)
    root.mainloop()
