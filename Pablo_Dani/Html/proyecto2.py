import pandas as pd
import pymysql
from flask import Flask, render_template, request, url_for, redirect
from jinja2 import Template, FileSystemLoader, Environment
from bs4 import BeautifulSoup
from werkzeug.utils import secure_filename
import os
path = 'static'
files = os.listdir(path)
filepic = []
i = 0
for filename in files:
    i += 1
    if i == 1:
        pass
    else:
        filepic.append(filename)
db = pymysql.connect(host="34.123.87.111",user="Pablo",password="123456789",db="proyecto2")
cursor = db.cursor()
templates = FileSystemLoader('templates')
environment = Environment(loader = templates)
app = Flask(__name__)
@app.route("/")
def home():
    return render_template("paginasql.html")

@app.route("/login")
def login():
    return render_template("login.html")

@app.route("/productos")
def product():
    with open("images.html") as inf:
        txt = inf.read()
        soup = BeautifulSoup(txt, 'html.parser')
    soup = str(soup)
    soup = soup.replace('</div></body>', '')
    soup = change(soup)
    return soup
    
@app.route("/VentasInsertar")
def ventasinsert():
    return render_template("Ventas.html")

@app.route("/ComprasInsertar")
def comprasinsert():
    return render_template("Compras.html")

@app.route("/InventarioInsertar")
def inventarioinsert():
    return render_template("inventario.html")

@app.route("/Confirmar", methods=['POST'])
def insertar():
    tipo = request.form['b']
    if tipo == '1':
        productid = request.form['ID1']
        Cantidad = request.form['Cant']
        Fecha = request.form['fecha1']
        cursor.execute("SELECT count(id) FROM compras")
        y = cursor.fetchall()
        y = str(y)
        y = y.replace('((', '')
        y = y.replace(',),)', '')
        y = str(int(y)+1)
        total = str(int(Cantidad)*8)
        cursor.execute("""INSERT INTO compras(id,Producto,Cantidad,Fecha,Total) 
        VALUES(%s,%s,%s,%s,%s)""",(y,productid,Cantidad,Fecha,total))
        db.commit()
    elif tipo == '2':
        Producto = request.form['Produc']
        cantidad = request.form['Cant3']
        t = request.form['Tipo']
        p = request.form['Precio']
        f = request.files['file']
        filename = secure_filename(f.filename)
        file_path = os.path.join('static', filename)
        f.save(file_path)
        filepic.append(filename)
        Existencia = 'Si'
        cursor.execute("SELECT count(Productid) FROM Productos")
        y = cursor.fetchall()
        y = str(y)
        y = y.replace('((', '')
        y = y.replace(',),)', '')
        y = str(int(y)+1)
        cursor.execute("""INSERT INTO Productos(Productid,Producto,Cantidad,Tipo,Preciounitario,Existencia) 
        VALUES(%s,%s,%s,%s,%s,%s)""",(y,Producto,cantidad,t,p,Existencia))
        db.commit()
    else:
        Client = request.form['Cliente']
        cantidad = request.form['Cant2']
        total = str(int(cantidad)*5)
        producto_n = request.form['ID2']
        forma_pago = request.form['Pago']
        Fecha = request.form['Fecha2']
        cursor.execute("SELECT count(Salesid) FROM ventas")
        y = cursor.fetchall()
        y = str(y)
        y = y.replace('((', '')
        y = y.replace(',),)', '')
        y = str(int(y)+1)
        cursor.execute("""INSERT INTO ventas(Salesid,Fecha_Venta,Cliente,Cantidad,Producto,Total,Metodo_Pago) 
        VALUES(%s,%s,%s,%s,%s,%s,%s)""",(y,Fecha,Client,cantidad,producto_n,total,forma_pago))
        db.commit()
    return render_template("page.html")

def change(soup):
    cursor.execute("select * FROM Productos")
    productos = cursor.fetchall()
    i = 0
    for p in productos:
        soup +=   f"""\n<div class="product">\n
        <a class="img-wrapper" href="#">\n
        <img src="/static/{filepic[i]}" width="250" height="240" />\n
        </a>\n
        <div class="note on-sale">On sale</div>\n
        <div class="info">\n
        <div class="title">{p[1]}</div>\n
        <div class="price sale">Q{p[4]}</div>\n
        </div>\n
        <div class="actions-wrapper">\n
        <a href="#" class="add-btn wishlist">Wishlist</a>\n
        <a href="#" class="add-btn cart">Cart</a>\n
        </div>\n
    </div>\n"""
        soup += "\n"
        i += 1
    soup += "</body>"
    return soup
if __name__ == '__main__':
    app.run(debug = True)