import pandas as pd
import pymysql
db = pymysql.connect(host="34.123.87.111",user="Pablo",password="123456789",db="proyecto2" )
cursor = db.cursor()
x = 0
csv_data = pd.read_csv('/Users/Pablo Velasquez/Downloads/Data.csv', encoding='ISO-8859-1')
df = pd.DataFrame(csv_data, columns=['Productid','ProductName','Quantity',
                                     'Type','Unit_Price','Existence','Salesid',
                                     'Date_Sale','Producto','Cant','Client','Total','Payment_Method',
                                     'ID','Productocompra','CantC','Date','Tot','DateCA','Ingresos',
                                     'Egresos','Saldo'])
for row in df.itertuples():
    if x < 110:
        cursor.execute("""INSERT INTO Productos(Productid,Producto, Cantidad, Tipo,Preciounitario,Existencia) 
        VALUES(%s,%s,%s,%s,%s,%s)""", (row.Productid,row.ProductName,row.Quantity,row.Type,row.Unit_Price,row.Existence))
        x += 1
    else:
        break
for row in df.itertuples():
    cursor.execute("""INSERT INTO ventas(Salesid, Fecha_Venta, Cliente, Cantidad, Producto, Total, Metodo_Pago)
    VALUES(%s,%s,%s,%s,%s,%s,%s)""", (row.Salesid,row.Date_Sale,row.Client,row.Cant,row.Producto,row.Total,row.Payment_Method))
    cursor.execute("""INSERT INTO compras(id,Producto,Cantidad,Fecha,Total) 
    VALUES(%s,%s,%s,%s,%s)""",(row.ID,row.Productocompra,row.CantC,row.Date,row.Tot))
    cursor.execute("""INSERT INTO caja(Fecha, Ingresos, Egresos) 
    VALUES(%s,%s,%s)""", (row.DateCA, row.Ingresos, row.Egresos))
db.commit()
db.close()