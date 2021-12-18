from tkinter import *
from  tkinter import ttk
import pyodbc as pyodbc

#======================= connect database =======================

def connectdb(server, dbname):
    conn = pyodbc.connect('Driver={SQL Server};'
                  'Server=DESKTOP-EC6UGJB;'
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
        table.insert(parent='', index='end', iid=i, text='',values=l)
        i=i+1
    return table

def AdminView():

    admin=Tk()
    admin['bg'] = '#AC99F2'
    admin.title("Chức năng cho Quản trị")
    admin.geometry("600x600")
    btnDSTK=Button(admin, text="Xem danh sách tài khoản",width=30, font='Time 10', border=5, padx=10, pady=20, command=danhsachtaikhoan)
    btnDSHDChuaDuyet = Button(admin, text="Gia hạn hợp đồng", font='Time 10',width=30, border=5, padx=10, pady=20, command=dshopdongchuaduyet)

    btnDSHDDaDuyet= Button(admin, text="Thêm sản phẩm", font='Time 10', border=5,width=30, padx=10, pady=20,command=dshopdongdaduyet)
    btnDuyetHD=Button(admin, text="Sửa sản phẩm", font='Time 10', border=5, padx=10,width=30, pady=20, command=duyethopdong)
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
    # danhsachtaikhoan=Tk()
    # danhsachtaikhoan.title("Danh sách tài khoản")
    #
    # dstkTable=create_table(["ID","Useranme","Password","Staff","Admin","phone","email","Address"], danhsachtaikhoan)
    # # add data
    # dstkTable.insert(parent='', index='end', iid=0, text='',
    #                values=('Tom', 'phuc@gmail.com', '123456','Quảng ngãi'))
    # dstkTable.insert(parent='', index='end', iid=1, text='',
    #                values=('Aandrew', 'phuc@gmail.com', '123456','Quảng ngãi'))
    # dstkTable.insert(parent='', index='end', iid=2, text='',
    #                values=('Anglina', 'phuc@gmail.com', '123456','Quảng ngãi'))
    # dstkTable.insert(parent='', index='end', iid=3, text='',
    #                values=('Shang-Chi', 'phuc@gmail.com', '123456','Quảng ngãi'))
    # dstkTable.pack()
    conn = connectdb("", "dbname")
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM ONLINESHOP.dbo.TAIKHOAN')
    records = cursor.fetchall()
    print(records)
    view(("ID","Username","Password","Staff","Admin","Phone","Email","Address","State"),records,"Danh sách tài khoản")


def dshopdongchuaduyet():
    dshopdongchuaduyet=Tk()
    dshopdongchuaduyet.title("Danh sách hợp đồng chưa duyệt")
    dshdcdTable=create_table(["ID", "DoiTac", "SLChiNhanh", "StartTime", "EndTime","Tips","Status"], dshopdongchuaduyet)
    # add data
    dshdcdTable.insert(parent='', index='end', iid=0, text='',
                     values=('1', '1', '10', '20-12-2020', '20-1-2023', "10%", "Accepted"))
    dshdcdTable.insert(parent='', index='end', iid=1, text='',
                     values=('1', '1', '10', '20-12-2020', '20-1-2023', "10%", "Accepted"))
    dshdcdTable.insert(parent='', index='end', iid=2, text='',
                     values=('1', '1', '10', '20-12-2020', '20-1-2023', "10%", "Accepted"))
    dshdcdTable.insert(parent='', index='end', iid=3, text='',
                     values=('1', '1', '10', '20-12-2020', '20-1-2023', "10%", "Accepted"))
    dshdcdTable.pack()
def dshopdongdaduyet():
    dshopdongdaduyet = Tk()
    dshopdongdaduyet.title("Danh sách hợp đồng đã duyệt")

    dshdddTable = create_table(["ID", "DoiTac", "SLChiNhanh", "StartTime", "EndTime", "Tips", "Status"],
                               dshopdongdaduyet)
    # add data
    lst=('1', '1', '10', '20-12-2020', '20-1-2023', "10%", "Accepted")
    dshdddTable.insert(parent='', index='end', iid=0, text='',
                       values=lst)

    dshdddTable.pack()
def view(fields,records,title):
    win=Tk()
    win.title(title)
    table=create_table(fields,win, records)
    table.pack()
def duyethopdong():
    duyethopdong=Tk()
    duyethopdong.title("Duyệt hợp đồng")
def capnhattaikhoan():
    capnhattaikhoan=Tk()
    capnhattaikhoan.title("Cập nhật tài khoản")
def thongbaogiahan():
    thongbaogiahan=Tk()
    thongbaogiahan.title("Thông báo gia hạn")
