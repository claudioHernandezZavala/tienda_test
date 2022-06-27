import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tienda_test/clases/productoCarritos.dart';

class itemcart extends StatefulWidget {
  final ProductoCarrito producto;
  const itemcart({Key? key, required this.producto}) : super(key: key);

  @override
  State<itemcart> createState() => _itemcartState();
}

class _itemcartState extends State<itemcart> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        color: Color(0xFFF0E4D7),
        elevation: 10,
        margin: EdgeInsets.all(10),
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                  height: 200,
                  width: 120,
                  child: Image.network(widget.producto.imagen)),
              SizedBox(
                width: 1,
              ),
              Expanded(
                flex: 1,
                child: Wrap(
                  children: [
                    Text(
                      "Nombre:" + widget.producto.nombre,
                      maxLines: 4,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Precio: " + widget.producto.precio),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          DatabaseReference ref = FirebaseDatabase.instance
                              .reference()
                              .child("carritos")
                              .child("${user?.uid}");

                          int cant = int.parse(widget.producto.cantidad);

                          cant++;

                          setState(() {
                            ref
                                .child(widget.producto.key)
                                .update({'cantidad': cant.toString()});
                            widget.producto.cantidad = cant.toString();
                          });
                        },
                        child: Icon(Icons.add)),
                    Text("Cantidad : ${widget.producto.cantidad}"),
                    OutlinedButton(
                        onPressed: () {
                          DatabaseReference ref = FirebaseDatabase.instance
                              .reference()
                              .child("carritos")
                              .child("${user?.uid}");

                          int cant = int.parse(widget.producto.cantidad);
                          if (cant > 1) {
                            cant--;
                          }

                          setState(() {
                            ref
                                .child(widget.producto.key)
                                .update({'cantidad': cant.toString()});
                            widget.producto.cantidad = cant.toString();
                          });
                        },
                        child: Icon(Icons.remove)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
