import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tienda_test/clases/categoria.dart';
import 'package:tienda_test/clases/productos.dart';
import 'package:tienda_test/componentes/grid_pulseras.dart';
import 'package:tienda_test/constants.dart';
import 'package:tienda_test/widgets/resultado_vacio.dart';

class body extends StatefulWidget {
  final BuildContext context;
  const body({Key? key, required this.context}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<Producto> productosGenerales = [];
  List<Producto> productosNuevos = [];
  List<Categoria> categoriasDisponibles = [];
  Categoria cagetoriaGeneral =
      Categoria("assets/imagenLogin.jpg", "Todo", "keyTodo");
  Producto prod = Producto("assets/avatar_mujer.png", "loco", "wow", "125",
      "oro", Colors.red, "lol", "200023");
  bool loading = false;

  final FirebaseAuth fireauth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 45,
              ),
              Text(
                "Categorias",
                style: estilo3(),
              ),
              SizedBox(
                width: 50,
              ),
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('cuerpoCate');
                },
                splashColor: Colors.blue,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                ),
                label: Text(
                  "Ver todo",
                  style: estiloLinks(),
                ),
              ),
            ],
          ),

          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child("categorias")
                  .orderByKey()
                  .onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data.snapshot.value != null) {
                  categoriasDisponibles.clear();
                  DataSnapshot valores = snapshot.data.snapshot;
                  Map<dynamic, dynamic> values = valores.value;
                  values.forEach((key, value) {
                    Categoria categorianueva =
                        Categoria(value['imagen'], value['categoria'], key);

                    categoriasDisponibles.add(categorianueva);
                  });
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Algo salio mal"));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text("No hay datos"));
                }
                if (snapshot.data.snapshot.value == null) {
                  categoriasDisponibles.clear();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: Colors.orange,
                  );
                }

                return categoriasDisponibles.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(left: 50.0, top: 8.0),
                        child: vacio(
                            elemento: "No hay categorias",
                            imagen: "assets/missingcate.png"),
                      )
                    : CarouselSlider.builder(
                        itemCount: categoriasDisponibles.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return item_categoria(
                              categoria: categoriasDisponibles[itemIndex]);
                        },
                        options: CarouselOptions(
                          height: 220,
                          scrollPhysics: BouncingScrollPhysics(),
                          aspectRatio: 25 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          pauseAutoPlayOnTouch: true,
                          scrollDirection: Axis.horizontal,
                        ));
              }),
          //stream builder de productos nuevos
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              " Productos nuevos",
              style: estilo3(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("productos/")
                  .snapshots(includeMetadataChanges: true),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data.snapshot.value != null) {
                  productosNuevos.clear();

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
                    productosNuevos.add(ProductoNuevo);
                  });
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Algo salio mal"));
                }
                if (snapshot == null) {
                  productosNuevos.clear();
                  return Center(child: Text("No hay datos"));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text("No hay datos"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.orange,
                  );
                }

                return productosNuevos.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(left: 50, top: 10),
                        child: vacio(
                          imagen: "assets/missingprod.png",
                          elemento: "No hay nuevos productos",
                        ),
                      )
                    : CarouselSlider.builder(
                        itemCount: productosNuevos.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return cardProductosCarousel(
                              producto: productosNuevos[itemIndex]);
                        },
                        options: CarouselOptions(
                          height: 350,
                          aspectRatio: 25 / 9,
                          scrollPhysics: const BouncingScrollPhysics(),
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ));
              }),
          //stream builder de categorias
        ],
      ),
    );
  }
}
