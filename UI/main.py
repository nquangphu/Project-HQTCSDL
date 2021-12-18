# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
from tkinter import *
import DoitacView, AdminView


# Press the green button in the gutter to run the script.


root= Tk()
root.title("Hello user")
root.geometry("800x800")

w = Scrollbar(root)
w.pack(side=RIGHT, fill=Y)

btnKhachhang=Button(root, text="Khách hàng",width=100, font='Time 20 bold',border=10, padx=20, pady=40, command=DoitacView.doitacView)
btnKhachhang.pack(pady=10)

btnTaixe=Button(root, text="Tài xế",width=100, font='Time 20 bold',border=10, padx=20, pady=40, command=DoitacView.doitacView)
btnTaixe.pack(pady=10)

btnDoitac=Button(root, text="Đối tác",width=100, font='Time 20 bold',border=10, padx=20, pady=40, command=DoitacView.doitacView)
btnDoitac.pack(pady=10)

btnAdmin=Button(root, text="Quản trị",width=100, font='Time 20 bold',border=10, padx=20, pady=40, command=AdminView.AdminView)
btnAdmin.pack(pady=10)


root.mainloop()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
