import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_test/clases/productos.dart';
import 'package:tienda_test/constants.dart';
import 'package:tienda_test/screens/details/producto_imagen_precio.dart';

class bodyDetails extends StatefulWidget {
  final Producto producto;
  const bodyDetails({Key? key, required this.producto}) : super(key: key);

  @override
  State<bodyDetails> createState() => _bodyDetailsState(producto);
}

class _bodyDetailsState extends State<bodyDetails> {
  int cantidadProducto = 1;

  _bodyDetailsState(producto1);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                        top: size.height * 0.13, left: 10, right: 10),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFF7F3E9),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                widget.producto.descripcion,
                                style: estilo3(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Precio:  Lps.${widget.producto.precio}",
                          style: estilo3(),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 11,
                            ),
                            SizedBox(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  elevation: 5,
                                  shadowColor: Colors.red,
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  if (cantidadProducto > 1) {
                                    setState(() {
                                      cantidadProducto--;
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                  child: Text(cantidadProducto
                                      .toString()
                                      .padLeft(2, "0"))),
                            ),
                            SizedBox(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 5,
                                  shadowColor: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cantidadProducto++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: kdefaultpadding),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: widget.producto.color,
                                      width: 1.6)),
                              child: IconButton(
                                  splashColor: Colors.teal,
                                  color: widget.producto.color,
                                  onPressed: () {
                                    DatabaseReference ref =
                                        FirebaseDatabase.instance.reference();
                                    User? user =
                                        FirebaseAuth.instance.currentUser;
                                    var data = {
                                      "imagen": widget.producto.imagen,
                                      "descripcion":
                                          widget.producto.descripcion,
                                      "precio": widget.producto.precio,
                                      "nombre": widget.producto.titulo,
                                      "material": widget.producto.material,
                                      "categoria": widget.producto.categoria,
                                      "cantidad": cantidadProducto.toString(),
                                    };

                                    itemExistente(data);

                                    // ref.child("carritos").child("${user?.uid}").child(widget.producto.key).set(data);
                                  },
                                  icon: Icon(Icons.add_shopping_cart)),
                            ),
                            SizedBox(
                              height: 50,
                              width: 250,
                              child: FlatButton(
                                  minWidth: 80,
                                  splashColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  color: widget.producto.color,
                                  onPressed: () {},
                                  child: Text(
                                    "Comprar Ahora ${int.parse(widget.producto.precio) * cantidadProducto}",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Producto_conImagen_Precio(producto: widget.producto)
              ],
            ),
          )
        ],
      ),
    );
  }

  void itemExistente(Map<String, String> datos) async {
    User? user = FirebaseAuth.instance.currentUser;
    //DatabaseReference databaseReference= FirebaseDatabase.reference().child("Ca");
    DatabaseReference rf = FirebaseDatabase.instance
        .reference()
        .child("carritos")
        .child("${user!.uid}")
        .child(widget.producto.key);

    await rf.get().then((DataSnapshot snap) {
      if (snap.value == null) {
        // print("ya lo tienes");
        rf.set(datos);
        // Fluttertoast.showToast(msg: "Producto agregado a carrito!", backgroundColor: Colors.green, textColor: Colors.black);
      } else {
        // print("no lo tienes");
        // Fluttertoast.showToast(msg: "Ya tienes este producto!", backgroundColor: Colors.yellow, textColor: Colors.black);
      }
    });
  }
}
