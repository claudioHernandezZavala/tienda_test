import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tienda_test/carrito/recibo.dart';
import 'package:tienda_test/clases/productoCarritos.dart';
import 'package:tienda_test/constants.dart';

import 'item_carrito.dart';

class shopcart extends StatefulWidget {
  const shopcart({Key? key}) : super(key: key);

  @override
  State<shopcart> createState() => _shopcartState();
}

class _shopcartState extends State<shopcart> {
  User? user = FirebaseAuth.instance.currentUser;
  String color2 = "blueAccent;";

  @override
  Widget build(BuildContext context) {
    List<ProductoCarrito> productosAcomprar = [];
    double total = 0;
    DatabaseReference postref = FirebaseDatabase.instance.reference();
    return Scaffold(
        backgroundColor: Color(0xFF9FD8DF),
        appBar: AppBar(
          title: Text("Mi carrito"),
          centerTitle: true,
          backgroundColor: Color(0xFFFF7171),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('carritos')
                    .child("${user?.uid}")
                    .onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data.snapshot.value != null) {
                    productosAcomprar.clear();
                    total = 0;
                    DataSnapshot valores = snapshot.data.snapshot;
                    Map<dynamic, dynamic> valor = valores.value;
                    valor.forEach((key, value) {
                      ProductoCarrito productoNuevoCarrito = ProductoCarrito(
                        value['imagen'],
                        value['nombre'],
                        value['descripcion'],
                        value['precio'],
                        value['material'],
                        value['categoria'],
                        key,
                        value['cantidad'],
                      );
                      productosAcomprar.add(productoNuevoCarrito);
                      double precioTemp =
                          double.parse(productoNuevoCarrito.precio);

                      double cantidadTemp =
                          double.parse(productoNuevoCarrito.cantidad);

                      total += precioTemp * cantidadTemp;
                    });
                  }
                  print(total);

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data.snapshot.value == null) {
                    productosAcomprar.clear();
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Hubo un error, revisa tu conexion a internet e intenta de nuevo"),
                    );
                  }
                  if (!snapshot.hasData) {
                    productosAcomprar.clear();
                    return Center(
                      child: Text("vacio"),
                    );
                  }
                  return productosAcomprar.isEmpty
                      ? Center(
                          child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: Container(
                                width: 200,
                                height: 200,
                                color: Colors.transparent,
                                child: Image.asset("assets/emptcart.png"),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Text(
                              "Tu carrito esta vacío,\n intenta escoger un producto\n para efectuar una compra",
                              style: estilo3(),
                            )
                          ],
                        ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: productosAcomprar.length,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                    child: itemcart(
                                        producto: productosAcomprar[index]),
                                    actionPane: SlidableDrawerActionPane(),
                                    actions: [
                                      IconSlideAction(
                                        caption: "Eliminar",
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () async {
                                          await postref
                                              .child("carritos")
                                              .child("${user?.uid}")
                                              .child(
                                                  productosAcomprar[index].key)
                                              .remove();
                                        },
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 70, top: 20),
                              child: Container(
                                child: Center(
                                    child: Text(
                                  "Total: " + total.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                )),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),

                                  gradient: LinearGradient(colors: [
                                    Color(0xFFfbc2eb),
                                    Color(0xFFa6c1ee)
                                  ]),
                                  //color: Colors.orange.shade200
                                ),
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 50,
                              ),
                            )
                          ],
                        );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: RawMaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => reciboCompra(
                      productos: productosAcomprar,
                      total: total,
                    )));
          },
          shape: StadiumBorder(),
          fillColor: Colors.blueAccent,
          splashColor: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shop,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Comprar",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )
              ],
            ),
          ),
        ));
  }
}
