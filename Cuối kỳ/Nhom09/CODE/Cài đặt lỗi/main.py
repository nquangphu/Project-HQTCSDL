from tkinter import *
from tkinter import messagebox
import tkinter
import Login
import pyodbc as pyodbc
import time

global conn

def connectdb():
    start = time.time()
    conn = pyodbc.connect('Driver={SQL Server};'
                  'Server=%s;'
                  'Database=ONLINESHOP;'
                  'Trusted_Connection=yes;'% (edt_servername.get()))
    end = time.time()
    if (end - start < 3000):
        Login.LoginView(conn)
    else:
        messagebox.showinfo("Thông báo", "Kết nối thất bại!")

windb = Tk()
windb.title("Kết nối máy chủ")
windb.geometry("350x150")
windb['bg'] = '#AC99F2'

db_frame = Frame(windb)
label_servername = Label(db_frame, text='Server Name :', underline=0)
edt_servername = Entry(db_frame, width=40, bg='#FDFCD9')
db_frame.pack(padx=20, pady=40)
label_servername.pack(side=LEFT)
edt_servername.pack(side=RIGHT)

btndb_frame = Frame(windb, bg='#AC99F2')
btnConn = Button(btndb_frame, text="Kết nối", width=10, bg='#3D50FF', fg='white', underline=0)
btnConn['command']=lambda:connectdb()

btnQuit = Button(btndb_frame, text="Thoát", width=10, bg='#D81E3D', fg='white', underline=0, command=windb.destroy)
btndb_frame.pack()
btnConn.pack(side=LEFT, padx=20)
btnQuit.pack(side=RIGHT, padx=20)

windb.mainloop()
