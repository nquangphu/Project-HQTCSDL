from tkinter import *
from  tkinter import ttk
import sqlite3 as sql
import pyodbc
from tksheet import Sheet

#Check out (madh)
#Xem ds san pham (madt) + Mua hang -> bam nut dat hang (makh, masp, madt, slsp, httt, diachigh, phiship)
#Xem ds doi tac

#======================= connect database =======================
def connectdb(server, dbname):
    conn = pyodbc.connect('Driver={SQL Server};'
                  'Server=DESKTOP-EC6UGJB;'
                  'Database=ONLINESHOP;'
                  'Trusted_Connection=yes;')
    return conn

# #======================= Table =======================
# def create_table(win_dssp, records):
#     #scrollbar
#     table_scroll = Scrollbar(win_dssp)
#     table_scroll.pack(side=RIGHT, fill=Y)

#     table_scroll = Scrollbar(win_kh,orient='horizontal')
#     table_scroll.pack(side= BOTTOM,fill=X)

#     my_table = ttk.Treeview(win_kh,yscrollcommand=table_scroll.set, xscrollcommand =table_scroll.set)


#     my_table.pack()

#     table_scroll.config(command=my_table.yview)
#     table_scroll.config(command=my_table.xview)

#     #define our column
#     lst_fields = ()
#     my_table['columns'] = ('MASP', 'TENSP', 'MALH')

#     # format our column
#     my_table.column("#0", width=0,  stretch=NO)
#     my_table.column("player_id",anchor=CENTER, width=80)
#     my_table.column("player_name",anchor=CENTER,width=80)
#     my_table.column("player_Rank",anchor=CENTER,width=80)


#     #Create Headings 
#     my_table.heading("#0",text="",anchor=CENTER)
#     my_table.heading("player_id",text="Id",anchor=CENTER)
#     my_table.heading("player_name",text="Name",anchor=CENTER)
#     my_table.heading("player_Rank",text="Rank",anchor=CENTER)


#     #add data 
#     my_table.insert(parent='',index='end',iid=0,text='',
#     values=('1','Ninja','101'))
#     my_table.insert(parent='',index='end',iid=1,text='',
#     values=('2','Ranger','102'))
#     my_table.insert(parent='',index='end',iid=2,text='',
#     values=('3','Deamon','103'))
#     my_table.insert(parent='',index='end',iid=3,text='',
#     values=('4','Dragon','104'))
#     my_table.insert(parent='',index='end',iid=4,text='',
#     values=('5','CrissCross','105'))
#     my_table.insert(parent='',index='end',iid=5,text='',
#     values=('6','ZaqueriBlack','106'))
#     my_table.insert(parent='',index='end',iid=6,text='',
#     values=('7','RayRizzo','107'))
#     my_table.insert(parent='',index='end',iid=7,text='',
#     values=('8','Byun','108'))
#     my_table.insert(parent='',index='end',iid=8,text='',
#     values=('9','Trink','109'))
#     my_table.insert(parent='',index='end',iid=9,text='',
#     values=('10','Twitch','110'))
#     my_table.insert(parent='',index='end',iid=10,text='',
#     values=('11','Animus','111'))
#     my_table.pack()

#     frame = Frame(win_kh)
#     frame.pack(pady=20)

#     #labels
#     playerid= Label(frame,text = "player_id")
#     playerid.grid(row=0,column=0 )

#     playername = Label(frame,text="player_name")
#     playername.grid(row=0,column=1)

#     playerrank = Label(frame,text="Player_rank")
#     playerrank.grid(row=0,column=2)

#     #Entry boxes
#     playerid_entry= Entry(frame)
#     playerid_entry.grid(row= 1, column=0)

#     playername_entry = Entry(frame)
#     playername_entry.grid(row=1,column=1)

#     playerrank_entry = Entry(frame)
#     playerrank_entry.grid(row=1,column=2)

#     #Select Record
#     def select_record():
#         #clear entry boxes
#         playerid_entry.delete(0,END)
#         playername_entry.delete(0,END)
#         playerrank_entry.delete(0,END)
        
#         #grab record
#         selected=my_table.focus()
#         #grab record values
#         values = my_table.item(selected,'values')
#         #temp_label.config(text=selected)

#         #output to entry boxes
#         playerid_entry.insert(0,values[0])
#         playername_entry.insert(0,values[1])
#         playerrank_entry.insert(0,values[2])

#     #save Record
#     def update_record():
#         selected=my_table.focus()
#         #save new data 
#         my_table.item(selected,text="",values=(playerid_entry.get(),playername_entry.get(),playerrank_entry.get()))
        
#     #clear entry boxes
#         playerid_entry.delete(0,END)
#         playername_entry.delete(0,END)
#         playerrank_entry.delete(0,END)

#     #Buttons
#     select_button = Button(win_kh,text="Select Record", command=select_record)
#     select_button.pack(pady =10)

#     refresh_button = Button(win_kh,text="Refresh Record",command=update_record)
#     refresh_button.pack(pady = 10)

#     temp_label =Label(win_kh,text="")
#     temp_label.pack()

#======================= view danh sach san pham =======================
def view_dssp(conn):
    win_dssp = Toplevel(win_kh)
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM ONLINESHOP.dbo.SANPHAM')
    records = cursor.fetchall()
    print(records)
    #create_table(win_dssp, records)


#======================= view danh sach doi tac =======================
def view_dsdt():
    win_dsdt = Toplevel(win_kh)

def KhachHang(win_kh):
    btn_dssp = Button(win_kh, text = "Xem danh sách sản phẩm", command=lambda:view_dssp(conn))
    btn_dsdt = Button(win_kh, text = "Xem danh sách đối tác")
    btn_dssp.pack()
    btn_dsdt.pack()
    win_kh.mainloop()

win_kh = Tk()
win_kh.title("Khách hàng")
table_frame = Frame(win_kh)
win_kh.geometry("700x500")
win_kh['bg'] = '#AC99F2'

# connect database
server = 'DESKTOP-EC6UGJB'
dbname = 'ONLINESHOP'
conn = connectdb(server, dbname)
KhachHang(win_kh)
