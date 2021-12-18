from tkinter import *
import AdminView
import DoitacView
import KhachhangView
import TaixeView

def Login(username, password):

    conn=AdminView.connectdb("","")
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


    if (len(admin)>0):
         AdminView.AdminView()
    if (len(doitac)>0):
        DoitacView.loggedInID=doitac[0][0]
        DoitacView.doitacView()
    if (len(khachhang)>0):
        KhachhangView.loggedInID=khachhang[0][0]
        KhachhangView.khachhangView()
    if (len(taixe)>0):
        TaixeView.loggedInID=taixe[0][0]
        TaixeView.taixeView()



root= Tk()
root.title("Hello user")

label_username = Label(root, text='Username')
edt_username = Entry(root, width=50)

label_password = Label(root, text='Password')
edt_password = Entry(root, width=50)

label_username.grid(row=0, column=0, padx=10, pady=10)
edt_username.grid(row=0, column=1, padx=10, pady=10)

label_password.grid(row=1, column=0, padx=10, pady=10)
edt_password.grid(row=1, column=1, padx=10, pady=10)

btnSave = Button(root, text="Login", command=lambda :Login(edt_username,edt_password))
btnSave.grid(row=2, column=1, padx=10, pady=10)
root.mainloop()
