import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tienda_test/carrito/carrito.dart';
import 'package:tienda_test/clases/categoria.dart';
import 'package:tienda_test/clases/productos.dart';
import 'package:tienda_test/componentes/grid_pulseras.dart';

import '../../constants.dart';

class categoriasCuerpo extends StatefulWidget {
  final Categoria categoria;
  const categoriasCuerpo({Key? key, required this.categoria}) : super(key: key);

  @override
  _categoriasCuerpoState createState() => _categoriasCuerpoState();
}

class _categoriasCuerpoState extends State<categoriasCuerpo> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context),
        backgroundColor: const Color(0xFFF4F9F9),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.categoria.categoriaTexto,
              style: estilo3(),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kdefaultpadding),
              child: StreamBuilder<Object>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child("pulseras")
                      .onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    List<Producto> productos = [];

                    var count = 2;
                    double espacio = 25;
                    double aspetr = 0.65;
                    if (MediaQuery.of(context).size.width > 700) {
                      count = 6;
                      espacio = 3;
                      aspetr = 0.8;
                    }
                    if (snapshot.hasData &&
                        snapshot.data.snapshot.value != null) {
                      productos.clear();
                      DataSnapshot valores = snapshot.data.snapshot;
                      Map<dynamic, dynamic> values = valores.value;
                      values.forEach((key, value) {
                        Producto ProductoNuevo = Producto(
                            value['imagen'],
                            value['nombre'],
                            value['descripcion'],
                            value['precio'],
                            value['material'],
                            Color(0xFF524175),
                            value['categoria'],
                            key);
                        if (widget.categoria.categoriaTexto == "Todo") {
                          productos.add(ProductoNuevo);
                        } else if (ProductoNuevo.categoria ==
                            widget.categoria.categoriaTexto) {
                          productos.add(ProductoNuevo);
                        }
                      });
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Algo salio mal"));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text("No hay datos"));
                    }
                    if (snapshot.data.snapshot.value == null) {
                      productos.clear();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: Colors.orange,
                      );
                    }

                    return productos.isEmpty
                        ? Center(
                            child: Container(
                                height: MediaQuery.of(context).size.height > 750
                                    ? 400
                                    : 500,
                                width: MediaQuery.of(context).size.width > 750
                                    ? 500
                                    : 500,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Image.asset("assets/al_buscar.png"),
                                    Text(
                                      "No pudimos encontrar productos en esa categoria",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )
                                  ],
                                )))
                        : GridView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: productos.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: count,
                                    mainAxisSpacing: espacio,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: aspetr),
                            itemBuilder: (context, index) =>
                                ItemFinal(producto: productos[index]));
                  }),
            )),
          ],
        ));
  }
}

AppBar appbar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
    ),
    title: Text(
      "Shop",
      style: TextStyle(color: Colors.white),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => shopcart()));
        },
        icon: Icon(Icons.shopping_cart, color: Colors.white),
        color: kTextColor,
      ),
      SizedBox(
        width: kdefaultpadding / 2,
      )
    ],
    backgroundColor: Color(0xFF383E56),
    elevation: 1,
    centerTitle: true,
  );
}
